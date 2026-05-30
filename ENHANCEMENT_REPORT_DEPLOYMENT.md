# HMG Academy CBT Pro — Expert Enhancement Report, Feature Explanation & Deployment Guide

Prepared for **HMG Concepts / HMG Academy**.

Date: **2026-05-28**

---

## 1. Purpose of the system

HMG Academy CBT Pro is a free, browser-based Computer-Based Testing platform for real classrooms, tutorial centres, virtual academies, and schools. It allows:

- teachers to create and manage assessments;
- students to take timed exams with a link or access code;
- results to be saved to Supabase;
- teachers/admins to analyse performance and export reports;
- schools to deploy without paid AI APIs, paid hosting, or framework build steps.

The system uses **plain HTML, CSS, JavaScript, Supabase free tier, static hosting, and browser APIs**.

---

## 2. Files and roles

| File / Folder | Purpose |
|---|---|
| `index.html` | Public landing page and role selector. |
| `teacher.html` | Teacher dashboard for exam creation, question bank, results, analytics, roster, settings, backups, and deployment tools. |
| `student.html` | Student exam portal with code/link entry, timed exam, anti-cheat, calculator, result review, and emergency backup. |
| `admin.html` | New free admin panel for teacher approval, platform oversight, security checks, and exports. |
| `manifest.webmanifest` | PWA metadata for installable app shell. |
| `sw.js` | Service worker that caches static app shell files and provides offline fallback. |
| `offline.html` | Friendly offline page explaining what can/cannot work offline. |
| `hmg-icon.svg` | Lightweight generated SVG app icon. |
| `assets/hmg-academy-logo.png` | Official HMG Academy logo used across the app. |
| `further_maths_sample.csv` | Sample question bank with 11+ question types. |
| `README.md` | Project summary and usage guide. |
| `DIAGNOSIS_FEATURES_DEPLOYMENT.md` | Existing detailed diagnosis/features/deployment documentation. |
| `ENTERPRISE_DEPLOYMENT_GUIDE.md` | Enterprise packaging and deployment guide. |
| `ENHANCEMENT_REPORT_DEPLOYMENT.md` | This expert enhancement report. |

---

## 3. Enhancements added in this update

### 3.1 Admin Panel (`admin.html`)

A new admin portal has been added without using any paid service.

#### What it does

- Admin login using Supabase Auth.
- Confirms admin access by either:
  - matching the configured `ADMIN_EMAIL`; or
  - detecting `profiles.is_admin === true`; or
  - detecting `profiles.role === 'admin'`.
- Loads all teacher profiles.
- Lets admin approve, set pending, or deactivate teacher accounts.
- Loads all exams.
- Loads all results.
- Displays platform KPIs:
  - total teachers;
  - pending teachers;
  - total exams;
  - total submissions;
  - integrity flags.
- Exports platform CSV for audit/record keeping.
- Downloads an admin checklist.
- Downloads a Supabase RLS smoke-test SQL file.
- Shows security/deployment diagnostics.

#### Why it matters

The existing landing page and teacher dashboard referenced an admin panel, but an `admin.html` file was not included. This has now been fixed. Schools can now manage teachers and monitor platform usage from one place.

#### Free-tool compliance

The admin panel uses only:

- Supabase Auth;
- Supabase REST/RPC;
- browser JavaScript;
- CSV/text downloads.

It does **not** use service-role keys, paid APIs, or paid AI tools.

---

### 3.2 Teacher emergency backup importer

The Student Portal already allowed a student to download an emergency result backup JSON if server saving failed. The Teacher Dashboard has now been enhanced with a matching import workflow.

#### Location

`Teacher Dashboard → Settings → Enterprise Operations → Import Student Backup JSON`

#### What it does

- Teacher selects the JSON backup sent by a student.
- System validates that the backup belongs to an exam owned by the logged-in teacher.
- System imports the result into the `results` table.
- It attempts a full insert first, then gracefully falls back if optional SQL columns are missing.
- After import, the teacher is taken to the Results page.

#### Why it matters

This closes the loop for unstable internet environments. A student can still prove their attempt, and the teacher can restore it into the dashboard without manually writing SQL.

---

### 3.3 Item analysis CSV export

A new local, rule-based item analysis export was added to the Results page.

#### Location

`Teacher Dashboard → Results → Item Analysis CSV`

#### What it does

When a teacher filters results to one exam, it exports per-question statistics:

- question number;
- question type;
- question text;
- number of submissions;
- attempted count;
- correct count;
- partial-credit count;
- wrong count;
- skipped count;
- error rate;
- average time spent.

#### Why it matters

This helps teachers identify:

- hard questions;
- weak topics;
- confusing options;
- questions students skipped;
- questions taking too long.

This is a free alternative to AI-generated analytics. It uses stored answers and rule-based scoring in the browser.

---

### 3.4 Student-side scheduled close enforcement

The student portal now checks `exam.close_at` before allowing entry.

#### Why it matters

Previously, scheduled auto-close depended mainly on the teacher dashboard polling. If the teacher dashboard was not open, an expired exam could remain technically open until the teacher returned. Now, even if `is_open` is still true, the student portal blocks access when the scheduled closing time has passed.

---

### 3.5 PWA and offline shell completion

Added/updated:

- `manifest.webmanifest`
- `hmg-icon.svg`
- `offline.html`
- `sw.js` cache version `v3`
- `assets/hmg-academy-logo.png`

#### What it does

- Allows supported browsers to install the platform as an app-like shortcut.
- Caches core static pages after first visit.
- Shows a friendly offline page when navigation fails.
- Avoids intercepting Supabase/API/CDN network requests.

#### Important limitation

Offline shell support does **not** mean offline exams can be fully submitted. Supabase login, exam loading, roster verification, and result saving still require internet.

---

## 4. Existing features preserved

No pre-existing feature was removed. The system still supports:

- teacher signup/login;
- exam creation;
- CSV/XLSX/PDF/manual question input;
- 11+ question types;
- direct link + raw code student access;
- open and registered-student modes;
- roster import;
- timed exams;
- randomised question order;
- calculator;
- integrity logging;
- optional browser-based proctoring;
- instant results;
- PDF/print result;
- result CSV export;
- analytics charts;
- rule-based class insights;
- exam package export/import;
- teacher backup export;
- deployment and security checklists.

---

## 5. Feature explanations by portal

### 5.1 Landing page

- Introduces HMG Academy CBT Pro.
- Routes users to Teacher, Student, and Admin portals.
- Explains workflow: create exam → share code/link → student submits → teacher analyses.
- Displays HMG Academy branding and contact links.

### 5.2 Teacher Dashboard

#### Exam creation

Teachers configure subject, class, term, type, topic, session, duration, attempt limit, pass mark, question count, open/locked status, scheduled close, and student access mode.

#### Question bank

Questions can come from:

- CSV;
- XLSX;
- PDF text extraction;
- manual typing;
- JSON exam package import.

#### Question types

The system supports:

1. MCQ;
2. True/False;
3. Multiple Response;
4. Short Answer;
5. Numeric;
6. Matching;
7. Ordering;
8. Cloze;
9. Essay/keyword response;
10. Categorization;
11. Multi-part numeric.

#### Results and analytics

Teachers can view:

- scores;
- percentages;
- correct/wrong/skipped counts;
- time taken;
- integrity flags;
- answer breakdown;
- proctor evidence;
- charts;
- leaderboard;
- class insights;
- item analysis CSV.

#### Enterprise operations

Teachers can:

- export full teacher backup;
- import student emergency backup JSON;
- download deployment checklist;
- download security checklist.

### 5.3 Student Portal

Students can:

- paste a full link;
- enter a raw access code;
- verify student ID in registered mode;
- accept integrity pledge;
- take timed exams;
- use a scientific calculator;
- answer 11+ question types;
- flag questions;
- receive instant result;
- download emergency backup JSON if saving fails.

### 5.4 Admin Panel

Admins can:

- review teachers;
- approve/deactivate accounts;
- inspect exams and submissions;
- export platform CSV;
- download setup/security SQL checklists;
- monitor integrity flags.

---

## 6. Why no AI API is used

Paid AI APIs are not cost-effective for free school deployment. Therefore:

- essay scoring is keyword/minimum-word rule based;
- class insights are generated with local browser rules;
- item analysis uses stored answer data;
- recommendations are deterministic and transparent.

Teachers should manually review important essay responses and flagged submissions.

---

## 7. Deployment steps — GitHub Pages

1. Create a folder named `hmg-cbt-enhanced`.
2. Ensure it contains all files in this enhanced package.
3. Create a new GitHub repository.
4. Upload the **contents** of `hmg-cbt-enhanced` to the repository root.
5. Commit the files.
6. Open **Settings → Pages**.
7. Under **Build and deployment**, select:

```text
Source: Deploy from a branch
Branch: main
Folder: /root
```

8. Save.
9. Wait for GitHub Pages to publish.
10. Test these URLs:

```text
https://YOUR_USERNAME.github.io/YOUR_REPO/
https://YOUR_USERNAME.github.io/YOUR_REPO/teacher.html
https://YOUR_USERNAME.github.io/YOUR_REPO/student.html
https://YOUR_USERNAME.github.io/YOUR_REPO/admin.html
```

---

## 8. Deployment steps — Cloudflare Pages

1. Push the enhanced folder to GitHub.
2. Log in to Cloudflare.
3. Go to **Workers & Pages**.
4. Click **Create application → Pages → Connect to Git**.
5. Select the repository.
6. Use these settings:

```text
Framework preset: None
Build command: blank
Output directory: blank or /
```

7. Click **Deploy**.
8. Test:

```text
https://your-project.pages.dev/
https://your-project.pages.dev/teacher.html
https://your-project.pages.dev/student.html
https://your-project.pages.dev/admin.html
```

---

## 9. Deployment steps — Vercel

1. Push the enhanced files to GitHub.
2. Log in to Vercel.
3. Click **Add New → Project**.
4. Import the repository.
5. Use:

```text
Framework preset: Other / Static
Build command: blank
Output directory: blank/root
```

6. Deploy.
7. Test the Vercel URLs for landing, teacher, student, and admin pages.

---

## 10. Supabase setup order

### Step 1 — Confirm credentials

Open `teacher.html`, `student.html`, and `admin.html`.

Confirm:

```js
const SB_URL='https://your-project.supabase.co';
const SB_KEY='your-anon-public-key';
```

Never use the Supabase `service_role` key in frontend files.

### Step 2 — Run SQL setup

1. Open deployed `teacher.html`.
2. Log in as teacher/admin.
3. Go to **Settings → Supabase Setup Guide**.
4. Copy and run each SQL block in Supabase SQL Editor.
5. Include:
   - RLS activation;
   - exams policies;
   - results policies;
   - `get_exam_teacher_id` helper;
   - students table;
   - profiles/admin setup;
   - optional result columns;
   - admin RPC functions.

### Step 3 — Configure Supabase Auth URLs

In Supabase:

```text
Authentication → URL Configuration
```

Set Site URL and Redirect URLs, for example:

```text
https://your-domain/
https://your-domain/teacher.html
https://your-domain/student.html
https://your-domain/admin.html
```

Add GitHub Pages, Cloudflare Pages, or Vercel URLs as needed.

### Step 4 — Verify admin

Make sure your admin account has either:

```text
email = buildingmyictcareer@gmail.com
```

or in `profiles`:

```text
is_admin = true
```

or:

```text
role = 'admin'
```

### Step 5 — Run diagnostics

- Teacher Dashboard → Settings → Live Diagnostic.
- Admin Panel → Security tab → download SQL smoke test and run it.

---

## 11. Final acceptance test

1. Open landing page and confirm logo loads.
2. Open `teacher.html` and log in.
3. Create a small test exam.
4. Confirm access code and direct link display.
5. Open `student.html` directly and paste the raw code.
6. Submit one test attempt.
7. Confirm result appears in Teacher Dashboard.
8. Export Results CSV.
9. Filter to the test exam and export Item Analysis CSV.
10. Export the exam package.
11. Export teacher backup.
12. Test emergency backup import using a backup JSON file.
13. Open `admin.html` and confirm teacher/exam/result counts load.
14. Approve/deactivate a test teacher account if applicable.
15. Test mobile browser.
16. Test scheduled close by setting a close time and trying to enter after it passes.

If all items pass, the enhanced platform is production-ready.
