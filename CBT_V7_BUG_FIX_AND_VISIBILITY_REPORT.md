# CBT v7 — Student Save/Print Visibility and Math Keyboard Bug Fix Report

Date: 2026-06-24

## Bugs addressed

### 1. Saved/printed student result and question review had dark/black backgrounds

Problem:

When a student tried to save or print the result/question review, parts of the result and review could retain the dark exam theme. This made text difficult to read, especially when saving as PDF or printing.

Root causes:

- One older print stylesheet block was written as `@media hideprint`, which is not valid CSS media for printing. Therefore important white-background review styles were not applied during printing.
- Some review cards and inline-styled elements retained dark backgrounds from the live exam UI.

Fixes:

- Changed the invalid print media block to a real `@media print` block.
- Strengthened print CSS so `#result-view`, `.review-card`, `.result-stats`, `.integrity-result`, badges and review text print with white backgrounds and dark text.
- Rebuilt `exportPDF()` to open a clean white print window rather than printing the dark live page directly.
- Added `downloadResultHTML()` so students can save a readable offline HTML copy of result + question review.

### 2. Math/Science keyboard availability for pre-existing exams

Problem:

Older exams may not have the newer `math_keyboard` database field, and some UI states could hide the Math/Science keyboard button.

Fixes:

- Added `ensureMathKeyboardAlwaysAvailable()` watchdog.
- The Math/Science keyboard button is force-shown during every active exam, regardless of old/new exam row fields.
- The keyboard still hides after exam submission/result page to avoid covering the result.

### 3. Result and question saving improved

Added a new student action button:

```text
Save Result + Questions
```

It downloads a readable HTML file containing:

- result summary;
- certificate/submission code where available;
- question-by-question review;
- explanations;
- clean white-background styling.

This is easier for students/parents/teachers to read than raw JSON backup.

## Existing v6/v5/v4 fixes retained

CBT v7 keeps:

- teacher navigation layout repair;
- PWA install prompt;
- student hide/show question navigator;
- teacher result/certificate printing;
- expanded exam types;
- SaaS-ready SQL;
- SEO/PWA/lead-generation files;
- 17 question types;
- no paid AI API.

## Deployment steps

1. Upload all files from `cbt v7` to the GitHub repository root.
2. Commit and push.
3. Redeploy on Vercel or Cloudflare Pages.
4. Clear PWA/browser cache after deployment.
5. Test an already-created exam, not only a newly-created exam.
6. Confirm the Math/Science keyboard appears during the exam.
7. Submit and click:
   - Export Result PDF;
   - Save Result + Questions;
   - Print Certificate.
8. Confirm saved/printed output has white background and readable text.

## Cache warning

Because the platform is a PWA, old CSS/JS can remain cached. After deployment, hard-refresh or unregister the service worker if the old black-background print view still appears.
