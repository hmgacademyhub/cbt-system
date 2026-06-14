# 📖 HMG Academy CBT Pro v3.0 — Complete Features Guide

> **Every feature documented and explained.**  
> Built by **HMG Concepts** — *Learning Deliberately. Teaching Authentically.*

---

## Table of Contents

1. [System Architecture](#1-system-architecture)
2. [Teacher Dashboard Features](#2-teacher-dashboard-features)
3. [Student Portal Features](#3-student-portal-features)
4. [Admin Panel Features](#4-admin-panel-features)
5. [Question Types](#5-question-types)
6. [Security & Integrity](#6-security--integrity)
7. [Analytics & Reporting](#7-analytics--reporting)
8. [Enterprise Features](#8-enterprise-features)
9. [PWA & Offline](#9-pwa--offline)
10. [Free Tools Used](#10-free-tools-used)

---

## 1. System Architecture

```
┌─────────────────────────────────────────────────────┐
│                  HMG ACADEMY CBT PRO v3.0            │
├─────────────┬──────────────┬────────────────────────┤
│   Frontend   │   Backend    │       Hosting           │
├─────────────┼──────────────┼────────────────────────┤
│ HTML5/CSS3  │  Supabase    │  GitHub Pages / Vercel  │
│ JavaScript  │  PostgreSQL  │  Netlify               │
│ Chart.js    │  Auth        │  (Static hosting)       │
│ PWA/SW      │  Row-Level   │                        │
│             │  Security    │                        │
└─────────────┴──────────────┴────────────────────────┘
         │              │              │
    Teacher Portal  Student Portal  Admin Panel
```

### Key Architectural Decisions
- **Static Frontend Only** — No server-side rendering needed
- **Supabase as Backend** — Free tier provides database, auth, real-time
- **RLS-First Security** — Data isolation at database level
- **Browser-Based Analytics** — All scoring runs client-side
- **No Paid APIs** — Zero external service costs

---

## 2. Teacher Dashboard Features (`teacher.html`)

### 2.1 Authentication
| Feature | Description |
|---------|-------------|
| Email/Password Login | Supabase Auth with email and password |
| Self-Service Signup | Teachers create their own accounts |
| Admin Approval Workflow | New accounts "pending" until admin approves |
| Password Reset | Email-based recovery via Supabase |
| Session Management | Persistent sessions with auto-logout |
| Password Strength Meter | Visual indicator during signup |

### 2.2 Dashboard Home
| Feature | Description |
|---------|-------------|
| Overview Stats | Total exams, submissions, pass rate, integrity flags |
| Recent Activity Feed | Latest submissions with scores |
| Quick Actions | Shortcuts to create, results, assessments, settings |
| Live Exams Summary | Currently active exams |
| Notification Bell | Real-time alerts for new submissions |

### 2.3 Exam Creation (14 Configurable Parameters)
- Subject, Class/Arm, Term, Exam Type, Topic, Academic Session
- Duration (minutes), Attempt Limits (1/2/Unlimited)
- Question Selection (count or all), Pass Mark (%)
- Auto-Close Date/Time, Start Window Date/Time
- Negative Marking (deduction per wrong answer)
- Result Release Control (immediate or held)
- Custom Exam Instructions
- Exam Mode: Open (anyone) or Registered (verified students only)

### 2.4 Question Input Methods
| Method | Description |
|--------|-------------|
| **CSV Upload** | 14-column format, all 11 question types |
| **Manual Entry** | Type directly with type-specific forms |
| **Excel (XLSX) Import** | Upload spreadsheets |
| **PDF Upload** | Parse text-based PDFs |
| **Template Download** | Pre-formatted CSV templates |

### 2.5 Exam Management
| Feature | Description |
|---------|-------------|
| **Full Exam Editing** | Edit every field of any existing exam |
| **Question Append** | Add questions to published exams |
| **Question Bank Editor** | Search, edit, add, delete individual questions |
| **Exam Preview** | See what students will see |
| **Exam Duplication** | Create a copy as new locked draft |
| **Open/Lock Toggle** | Instant availability control |
| **Code Regeneration** | Roll new 6-character access code |
| **WhatsApp Sharing** | Pre-formatted exam link messages |
| **Access Sheet Printing** | Invigilation sheets with codes |
| **Exam Archive** | Soft-delete — hide but preserve data |
| **Batch Actions** | Select multiple, apply simultaneously |
| **Package Export/Import** | JSON backup and restore |
| **Question Reusability** | Import from past exams |

### 2.6 Results & Analytics
- Results table with filtering and sorting
- Per-student correct/wrong/skipped counts
- Answer breakdown with teacher explanations
- Difficulty heatmap (time-spent per question)
- Proctor photo viewer
- Result slip printing
- CSV export and Item Analysis export
- Bulk delete with checkbox selection
- Emergency backup import
- Score distribution charts (Chart.js)
- Pass/fail ratio doughnut chart
- Submission trend line chart (30 days)
- Per-question difficulty analysis
- Student progress tracking (historical)
- Weakness identification
- Leaderboard with percentiles
- Class insights with rule-based recommendations

### 2.7 Student Management
- Class roster upload and management
- Student search by name, ID, or class
- CSV import for bulk student addition
- Registered-mode exam restriction
- Individual student addition via UI

### 2.8 Theme & UI
- Dark mode (default) and light mode toggle
- Responsive design (mobile, tablet, desktop)
- Collapsible sidebar with section labels
- Print styles for reports and results

---

## 3. Student Portal Features (`student.html`)

### 3.1 Exam Access
| Feature | Description |
|---------|-------------|
| Code Entry | 6-character exam access code |
| Direct Link | Auto-load with code pre-filled |
| Link Checker | Validate codes before entering |
| Name Input | Full name and class identification |
| Integrity Pledge | Accept exam rules before starting |
| Registered Mode | Student ID identity verification |

### 3.2 During the Exam
| Feature | Description |
|---------|-------------|
| Countdown Timer | Live with color warnings (green→yellow→red) |
| Question Navigator | Grid showing answered/flagged/skipped |
| Answer Selection | Type-adaptive UI |
| Flag Questions | Mark for later review |
| Auto-Save | localStorage every 30 seconds |
| Progress Bar | Visual completion percentage |
| Navigation Buttons | Previous/Next with keyboard shortcuts |
| Scientific Calculator | Built-in sci-calc |
| Text-to-Speech | Browser-native TTS reads questions |
| Font Size Control | A-/A+ buttons |
| Tab-Switch Detection | Warns and logs tab/window switches |
| Fullscreen Enforcement | Detects exit from fullscreen |
| DevTools Detection | Flags developer tools opening |
| Screen Watermark | Dynamic anti-screenshot overlay |
| Right-Click Disabled | Prevents copy/paste |

### 3.3 After Submission
| Feature | Description |
|---------|-------------|
| Instant Results | Score displayed immediately (unless held) |
| Answer Review | Correct answers with explanations |
| Result Certificate | Printable with verification code |
| Performance Summary | Breakdown by score band |
| Time Report | Duration of exam completion |
| PDF Export | Downloadable result |
| Result Sharing | WhatsApp or other methods |
| Emergency Backup | JSON download if server save fails |
| Retry Option | Re-attempt if multiple attempts allowed |

---

## 4. Admin Panel Features (`admin.html`)

### 4.1 Platform Management
| Feature | Description |
|---------|-------------|
| Teacher Overview | All registered teachers with status |
| Account Approval | Approve/reject new teachers |
| Account Suspension | Deactivate/reactivate access |
| Role Promotion | Promote teachers to admin |
| Platform Analytics | System-wide usage statistics |
| Exam Oversight | All exams across all teachers |
| Result Management | All student results platform-wide |
| Broadcast Announcements | Notices to all teachers |

### 4.2 Security & Deployment
| Feature | Description |
|---------|-------------|
| Security Checks | Browser-based RLS, RPC, HTTPS verification |
| Deployment Validation | Required files check |
| Admin Checklist | Downloadable operational checklist |
| SQL Smoke Test | Downloadable verification queries |
| Platform Export | Full CSV of teachers, exams, results |
| Activity Logging | All admin actions with timestamps |

### 4.3 Dashboard Pages
| Page | Description |
|------|-------------|
| **Overview** | Platform health, recent submissions, pending approvals |
| **Pending Approvals** | Teachers awaiting confirmation |
| **All Teachers** | Complete management with filtering |
| **All Exams** | Platform-wide exam listing |
| **All Results** | Platform-wide results with filters |
| **Activity Log** | Chronological admin action record |
| **Security & Deployment** | Health checks and tools |
| **Setup & SQL** | Database setup guide with copyable SQL |

---

## 5. Question Types (11+)

| # | Type | Code | Student UI | Scoring |
|---|------|------|------------|---------|
| 1 | Multiple Choice | `mcq` | Radio buttons | 1 correct, 0 wrong |
| 2 | Multiple Response | `mrq` | Checkboxes | Full/partial credit |
| 3 | True/False | `tf` | Two buttons | 1 correct, 0 wrong |
| 4 | Short Answer | `short` | Text input | Case-insensitive match |
| 5 | Numeric | `numeric` | Number input | Within tolerance range |
| 6 | Matching | `matching` | Drag/drop or dropdown | Per-pair scoring |
| 7 | Ordering | `ordering` | Drag/drop | Per-position scoring |
| 8 | Cloze | `cloze` | Multiple text inputs | Per-blank scoring |
| 9 | Essay | `essay` | Large text area | Keyword matching |
| 10 | Categorization | `categorization` | Category assignment | Per-item accuracy |
| 11 | Multi-Numeric | `multi_numeric` | Multiple number inputs | Per-part scoring |

### CSV Format (14 Columns)
```
Question | A | B | C | D | CorrectAnswer | Explanation | Type | Tolerance | Unit | Accept | MRQ_AON | Pairs | Items
```
Columns 1–7: Required base format. Columns 8–14: Optional, type-specific.

---

## 6. Security & Integrity

### 6.1 Database Security
| Feature | Description |
|---------|-------------|
| Row-Level Security | PostgreSQL data isolation per teacher |
| SECURITY DEFINER Functions | Admin RPC bypasses RLS safely |
| Anon INSERT Policy | Students submit without auth |
| No Service Role Key | Frontend uses anon key only |

### 6.2 Exam Integrity
| Feature | Description |
|---------|-------------|
| Tab-Switch Detection | Logs browser tab/window switches |
| Fullscreen Enforcement | Detects exit from fullscreen |
| DevTools Detection | Flags developer tools opening |
| Right-Click Disabled | Prevents copy/paste |
| Screen Watermark | Anti-screenshot overlay |
| One-Submission Lock | Prevents duplicate attempts |
| Proctor Photo Capture | 3 intake photos + periodic snapshots |
| Multiple People Detection | Basic face detection warning |
| Audio Monitoring | Detects unusual audio levels |
| Violation Logging | All integrity events timestamped |

### 6.3 Result Integrity
| Feature | Description |
|---------|-------------|
| Stored Score Counts | Ground truth saved at submission |
| Verification Codes | Unique hash per result certificate |
| Emergency Backup | JSON download if server save fails |
| Proctor Evidence | Photos and violation logs attached |

---

## 7. Analytics & Reporting

### 7.1 Performance Bands
| Band | Range | Color | Action |
|------|-------|-------|--------|
| Distinction | 90–100% | Green | Recognize and challenge |
| Credit | 70–89% | Blue | Good performance |
| Pass | 50–69% | Amber | Meet expectations |
| Near Miss | 40–49% | Orange | Targeted intervention |
| Fail | 0–39% | Red | Urgent remedial teaching |

### 7.2 Class Insights (Rule-Based, No AI API)
- Average score vs. pass mark
- Struggling students (below 40%)
- Near-miss students (40% to pass mark)
- Top performers (80%+)
- Hardest questions (highest error rates)
- Teacher recommendations

### 7.3 Item Analysis (Per-Question CSV Export)
- Question number and type
- Attempted, correct, wrong, skipped counts
- Error rate percentage
- Average time spent

---

## 8. Enterprise Features

### 8.1 Multi-Teacher Support
- Independent exam creation per teacher
- Separate student rosters
- Individual analytics and reports
- Admin approval workflow

### 8.2 Registered-Student Mode
- Teacher uploads student roster via CSV
- Students verify identity with Student ID
- Only registered students can sit exam
- Results linked to specific student records

### 8.3 Exam Templates
- Save configurations to localStorage
- Duration, pass mark, attempt limits
- Subject, class, term combinations
- Negative marking settings
- Instant loading for repeated exam types

### 8.4 Platform Announcements
- Admin broadcasts to all teachers
- Maintenance notices, policy updates
- Stored in localStorage for persistence

### 8.5 Data Portability
| Format | Use | Direction |
|--------|-----|-----------|
| CSV (Questions) | Upload banks | Import |
| CSV (Students) | Upload rosters | Import |
| CSV (Results) | Download results | Export |
| CSV (Item Analysis) | Difficulty report | Export |
| CSV (Platform) | Full export | Export |
| JSON (Exam Package) | Backup/restore | Both |
| JSON (Student Backup) | Emergency recovery | Both |
| JSON (Teacher Backup) | Complete export | Export |

---

## 9. PWA & Offline

### 9.1 Progressive Web App
| Feature | Description |
|---------|-------------|
| Installable | Add to home screen on mobile |
| App Shell Caching | Core files cached for instant loading |
| Offline Fallback | Custom page when no internet |
| Auto-Save | Exam progress saved every 30s |
| Emergency Backup | JSON download if save fails |

### 9.2 Offline Limitations
- Login/authentication requires internet
- Loading questions requires internet
- Submitting results requires internet
- Only exam-taking progress auto-saves offline

---

## 10. Free Tools Used

| Tool | Purpose | Cost |
|------|---------|------|
| Supabase | Database + Auth + Real-time | Free (500MB, 50K MAU) |
| Chart.js | Analytics charts | Free (CDN) |
| GitHub | Version control | Free |
| Vercel | Production hosting | Free (100GB/mo) |
| Netlify | Alternative hosting | Free (100GB/mo) |
| GitHub Pages | Alternative hosting | Free |
| PWA APIs | App installation, offline | Free (built-in) |
| Web Speech API | Text-to-speech | Free (built-in) |
| FileReader API | CSV/XLSX/PDF parsing | Free (built-in) |
| Canvas API | Certificate generation | Free (built-in) |
| localStorage | Auto-save, templates | Free (built-in) |
| Page Visibility API | Tab-switch detection | Free (built-in) |
| Fullscreen API | Exam integrity | Free (built-in) |

> **Total monthly cost: ₦0** — No paid AI APIs, no server costs, no license fees.

---

> **HMG Academy CBT Pro v3.0** — *Learning Deliberately. Teaching Authentically.*  
> © 2026 HMG Concepts. All features free — no paid APIs required.
