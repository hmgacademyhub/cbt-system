# CBT v3 — Expert Enhancement Report and Deployment Guide

Date: 2026-06-23

## What CBT v3 fixes

CBT v3 focuses on making the whole repository reflect the real feature set that has been added to the HTML files.

Key corrections:

1. `PROMPT_TEMPLATE.md` has been rewritten for its proper purpose: a set of ready-to-copy prompts that teachers can give to an AI assistant to generate HMG Academy CBT Pro CSV question banks manually.
2. `teacher.html` now documents all 17 question types in the Question Bank section.
3. `teacher.html` downloadable CSV question template now includes example rows for all 17 question types.
4. Documentation files now mention the 17-type CBT v3 feature set and explain that no AI API is used inside the platform.

## Current supported question types

1. `mcq` — Multiple Choice
2. `mrq` — Multiple Response
3. `tf` — True/False
4. `short` — Short Answer
5. `numeric` — Numeric
6. `matching` — Matching
7. `ordering` — Ordering/Sequencing
8. `cloze` — Multi-blank
9. `essay` — Keyword/minimum-word essay
10. `categorization` — Classify items into categories
11. `multi_numeric` — Multi-part numeric
12. `assertion_reason` — Assertion–Reason
13. `case_study` — Passage/scenario question
14. `image_mcq` — Image/diagram MCQ
15. `matrix` — Grid/matrix rows with shared answer options
16. `hot_text` — Select correct text chunks
17. `code` — Code, SQL, pseudocode, or algorithm response

## Prompt template purpose

`PROMPT_TEMPLATE.md` is not a developer-maintenance prompt anymore. It is now a practical teacher-facing question-generation prompt file.

It includes:

- a 60-question prompt for the 11 core types;
- a 60-question prompt for all 17 CBT v3 types;
- a smaller advanced-type prompt;
- CSV header rules;
- JSON escaping instructions;
- exact column rules for each question type;
- no-paid-AI-API warning;
- quality rules for curriculum-aligned assessment.

## Deployment steps

### 1. Run Supabase SQL

1. Open Supabase Dashboard.
2. Go to your project.
3. Open SQL Editor.
4. Copy the full `COMPLETE_SQL_SETUP.sql` from the CBT v3 folder.
5. Run it from top to bottom.
6. Confirm success.

### 2. Upload CBT v3 files to GitHub

1. Open the `CBT v3` folder.
2. Copy every file inside it.
3. Replace the files in the GitHub repository root.
4. Commit and push.

### 3. Deploy to Vercel

1. Open Vercel.
2. Import or redeploy the GitHub repository.
3. Framework preset: Other/Static.
4. Build command: blank.
5. Output directory: blank/root.
6. Deploy.
7. Add the Vercel domain to Supabase Auth redirect URLs.
8. Visit `/deployment_validator.html`.

### 4. Deploy to Cloudflare Pages

1. Open Cloudflare Pages.
2. Connect the GitHub repository.
3. Framework preset: None.
4. Build command: blank.
5. Output directory: root.
6. Deploy.
7. Add the Pages domain to Supabase Auth redirect URLs.
8. Visit `/deployment_validator.html`.

## CBT v3 smoke test

After deployment:

1. Login as teacher.
2. Open Create Exam → Question Bank.
3. Confirm the Question Type Reference shows all 17 types.
4. Click Download CSV Template.
5. Confirm the downloaded CSV has examples for all 17 types.
6. Create/import a small exam with at least: `assertion_reason`, `matrix`, `hot_text`, and `code`.
7. Open as student.
8. Confirm the Math/Science keyboard is available.
9. Submit.
10. Confirm result appears in Teacher Dashboard.
11. Login as admin.
12. Test teacher control/impersonation mode and exam open/lock controls.

## Important no-AI-API note

The platform still does not call an AI API. Teachers can use `PROMPT_TEMPLATE.md` manually with an AI assistant, copy/download the CSV output, review it, and upload it. This keeps the platform free-tier friendly and avoids paid API costs.
