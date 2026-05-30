# HMG Academy CBT — Complete Feature Guide

This document explains **every feature** in the system, portal by portal, including the pre-existing features (preserved) and the new additions from this enhancement round. The platform is **100% free**: pure HTML/CSS/JavaScript on the front end and **Supabase free tier** as the database/auth backend. **No paid AI API is used** — all scoring and insights are browser logic and rules.

---

## A. The three portals (+ tools)

| File | Portal | Who uses it |
|---|---|---|
| `index.html` | Public landing page & role selector | Everyone |
| `teacher.html` | Teacher Dashboard | Teachers / tutors |
| `student.html` | Student Exam Portal | Students (no account) |
| `admin.html` | Admin Panel | Platform administrators |
| `feature_guide.html` | In-app feature guide | Everyone |
| `deployment_validator.html` | Browser-only readiness checker | Deployer/admin |
| **`link_checker.html`** | **NEW — Exam Link & Code Health Checker** | Teachers & students |
| `offline.html` | Offline fallback page (PWA) | Auto-shown when offline |

---

## B. Student Portal (`student.html`)

### B1. Two ways to access an exam (the core flow — now fixed)
- **Direct link:** `student.html?code=ABC123` (teacher shares this; one tap to open).
- **Manual code:** student types/pastes the 6-character code on the entry screen.
- The parser `extractExamCode()` accepts a **raw code**, a **full link**, a `#hash`, or `?code=`/`?exam=`/`?c=` query forms, and normalises to upper-case. *(This is the function that contained the reported bug; it is now corrected and unit-tested.)*

### B2. Two exam modes
- **Open mode:** student enters name + class, accepts the integrity pledge, and starts. No account.
- **Registered mode:** student verifies a **Student ID** against the teacher's class roster (`students` table) before starting; identity strip is shown during the exam.

### B3. Taking the exam
- **Randomised questions & options** per student (shuffle) to reduce copying — original CSV index is preserved internally so grading always maps correctly.
- **Question selection:** teacher can deliver a random subset (`select_count`) from a larger bank.
- **Countdown timer** with colour warnings (normal → amber ≤5 min → red ≤2 min); auto-submits at zero.
- **Question navigator** grid; **flagging** questions for review; **jump to first unanswered**.
- **Answer draft auto-save** to the device, restored if the page reloads mid-exam.
- **On-screen scientific calculator** (sin/cos/tan, ln/log, powers, roots, factorial, inverse, etc.) with history.
- **One submission only** — prevents duplicate submissions; enforces the per-exam **attempt limit**.

### B4. 11+ question types
`mcq` (single choice), `mrq` (multiple response, optional all-or-nothing), `tf` (true/false), `short` (short text/keyword), `numeric` (number with tolerance), `multi_numeric` (multi-blank numeric), `matching`, `ordering`, `cloze` (multi-blank fill-in), `categorization`/classification, and `essay` (keyword-based rubric scoring — **no AI API**).

### B5. Integrity / proctoring (free, browser-based)
- **Fullscreen enforcement** with re-entry prompts.
- **Tab-switch / window-blur detection**, **copy/cut/paste/right-click blocking**, **devtools size-trap**, and a **violation engine** with a max-violations threshold and optional auto-submit.
- **Identity photo capture** + **live camera proctoring** with periodic snapshots and **multi-face detection** via the open-source `face-api.js` loaded from a free CDN. Gracefully **skips** if the camera is unavailable (never blocks the exam because of hardware).
- **Integrity pledge** checkbox required before starting.

### B6. Results
- **Instant auto-grading** and a **shareable result certificate** with score and grade.
- **Result review** with the teacher's **per-question explanations**.
- **Emergency result backup**: if the network/database save fails, the student can **download their result payload** so nothing is lost.

### B7. NEW resilience additions
- **🔄 Retry button** on connection errors during exam load.
- **Corrupt/empty exam guards** with clear, actionable messages.
- **"Trouble getting in?" link** to the new Health Checker.

---

## C. Teacher Dashboard (`teacher.html`)

### C1. Authentication & account
- Supabase email/password login, session refresh, **inactivity auto-logout**, last-login display.

### C2. Creating exams — four import methods
- **CSV upload** (with a provided `further_maths_sample.csv` template).
- **Manual builder** (`tab-manual`).
- **PDF import** (`tab-pdf`) and **XLSX import** (`tab-xlsx`).
- Configure **subject/class/term/topic/type/session/passmark** (encoded in the `subject` meta field), **duration**, **attempt limit**, **question count**, **randomisation**, and **exam mode** (open/registered).

### C3. Sharing
- Auto-generated **6-character access code**.
- **Direct student link** (`student.html?code=XXXXXX`) that auto-detects the current deployment (Vercel/GitHub Pages/Cloudflare).
- **Copy link**, **copy code**, and **WhatsApp share** with a pre-filled message.

### C4. Managing exams & students
- **Assessments list**: open/close exams, **regenerate code**, edit, delete.
- **Auto-close scheduler** (`close_at`) — enforced on **both** the dashboard poller **and** the student side.
- **Students/roster** management for registered mode.

### C5. Results & analytics
- **Live results polling** (~15s) for new submissions.
- **Leaderboard**, score distribution, **pass/fail ratios**, average time-per-question, and other charts.
- **CSV export** of results.

### C6. Settings
- Institution branding, student base-URL display, backup/export workflows.

---

## D. Admin Panel (`admin.html`)
- Admin-only secure login (checks `is_admin`/`status` on the `profiles` table).
- **Manage teachers & accounts**, platform-wide analytics/reports, and system configuration.
- Uses the same Supabase project; service-key paths are guarded behind admin auth.

---

## E. Free utility tools

### E1. NEW — Exam Link & Code Health Checker (`link_checker.html`)
Paste a link or code and get a 7-step health report (code readable → DB reachable → exam found → open status → schedule → questions valid → final verdict) plus a one-click "open student page". Pre-fillable via `?code=`. Prevents the entire "students can't get in" support category.

### E2. Deployment Validator (`deployment_validator.html`)
Browser-only readiness checker for required files, PWA assets, Supabase configuration, and security basics.

### E3. In-app Feature Guide (`feature_guide.html`)
Human-readable walkthrough of portals, features, question types and deployment, for school administrators.

---

## F. Platform-wide (PWA & security)
- **Installable PWA** (`manifest.webmanifest`) — works on phones/tablets, "Add to Home Screen".
- **Service worker** (`sw.js`) caches the **static shell only** and **never** intercepts Supabase/API/CDN calls, so live data is always fresh. Cache version **bumped to `v5`** to push the bug fix to returning devices.
- **Offline fallback** page for navigation when offline.
- **Security headers** via `_headers` (`X-Content-Type-Options`, `X-Frame-Options`, `Referrer-Policy`, `Permissions-Policy`).
- **Cost model:** Supabase free tier + free static hosting + free CDN libraries = **₦0 running cost**; **no paid AI API**.

---

## G. What changed in this enhancement round (summary)
| Area | Change | Type |
|---|---|---|
| Student access parser | Fixed corrupted `\b` regex | **Bug fix** |
| Student exam load | Retry button, corrupt/empty-exam guards | Enhancement (additive) |
| New tool | `link_checker.html` health checker | New feature |
| PWA | Cached new tool, bumped cache `v4→v5` | Maintenance |
| Docs | This guide + fix report + deployment guide | Documentation |

> **No pre-existing feature was removed or changed in behaviour.** Every addition is backward-compatible.
