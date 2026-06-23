# HMG Academy CBT Pro — Expert Audit, Fix Summary, and Deployment Steps

Date: 2026-06-23

## What was audited

The live site landing page and the GitHub repository were reviewed across the main static files:

- `index.html`
- `teacher.html`
- `student.html`
- `admin.html`
- `certificate.html`
- `deployment_validator.html`
- `feature_guide.html`
- `link_checker.html`
- `COMPLETE_SQL_SETUP.sql`
- documentation files including `README.md`, `FEATURES.md`, `SECURITY.md`, `CHANGELOG.md`, `DIAGNOSIS_REPORT.md`, `EXPERT_ENHANCEMENT_REPORT.md`, and `PROMPT_TEMPLATE.md`

JavaScript syntax checks were run for the major HTML files after the fixes.

## Key diagnosis

### 1. Student result save error

The likely root cause of the student error seen during recent tests is that the frontend sent a result payload containing newer columns while the deployed Supabase database/RLS may not have been fully updated. Direct anonymous insert can also fail when policies are not aligned.

Fix added:

- New secure Supabase RPC: `submit_student_result(jsonb)`.
- Student submission now tries the RPC first.
- If the RPC is not installed yet, the old REST save attempts still run as fallbacks.
- If every save fails, the existing emergency backup workflow remains available.

### 2. Anti-cheat selection was not granular

Previously, proctoring/camera behaviour was effectively not teacher-selectable enough.

Fix added:

- Teachers can choose per exam:
  - tab/app switch detection;
  - window blur/focus loss detection;
  - copy/cut/paste/select-all blocking;
  - right-click blocking;
  - fullscreen enforcement;
  - devtools/print/source shortcut detection;
  - camera photo gate and periodic snapshots;
  - audio spike monitoring;
  - violation limit before auto-submit.
- Camera proctoring now runs only when the teacher enables it.

### 3. Math/Science keyboard was not inserting symbols reliably

Cause: clicking an on-screen keyboard button can move focus away from the answer input, so the insertion target was lost.

Fix added:

- The system tracks the last active typed-answer field.
- Keyboard buttons use `mousedown` focus preservation.
- Symbol insertion now supports short answer, numeric, essay, cloze/multi-blank, and multi-part numeric fields.
- More symbols were added for mathematics, chemistry, physics, Greek letters, superscripts, subscripts, set notation, logic, units, and science notation.

### 4. Certificate verification was incomplete

`certificate.html` called a `verify_certificate` RPC, but the SQL setup did not define it.

Fix added:

- New SQL RPC: `verify_certificate(text)`.
- Certificate page now validates against the database result record.
- Disabled or expired certificates are shown as invalid.
- Certificate validity fields added to `exams`.

## Important files changed

- `teacher.html`
- `student.html`
- `certificate.html`
- `deployment_validator.html`
- `feature_guide.html`
- `COMPLETE_SQL_SETUP.sql`
- `README.md`
- `FEATURES.md`
- `SECURITY.md`
- `CHANGELOG.md`
- `DIAGNOSIS_REPORT.md`
- `EXPERT_ENHANCEMENT_REPORT.md`
- `PROMPT_TEMPLATE.md`

## Required Supabase deployment step

Before testing the new features, run the full SQL file:

```text
COMPLETE_SQL_SETUP.sql
```

Run it in Supabase Dashboard → SQL Editor from top to bottom.

This creates/updates:

- missing columns;
- RLS policies;
- public student RPCs;
- `submit_student_result(jsonb)`;
- `verify_certificate(text)`;
- admin RPCs;
- grants and verification queries.

## Vercel deployment steps

1. Open the prepared `CBT` folder.
2. Upload/push the folder contents to the GitHub repository root.
3. Go to Vercel.
4. Import the GitHub repository.
5. Framework preset: **Other** or **Static**.
6. Build command: leave empty.
7. Output directory: leave empty or use root.
8. Deploy.
9. In Supabase Auth settings, add your Vercel domain to allowed redirect URLs.
10. Open `/deployment_validator.html` on the deployed site.
11. Create a test teacher, approve if needed, create a small exam, submit as a student, verify the teacher dashboard shows the result, then verify the certificate.

## Cloudflare Pages deployment steps

1. Push the `CBT` folder contents to GitHub repository root.
2. Open Cloudflare Dashboard → Workers & Pages → Pages.
3. Connect the repository.
4. Framework preset: **None**.
5. Build command: leave empty.
6. Build output directory: `/` or leave default root for static files.
7. Deploy.
8. In Supabase Auth settings, add the Cloudflare Pages domain to allowed redirect URLs.
9. Open `/deployment_validator.html`.
10. Run the same functional smoke test.

## Functional smoke test checklist

After deployment and SQL update:

1. Login as teacher.
2. Create an exam with camera proctoring OFF.
3. Enable only tab-switch and copy/paste controls.
4. Add at least one short-answer question requiring a symbol such as `H₂O`, `≤`, `π`, or `Ω`.
5. Take exam as a student.
6. Use the Math/Science keyboard to insert the symbol.
7. Submit.
8. Confirm no “result not saved” error appears.
9. Confirm the result appears in teacher dashboard.
10. Export results CSV.
11. Delete the test result.
12. Print/open certificate and verify its code on `certificate.html`.
13. Repeat one test with camera proctoring ON if needed.

## Notes

- No paid AI API was added.
- No service-role key is exposed.
- The app remains static HTML/CSS/JavaScript.
- Supabase free tier remains the backend.
- Existing UI/UX structure was preserved; features were added inside the current layout.
