# HMG Academy CBT Pro — Free Browser-Based Assessment Platform

> Built by **Adewale Samson Adeagbo** for HMG Concepts / HMG Academy: free, practical EdTech for real Nigerian classrooms — no paid AI API, no build step, no monthly platform fee.

![Status](https://img.shields.io/badge/Status-Live-10b981?style=flat-square)
![Stack](https://img.shields.io/badge/Stack-HTML%20CSS%20Vanilla%20JS-blue?style=flat-square)
![Database](https://img.shields.io/badge/Database-Supabase%20Free%20Tier-3ECF8E?style=flat-square)
![Question Types](https://img.shields.io/badge/Question%20Types-11+-8b5cf6?style=flat-square)
![Cost](https://img.shields.io/badge/AI%20API-Not%20Required-f59e0b?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

---

## Brand Identity

- **Founder / Visioner:** Adewale Samson Adeagbo
- **Parent Brand:** HMG Concepts — His Marvellous Grace Educational Consult
- **Education Arm:** HMG Academy — full-service virtual learning institution
- **Technology Arm:** HMG Technologies — CBT systems, data tools, EdTech products
- **Philosophy:** Learning Deliberately. Teaching Authentically.
- **Contact:** +234 810 086 6322 · +234 907 790 7677 · hismarvellousgrace@gmail.com · buildingmyictcareer@gmail.com

---

## What This Platform Does

HMG Academy CBT Pro is a free computer-based testing system for teachers, schools, tutors, and virtual academies. It lets teachers create assessments, share either a link or code, collect student submissions, analyse performance, and export reports.

Students can sit exams from a browser without creating accounts. Teachers can run open exams or registered-student-only exams using a class roster.

---

## Portals

| File | Purpose |
|---|---|
| `index.html` | Public landing page and role selector |
| `teacher.html` | Teacher dashboard: exam creation, question bank, results, analytics, settings |
| `student.html` | Student exam portal: access by link or code, timed exams, result review |
| `manifest.webmanifest` | PWA metadata for installable app shell |
| `sw.js` | Service worker for static shell caching |
| `hmg-icon.svg` | HMG app icon |
| `DIAGNOSIS_FEATURES_DEPLOYMENT.md` | Full diagnosis, features, SQL notes, and deployment guide |

If your repo also has `admin.html`, deploy it alongside these files.

---

## Access Options for Students

Teachers can share two options:

1. **Direct link** — `student.html?code=ABC123`
2. **Access code** — `ABC123`

The Student Portal accepts both. Students may paste the full link or type the code manually.

---

## 11+ Question Types

The platform now supports a wider evaluation range without using paid AI marking.

| Type | Code | Student Interaction | Scoring |
|---|---|---|---|
| Multiple Choice | `mcq` | Choose one option | 1 or 0 |
| True / False | `tf` | Choose true/false | 1 or 0 |
| Multiple Response | `mrq` | Select all correct options | Partial or all-or-nothing |
| Short Answer | `short` | Type a word/phrase | Case-insensitive accepted answers |
| Numeric | `numeric` | Type one number | Tolerance-based |
| Matching | `matching` | Pair left items with right answers | Partial per pair |
| Ordering | `ordering` | Arrange items in sequence | Partial per position |
| Cloze / Multi-Blank | `cloze` | Fill multiple blanks | Partial per blank |
| Essay / Keyword Response | `essay` | Write a paragraph/long answer | Keyword/minimum-word rule-based scoring; teacher review recommended |
| Categorization | `categorization` | Assign items to categories | Partial per item |
| Multi-Part Numeric | `multi_numeric` | Solve several numeric parts | Partial per part |

### Why essay is not AI-marked

The platform deliberately avoids AI APIs because they are not cost-effective for free school deployment. Essay scoring is therefore **keyword/minimum-word based**, not semantic AI grading. It is useful for guided evaluation but teachers should review important essays manually.

---

## CSV Format

Header:

```csv
Question,A,B,C,D,CorrectAnswer,Explanation,Type,Tolerance,Unit,Accept,MRQ_AON,Pairs,Items
```

| Column | Field | Usage |
|---|---|---|
| 1 | Question | Required for all types |
| 2–5 | A–D | Options for MCQ/MRQ/TF only |
| 6 | CorrectAnswer | Letters, answer text, numeric value, or blank for JSON-based types |
| 7 | Explanation | Optional feedback shown after submission |
| 8 | Type | `mcq`, `tf`, `mrq`, `short`, `numeric`, `matching`, `ordering`, `cloze`, `essay`, `categorization`, `multi_numeric` |
| 9 | Tolerance | Numeric only |
| 10 | Unit | Numeric labels |
| 11 | Accept | Short alternates or essay keywords using pipe `|` |
| 12 | MRQ_AON | `true` or `false` for MRQ scoring |
| 13 | Pairs | Matching JSON |
| 14 | Items | Ordering/cloze/categorization/multi_numeric/essay JSON |

---

## JSON Examples for Advanced Types

### Cloze

```csv
"Force = ___ × ___","","","","","","Force equals mass times acceleration.","cloze","","","","","","[""mass|m"",""acceleration|a""]"
```

### Essay

```csv
"Explain two reasons why exam integrity matters.","","","","","","Teacher review recommended.","essay","","","honesty|fairness|trust|validity","","","{""min_words"":30,""keywords"":[""honesty"",""fairness"",""trust"",""validity""]}"
```

### Categorization

```csv
"Categorise each item.","","","","","","Partial credit per item.","categorization","","","","","","[{""item"":""Sodium"",""category"":""Metal""},{""item"":""Oxygen"",""category"":""Non-metal""}]"
```

### Multi-Part Numeric

```csv
"Solve x + y = 5 and x - y = 1.","","","","","","x=3 and y=2.","multi_numeric","","","","","","[{""label"":""x"",""answer"":3,""tolerance"":0},{""label"":""y"",""answer"":2,""tolerance"":0}]"
```

---

## Teacher Features

### Exam Creation

Teachers configure subject, class, term, topic, session, duration, pass mark, attempt limit, random question pull count, open/locked status, auto-close schedule, and student access mode.

### Question Input

Supported input methods:

- CSV upload
- Excel/XLSX upload using free SheetJS CDN
- PDF text extraction using free PDF.js CDN
- Manual typing for core question types
- JSON exam package import

### Question Bank Management

Teachers can preview, edit, export, duplicate, and reuse question banks. Exam package export/import allows backups and migration between deployments.

### Sharing

Each exam provides:

- access code
- direct link
- full student instructions copy button
- WhatsApp share

### Results and Analytics

The teacher dashboard provides:

- score table
- correct/wrong/skipped counts
- time taken
- integrity flags
- answer breakdown
- time-per-question heatmap
- charts
- pass/fail ratios
- leaderboard
- CSV export
- local rule-based class insights without AI API

### Student Roster

Teachers can add students manually or import CSV rosters. Registered-mode exams verify Student ID before entry.

---

## Student Features

- Enter by full link or access code
- Open mode: name and class
- Registered mode: Student ID verification
- Integrity pledge before exam
- Countdown start
- Timer with warning colours
- Question navigator
- Flag questions
- Scientific calculator
- Auto-submit on timeout
- Anti-cheat event logging
- Optional webcam/microphone proctoring where browser permissions allow
- Instant result screen
- PDF/print result
- Emergency result backup JSON if server saving fails
- Local draft restore on the same device

---

## Free Tools Used

| Tool | Purpose |
|---|---|
| HTML/CSS/Vanilla JS | Frontend |
| Supabase free tier | Auth, database, REST API, RLS |
| GitHub Pages / Cloudflare Pages / Vercel | Static hosting |
| Chart.js | Charts |
| SheetJS | Excel parsing |
| PDF.js | PDF text extraction |
| face-api.js | Optional browser-side face checks |
| Web Audio API | Optional audio spike detection |
| Service Worker | App shell caching |

No paid AI API is required.

---

## Deployment Summary

1. Upload all files to your static hosting provider.
2. Confirm `SB_URL` and `SB_KEY` in `teacher.html` and `student.html`.
3. Run the Supabase SQL setup from Teacher Dashboard → Settings.
4. Configure Supabase Auth redirect URLs.
5. Create a teacher account.
6. Create a test exam.
7. Confirm students can enter using both link and code.
8. Submit a test result and verify it appears in the teacher dashboard.

For full step-by-step deployment, read `DIAGNOSIS_FEATURES_DEPLOYMENT.md`.

---

## Security Model

The Supabase anon key is public by design. Security depends on Row Level Security policies. Never place the Supabase `service_role` key in frontend files.

---

## License

MIT License. Free to use, modify, deploy, and improve.

---

<div align="center">
<strong>HMG Academy CBT Pro</strong><br>
Learning Deliberately. Teaching Authentically.<br>
Built by Adewale Samson Adeagbo · HMG Concepts
</div>

---

## 2026 Expert Enhancement Update

This enhanced package now includes additional free, non-AI-API features:

- **`admin.html` Admin Panel** — teacher approval, account status management, platform KPIs, exams/results overview, security diagnostics, and platform CSV export.
- **Teacher emergency backup importer** — teachers can import a student's emergency backup JSON from Settings → Enterprise Operations.
- **Item Analysis CSV** — exports per-question attempted/correct/partial/wrong/skipped counts, error rate, and average time for one filtered exam.
- **Student scheduled-close enforcement** — the student portal blocks exams whose `close_at` time has passed.
- **Completed PWA shell** — added `manifest.webmanifest`, `hmg-icon.svg`, `offline.html`, updated `sw.js`, and `assets/hmg-academy-logo.png`.

Read `ENHANCEMENT_REPORT_DEPLOYMENT.md` for the complete expert feature explanation and deployment process.


---

## 2026 Production-Readiness Enhancement Added in This Package

This enhanced folder adds missing PWA/static deployment assets and two browser-based help tools while preserving all existing CBT features:

- `manifest.webmanifest` — installable PWA metadata.
- `hmg-icon.svg` and `assets/hmg-academy-logo.png` — fixed icon/logo paths used by all portals.
- `deployment_validator.html` — one-click browser readiness checker for required files, HTTPS/PWA basics, Supabase config visibility, and frontend key safety.
- `feature_guide.html` — human-friendly system guide explaining portals, features, free tools, question types, and deployment.
- `_headers` — basic static-hosting security/cache headers for compatible hosts.
- `.nojekyll` — GitHub Pages compatibility marker.
- `EXPERT_ENHANCEMENT_AND_DEPLOYMENT_REPORT.md` — detailed expert understudy, enhancements, feature explanations, and deployment process.

No pre-existing feature was removed. The system still uses free/static tools and does not require any paid AI API.
