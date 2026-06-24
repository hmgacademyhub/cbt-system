# CBT v4 — Enterprise Enhancement, SEO/PWA and Repair Report

Date: 2026-06-23

## Purpose

CBT v4 builds on the repaired HMG Academy CBT platform and adds free enterprise-style capabilities inspired by leading online examination systems while preserving the existing layout and UI/UX.

## External feature study summary

Comparable assessment platforms commonly advertise these advanced capabilities:

- high-stakes delivery with item banking, psychometrics, governance workflows and credentialing;
- candidate management, bulk imports, question-bank analytics and auto-result generation;
- proctoring controls such as tab-switch prevention, webcam checks, audio monitoring and identity verification;
- certificates, exports, LMS/API integrations and branded portals;
- mobile-first/PWA access, offline shell loading and secure delivery;
- school, university, admission, recruitment, certification and training exam workflows.

CBT v4 implements free/static/Supabase-friendly equivalents where possible without paid AI APIs.

## Key CBT v4 additions

### 1. Teacher menu repair retained

The critical Teacher Dashboard layout fix remains. Assessments, Results, Analytics, Settings and Students are direct children of `#main-content` and are protected by `repairTeacherPageLayout()`.

### 2. PWA install enforcement / strong install gate

Added `pwa_install_enforcer.js` and linked it on the main platform pages. Browsers do not allow a website to truly force installation, but the platform now strongly prompts users to install and repeats the reminder weekly if not installed.

Supported devices:

- Android Chrome: Install app / Add to Home screen.
- iPhone/iPad Safari: Share → Add to Home Screen.
- Windows/macOS/Chromebook: Chrome/Edge install icon or menu → Install.

### 3. Student can hide/unhide question numbering navigator

In `student.html`, students can now hide the fixed question-number navigation panel during the exam for more writing/reading space and show it again using a floating button. The preference is stored on the device.

### 4. Math/Science keyboard remains available for old and new exams

The Math/Science on-screen keyboard remains available during every active exam, including pre-existing exams whose database rows do not contain `math_keyboard`.

### 5. Teacher can print/save each student's result, certificate and Q&A packet

From the Teacher Results table, the teacher can now:

- print an individual student result slip;
- print an individual student certificate/assessment record;
- download an individual student question-and-answer packet as JSON;
- bulk print all listed/filtered results;
- bulk print all listed/filtered certificates.

This supports common entrance, external candidate screening, school admission tests, scholarship tests and instant result/certificate issuance.

### 6. School ecosystem exam compatibility

The system supports school and external assessment workflows such as:

- class tests and continuous assessment;
- terminal exams;
- mock exams;
- common entrance examinations;
- scholarship/admission screening;
- WAEC/NECO/BECE/UTME/JAMB-style practice;
- aptitude/recruitment tests;
- training/certification assessments;
- code/algorithm and practical STEM assessments.

### 7. SEO and HMG Concepts lead-generation retained

CBT v4 keeps:

- `robots.txt`;
- `sitemap.xml`;
- `llms.txt`;
- JSON-LD structured data;
- Open Graph/Twitter metadata;
- HMG Academy / HMG Concepts / WhatsApp lead links.

## Deployment steps

### 1. Upload to GitHub

1. Open `CBT v4`.
2. Copy all files inside it.
3. Replace the files in the GitHub repo root.
4. Commit and push.

### 2. Run Supabase SQL

If not already done, run the full `COMPLETE_SQL_SETUP.sql` in Supabase SQL Editor. This ensures result saving, certificate verification, admin RPCs and RLS policies are current.

### 3. Redeploy on Vercel

1. Open Vercel dashboard.
2. Select the CBT project.
3. Redeploy from latest GitHub commit.
4. Verify `/teacher.html`, `/student.html`, `/robots.txt`, `/sitemap.xml`, `/manifest.webmanifest` and `/deployment_validator.html`.

### 4. Clear old cache/service worker

Because this is a PWA:

- desktop: hard refresh with Ctrl+F5 or Cmd+Shift+R;
- mobile: clear site data or open in private tab first;
- if necessary, unregister the old service worker in browser DevTools → Application → Service Workers.

## Smoke test

1. Login as teacher.
2. Click all sidebar menus: Dashboard, Create, Assessments, Results, Analytics, Settings, Students.
3. Create a small test exam.
4. Open as student.
5. Confirm install prompt appears if app is not installed.
6. Start exam.
7. Confirm Math/Science keyboard is visible.
8. Hide and show the question-number navigator.
9. Submit result.
10. In Teacher Results, test:
    - View;
    - Print Result;
    - Print Certificate;
    - Download Q&A;
    - Print Listed Results;
    - Print Listed Certificates.
11. Open `/deployment_validator.html`.
12. Submit sitemap to Google Search Console and Bing Webmaster Tools.

## No paid AI API

No runtime AI API was added. Prompt templates remain manual authoring aids only. All platform features use static JavaScript, browser APIs and Supabase free-tier-compatible workflows.
