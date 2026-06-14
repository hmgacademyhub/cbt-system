# 📝 HMG Academy CBT Pro — Changelog

> **Tracking all changes, fixes, and enhancements.**  
> Built by **HMG Concepts** — *Learning Deliberately. Teaching Authentically.*

---

## v3.0.0 — June 13, 2026

### 🐛 Critical Bug Fixes

1. **Service Worker Cache References**
   - **Problem:** `sw.js` referenced non-existent files (`README.md`, `DEPLOY_NOW.txt`, etc.)
   - **Fix:** Updated cache list to only include files that actually exist
   - **Files:** `sw.js`

2. **SQL Column Name Mismatch**
   - **Problem:** Results table had `student_id` but frontend queried `student_id_ref`
   - **Fix:** Unified all references to `student_id_ref` and `student_type`
   - **Files:** `COMPLETE_SQL_SETUP.sql`, `teacher.html`, `student.html`, `admin.html`

3. **RLS Recursive Deadlock**
   - **Problem:** Results policies caused recursive RLS errors when exams table also had RLS
   - **Fix:** Created `get_exam_teacher_id()` SECURITY DEFINER helper function
   - **Files:** `COMPLETE_SQL_SETUP.sql`

4. **Admin RPC Functions Missing CASCADE**
   - **Problem:** "Cannot change return type" errors when re-running SQL
   - **Fix:** Added `DROP FUNCTION ... CASCADE` before recreating all admin RPC functions
   - **Files:** `COMPLETE_SQL_SETUP.sql`

5. **Auto-Signup Trigger Failures**
   - **Problem:** Trigger failed without `SECURITY DEFINER` and proper schema context
   - **Fix:** Added `SET search_path = public`, `SECURITY DEFINER`, and exception handling
   - **Files:** `COMPLETE_SQL_SETUP.sql`

6. **Teacher Signup Blocked by Missing Grants**
   - **Problem:** Trigger couldn't write to profiles table due to missing permissions
   - **Fix:** Added `GRANT ALL ON public.profiles TO postgres/service_role`
   - **Files:** `COMPLETE_SQL_SETUP.sql`

7. **Score Mismatch Between Student and Teacher Views**
   - **Problem:** Teacher dashboard re-scored from answers_data with modified question banks
   - **Fix:** Added `correct_count`, `wrong_count`, `skipped_count` columns as authoritative source
   - **Files:** `COMPLETE_SQL_SETUP.sql`, `teacher.html`, `student.html`

### ✨ New Enterprise Features (30 Total)

1. Full Exam Editing, 2. Question Append, 3. Exam Templates, 4. Negative Marking, 5. Exam Scheduling, 6. Auto-Close Scheduling, 7. Result Release Control, 8. Question Difficulty Levels, 9. Sectioned Exams, 10. Student Progress Tracking, 11. Certificates with Verification, 12. Per-Question Time Analytics, 13. Exam Archive, 14. Student Weakness Identification, 15. Leaderboard with Percentiles, 16. Batch Exam Actions, 17. Question Reusability, 18. Text-to-Speech, 19. Dynamic Screen Watermark, 20. Item Analysis Export, 21. Code Regeneration, 22. Printable Result Slips, 23. Deployment Validator, 24. Feature Guide, 25. Admin Security Centre, 26. Proctoring Photo Capture, 27. Developer Tools Detection, 28. Multiple People Detection, 29. Emergency Backup System, 30. Notification System

### 📚 Documentation

- **README.md** — Completely rewritten with comprehensive overview
- **DEPLOYMENT.md** — Step-by-step guide with troubleshooting
- **FEATURES.md** — Detailed documentation of every feature
- **CHANGELOG.md** — This file, tracking all changes
- **SECURITY.md** — Security best practices and compliance
- **CONTRIBUTING.md** — Guidelines for community contributions
- **EXPERT_ENHANCEMENT_REPORT.md** — Complete audit and enhancement report

---

## v2.0.0 — June 12, 2026

### Initial Release

- Three dedicated portals: Teacher, Student, Admin
- Supabase backend with PostgreSQL database
- 11+ question types with CSV/XLSX/PDF import
- PWA support with offline capabilities
- Row-Level Security for data isolation
- Anti-cheat monitoring (tab-switch detection)
- Analytics and charts with Chart.js
- Result certificates and CSV export
- Student roster management
- WhatsApp sharing for exam links

---

> **HMG Academy CBT Pro v3.0** — *Learning Deliberately. Teaching Authentically.*  
> © 2026 HMG Concepts. All features free — no paid APIs required.
