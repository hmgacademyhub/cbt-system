# 🔒 HMG Academy CBT Pro v3.0 — Security Policy

> **Security best practices and data protection guidelines.**  
> Built by **HMG Concepts** — *Learning Deliberately. Teaching Authentically.*

---

## 📋 Table of Contents
1. [Security Architecture](#security-architecture)
2. [Data Protection](#data-protection)
3. [Access Control](#access-control)
4. [Exam Integrity](#exam-integrity)
5. [Infrastructure Security](#infrastructure-security)
6. [Incident Response](#incident-response)
7. [Compliance](#compliance)
8. [Contact](#contact)

---

## 🏗️ Security Architecture

### Defense in Depth
1. **Database Layer (RLS)** — PostgreSQL Row-Level Security ensures each teacher only accesses their own data
2. **Application Layer** — Authentication checks on every API call
3. **Transport Layer** — HTTPS encryption for all communications
4. **Client Layer** — No sensitive keys exposed in frontend code

### Security-First Design
- **RLS-First Architecture** — Data isolation enforced at the database level
- **Zero Service Role Exposure** — The `service_role` key is never in frontend files
- **Anon-Only Access** — Only the `anon` public key is used in the browser
- **Least Privilege** — Each role has only the permissions it needs

---

## 🛡️ Data Protection

### Student Data
| Data Type | Storage | Protection |
|-----------|---------|------------|
| Name | Supabase (results table) | RLS-protected |
| Class | Supabase (results table) | RLS-protected |
| Student ID | Supabase (results table) | RLS-protected |
| Exam Answers | Supabase (results.answers_data) | RLS-protected |
| Proctor Photos | Supabase (results.proctor_data) | RLS-protected, base64 |
| Violation Logs | Supabase (results.violation_log) | RLS-protected |

### Data Retention
- Results stored indefinitely within Supabase free tier limits
- Archived exams preserved but hidden from main list
- Deleted exams and results permanently removed (CASCADE)
- Export backups stored locally on teacher's device

### Data Portability
Teachers can export data at any time:
- Exam Package Export (JSON)
- Results CSV Export
- Platform CSV Export (admin only)
- Emergency Backup (student JSON)

---

## 🔐 Access Control

### Role-Based Access
| Role | Permissions |
|------|-------------|
| **Student** | Submit results, view own results, take exams |
| **Teacher** | Create/manage exams, view own results, manage own students |
| **Admin** | All teacher permissions + manage all teachers, platform-wide access |

### Teacher Approval Workflow
1. Teacher creates account → status set to `pending` by trigger
2. Teacher sees "Awaiting Approval" screen
3. Admin reviews and approves from admin panel
4. Teacher status changes to `active` → gains dashboard access

### Session Security
- **Admin sessions** expire after 1 hour (with refresh token support)
- **Teacher sessions** managed by Supabase Auth with automatic refresh
- **Student sessions** are single-use (one exam, one submission)

### ⚠️ Never Expose the Service Role Key
The `service_role` key has **unrestricted database access** and should **never** appear in frontend files.

---

## 🛡️ Exam Integrity

### Anti-Cheat Measures
| Measure | Description |
|---------|-------------|
| Tab-Switch Detection | Warns and logs tab/window switches |
| Fullscreen Enforcement | Detects exit from fullscreen mode |
| DevTools Detection | Flags developer tools opening |
| Right-Click Disabled | Prevents copy/paste of content |
| Screen Watermark | Dynamic anti-screenshot overlay |
| One-Submission Lock | Prevents duplicate attempts |
| Proctor Photo Capture | 3 intake photos + periodic snapshots |
| Multiple People Detection | Basic face detection warning |
| Audio Monitoring | Detects unusual audio levels |
| Violation Logging | All events recorded with timestamps |

### Result Verification
- **Verification Codes** — Unique hash per result certificate
- **Stored Score Counts** — Ground truth saved at submission
- **Proctor Evidence** — Photos and violation logs attached
- **Emergency Backup** — JSON download if server save fails

---

## 🌐 Infrastructure Security

### Hosting Security
| Platform | Features |
|----------|----------|
| **Vercel** | Auto HTTPS, DDoS protection, global CDN |
| **GitHub Pages** | HTTPS enforced, static-only |
| **Netlify** | Auto HTTPS, DDoS protection, security headers |

### Network Security (`_headers` file)
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: SAMEORIGIN`
- `Referrer-Policy: strict-origin-when-cross-origin`
- `Permissions-Policy: geolocation=(), payment=(), usb=(), bluetooth=()`

---

## 🚨 Incident Response

### If a Security Issue Is Discovered
1. **Immediate:** Rotate Supabase `anon` key, update `SB_KEY` in HTML files, re-deploy
2. **Investigation:** Review `platform_logs`, check violation logs, assess scope
3. **Remediation:** Apply fix, test in staging, deploy to production, notify users

### Reporting
- **WhatsApp:** +234 810 086 6322
- **Email:** buildingmyictcareer@gmail.com
- **Phone:** +234 907 790 7677

---

## 📜 Compliance

### Nigeria Data Protection Act (NDPA) 2023
- Collecting only necessary student data
- Storing data securely with RLS protection
- Providing data portability through exports
- Allowing data deletion
- Not sharing data with third parties

---

## 📞 Contact

**HMG Concepts** — Security & Support

| Channel | Contact |
|---------|---------|
| WhatsApp | [+234 810 086 6322](https://wa.me/2348100866322) |
| Phone | +234 907 790 7677 |
| Email | buildingmyictcareer@gmail.com |
| Founder | Adewale Samson Adeagbo |
| HMG Academy | [hmgacademy.pages.dev](https://hmgacademy.pages.dev/) |
| HMG Concepts | [hmgconcepts.pages.dev](https://hmgconcepts.pages.dev/) |

---

> **HMG Academy CBT Pro v3.0** — *Learning Deliberately. Teaching Authentically.*  
> © 2026 HMG Concepts. All features free — no paid APIs required.
