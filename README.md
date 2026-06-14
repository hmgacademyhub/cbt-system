# 🎓 HMG Academy CBT Pro — v3.0 Enterprise Edition

> **The CBT Platform Built for African Classrooms** — Free, browser-based, zero AI API costs  
> 🌍 Designed by **HMG Concepts** for real Nigerian & international classrooms

[![HMG Academy](https://img.shields.io/badge/HMG-Academy-10b981?style=for-the-badge)](https://hmgacademy.pages.dev/)
[![Version](https://img.shields.io/badge/Version-3.0-blue?style=for-the-badge)](https://github.com/hmgacademyhub/cbt-system)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [User Portals](#user-portals)
- [Question Types](#question-types)
- [Enterprise Features](#enterprise-features)
- [System Architecture](#system-architecture)
- [Deployment](#deployment)
- [Database Setup](#database-setup)
- [Brand & Contact](#brand--contact)
- [File Structure](#file-structure)
- [Supported Exams](#supported-exams)
- [Cost Structure](#cost-structure)

---

## 📖 Overview

**HMG Academy CBT Pro** is a complete, enterprise-grade Computer-Based Test platform built exclusively with free, open-source tools. It provides three dedicated portals — for **Teachers**, **Students**, and **Administrators** — enabling seamless exam creation, delivery, grading, and analytics without any paid API costs.

Built by **Adewale Samson Adeagbo**, a Data Scientist and STEM Educator with 15+ years in Nigerian classrooms, this platform is designed specifically for the realities of African education: unreliable internet, budget constraints, and the need for robust assessment tools.

### 🏫 Who Is This For?

- 🏫 **Schools** running terminal exams, CAs, and class tests
- 📚 **Tutorial Centres** preparing students for WAEC, NECO, JAMB
- 🎓 **Universities** conducting post-UTME and internal assessments
- 💼 **Corporate Trainers** delivering employee competency tests
- 👨‍👩‍👧 **Parents/Guardians** monitoring student performance

---

## ✨ Key Features

### 🚀 Zero-Cost Architecture
- **₦0 AI API** — All analytics and scoring use browser logic and rule-based algorithms
- **Free hosting** — Deploy on GitHub Pages, Vercel, or Netlify at no cost
- **Free database** — Supabase free tier handles 500MB and 50,000 monthly active users

### 🔐 Security & Integrity
- **Row-Level Security (RLS)** — Database-level data isolation per teacher
- **Anti-cheat monitoring** — Tab-switch detection, fullscreen enforcement, DevTools trapping
- **Proctor photo capture** — Student identity verification with periodic snapshots
- **Screen watermark** — Dynamic anti-screenshot overlay during exams
- **One-submission lock** — Prevents duplicate exam attempts
- **Result certificates** — Unique verification codes on every result

### 📊 Analytics & Insights
- **Score distributions** — Visual breakdowns by performance bands
- **Item analysis** — Per-question difficulty, error rates, and time analysis
- **Student progress tracking** — Historical performance across all exams
- **Weakness identification** — Automatic detection of struggling topics
- **Leaderboard with percentiles** — Ranked class performance visualization
- **Class insights report** — Rule-based teacher recommendations (no AI API)

### 📱 Accessibility
- **Responsive design** — Works on mobile, tablet, and desktop
- **PWA support** — Installable as a native-like app
- **Offline-capable** — Auto-save during exams works without internet
- **Text-to-speech** — Built-in question reading for visually impaired students
- **No student accounts required** — Simple code-based access

---

## 👥 User Portals

### 🖊️ Teacher Dashboard (`teacher.html`)

The complete educator toolkit for assessment creation and management.

**Core Capabilities:**
- Create exams with 14 configurable parameters
- Upload questions via CSV, Excel (XLSX), PDF, or manual entry
- Full editing of existing exams — change everything
- Add questions to published exams via CSV append or single-question entry
- Monitor live exams with real-time submission alerts
- Export results as CSV for external analysis

**Analytics & Reporting:**
- Score distribution charts (Chart.js)
- Pass/fail ratio visualization
- Per-question difficulty analysis
- Student progress tracking with historical data
- Leaderboard with percentile rankings
- Class insights with rule-based recommendations

**Student Management:**
- Upload class rosters via CSV
- Individual student addition
- Registered-mode exam restriction
- Student search and filtering

**Enterprise Operations:**
- Full teacher backup (JSON export)
- Print access sheets for invigilators
- Deployment and security checklists
- Exam package export/import for reuse
- WhatsApp sharing with pre-formatted links

### 📝 Student Portal (`student.html`)

The streamlined exam-taking experience — no signup, no app install.

**Exam Access:**
- Enter a 6-character access code
- Click a direct exam link
- Student identity verification (registered mode)
- Integrity pledge acceptance

**During the Exam:**
- Live countdown timer with color warnings (green → yellow → red)
- Question navigator grid showing answered/flagged status
- Flag questions for later review
- Auto-save progress every 30 seconds (localStorage)
- Tab-switch and window-switch detection
- Built-in scientific calculator
- Text-to-speech question reading
- Anti-screenshot screen watermark

**After Submission:**
- Instant results display (unless held by teacher)
- Question-by-question review with explanations
- Printable result certificate with verification code
- Emergency backup JSON download for offline situations
- Performance summary by score band

### ⚙️ Admin Panel (`admin.html`)

Super-level control for platform management and oversight.

**Platform Management:**
- View and manage all registered teachers
- Approve/reject teacher accounts
- Deactivate/reactivate teacher access
- Promote teachers to admin role
- Platform-wide analytics and reports

**Exam & Result Oversight:**
- View all exams across all teachers
- Access all student results platform-wide
- Delete exams and results when needed
- Export platform-wide data as CSV

**Security & Deployment:**
- Run security checks in-browser
- Verify RLS policies and RPC functions
- Download operational checklists
- Security report generation

---

## 🧠 Question Types (11+)

| # | Type | Code | Description |
|---|------|------|-------------|
| 1 | Multiple Choice | `mcq` | One correct answer from A, B, C, D |
| 2 | Multiple Response | `mrq` | One or more correct answers (checkboxes) |
| 3 | True/False | `tf` | Binary choice |
| 4 | Short Answer | `short` | Type a word or phrase |
| 5 | Numeric | `numeric` | Number input with configurable tolerance |
| 6 | Matching | `matching` | Pair left items to right items |
| 7 | Ordering | `ordering` | Arrange items in correct sequence |
| 8 | Cloze | `cloze` | Multi-blank fill-in-the-gap |
| 9 | Essay | `essay` | Keyword-based evaluation (teacher review recommended) |
| 10 | Categorization | `categorization` | Classify items into groups |
| 11 | Multi-Numeric | `multi_numeric` | Several numeric answers in one question |

### CSV Format (14 Columns)

```
Question | A | B | C | D | CorrectAnswer | Explanation | Type | Tolerance | Unit | Accept | MRQ_AON | Pairs | Items
```

Columns 1–7 are required base format. Columns 8–14 are optional and type-specific.  
A sample CSV is included: `further_maths_sample.csv`

---

## 🏢 Enterprise Features (v3.0 New Additions)

1. **Full Exam Editing** — Edit every field of any existing exam
2. **Question Append to Existing Exams** — Add questions via CSV or manually
3. **Exam Templates** — Save and reuse configurations
4. **Negative Marking** — Configurable deduction per wrong answer
5. **Exam Scheduling** — Start windows with "Wait Room"
6. **Auto-Close Scheduling** — Exams close automatically
7. **Result Release Control** — Hold results until manual release
8. **Question Difficulty Levels** — Easy/Medium/Hard tagging
9. **Sectioned Exams** — Group questions by section
10. **Student Progress Tracking** — Historical performance
11. **Certificates with Verification** — Unique hash codes
12. **Per-Question Time Analytics** — Track time per question
13. **Exam Archive (Soft Delete)** — Preserve data while hiding
14. **Student Weakness Identification** — Auto-detect struggling topics
15. **Leaderboard with Percentiles** — Class ranking display
16. **Batch Exam Actions** — Multi-exam operations
17. **Question Reusability** — Import from past exams
18. **Text-to-Speech** — Browser-native TTS
19. **Dynamic Screen Watermark** — Anti-screenshot overlay
20. **Item Analysis Export** — Per-question difficulty CSV
21. **Code Regeneration** — Roll new access codes
22. **Printable Result Slips** — Official score reports
23. **Deployment Validator** — Browser-only readiness checker
24. **Feature Guide** — Built-in system documentation
25. **Admin Security Centre** — In-browser security audit
26. **Proctoring Photo Capture** — Student identity verification
27. **Developer Tools Detection** — Auto-flag DevTools
28. **Multiple People Detection** — Basic face detection
29. **Emergency Backup System** — JSON download for offline recovery
30. **Notification System** — Real-time submission alerts

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────┐
│                  HMG ACADEMY CBT PRO                 │
├─────────────┬──────────────┬────────────────────────┤
│   Frontend   │   Backend    │       Hosting           │
├─────────────┼──────────────┼────────────────────────┤
│ HTML5/CSS3  │  Supabase    │  GitHub Pages / Vercel  │
│ JavaScript  │  PostgreSQL  │  Netlify               │
│ Chart.js    │  Auth        │  (Static hosting)       │
│ PWA/SW      │  Row-Level   │                        │
│             │  Security    │                        │
└─────────────┴──────────────┴────────────────────────┘
                    │
         ┌──────────┼──────────┐
         │          │          │
     Teacher    Student     Admin
     Portal     Portal     Portal
```

### Technology Stack
- **Frontend**: Pure HTML5, CSS3, vanilla JavaScript
- **Backend**: Supabase (PostgreSQL + Authentication + Real-time)
- **Charts**: Chart.js 4.x (CDN)
- **PWA**: Service Worker + Web App Manifest
- **Hosting**: Static (GitHub Pages / Vercel / Netlify)
- **Cost**: ₦0/month (free tier only)

---

## 🚀 Deployment

See [`DEPLOYMENT.md`](DEPLOYMENT.md) for complete step-by-step instructions.

**Quick Start:**
1. Create a free Supabase project
2. Run the SQL setup (`COMPLETE_SQL_SETUP.sql`)
3. Update `SB_URL`, `SB_KEY`, and `ADMIN_EMAIL` in all HTML files
4. Push to GitHub and deploy to Vercel, Netlify, or GitHub Pages
5. Test: create an exam → share code → student takes exam → view results

---

## 🗄️ Database Setup

All SQL is in [`COMPLETE_SQL_SETUP.sql`](COMPLETE_SQL_SETUP.sql). Run in Supabase SQL Editor in order:

1. **Create Tables** (exams, results, students, profiles)
2. **Add Missing Columns** (safe upgrade compatibility)
3. **Enable Row-Level Security** (critical data isolation)
4. **Create RLS Policies** (per-teacher data protection)
5. **Create Helper Functions** (SECURITY DEFINER for admin access)
6. **Create Triggers** (auto-timestamp updates)
7. **Create Indexes** (query performance)
8. **Admin RPC Functions** (cross-teacher data access)
9. **Verify Setup** (confirmation queries)

---

## 🏷️ Brand & Contact

### 👨‍🏫 Adewale Samson Adeagbo
**Founder, HMG Concepts**  
Data Scientist · STEM Educator · AI-Augmented Solutions Developer  
15+ years in Nigerian classrooms across Lagos and Ogun State

### 🏫 HMG Academy
A full-service virtual learning institution covering Nursery through Secondary,  
WAEC, NECO, BECE, UTME/JAMB, Post-UTME, IGCSE, IELTS, SAT, and JUPEB preparation.  
🌐 [hmgacademy.pages.dev](https://hmgacademy.pages.dev/)

### 💻 HMG Technologies
The EdTech and data arm building CBT systems, student performance dashboards,  
at-risk predictors, question-bank tools, and practical school data solutions.  
🌐 [hmgconcepts.pages.dev](https://hmgconcepts.pages.dev/)

### 📞 Contact
- **WhatsApp**: [+234 810 086 6322](https://wa.me/2348100866322)
- **Phone**: +234 907 790 7677
- **Email**: hismarvellousgrace@gmail.com
- **Partnerships**: buildingmyictcareer@gmail.com
- **Founder Portfolio**: [cssadewale.pages.dev](https://cssadewale.pages.dev/)

---

## 📁 File Structure

```
CBT/
├── index.html                    # Landing page
├── teacher.html                  # Teacher dashboard (enhanced v3.0)
├── student.html                  # Student exam portal (enhanced v3.0)
├── admin.html                    # Admin management panel (enhanced v3.0)
├── sw.js                         # Service worker for PWA
├── manifest.webmanifest          # PWA app manifest
├── offline.html                  # Offline fallback page
├── deployment_validator.html     # Browser-only deployment readiness checker
├── feature_guide.html            # Built-in system feature documentation
├── link_checker.html             # Exam link/code validation tool
├── COMPLETE_SQL_SETUP.sql        # Complete database setup script
├── further_maths_sample.csv      # Sample question bank
├── hmg-academy-logo.png          # Brand logo
├── hmg-icon.svg                  # SVG brand icon
├── _headers                      # Netlify security headers
├── .nojekyll                     # Disable GitHub Pages Jekyll
├── README.md                     # This file
├── DEPLOYMENT.md                 # Step-by-step deployment guide
├── CHANGELOG.md                  # Version history
├── FEATURES.md                   # Detailed feature documentation
├── SECURITY.md                   # Security best practices guide
├── CONTRIBUTING.md               # Contribution guidelines
├── EXPERT_ENHANCEMENT_REPORT.md  # Expert audit and enhancement report
├── LICENSE                       # MIT License
└── assets/
    └── hmg-academy-logo.png      # Logo in assets folder
```

---

## 📚 Supported Exams

WAEC/SSCE · NECO · BECE/JSS3 · UTME/JAMB · Post-UTME · JUPEB · IGCSE · SAT · IELTS  
School Terminal Exams · Class Quizzes · Custom Assessments

---

## 💰 Cost Structure

| Component | Service | Cost |
|-----------|---------|------|
| Database | Supabase Free Tier | $0/month (up to 500MB) |
| Authentication | Supabase Auth | $0/month (up to 50,000 MAU) |
| Hosting | Vercel / Netlify / GitHub Pages | $0/month |
| Charts | Chart.js (CDN) | $0 |
| AI APIs | **Not Used** | $0 |
| Domain | Custom domain (optional) | ~₦5,000/year |
| **Total** | | **₦0/month** |

---

> **HMG Academy CBT Pro v3.0** — *Learning Deliberately. Teaching Authentically.*  
> © 2026 HMG Concepts. All features free — no paid APIs required.
