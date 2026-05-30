# HMG Academy CBT Pro — Diagnosis, Fixes, Feature Guide & Deployment Process

Prepared for **Adewale Samson Adeagbo / HMG Concepts / HMG Academy**.

## 1. Platform purpose

This platform is a free, browser-based Computer-Based Testing (CBT) system for schools, teachers, students, tutors, and virtual learning programmes. It supports:

- **Teacher Dashboard (`teacher.html`)** — teachers create exams, upload/edit question banks, open/lock assessments, share exams, view results, analyse performance, and export reports.
- **Student Portal (`student.html`)** — students access exams, answer timed questions, submit automatically or manually, and receive instant performance feedback.
- **Landing Page (`index.html`)** — public entry point explaining the HMG Academy CBT system and routing users to the teacher/student portals.

The product is aligned with the HMG brand promise: **“Learning Deliberately. Teaching Authentically.”** It is designed as part of **HMG Technologies**, the EdTech/data arm of **HMG Concepts**, founded by **Adewale Samson Adeagbo**.

---

## 2. Brand details embedded

The updated pages now embed the following brand/persona details:

- **Founder:** Adewale Samson Adeagbo
- **Roles:** Data Scientist, STEM Educator, AI-Augmented Solutions Developer, Founder/Visioner of HMG Concepts
- **Experience:** 15+ years teaching in Nigerian classrooms across Lagos and Ogun State
- **Brands:** HMG Concepts, HMG Academy, HMG Technologies, HMG Media
- **Tagline:** Learning Deliberately. Teaching Authentically.
- **Contact:**
  - WhatsApp/Hotline: +234 810 086 6322
  - Phone: +234 907 790 7677
  - Brand Email: hismarvellousgrace@gmail.com
  - Tech/Partnerships: buildingmyictcareer@gmail.com
- **Links:**
  - https://cssadewale.pages.dev
  - https://hmgconcepts.pages.dev
  - https://hmgacademy.pages.dev
  - https://wa.me/2348100866322

---

## 3. Diagnosis summary — bugs and issues found

### 3.1 Teacher sharing gap
**Problem:** The teacher dashboard could copy/share a student link, but it did not make the 6-character exam code clearly visible as a separate access option.

**Fix:** Each assessment now displays:

1. A visible **Student Access Code** block.
2. A visible **Student Link** block.
3. Separate **Copy Code** and **Copy Link** buttons.
4. WhatsApp sharing message now includes both:
   - Option 1: direct link
   - Option 2: access code

### 3.2 Student access gap
**Problem:** `student.html` only worked when a `?code=XXXXXX` query parameter existed in the URL. If a student visited `student.html` directly, the page showed an invalid link message and could not accept a code manually.

**Fix:** The Student Portal now accepts both:

1. A full link, e.g. `student.html?code=ABC123`
2. A raw access code, e.g. `ABC123`

Students can paste either into the new access box.

### 3.3 Hidden identity-strip bug
**Problem:** The student identity strip had conflicting inline CSS: it contained both `display:none` and `display:flex`, causing it to show when it should initially be hidden.

**Fix:** Removed the duplicate `display:flex`; the strip now remains hidden until a registered student is verified and the exam begins.

### 3.4 Question-time key bug
**Problem:** At submission, student question timing was briefly written using `current` instead of the question’s original `_orig` index. This could cause timing mismatch when questions were shuffled.

**Fix:** Removed the incorrect timing write. Timing is now saved against the original question key.

### 3.5 Brand inconsistency
**Problem:** The pages did not fully carry the founder/HMG brand details.

**Fix:** Added brand cards/sections in the landing page, teacher dashboard, and student portal.

---

## 4. Files updated

- `index.html`
- `teacher.html`
- `student.html`
- `DIAGNOSIS_FEATURES_DEPLOYMENT.md`

---

## 5. Feature guide — detailed explanation

### 5.1 Landing page features (`index.html`)

#### 5.1.1 Role-based portal selection
Users can choose:

- Teacher Dashboard
- Student Portal
- Admin Panel link retained from the existing system

#### 5.1.2 Public product explanation
The landing page explains the CBT workflow:

1. Teacher uploads/adds questions.
2. Teacher configures exam settings.
3. Teacher shares link or access code.
4. Student submits exam.
5. Teacher analyses results.

#### 5.1.3 Brand identity section
A new HMG brand section explains:

- Adewale Samson Adeagbo’s role
- HMG Academy’s purpose
- HMG Technologies’ EdTech mission
- Contact channels

---

### 5.2 Teacher Dashboard features (`teacher.html`)

#### 5.2.1 Teacher authentication
Teachers sign in with Supabase Auth. The dashboard supports login, signup, email verification flow, password reset, and password change.

#### 5.2.2 Exam creation
Teachers can configure:

- Subject
- Class/arm
- Term
- Exam type
- Topic/chapter
- Academic session
- Duration
- Attempt limit
- Number of questions to pull
- Pass mark
- Open/locked status
- Auto-close date/time
- Open exam mode or registered-student mode

#### 5.2.3 Question input methods
The system keeps all pre-existing question input methods:

1. **CSV upload** — supports old 7-column format and extended 14-column format.
2. **Manual typing** — teachers can type questions directly.
3. **Excel/XLSX upload** — powered by free SheetJS CDN.
4. **PDF upload** — powered by free PDF.js CDN for text-based PDFs.

#### 5.2.4 Question types
The platform supports:

- MCQ — one correct option
- MRQ — multiple correct options, optional partial credit
- True/False
- Short answer
- Numeric input with tolerance
- Matching
- Ordering/sequencing

#### 5.2.5 Link and code generation — enhanced
Every published exam generates:

- A direct student link: `student.html?code=XXXXXX`
- A 6-character access code: `XXXXXX`

Teachers now see both in the assessment list and can copy either separately.

#### 5.2.6 WhatsApp sharing — enhanced
WhatsApp sharing now tells students:

- Option 1: click the direct link.
- Option 2: enter the access code on the student portal.

#### 5.2.7 Exam management
Teachers can:

- Preview exam questions
- Open/lock exams
- Schedule auto-close
- Duplicate assessments
- Delete exams
- Export question banks
- Edit question banks after publishing

#### 5.2.8 Student roster
Teachers can:

- Add one student manually
- Import students by CSV
- Search/filter class roster
- Remove students
- Create registered-student-only exams

#### 5.2.9 Result dashboard
Teachers can view:

- Student name/class
- Subject/term/type/topic
- Score and percentage
- Correct/wrong/skipped count
- Attempt number
- Time taken
- Integrity flags
- Open/registered student mode

#### 5.2.10 Analytics
Analytics include:

- Score distribution chart
- Pass/fail ratio
- Submission trend
- Top-student leaderboard
- Exportable analytics CSV

Charting uses **Chart.js** via CDN — a free browser-side tool.

#### 5.2.11 Local class insights — no AI API
The “Generate Class Insights” feature is rule-based and runs locally in the browser. It does **not** call OpenAI, Gemini, Claude, or any paid AI API.

It generates:

- Class average
- Pass/fail rate
- Score bands
- Below-40 intervention list
- Near-pass list
- Excellent-student list
- Hardest questions
- Teacher recommendation

#### 5.2.12 Proctoring evidence viewer
Where available, teachers can review:

- Identity intake photos
- Periodic exam snapshots
- Violation logs
- Time-per-question heatmap

The system uses browser-native camera/audio APIs and optional free `face-api.js` from CDN.

---

### 5.3 Student Portal features (`student.html`)

#### 5.3.1 Two access options — enhanced
Students can now access exams through either:

1. A teacher-provided link.
2. A teacher-provided code.

If the student lands on `student.html` without a code, the portal displays an access box.

#### 5.3.2 Open mode
In open mode, students enter:

- Full name
- Class

No account is required.

#### 5.3.3 Registered mode
In registered mode, students must verify their Student ID against the teacher’s roster.

#### 5.3.4 Integrity pledge
Students must accept the academic integrity pledge before starting.

#### 5.3.5 Countdown and timed exam
Before the exam begins, students see a countdown. During the exam, the timer:

- Counts down live
- Shows warning colours near the end
- Auto-submits when time expires

#### 5.3.6 Question navigation
Students can:

- Jump between questions
- See answered/unanswered state
- Flag questions for review
- Jump to first unanswered question

#### 5.3.7 Multiple question types
The student portal renders all supported question types:

- MCQ buttons
- MRQ checkboxes
- True/False cards
- Short-answer input
- Numeric input
- Matching dropdowns
- Ordering drag/drop and up/down controls

#### 5.3.8 Built-in scientific calculator
A free client-side calculator supports:

- Basic operations
- Trigonometry
- Logarithms
- Square/cube powers
- Constants π and e
- Memory operations
- History
- DEG/RAD mode

#### 5.3.9 Anti-cheat/proctoring
The system logs:

- Tab switching
- Window blur
- Right-click
- Copy/cut/paste attempts
- Ctrl shortcuts
- Print/source/devtools attempts
- Fullscreen exit
- Optional face/multiple-person detection
- Optional audio spike detection

After a threshold, the exam can auto-submit.

#### 5.3.10 Instant results
After submission, students see:

- Percentage score
- Grade badge
- Score ring
- Correct/wrong/skipped count
- Time used
- Integrity summary
- Question-by-question review
- Correct answers and explanations
- Export/print result option
- Share result option

---

## 6. Free tools used

The system remains based on free or free-tier tools:

- HTML/CSS/Vanilla JavaScript
- Supabase free tier for Auth, Postgres, RLS, and REST API
- GitHub Pages / Cloudflare Pages / Vercel free static hosting
- Chart.js CDN for analytics charts
- SheetJS CDN for XLSX parsing
- PDF.js CDN for text-based PDF parsing
- face-api.js CDN for optional browser-side face checks
- Web Audio API and MediaDevices API from the browser

No paid AI API is required.

---

## 7. Deployment process — clear steps

### Option A — GitHub Pages deployment

1. Create a GitHub repository, e.g. `cbt-system`.
2. Upload these files to the repository root:
   - `index.html`
   - `teacher.html`
   - `student.html`
   - any future `admin.html` if used
   - `DIAGNOSIS_FEATURES_DEPLOYMENT.md`
3. Commit the files.
4. Go to **Repository Settings → Pages**.
5. Under **Build and deployment**:
   - Source: `Deploy from a branch`
   - Branch: `main`
   - Folder: `/root`
6. Save.
7. GitHub will generate a URL like:
   - `https://YOUR_USERNAME.github.io/cbt-system/`
8. Open:
   - Landing: `https://YOUR_USERNAME.github.io/cbt-system/`
   - Teacher: `https://YOUR_USERNAME.github.io/cbt-system/teacher.html`
   - Student: `https://YOUR_USERNAME.github.io/cbt-system/student.html`

### Option B — Cloudflare Pages deployment

1. Push the project to GitHub.
2. Log in to Cloudflare.
3. Go to **Workers & Pages → Create application → Pages → Connect to Git**.
4. Select the CBT repository.
5. Build settings:
   - Framework preset: `None`
   - Build command: leave blank
   - Build output directory: `/` or leave blank depending on Cloudflare UI
6. Deploy.
7. Your site will be available at something like:
   - `https://your-project.pages.dev`
8. Test:
   - `/index.html`
   - `/teacher.html`
   - `/student.html`

### Option C — Vercel deployment

1. Push files to GitHub.
2. Log in to Vercel.
3. Click **Add New → Project**.
4. Import the repository.
5. Framework preset: `Other` or `Static`.
6. Build command: leave blank.
7. Output directory: leave blank/root.
8. Deploy.
9. Test the generated Vercel URL.

---

## 8. Supabase setup checklist

### 8.1 Confirm Supabase project
The current files contain:

- Supabase URL
- Supabase anon key

If you create a new Supabase project, replace `SB_URL` and `SB_KEY` in both `teacher.html` and `student.html`.

### 8.2 Required tables
At minimum, the database needs:

- `exams`
- `results`
- `students`
- `profiles` if using teacher approval/admin flow

### 8.3 Run SQL setup
Inside the Teacher Dashboard, go to:

**Settings → Supabase Setup Guide**

Run all SQL blocks in order inside:

**Supabase Dashboard → SQL Editor**

Important blocks include:

- Enable RLS
- Exams policies
- Results policies using `SECURITY DEFINER` helper
- Add `answers_data`, `violations`, `violation_log`
- Add `exam_mode`, `student_id_ref`, `student_type`
- Create `students` table
- Add proctoring/time/attempt columns
- Add scoring count columns

### 8.4 Supabase Auth settings
In Supabase:

1. Go to **Authentication → URL Configuration**.
2. Add your deployed site URL as the Site URL.
3. Add redirect URLs for:
   - `https://your-domain/teacher.html`
   - `https://your-domain/student.html`
4. If using GitHub Pages, include the GitHub Pages URL.
5. If using Cloudflare Pages/Vercel, include that deployment URL.

### 8.5 Test database connection
After login, go to:

**Teacher Dashboard → Settings → Live Connection Diagnostic**

Click **Run Diagnostic**. Fix any SQL/RLS warnings shown there.

---

## 9. Post-deployment testing checklist

1. Open landing page.
2. Click Teacher Dashboard.
3. Login or create teacher account.
4. Create a test exam with 2–3 questions.
5. Publish the exam.
6. Confirm the assessment list displays:
   - access code
   - direct link
   - copy code button
   - copy link button
   - WhatsApp button
7. Open `student.html` directly with no code.
8. Paste the code only; confirm exam loads.
9. Open the direct link; confirm exam loads.
10. Submit a test attempt.
11. Return to Teacher Dashboard → Results.
12. Confirm result appears.
13. Click View and confirm answer breakdown opens.
14. Export CSV.
15. Generate class insights.
16. Test on mobile browser.

---

## 10. Recommended next enhancements

These can be added later without paid AI APIs:

1. Offline-first exam cache for low-network environments.
2. Import/export entire exam packages as JSON.
3. Printable exam paper from question bank.
4. Parent/student performance history page.
5. Topic mastery dashboard.
6. Local rule-based recommendation engine per topic.
7. Certificate serial-number verification page.
8. Lightweight PWA install support.
9. Dark/light theme for student portal.
10. Teacher onboarding wizard for first-time setup.

---

## 11. Important note on AI APIs

No AI API was added. The platform uses local browser logic and rule-based analysis for insights. This keeps the system cost-effective and suitable for free deployment.
---

# 12. Additional expert enhancements added in this update

## 12.1 Progressive Web App shell cache

Files added:

- `manifest.webmanifest`
- `sw.js`
- `hmg-icon.svg`

The platform can now behave more like an installable web app on supported browsers. This does **not** make Supabase submissions offline-first, because database writes still require internet, but it improves reliability by caching the static shell files:

- landing page
- teacher dashboard
- student portal
- feature/deployment guide
- app icon/manifest

### What it means in practice

If the pages were opened before, the browser may still load the app shell during weak network conditions. Supabase login, exam loading, and result submission still require internet.

### Why this is free

It uses only browser-native Service Worker and Web App Manifest standards. No paid service is involved.

---

## 12.2 Teacher exam package export/import

### New export feature

Each assessment row now has a **📦 Package** button. It downloads a JSON exam package containing:

- exam metadata
- duration
- pass mark
- attempt limit
- student mode
- question bank
- original code for reference
- HMG brand metadata

### New import feature

The Create Exam page now includes **Restore / Reuse Exam Package**. A teacher can import an exported JSON package, review the settings, edit questions if desired, and publish it as a new assessment.

### Use cases

- Backup exams before major edits
- Move exams between deployments
- Reuse last term’s exam as a template
- Share question-bank packages between authorised HMG teachers
- Restore an exam after accidental deletion

### Important note

Imported packages publish as new exams with a fresh access code. This prevents accidental reuse of old codes.

---

## 12.3 CSV template downloads

New template download buttons were added for:

1. **Question CSV template**
2. **Student roster CSV template**

### Question CSV template includes examples for:

- MCQ
- MRQ
- True/False
- Short answer
- Numeric input
- Matching
- Ordering

### Student roster template includes:

```csv
FullName,StudentID,Class
ADEWALE SAMSON,SS/2026/001,SSS2A
FATIMA IBRAHIM,SS/2026/002,SSS2A
```

This reduces formatting errors and helps new teachers onboard faster.

---

## 12.4 Copy full student instructions

Each assessment row now has a **📋 Instructions** button. It copies a clean message containing:

- Subject
- Class
- Term
- Exam type
- Duration
- Direct link
- Access code
- Student rules
- HMG Academy CBT branding

This is useful for WhatsApp groups, Google Classroom, Telegram, SMS, or email.

---

## 12.5 Student network status indicator

The student portal now has a visible online/offline indicator:

- `● Online`
- `● Offline`

If a student goes offline, the portal warns them that result saving may require a backup download.

---

## 12.6 Emergency result backup JSON

If the result cannot save to Supabase, the student result page now offers:

**⬇ Download Backup JSON**

The backup file contains:

- student identity
- exam ID
- score
- correct/wrong/skipped counts
- answers data
- violation log
- proctoring payload, if available
- timestamp
- HMG brand metadata

### Teacher/admin handling process

If a student sends a backup JSON file:

1. Open the JSON file.
2. Confirm the student name, exam ID, score, and timestamp.
3. Compare with screenshots if needed.
4. If required, manually insert the record in Supabase `results` table or keep it as audit evidence.

This is a no-cost safeguard for unstable internet environments.

---

## 12.7 Student draft restore

The student portal already had local autosave logic. It now actively restores saved answers from the same device when the exam resumes.

### What is restored

- selected answers
- flagged questions
- current question position
- shuffled question order, where possible

### Limitation

Timer recovery is still conservative. The exam timer restarts from the configured exam duration after re-entry, so teachers should rely on attempt limits and integrity logs for strict environments. A future enhancement can store server-side start time, but that would require a schema change.

---

# 13. Updated deployment checklist including new files

When deploying, include these additional files:

```text
manifest.webmanifest
sw.js
hmg-icon.svg
DIAGNOSIS_FEATURES_DEPLOYMENT.md
```

Your final project root should contain at least:

```text
index.html
teacher.html
student.html
manifest.webmanifest
sw.js
hmg-icon.svg
DIAGNOSIS_FEATURES_DEPLOYMENT.md
```

If using an admin panel, also include:

```text
admin.html
```

---

# 14. Full deployment steps — updated and explicit

## 14.1 Prepare the files

1. Create a folder on your device named `hmg-cbt-system`.
2. Put these files inside it:
   - `index.html`
   - `teacher.html`
   - `student.html`
   - `manifest.webmanifest`
   - `sw.js`
   - `hmg-icon.svg`
   - `DIAGNOSIS_FEATURES_DEPLOYMENT.md`
3. If you have `admin.html`, add it too.

## 14.2 Confirm Supabase credentials

Open both:

- `teacher.html`
- `student.html`

Confirm these constants are correct:

```js
const SB_URL='https://your-project.supabase.co';
const SB_KEY='your-anon-key';
```

If you keep using the existing Supabase project, do not change them.

## 14.3 Deploy to GitHub Pages

1. Go to GitHub.
2. Create a new repository, e.g. `cbt-system`.
3. Upload all project files to the repository root.
4. Commit changes.
5. Go to **Settings → Pages**.
6. Under **Build and deployment**:
   - Source: `Deploy from a branch`
   - Branch: `main`
   - Folder: `/root`
7. Click **Save**.
8. Wait for GitHub Pages to publish.
9. Visit:

```text
https://YOUR_USERNAME.github.io/cbt-system/
https://YOUR_USERNAME.github.io/cbt-system/teacher.html
https://YOUR_USERNAME.github.io/cbt-system/student.html
```

## 14.4 Deploy to Cloudflare Pages

1. Push the same folder to GitHub.
2. Log in to Cloudflare.
3. Go to **Workers & Pages**.
4. Click **Create Application → Pages → Connect to Git**.
5. Select the repository.
6. Use these settings:
   - Framework preset: `None`
   - Build command: blank
   - Output directory: `/` or blank
7. Click **Deploy**.
8. Test:

```text
https://your-project.pages.dev/
https://your-project.pages.dev/teacher.html
https://your-project.pages.dev/student.html
```

## 14.5 Deploy to Vercel

1. Push the project to GitHub.
2. Log in to Vercel.
3. Click **Add New → Project**.
4. Import the repository.
5. Use:
   - Framework preset: `Other`
   - Build command: blank
   - Output directory: blank/root
6. Click **Deploy**.
7. Test the generated Vercel URL.

---

# 15. Supabase setup steps — unambiguous order

## Step 1 — Open Supabase

1. Log in to Supabase.
2. Open your CBT project.
3. Go to **SQL Editor**.

## Step 2 — Run the SQL guide inside Teacher Dashboard

1. Open deployed `teacher.html`.
2. Log in.
3. Go to **Settings**.
4. Scroll to **Supabase Setup Guide**.
5. Copy and run each SQL block in order.

Run all sections including:

- RLS activation
- Exams policies
- Results policies
- Helper function `get_exam_teacher_id`
- Optional result columns
- Student mode columns
- Students table
- Proctoring columns
- Scoring count columns
- Admin RPC functions if using admin panel

## Step 3 — Configure Auth redirect URLs

In Supabase:

1. Go to **Authentication → URL Configuration**.
2. Set **Site URL** to your production URL, for example:

```text
https://your-project.pages.dev
```

3. Add redirect URLs:

```text
https://your-project.pages.dev/teacher.html
https://your-project.pages.dev/student.html
https://YOUR_USERNAME.github.io/cbt-system/teacher.html
https://YOUR_USERNAME.github.io/cbt-system/student.html
```

Use only the ones relevant to your deployment.

## Step 4 — Run diagnostic

1. Log into the Teacher Dashboard.
2. Go to **Settings**.
3. Click **Run Diagnostic**.
4. Fix any red error shown.

---

# 16. Final acceptance test

After deployment, perform this test:

1. Open `teacher.html`.
2. Log in.
3. Create a test exam with at least:
   - one MCQ
   - one True/False
   - one short answer
4. Publish the exam.
5. Confirm you see:
   - access code
   - student link
   - instructions button
   - package export button
6. Click **📋 Instructions** and paste somewhere to confirm it copies correctly.
7. Click **📦 Package** and confirm JSON downloads.
8. Go to `student.html` directly.
9. Paste only the code and load the exam.
10. Submit the exam.
11. Confirm the result saves.
12. Return to Teacher Dashboard → Results.
13. Open the result breakdown.
14. Export analytics CSV.
15. Import the JSON package into Create Exam and confirm the questions restore.

If all steps pass, the deployment is healthy.

---

# 17. New assessment depth update — 11+ question types

The system has been further enhanced to evaluate students with more than simple objective questions. The supported type list is now:

1. `mcq` — multiple choice
2. `tf` — true/false
3. `mrq` — multiple response / checkbox
4. `short` — short typed answer
5. `numeric` — single numeric answer with tolerance
6. `matching` — left/right pairing
7. `ordering` — sequencing / arrangement
8. `cloze` — multi-blank fill-in-the-gap
9. `essay` — long response scored by keyword/minimum-word rules
10. `categorization` — assign items to correct categories
11. `multi_numeric` — several numeric parts inside one question

## 17.1 Why these types matter

- MCQ and TF test recognition.
- MRQ tests complete conceptual understanding.
- Short answer reduces guessing.
- Numeric tests calculation accuracy.
- Matching tests relationship knowledge.
- Ordering tests process understanding.
- Cloze tests recall inside structured statements.
- Essay tests expression and reasoning without paid AI.
- Categorization tests classification skill.
- Multi-part numeric tests step-by-step problem solving.

## 17.2 No paid AI marking

The essay type does **not** use AI APIs. It uses:

- configured keywords
- minimum word count
- rule-based score

This keeps the system cost-effective. Teachers should review essay answers manually where the judgement is important.

## 17.3 Advanced CSV examples

### Cloze

```csv
"Force = ___ × ___.","","","","","","Force equals mass times acceleration.","cloze","","","","","","[""mass|m"",""acceleration|a""]"
```

### Essay

```csv
"Explain why honesty matters in examinations.","","","","","","Teacher review recommended.","essay","","","honesty|fairness|trust","","","{""min_words"":30,""keywords"":[""honesty"",""fairness"",""trust""]}"
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

# 18. Repository documentation files updated

The remaining repository files were updated to reflect the new development:

- `README.md`
- `CONTRIBUTING.md`
- `SECURITY.md`
- `PROMPT_TEMPLATE.md`
- `LICENSE.txt`
- `further_maths_sample.csv`

The sample CSV now includes advanced question-type examples and a corrected AP answer row.

---

# 19. Updated deployment file list

Deploy these files together:

```text
index.html
teacher.html
student.html
README.md
CONTRIBUTING.md
SECURITY.md
PROMPT_TEMPLATE.md
LICENSE.txt
DIAGNOSIS_FEATURES_DEPLOYMENT.md
further_maths_sample.csv
manifest.webmanifest
sw.js
hmg-icon.svg
```

If your repo includes an admin portal, also deploy:

```text
admin.html
```

---

# 20. Final post-update testing checklist

1. Upload `further_maths_sample.csv` in the Teacher Dashboard.
2. Confirm all 11 types parse.
3. Publish the exam.
4. Open the student portal by link.
5. Open the student portal by raw code.
6. Answer each type:
   - MCQ
   - TF
   - MRQ
   - short
   - numeric
   - matching
   - ordering
   - cloze
   - essay
   - categorization
   - multi_numeric
7. Submit the exam.
8. Confirm the result page shows correct/wrong/skipped counts.
9. Confirm the Teacher Dashboard result row appears.
10. Open the Teacher View modal and confirm advanced type responses are visible.
11. Export CSV results.
12. Export the exam package.
13. Import the exam package into Create Exam and confirm the question bank restores.

If all steps pass, the enhanced platform is ready for production deployment.

---

# 21. HMG Academy ecosystem and enterprise package update

The uploaded HMG Academy logo has been added to the platform and the system is now packaged for enterprise-style deployment.

## 21.1 Logo placement

The official HMG Academy logo is used in:

- landing page navbar
- landing page hero section
- landing page footer
- teacher login screen
- teacher dashboard sidebar
- student portal entry screen
- student result screen
- PWA manifest/icon references
- printable exam access sheet

Logo path:

```text
assets/hmg-academy-logo.png
```

## 21.2 Enterprise Operations added to Teacher Settings

A new **Enterprise Operations** panel provides:

1. **Export Teacher Backup** — downloads exams, result summaries, student roster, and metadata as JSON.
2. **Deployment Checklist** — downloads a plain text deployment checklist.
3. **Security Checklist** — downloads a plain text security checklist.

These use browser-side downloads and existing teacher-visible data. No paid service is involved.

## 21.3 Printable exam access sheet

Each exam now includes a printable access sheet with:

- HMG logo
- exam title and metadata
- large access code
- direct student link
- student instructions
- generation timestamp

This is useful for CBT labs, invigilators, school notice boards, and WhatsApp image sharing.

## 21.4 Enterprise folder and ZIP

A deployment-ready folder named `enterprise` has been created. It contains all necessary files for GitHub or static hosting deployment.

A zipped copy named `enterprise.zip` has also been created.
