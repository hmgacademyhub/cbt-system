# HMG Academy CBT Pro v6 — Fullstack SaaS Architecture

## Summary

HMG Academy CBT Pro is a fullstack SaaS-style web application built with free/static-friendly tools:

- **Frontend:** static HTML, CSS and JavaScript.
- **Backend/database:** Supabase Postgres, Auth, RLS and RPC functions.
- **Hosting:** Vercel, Cloudflare Pages, GitHub Pages or any static host.
- **PWA layer:** service worker, manifest and install prompt.
- **No paid AI API:** all scoring and analytics are rule-based or SQL/browser based.

## Why this qualifies as fullstack

The application has a real frontend and a real backend:

### Frontend layer

- `index.html` — SEO/PWA landing page.
- `teacher.html` — exam authoring, results, analytics and student management.
- `student.html` — exam delivery, autosave, anti-cheat, submission and certificates.
- `admin.html` — platform administration and teacher/account control.
- `certificate.html` — public certificate verification.

### Backend layer

- Supabase Auth for users.
- Postgres tables for teachers, exams, results, students, institutions and audit logs.
- RLS policies for tenant/user separation.
- RPC functions for secure student flows, admin flows, result saving and certificate verification.

## SaaS / multi-tenant readiness added in v6

The SQL now includes optional SaaS tables and columns:

### `institutions`

Represents schools, centres, training providers, organisations or HMG-managed client tenants.

Fields include:

- name
- slug
- owner_id
- plan
- status
- branding JSON
- settings JSON
- timestamps

### `audit_logs`

Stores platform actions for compliance and traceability.

Fields include:

- institution_id
- actor_id
- actor_email
- action
- entity_type
- entity_id
- metadata JSON
- timestamp

### Tenant columns

Optional `institution_id` columns were added to:

- profiles
- exams
- students
- results

This makes it possible to evolve the platform from single-school/teacher use into school-by-school SaaS tenancy while preserving existing data.

## v6 SQL repair

The Supabase SQL error:

```text
ERROR: 42601: mismatched parentheses at or near ";"
LINE 868: ), 0) AS pass_rate;
```

was caused by the previous `admin_get_platform_stats()` pass-rate expression. CBT v6 replaces it with a clearer and safer expression:

```sql
COALESCE((
  SELECT ROUND(
    AVG(CASE WHEN (score / NULLIF(total, 0)) * 100 >= 50 THEN 1 ELSE 0 END) * 100,
    2
  )
  FROM public.results
  WHERE total > 0
), 0) AS pass_rate
```

The full SQL file was parsed successfully after the repair.

## Enterprise features already present

- 17 question types.
- Exam type presets for admission, scholarship, common entrance, recruitment, certification, STEM and standardised practice.
- Teacher result/certificate printing.
- Student question navigator hide/show.
- PWA installation prompts.
- SEO/lead-generation pages.
- Certificate verification.
- Admin panel.
- Anti-cheat controls.
- Registered student roster mode.
- CSV/XLSX/PDF import options.
- Exports and backups.

## Recommended next SaaS steps

These can be added later without paid APIs:

1. Institution onboarding page.
2. Institution branding editor.
3. Per-institution teacher limits.
4. Per-institution result quotas.
5. Admin audit-log viewer.
6. Tenant-specific landing pages.
7. Public pricing/contact page.
8. Self-service school signup workflow.

The backend SQL is now prepared for these future steps.
