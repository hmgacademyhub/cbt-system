# HMG Academy CBT Pro — v2.0 Enhanced Edition

> **Built for African Classrooms** — Free, browser-based, zero AI API costs

---

## System Overview

A complete Computer-Based Test system built with HTML, CSS, and JavaScript. Uses **Supabase** as backend (free tier). **No paid AI APIs**.

### Architecture
- **Frontend**: Pure HTML5/CSS3/JavaScript
- **Backend**: Supabase (PostgreSQL + Auth)
- **Hosting**: Vercel, GitHub Pages, Netlify
- **PWA**: Full Progressive Web App support

### User Portals
1. `index.html` — Landing page
2. `teacher.html` — Teacher dashboard (create, manage, analyze exams)
3. `student.html` — Student exam portal
4. `admin.html` — Admin management panel

---

## Bugs Diagnosed & Fixed

| # | Bug | Fix |
|---|-----|-----|
| 1 | **No edit functionality for existing exams** — teachers could only duplicate, schedule, or delete | Added full edit modal with all exam configuration fields |
| 2 | **Cannot add questions to existing exams** | Added CSV append and single-question add functions |
| 3 | **Missing edit button in exam list** | Added ✏️ Edit button with primary styling |
| 4 | **No question count or submission count in management** | Added info panel in edit modal |
| 5 | **Missing CSS for btn-primary small buttons** | Added `.btn-primary` and hover styles |

---

## New Features Added

### ✏️ Full Exam Editing
Every aspect of any existing exam can now be edited:
- **Academic Context**: Subject, Class/Arm, Term, Exam Type, Topic, Session
- **Exam Configuration**: Duration, Attempts, Questions to Pull, Pass Mark
- **Scheduling**: Auto-Close Date & Time, Open/Lock Status
- **Student Access**: Open Mode or Registered Mode
- **Question Bank**: Add questions via CSV or manual entry
- **Exam Info**: View access code, student link, question count, submission count

---

## 11+ Question Types

| Type | Code | Description |
|------|------|-------------|
| Multiple Choice | mcq | One correct answer from A, B, C, D |
| Multiple Response | mrq | One or more correct answers (checkboxes) |
| True/False | tf | Binary choice |
| Short Answer | short | Type a word or phrase |
| Numeric | numeric | Number with configurable tolerance |
| Matching | matching | Pair left and right items |
| Ordering | ordering | Arrange items in correct sequence |
| Cloze | cloze | Fill-in-the-blank (multiple blanks) |
| Essay | essay | Keyword-based evaluation |
| Categorization | categorization | Classify items into groups |
| Multi-Numeric | multi_numeric | Multiple numeric answers |

---

## File Structure

cbt/
├── index.html              # Landing page
├── teacher.html            # Teacher dashboard (enhanced with full edit)
├── student.html            # Student exam portal
├── admin.html              # Admin panel
├── sw.js                   # Service Worker for PWA
├── manifest.webmanifest    # PWA manifest
├── .nojekyll               # Prevents GitHub Pages Jekyll processing
├── README.md               # This file
├── DEPLOYMENT_GUIDE.md     # Deployment instructions
├── FEATURES_GUIDE.md       # Feature documentation
├── DIAGNOSIS_REPORT.md     # Bug diagnosis report
└── assets/
    └── hmg-academy-logo.png

---

## Supported Exams
WAEC/SSCE · NECO · BECE/JSS3 · UTME/JAMB · Post-UTME · JUPEB · IGCSE · SAT · IELTS · School Terminal Exams · Class Quizzes · Custom Assessments

---

## Contact
- **Built by**: Adewale Samson Adeagbo — Founder, HMG Concepts
- **WhatsApp**: +234 810 086 6322
- **Phone**: +234 907 790 7677
- **Email**: hismarvellousgrace@gmail.com
- **Partnerships**: buildingmyictcareer@gmail.com

*HMG Academy CBT Pro v2.0 — Learning Deliberately. Teaching Authentically.*
*© 2026 HMG Concepts. All features free — no paid APIs required.*
