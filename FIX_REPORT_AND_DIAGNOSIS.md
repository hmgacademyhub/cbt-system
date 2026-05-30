# HMG Academy CBT — Expert Diagnosis, Bug Fix & Enhancement Report

**Prepared:** 2026-05-29
**Scope:** Full audit of the live site (`https://hmgacademy-cbt-system.vercel.app/`) and the GitHub repository (`hmgacademyhub/cbt-system`).
**Reported symptom:** *"When the teacher sends the link (whether new or old), the student cannot access the platform for the exam."*

---

## 1. Executive summary

The reported problem is **100% reproducible** and traced to **one single corrupted line of code** in `student.html`. A regular expression that is supposed to read the exam code from a link or from typed input had its two `\b` (word-boundary) escape sequences saved as **literal backspace control characters (byte `0x08`)**. The result was a regex that can *never* match a normal exam code.

This silently broke **both** ways a student can enter an exam:

1. Clicking the teacher's link (`student.html?code=ABC123`), and
2. Typing/pasting the 6-character code manually.

In both paths the system concluded "no valid code" and bounced the student to the code-entry screen — so the exam never loaded, exactly as reported.

The fix is a **one-line correction** (restore the `\b` escapes). I also added several **safe, additive** robustness improvements and a new free self-service **Link & Code Health Checker** tool. **No existing feature was removed or altered in behaviour.**

---

## 2. How the platform works (audit findings)

The system is a **static HTML/CSS/vanilla-JS** site with **Supabase (free tier)** as the backend:

| Layer | Technology | Notes |
|---|---|---|
| Hosting | Vercel / GitHub Pages / Cloudflare Pages | Pure static files, no build step |
| Database/API | Supabase REST (`/rest/v1/...`) | Tables: `exams`, `results`, `students`, `profiles` |
| Auth | Supabase Auth | Teacher & admin login; students are anonymous |
| Offline shell | Service worker (`sw.js`) | Caches static pages only; **never** intercepts Supabase calls |
| AI cost | **None** | Scoring/insights are pure browser logic & rules |

**Student access flow (the relevant path):**

```
init()
  └─ resolveCodeFromURL()        // reads ?code= / ?exam= / ?c= or #hash
        └─ extractExamCode(raw)  // normalises a link OR a raw code → CODE
  └─ fetch exams?code=eq.CODE    // Supabase REST, anon key
  └─ validate is_open / close_at
  └─ JSON.parse(csv_data) → render questions
```

### Backend health check (performed during audit)
I queried the live Supabase project directly with the public anon key:

- `GET /rest/v1/exams?select=...` → **200 OK**, 57 exams present.
- `GET /rest/v1/exams?code=eq.O13MH1&select=*` → **200 OK**, valid record, `is_open=true`, `csv_data` parses to 60 questions.
- `GET /rest/v1/results` and `GET /rest/v1/students` → **200 OK** (anon read works).
- `POST /rest/v1/results` → reaches the table (insert path works; rejects only when required columns are intentionally omitted).

**Conclusion:** The database, RLS policies, anon key, and network are all healthy. The failure was **purely client-side** in code parsing.

---

## 3. Root cause (the bug)

**File:** `student.html`
**Function:** `extractExamCode()`
**Line (original):** the final fallback regex.

### What it should be
```js
const codeMatch = text.toUpperCase().match(/\b[A-Z0-9]{4,12}\b/);
```

### What it actually was (bytes on disk)
```
const codeMatch = text.toUpperCase().match(/<0x08>[A-Z0-9]{4,12}<0x08>/);
```

The two `\b` escapes had been replaced by raw **backspace characters (0x08)**. In a JavaScript regular expression:

- `\b` *inside a character set* means backspace, but **outside** a set it means "word boundary".
- A **literal 0x08 byte** in the pattern matches an actual backspace character in the text — which never appears in an exam code.

So the pattern `/\x08[A-Z0-9]{4,12}\x08/` requires a backspace **before and after** the code. No real code is ever surrounded by backspaces, so the match **always fails**.

### Why this broke *both* access methods

`extractExamCode()` tries, in order:
1. Parse as a URL and read `?code=` → works only for a *full link* string.
2. Regex for `?code=` substring → works only if the string still contains `?code=`.
3. **Fallback bare-code regex** → the corrupted line.

- **Teacher link path:** `resolveCodeFromURL()` first pulls the *value* `ABC123` out of the URL, then re-runs `extractExamCode('ABC123')`. Now the input is a *bare code* with no `?code=`, so it falls through to step 3 → the broken regex → returns `""` → student blocked.
- **Manual entry path:** `loadExamFromInput()` calls `extractExamCode('ABC123')` directly → step 3 → broken regex → returns `""` → "Please enter a valid exam link or access code."

This is why **new and old links alike** failed: the code value itself was never the problem — the *parser* was.

### Reproduction (verified)
Running the exact original function in Node:

| Input | Broken output | Fixed output |
|---|---|---|
| `O13MH1` (typed code) | `""` ❌ | `O13MH1` ✅ |
| teacher link `...?code=O13MH1` → re-parsed value | `""` ❌ | `O13MH1` ✅ |
| full link string (rare direct case) | `O13MH1` | `O13MH1` |

The only case that *appeared* to work was passing a complete URL string straight into step 1 — which is not what the runtime flow does, masking the bug during casual testing.

---

## 4. The fix

**Primary fix (the actual bug):** restored the word-boundary escapes.

```js
// BEFORE (corrupted — literal 0x08 bytes)
const codeMatch = text.toUpperCase().match(/␈[A-Z0-9]{4,12}␈/);
// AFTER (correct)
const codeMatch = text.toUpperCase().match(/\b[A-Z0-9]{4,12}\b/);
```

**Verification after fix** (Node, using the real function extracted from the patched file):

```
"O13MH1"                      -> "O13MH1"
"o13mh1"                      -> "O13MH1"
" O13MH1 "                    -> "O13MH1"
".../student.html?code=O13MH1"-> "O13MH1"
"student.html?code=ABC123"    -> "ABC123"
"#O13MH1"                     -> "O13MH1"
```

A full-repository sweep confirmed **no other file** contains stray control characters (`0x08`, `0x07`, `0x0b`, `0x0c`, `0x1b`).

---

## 5. Additional safe enhancements (additive only)

These improve resilience around the same access flow. **Nothing existing was removed.**

### 5.1 `student.html` — resilient `init()`
- **Connection-error retry:** the generic *"Connection error"* message now includes a **🔄 Retry** button so a student on a flaky network can re-attempt without reloading or re-typing the code.
- **Corrupt question-data guard:** `JSON.parse(exam.csv_data)` is now wrapped in `try/catch`. If a teacher ever publishes malformed data, the student sees a clear message ("ask your teacher to re-publish") instead of a silent dead screen.
- **Empty-exam guard:** if an exam has zero questions, the student is told clearly instead of starting a broken/blank exam.

### 5.2 New free tool — `link_checker.html` (Exam Link & Code Health Checker)
A standalone, no-login page that lets a **teacher or student** paste a link/code and instantly see a step-by-step health report:

1. ✅ Code read successfully (shows the resolved code)
2. ✅ Database reachable
3. ✅ Exam found (subject, duration, mode)
4. ✅/⚠️ Exam open or closed
5. ✅/⚠️ Schedule (close time) status
6. ✅/⚠️/❌ Question data present & valid
7. **Final verdict** + a one-click "Open the student exam page" link

It reuses the **same corrected parser** and the same Supabase anon (read-only) config, so it always reflects exactly what a real student would experience. It is also pre-fillable via `link_checker.html?code=ABC123` so teachers can bookmark a one-click check. This directly prevents the *class* of "students can't get in" support tickets going forward.

- Linked from the student code-entry screen ("Trouble getting in? Test your link or code here →").
- Registered in `sw.js` for offline availability; cache version bumped `v4 → v5` so every existing device picks up the fix on next load.

---

## 6. Files changed

| File | Change |
|---|---|
| `student.html` | **Bug fix** (regex) + retry button + JSON-parse guard + empty-exam guard + checker link |
| `link_checker.html` | **New** free Link & Code Health Checker tool |
| `sw.js` | Added `link_checker.html` to shell cache; bumped cache `v4 → v5` |

All JavaScript was re-validated with `node --check` after every edit — **no syntax errors**.

---

## 7. Why the cache bump matters for deployment

Because the broken `student.html` may already be cached on students' devices by the old service worker (`hmg-cbt-shell-v4`), simply uploading the fix is not always enough on returning devices. Bumping to `hmg-cbt-shell-v5` forces the service worker to **activate, delete old caches, and re-fetch** the corrected files on the next visit — guaranteeing students get the working version.

---

## 8. Post-deployment verification checklist

After deploying (see `DEPLOYMENT_GUIDE.md`):

1. Open `link_checker.html`, paste a known code (e.g. an open exam code) → expect all green and a working "Open the student exam page" link.
2. Open `student.html?code=YOURCODE` directly → the exam banner and entry form load (not the code box).
3. Open `student.html`, type the code manually, press **Open Exam →** → same exam loads.
4. Complete a short exam end-to-end and confirm the result is saved and appears in the teacher dashboard.
5. On a phone that used the site before, confirm the new version loads (service worker `v5`).
