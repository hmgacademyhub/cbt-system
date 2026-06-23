# CBT v2 — Expert Enhancement Report and Deployment Guide

Date: 2026-06-23

## Summary

This v2 package further enhances HMG Academy CBT Pro with more question types, always-available Math/Science keyboard access, and deeper admin control including admin-supervised teacher impersonation/control mode.

The platform remains:

- static HTML/CSS/JavaScript;
- Supabase free-tier based;
- no paid AI API;
- no service-role key in frontend;
- deployable to GitHub Pages, Vercel, or Cloudflare Pages.

## New/enhanced features in CBT v2

### 1. Expanded question types

The student portal and teacher import paths now support these additional question types:

- `assertion_reason` — Assertion–Reason logic questions.
- `case_study` — passage/scenario-based MCQ.
- `image_mcq` — image/diagram-based MCQ.
- `matrix` — matrix/grid rows with shared answer choices.
- `hot_text` — select correct words/phrases.
- `code` — typed code, SQL, pseudocode, or algorithm answer.

These are added on top of the existing MCQ, MRQ, TF, short, numeric, matching, ordering, cloze, essay, categorization, and multi-part numeric types.

### 2. Math/Science keyboard always available

The student Math/Science keyboard is now available during exams regardless of whether the exam was created before the keyboard setting existed. This solves the problem where old exams did not show the keyboard because their stored exam object did not contain the newer `math_keyboard` field.

It remains especially useful for:

- H₂O, CO₂, O₂;
- superscripts/subscripts;
- Greek letters;
- calculus/set notation;
- inequalities;
- science units and symbols.

### 3. Admin-supervised teacher impersonation/control mode

The Admin Panel can now open a Teacher Dashboard control mode for a selected teacher.

Important security note:

- This does **not** steal or reveal the teacher's password.
- The admin uses their own authenticated admin token.
- The teacher dashboard is opened with the selected teacher ID as the operating context.
- Supabase RLS/admin policy must be correctly installed so admin operations are allowed.
- A visible warning banner appears in `teacher.html`: **ADMIN CONTROL MODE**.
- Admin can exit control mode and return to `admin.html`.

This allows the owner/admin to help teachers by managing their exams, students, settings, and results without needing their password.

### 4. More admin platform control

The Admin Panel was enhanced with additional platform-wide exam actions:

- open/lock any teacher's exam;
- clear all results for an exam;
- delete an exam;
- delete individual results;
- impersonate/control a teacher dashboard;
- review teacher dashboard summary;
- export platform data.

### 5. Free enterprise features recommended/added

The package also documents or reinforces:

- emergency result backup workflow;
- certificate verification;
- admin security checks;
- deployment validator;
- teacher CSV/XLSX/PDF import paths;
- no-AI rule-based advanced scoring.

## Required deployment process

### Step 1 — Run Supabase SQL

1. Open Supabase Dashboard.
2. Select your project.
3. Go to **SQL Editor**.
4. Open `COMPLETE_SQL_SETUP.sql` from the CBT v2 folder.
5. Copy everything.
6. Paste into SQL Editor.
7. Run it from top to bottom.
8. Confirm success.

This is required for:

- result-saving RPC;
- certificate verification RPC;
- admin RPCs;
- anti-cheat config fields;
- RLS policies.

### Step 2 — Upload files to GitHub

1. Open the `CBT v2` folder.
2. Copy all files inside it.
3. Replace/update the files in your GitHub repository root.
4. Commit changes.
5. Push to GitHub.

### Step 3A — Deploy to Vercel

1. Go to Vercel.
2. Import the GitHub repository.
3. Framework preset: **Other** / **Static**.
4. Build command: leave empty.
5. Output directory: root / empty.
6. Deploy.
7. Add the Vercel domain to Supabase Auth redirect URLs.
8. Visit `/deployment_validator.html`.

### Step 3B — Deploy to Cloudflare Pages

1. Go to Cloudflare Dashboard.
2. Open **Workers & Pages → Pages**.
3. Connect the GitHub repo.
4. Framework preset: **None**.
5. Build command: empty.
6. Output folder: root.
7. Deploy.
8. Add the Cloudflare Pages domain to Supabase Auth redirect URLs.
9. Visit `/deployment_validator.html`.

## Smoke test checklist

After deployment:

1. Login as admin.
2. Open a teacher detail/dashboard.
3. Click **Impersonate / Control Teacher**.
4. Confirm `teacher.html` opens with an **ADMIN CONTROL MODE** banner.
5. Create or edit an exam under that teacher.
6. Add a new advanced question type, e.g. matrix or hot_text.
7. Open the exam as a student.
8. Confirm the Math/Science keyboard is visible during the exam.
9. Submit the result.
10. Confirm the result appears in teacher dashboard.
11. Verify certificate if enabled.
12. Return to Admin Panel and test open/lock/clear results on a test exam.

## Important notes

- Do not add a Supabase service-role key to frontend files.
- Admin impersonation/control mode depends on admin RLS/RPC policies being installed.
- Code/essay scoring is keyword/rule based and should be teacher-reviewed for high-stakes exams.
- Image questions should use data URIs or same-site images for reliable static deployment.
