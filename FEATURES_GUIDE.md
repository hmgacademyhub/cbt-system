# HMG Academy CBT Pro — Features Guide

## Teacher Dashboard (teacher.html)

### Authentication
- Email/Password Login via Supabase Auth
- Account Registration (self-service signup)
- Password Reset (email-based recovery)
- Account Approval (admin workflow)
- Session Management (auto-logout on inactivity)
- Password Strength Meter (visual security indicator)

### Dashboard Home
- Overview Stats (total exams, submissions, pass rate, integrity flags)
- Recent Activity (latest submissions with scores)
- Quick Actions (shortcuts to create exam, results, assessments, settings)
- Live Exams (summary of active exams)

### Create Exam
- Academic Context: Subject, Class, Term, Type, Topic, Session
- Duration: Configurable in minutes
- Attempt Limits: Strict (1), Standard (2), Unlimited
- Question Selection: Specific count or all
- Pass Mark: Configurable percentage
- Auto-Close: Scheduled closure date/time
- Exam Status: Open immediately or locked
- Student Access Mode: Open or Registered

### Question Upload Methods
- CSV Upload (14-column format, all question types)
- Manual Entry (type directly with type-specific forms)
- Excel XLSX Import (from spreadsheets)
- PDF Import (basic text extraction)
- Template Download (pre-formatted CSV and student roster templates)

### 11 Question Types
1. Multiple Choice (mcq) — One correct answer from A, B, C, D
2. Multiple Response (mrq) — One or more correct answers (checkboxes)
3. True/False (tf) — Binary choice
4. Short Answer (short) — Type a word or phrase
5. Numeric (numeric) — Number with configurable tolerance
6. Matching (matching) — Pair left and right items
7. Ordering (ordering) — Arrange items in correct sequence
8. Cloze (cloze) — Fill-in-the-blank (multiple blanks)
9. Essay (essay) — Keyword-based evaluation
10. Categorization (categorization) — Classify items into groups
11. Multi-Numeric (multi_numeric) — Multiple numeric answers

### Assessments Management
- Search and Filter: By subject, class, term, type, status, keyword
- Sort: By date, subject, or class
- Edit: Full editing of ALL exam properties (NEW!)
- Preview: See exactly what students will see
- Question Bank: View and edit individual questions
- Duplicate: Create a copy as a new locked draft
- Open/Lock: Toggle exam availability instantly
- Schedule: Set auto-close date and time
- Copy Code: Copy 6-character access code to clipboard
- Copy Link: Copy student access URL to clipboard
- Instructions: Copy full student instructions to clipboard
- Print Sheet: Print invigilation/access sheet
- Package Export: Download exam as reusable JSON file
- WhatsApp Share: Generate and share WhatsApp link
- Delete: Permanently remove exam with confirmation

### Full Exam Editing (NEW!)
- Subject: Change exam subject name
- Class/Arm: Change class designation
- Term: Change term (1st/2nd/3rd)
- Exam Type: Change assessment type
- Topic: Change topic/chapter name
- Session: Change academic session
- Duration: Change time limit in minutes
- Attempts: Change allowed attempts (1, 2, or unlimited)
- Questions to Pull: Change number of questions from bank
- Pass Mark: Change passing percentage threshold
- Auto-Close Date: Change or remove scheduled closure
- Open/Lock Status: Change availability
- Exam Mode: Change between Open and Registered
- Add Questions: Append new questions via CSV upload or manually
- View Info: Access code, student link, question count, submission count

### Results Management
- Leaderboard (ranked student scores)
- Filter (by exam, date range, score range)
- Answer Breakdown (per-student correct/wrong/skipped)
- Score Distribution (visual histogram)
- Print Slips (individual result certificates)
- CSV Export (download all results as spreadsheet)
- Real-time Polling (auto-refresh for new submissions)
- Proctor Photos (view student photos if captured)

### Students Management
- Class Roster (upload and manage student lists)
- Student Search (find students by name or ID)
- CSV Import (bulk upload student data)
- Registered Mode (restrict exams to enrolled students)

### Analytics
- Score Distribution Chart (visual histogram)
- Performance Bands (Distinction 90-100%, Credit 70-89%, Pass 50-69%, Near Miss 40-49%, Fail 0-39%)
- Per-Question Analysis (identify most-missed questions)
- Pass/Fail Ratio (overall pass rate visualization)
- Average Time Analysis (time spent per question)
- Trend Charts (performance over time)
- Exam Comparison (compare results across assessments)
- Difficulty Index (which questions are hardest/easiest)
- Insights and Recommendations (AI-free, rule-based analysis)

### Settings
- Profile Management (update name and email)
- Password Change (secure password update)
- Supabase Setup Guide (step-by-step SQL instructions)
- Database Schema (table definitions and relationships)
- RLS Policies (row-level security configuration)
- Deployment Checklist (pre-launch verification)
- System Information (version, dependencies, configuration)

### Question Bank Editor
- View All Questions (complete list for any exam)
- Search Questions (filter by keyword)
- Edit Individual Questions (modify text, options, answers)
- Add New Questions (insert into existing bank)
- Delete Questions (remove unwanted questions)
- Export as CSV (download question bank for backup)
- Save Changes (persist all edits to Supabase)

---

## Student Portal (student.html)

### Exam Access
- Code Entry (enter 6-character exam access code)
- Direct Link (click exam link to auto-load exam)
- Name Input (enter student name for identification)
- Integrity Pledge (accept exam rules before starting)

### During Exam
- Countdown Timer (live with color warnings: green -> yellow -> red)
- Question Navigator (grid showing answered/flagged status)
- Answer Selection (click to select answer for current question)
- Flag Questions (mark uncertain questions for later review)
- Auto-Save (progress saved locally every 30 seconds)
- Tab-Switch Detection (warn if student leaves exam page)
- Progress Bar (visual indicator of completion)
- Navigation Buttons (Previous/Next question controls)

### After Submission
- Instant Results (score displayed immediately after submission)
- Answer Review (see correct answers with teacher explanations)
- Result Certificate (printable certificate with score and grade)
- Performance Summary (breakdown by question type)
- Time Report (how long the exam took)

---

## Admin Panel (admin.html)

### Platform Management
- Teacher Oversight (view all registered teachers)
- Account Approval (approve or reject new teacher accounts)
- Account Suspension (deactivate teacher access)
- Platform Analytics (system-wide usage statistics)
- Exam Oversight (view all exams across all teachers)
- Result Management (access all student results platform-wide)

### Security and Configuration
- RLS Management (configure database security policies)
- System Settings (global platform configuration)
- Backup and Restore (full system data export/import)
- Audit Logs (track all platform activities)

---

## Technical Features

### Data Storage
- Supabase Database (PostgreSQL with real-time sync)
- Row-Level Security (per-teacher data isolation)
- Local Storage (browser-based auto-save during exams)
- CSV Import/Export (bulk data operations)
- JSON Package (full exam backup and restore)

### Security
- Authentication (Supabase Auth email/password)
- RLS Policies (database-level access control)
- One Submission (prevents duplicate exam attempts)
- Tab-Switch Detection (exam integrity monitoring)
- Auto-Logout (session timeout after inactivity)
- Password Hashing (secure credential storage via Supabase)

### Accessibility
- Responsive Design (works on mobile, tablet, and desktop)
- No App Required (browser-based access)
- No Student Accounts (simple code-based access)
- PWA Support (installable on mobile devices)
- Offline Capability (auto-save works without internet)

### Performance
- Static Files (no server-side rendering needed)
- CDN Delivery (fast loading via global CDN)
- Minimal Dependencies (only Chart.js for analytics)
- Optimized Assets (compressed images and minified code)

---

## Cost Structure
| Component | Service | Cost |
|-----------|---------|------|
| Database | Supabase Free Tier | $0/month (up to 500MB) |
| Hosting | Vercel/Netlify/GitHub Pages | $0/month |
| Authentication | Supabase Auth | $0/month (up to 50,000 MAU) |
| AI APIs | Not Used | $0 |
| Domain | Custom domain | ~5000 Naira/year |
| Total | | ~5000 Naira/year |

---

HMG Academy CBT Pro v2.0 — Learning Deliberately. Teaching Authentically.
© 2026 HMG Concepts
