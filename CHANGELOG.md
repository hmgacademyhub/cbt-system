# Changelog — HMG Academy CBT Pro

## v3.1 Enterprise Security & Correctness Release — 2026-06-14

### SQL and database fixes

- Reordered `COMPLETE_SQL_SETUP.sql` so helper functions are created before RLS policies reference them.
- Added `public.is_platform_admin()` and made admin RPCs enforce admin status inside PostgreSQL.
- Removed dependency on broad anonymous `SELECT` policies for exams and students.
- Replaced unsafe `WITH CHECK (true)` student result insert with `public.is_exam_open_for_submission(exam_id)`.
- Added public student RPCs:
  - `get_public_exam_by_code`
  - `verify_student_for_exam`
  - `get_exam_attempt_count`
- Added schedule-aware public exam loading: question data is hidden before scheduled start time.
- Changed `results.score` to `NUMERIC(10,2)` for partial-credit accuracy.
- Added/standardised indexes for exams, results, profiles, and students.
- Added/standardised constraints for roles, statuses, modes, durations, attempts, and non-negative scores.
- Added safer grants and explicit RPC execution permissions.
- Updated SQL snippets embedded in `teacher.html` and `admin.html`.

### Student portal

- Student exam loading now uses secure public RPC with legacy REST fallback.
- Registered-student ID verification now uses secure RPC with legacy fallback.
- Attempt-limit checking now uses secure RPC instead of anonymous result table reads.
- Implemented negative-marking deduction.
- Implemented held-result display when `release_results=false`.
- Added submission/certificate verification code display and storage.
- Added JAMB-style keyboard shortcuts.
- Fixed scheduled wait-room issue by re-fetching exam data after start time.
- Added robust question-data parser for old JSON-string and new JSONB-array formats.
- Fixed typo: `HMT Academy` → `HMG Academy`.
- Improved typed-answer keyboard handling so normal input editing is not incorrectly flagged as cheating.

### Teacher dashboard

- Stores question banks as native JSONB arrays while still reading old JSON-string records.
- Added robust `parseQuestionData()` and `cloneQuestionData()` helpers.
- Added CSV metadata support: `Difficulty`, `Tags`, `Section`.
- Added signup full-name metadata to Supabase Auth signup.
- Updated question template header to include metadata fields.
- Updated embedded SQL snippets to v3.1 security model.

### Admin panel

- Added robust question-data parser.
- Updated teacher rejection wording to clarify that frontend cannot delete Supabase Auth users without a service key.
- Updated SQL setup text to remove old insecure anonymous roster/read policy language.
- Updated embedded admin RPC SQL to server-side admin guard model.

### Tools and docs

- Updated `deployment_validator.html` required file list and SQL checks.
- Updated `link_checker.html` to use secure public exam RPC and schedule-aware messages.
- Updated `sw.js` cache name to `hmg-cbt-shell-v7`.
- Updated `index.html` from v2.0 wording to v3.1 Enterprise.
- Updated `further_maths_sample.csv` with metadata columns.
- Rewrote/expanded README, deployment, features, security, diagnosis, enhancement, and prompt documentation.

---

## v3.0 Enterprise Baseline

- Added full exam editing.
- Added question append workflows.
- Added registered-student mode.
- Added proctoring snapshot support.
- Added deployment validator.
- Added feature guide.
- Added exam package export/import.
- Added item analysis and analytics exports.
- Added PWA/offline shell.

---

## v2.x Enhanced Baseline

- Teacher, student, and admin portals.
- CSV question upload.
- Exam access codes and links.
- Student countdown timer.
- Basic results and exports.
- Supabase backend integration.

## 2026-06-23 — Enterprise audit repair package

- Added granular per-exam anti-cheat selection: tab/app switch, blur, copy/paste, right-click, fullscreen, devtools, camera proctoring, audio monitoring, and violation limit.
- Changed camera proctoring from forced/default to teacher-controlled.
- Fixed the on-screen Math/Science keyboard insertion bug by tracking the last active answer field and preventing keyboard buttons from stealing focus. Added many extra mathematics, chemistry, physics, Greek, superscript, subscript, set, logic, and unit symbols.
- Added robust `submit_student_result(jsonb)` Supabase RPC with REST fallback so student submissions are saved even when direct anonymous insert/RLS behaviour differs.
- Added `verify_certificate(text)` RPC and certificate validity support. Certificate page now verifies from the result record and detects disabled/expired certificates.
- Added database fields for `anti_cheat_config`, `certificate_enabled`, and `certificate_valid_days`.
- Updated deployment validation and documentation to reflect current enterprise features.
## CBT v2 — 2026-06-23

- Added six more question types: assertion_reason, case_study, image_mcq, matrix, hot_text, and code.
- Made Math/Science keyboard always visible during exams, including older exams created before the keyboard setting existed.
- Added admin-supervised teacher impersonation/control mode.
- Added Admin Panel controls to open/lock any exam and clear all results for a selected exam.
- Added ADVANCED_QUESTION_TYPES_GUIDE.md and CBT_V2_AUDIT_AND_DEPLOYMENT_STEPS.md.
## CBT v3 — 2026-06-23

- Reworked `PROMPT_TEMPLATE.md` into practical AI question-bank generation prompts for manual CSV creation.
- Added prompt templates for 11 core types and all 17 CBT v3 types.
- Updated Teacher Dashboard question-type reference to list and explain all 17 supported types.
- Updated downloadable question CSV template to include examples for all 17 question types.
- Updated documentation files to reflect the current question-type and enterprise-feature set.
## SEO/PWA lead generation update — 2026-06-23

- Added `robots.txt`, `sitemap.xml`, `llms.txt`, and `browserconfig.xml` for search engine discovery and AI/search assistant context.
- Added SEO, Open Graph, Twitter Card and JSON-LD structured data to the landing page.
- Added HMG Concepts ecosystem lead-generation section with links to HMG Academy, HMG Concepts, project enquiry and WhatsApp enquiry.
- Improved PWA install metadata and added a landing-page install CTA plus device-specific install instructions.
- Updated `_headers` and service worker cache list for SEO/PWA support files.
## Repair release — 2026-06-23

- Fixed critical Teacher Dashboard navigation bug where Assessments, Results, Analytics, Settings and Students appeared blank because those sections were accidentally nested inside the hidden Create Exam page.
- Added defensive `repairTeacherPageLayout()` to prevent future page-nesting regressions.
- Added safer dashboard data loading so Supabase/RLS errors do not break page navigation.
- Fixed undefined `renderQuestionsPreview()` call in reusable question import.
- Added `vercel.json` headers for Vercel deployment.
## CBT v4 — Enterprise + install + school-exam workflow update

- Added PWA install enforcer/encourager across main platform pages.
- Added student control to hide/unhide the question-number navigator during exams.
- Added teacher-side print result, print certificate, bulk print listed results, bulk print listed certificates and download Q&A packet per student.
- Added `EXAM_COMPATIBILITY_GUIDE.md` for school ecosystem use cases such as common entrance, admission screening, certification and STEM exams.
- Added `CBT_V4_ENTERPRISE_ENHANCEMENT_REPORT.md`.
## CBT v5 — Exam type expansion

- Added Admission Screening, Scholarship Test, Common Entrance, Recruitment/Aptitude Test, Certification Exam, STEM Exam, UTME/JAMB Practice, WAEC/NECO/BECE Practice, Post-UTME Screening, Placement Test, IELTS/SAT Practice and Training Assessment to Teacher Dashboard exam type controls.
- Added exam-type presets that apply recommended duration, attempt limit, release control, pass mark and instructions for key assessment categories.
- Updated landing-page exam category pills and documentation.
- Added `CBT_V5_EXAM_TYPE_AND_ENTERPRISE_REPORT.md`.
## CBT v6 — Fullstack SaaS SQL repair

- Fixed Supabase SQL error in `admin_get_platform_stats()` pass-rate calculation that caused `ERROR 42601: mismatched parentheses at or near ";"`.
- Rewrote pass-rate calculation using `AVG(CASE WHEN ... THEN 1 ELSE 0 END) * 100` for clearer Postgres syntax.
- Parsed the full `COMPLETE_SQL_SETUP.sql` successfully after repair.
- Added SaaS-ready `institutions` and `audit_logs` tables plus tenant columns for profiles, exams, students and results.
- Added `FULLSTACK_SAAS_ARCHITECTURE.md`.
## CBT v7 — Student save/print visibility and keyboard reliability

- Fixed student result/question print styles so saved PDFs and printed pages use white backgrounds and readable dark text.
- Corrected invalid `@media hideprint` to proper print handling.
- Rebuilt student `exportPDF()` to print from a clean white result document instead of the live dark UI.
- Added `Save Result + Questions` readable HTML export for students.
- Added a Math/Science keyboard availability watchdog so the keyboard remains visible during all active exams, including pre-existing exams.
- Added `CBT_V7_BUG_FIX_AND_VISIBILITY_REPORT.md`.

