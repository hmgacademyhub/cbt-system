# CBT v5 — Exam-Type Expansion and Enterprise Enhancement Report

Date: 2026-06-24

## Purpose

CBT v5 specifically adds broader exam-type support to make HMG Academy CBT Pro suitable for nearly every school, training, admission, scholarship, recruitment and certification assessment workflow while preserving the existing UI/UX.

## New exam types added to Teacher Dashboard

The Teacher Dashboard exam type dropdowns now include:

### School / classroom

- Class Test
- Continuous Assessment (CA)
- Mid-Term Exam
- Terminal Exam
- Mock Exam
- Practice / Revision
- STEM Exam

### Admissions / external candidates

- Admission Screening
- Common Entrance Exam
- Scholarship Test
- Post-UTME Screening
- Placement Test

### Standardised practice

- UTME / JAMB Practice
- WAEC / NECO / BECE Practice
- IELTS / SAT Practice

### Professional / enterprise

- Recruitment / Aptitude Test
- Certification Exam
- Training Assessment

These were added in:

- Create Exam form
- Edit Exam modal
- Assessment filter
- Results filter
- Landing-page exam-type pills

## Exam-type presets

For selected exam types, CBT v5 applies recommended default settings. Teachers can still edit them afterwards.

Examples:

- Admission Screening: one attempt, held result, 60 minutes.
- Common Entrance: one attempt, held result, 60 minutes.
- Scholarship Test: one attempt, held result, higher pass mark.
- Recruitment / Aptitude Test: one attempt, held result, 45 minutes.
- Certification Exam: one attempt, immediate certificate-ready result, higher pass mark.
- STEM Exam: 60 minutes, Math/Science tools encouraged.
- UTME / JAMB Practice: practice mode, unlimited attempts, 120 minutes.
- WAEC / NECO / BECE Practice: practice mode, unlimited attempts, 90 minutes.

## Similar-platform feature study

Reviewed public feature patterns from online exam/assessment systems. Common enterprise features include:

- admission and entrance test workflows;
- scholarship tests;
- recruitment/aptitude tests;
- certification exams and certificate issuing;
- bulk candidate management;
- secure/proctored delivery;
- question banks and multiple question types;
- instant results and analytics;
- mobile compatibility;
- branding and exports;
- LMS/HR integrations.

CBT v5 strengthens the free equivalent by using:

- exam-type presets;
- open/registered modes;
- access codes and links;
- 17 question types;
- teacher/admin exports;
- certificates;
- installable PWA;
- anti-cheat controls;
- result/certificate printing;
- Q&A packets;
- no paid AI API.

## Deployment steps

1. Open the `CBT v5` folder.
2. Copy all files inside it into the GitHub repository root.
3. Commit and push.
4. On Vercel, redeploy the latest commit.
5. Run `COMPLETE_SQL_SETUP.sql` in Supabase if not already current.
6. Hard refresh browser / clear PWA cache.
7. Test Create Exam and confirm the expanded Exam Type dropdown appears.
8. Test Admission Screening, Common Entrance, Scholarship Test and Recruitment/Aptitude Test preset behaviour.
9. Test student submission and teacher result/certificate printing.

## Smoke test

- Create an Admission Screening exam.
- Confirm attempts = 1 and result release is held by default.
- Create a Common Entrance exam.
- Submit as an external/open-mode candidate.
- Print result slip and certificate from Teacher Results.
- Create a UTME/JAMB Practice exam.
- Confirm practice-friendly settings.
- Check filters for the new exam types in Assessments and Results.

## No paid AI API

No AI API was added. Prompt templates remain manual question-generation aids only.
