# HMG Academy CBT Pro — Enterprise Deployment Guide

This folder is ready for upload to GitHub, GitHub Pages, Cloudflare Pages, Vercel, Netlify, or any static hosting provider.

The platform is part of the **HMG Academy ecosystem** under **HMG Concepts** and uses the official HMG Academy logo in the landing page, teacher dashboard, student portal, PWA manifest, and result flow.

---

## 1. Enterprise package contents

The `enterprise` folder should contain:

```text
enterprise/
├── index.html
├── teacher.html
├── student.html
├── manifest.webmanifest
├── sw.js
├── hmg-icon.svg
├── README.md
├── CONTRIBUTING.md
├── SECURITY.md
├── PROMPT_TEMPLATE.md
├── LICENSE.txt
├── DIAGNOSIS_FEATURES_DEPLOYMENT.md
├── ENTERPRISE_DEPLOYMENT_GUIDE.md
├── further_maths_sample.csv
└── assets/
    └── hmg-academy-logo.png
```

If your repository also includes an admin panel, add:

```text
admin.html
```

---

## 2. Enterprise features added

### 2.1 Official HMG Academy branding

The uploaded HMG Academy logo is now embedded across the system:

- landing page hero
- landing page navbar/footer
- teacher login screen
- teacher dashboard sidebar
- student entry screen
- student result screen
- PWA icon reference
- printable exam access sheet

### 2.2 Institution-ready exam access sheet

Teachers can print an **Access Sheet** for each assessment. It includes:

- HMG logo
- subject/class/term/type
- duration and pass mark
- large student access code
- direct exam link
- student rules
- generated timestamp

Use cases:

- CBT lab notice board
- WhatsApp group screenshot
- invigilator file
- printed instruction sheet

### 2.3 Enterprise teacher backup

The Teacher Dashboard now includes **Enterprise Operations** in Settings.

Teachers can export a backup JSON containing:

- exams
- visible result summaries
- student roster
- backup metadata
- HMG brand metadata

This is useful for:

- migration
- audit
- termly archive
- disaster recovery
- handover between school administrators

### 2.4 Deployment checklist download

Teachers/admins can download a plain text deployment checklist from the dashboard. This is useful when deploying for partner schools or multiple academies.

### 2.5 Security checklist download

Teachers/admins can download a school-facing security checklist covering:

- Supabase keys
- RLS
- exam code handling
- backups
- flagged submissions
- HTTPS hosting

### 2.6 11+ question types

The system supports:

1. MCQ
2. True/False
3. Multiple Response
4. Short Answer
5. Numeric
6. Matching
7. Ordering
8. Cloze / Multi-Blank
9. Essay / Keyword Response
10. Categorization
11. Multi-Part Numeric

All advanced scoring is rule-based. No AI API is used.

### 2.7 Link + code access

Students can enter an exam in two ways:

- direct link
- raw access code

This solves the common issue where students receive only the code through WhatsApp or SMS.

### 2.8 PWA shell support

The app includes a manifest and service worker. The static shell can be cached by the browser, improving the app-like feel. Database operations still need internet.

### 2.9 Emergency student backup

If result submission fails due to network or database setup issues, the student can download a backup JSON and send it to the teacher.

---

## 3. Free tools only

The enterprise edition still uses only free or free-tier tools:

- HTML/CSS/Vanilla JavaScript
- Supabase free tier
- GitHub Pages / Cloudflare Pages / Vercel
- Chart.js CDN
- SheetJS CDN
- PDF.js CDN
- face-api.js CDN
- browser Web Audio API
- browser MediaDevices API
- browser Service Worker API

No paid AI API is required.

---

## 4. Deployment to GitHub Pages

1. Create a new GitHub repository.
2. Upload everything inside the `enterprise` folder to the repository root.
3. Commit changes.
4. Open repository **Settings**.
5. Go to **Pages**.
6. Select:

```text
Source: Deploy from a branch
Branch: main
Folder: /root
```

7. Save.
8. Wait for GitHub to publish.
9. Test:

```text
https://YOUR_USERNAME.github.io/YOUR_REPO/
https://YOUR_USERNAME.github.io/YOUR_REPO/teacher.html
https://YOUR_USERNAME.github.io/YOUR_REPO/student.html
```

---

## 5. Deployment to Cloudflare Pages

1. Push the enterprise files to GitHub.
2. Log in to Cloudflare.
3. Go to **Workers & Pages**.
4. Click **Create Application**.
5. Select **Pages**.
6. Connect your GitHub repository.
7. Use:

```text
Framework preset: None
Build command: blank
Output directory: blank or /
```

8. Deploy.
9. Test:

```text
https://your-project.pages.dev/
https://your-project.pages.dev/teacher.html
https://your-project.pages.dev/student.html
```

---

## 6. Deployment to Vercel

1. Push enterprise files to GitHub.
2. Log in to Vercel.
3. Click **Add New → Project**.
4. Import the repository.
5. Use:

```text
Framework preset: Other
Build command: blank
Output directory: blank/root
```

6. Deploy.
7. Test the generated URLs.

---

## 7. Supabase setup

### 7.1 Confirm credentials

Open:

- `teacher.html`
- `student.html`

Confirm:

```js
const SB_URL='https://your-project.supabase.co';
const SB_KEY='your-anon-public-key';
```

### 7.2 Run SQL setup

1. Deploy the site.
2. Open `teacher.html`.
3. Log in.
4. Go to **Settings → Supabase Setup Guide**.
5. Run every SQL block in Supabase SQL Editor.

### 7.3 Required tables

- `exams`
- `results`
- `students`
- `profiles`

### 7.4 Required important result columns

- `answers_data`
- `violations`
- `violation_log`
- `proctor_data`
- `time_taken`
- `attempt_number`
- `correct_count`
- `wrong_count`
- `skipped_count`
- `student_id_ref`
- `student_type`

### 7.5 Auth URLs

In Supabase:

```text
Authentication → URL Configuration
```

Add:

```text
https://your-domain/teacher.html
https://your-domain/student.html
```

Also add GitHub Pages / Cloudflare / Vercel URLs if you use them.

---

## 8. Production testing checklist

Before announcing to students:

1. Open landing page.
2. Confirm the HMG logo displays.
3. Login as teacher.
4. Create or import an exam.
5. Confirm exam code and link display.
6. Print access sheet.
7. Export exam package.
8. Export teacher backup.
9. Open student portal directly.
10. Enter raw code.
11. Complete all question types.
12. Submit result.
13. Confirm result appears in teacher dashboard.
14. Open teacher result breakdown.
15. Export result CSV.
16. Run Live Diagnostic in Settings.
17. Test on Android phone.
18. Test on desktop browser.

---

## 9. Operational advice for schools

- Use registered mode for formal exams.
- Keep exam codes private until exam time.
- Regenerate/recreate exams if a code leaks.
- Export teacher backup at the end of each term.
- Review flagged submissions manually.
- Treat result backups and proctor photos as confidential student records.
- Do not depend solely on browser anti-cheat; combine with school policy and supervision.

---

## 10. No AI API note

The platform does not call paid AI APIs. Rule-based insights and scoring are performed locally in the browser. This keeps the platform affordable and sustainable for HMG Academy, partner schools, and Nigerian classrooms.

---

## 11. 2026 Expert Enhancement Addendum

The enhanced enterprise package now includes:

```text
admin.html
offline.html
ENHANCEMENT_REPORT_DEPLOYMENT.md
```

Additional features:

1. **Admin Panel** — teacher approval/status management, platform KPIs, all-exam/all-result visibility through Supabase RPC/direct fallback, platform CSV export, and security checklist downloads.
2. **Emergency Backup Importer** — teachers can import a student's backup JSON from Teacher Dashboard → Settings → Enterprise Operations.
3. **Item Analysis CSV** — teachers can filter to one exam and export question-level diagnostics for remediation.
4. **Student-side Scheduled Close Check** — students are blocked if the exam close time has passed, even if the teacher dashboard is not open.
5. **Offline Fallback Page** — static app shell caching now has a friendly `offline.html` fallback.

For details and exact deployment/test steps, see `ENHANCEMENT_REPORT_DEPLOYMENT.md`.
