# CBT v6 — SQL Repair, Fullstack SaaS Readiness and Deployment Guide

Date: 2026-06-24

## Error reported

Supabase returned:

```text
Failed to run sql query: ERROR: 42601: mismatched parentheses at or near ";"
LINE 868: ), 0) AS pass_rate;
```

## Root cause

The issue was inside `admin_get_platform_stats()` in `COMPLETE_SQL_SETUP.sql`. The former pass-rate expression used an aggregate `FILTER` expression with casting inside a nested `ROUND/COALESCE` expression. Supabase/Postgres reported a syntax issue at the end of the statement.

## Fix applied

The old expression was replaced with a clearer Postgres-safe version:

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

This computes pass rate as the percentage of result rows where score percentage is at least 50%.

## Validation

The full `COMPLETE_SQL_SETUP.sql` was parsed successfully after the repair using a PostgreSQL parser. JavaScript syntax checks were also run on major HTML files.

## Fullstack/SaaS enhancement in v6

The app is a fullstack SaaS-style system:

- Frontend: static HTML/CSS/JavaScript.
- Backend: Supabase Auth, Postgres, RLS and RPC functions.
- Hosting: Vercel/Cloudflare Pages/GitHub Pages.
- PWA: installable web app.
- No paid AI API.

CBT v6 adds SaaS-ready backend structures:

- `institutions` table;
- `audit_logs` table;
- optional `institution_id` on profiles, exams, students and results;
- RLS policies for institutions and audit logs;
- `log_audit_event()` RPC;
- indexes for tenant/audit lookup.

These additions prepare the platform for future multi-school tenancy, institution branding, SaaS plan tiers, audit views and school-owner dashboards without breaking existing teacher/student workflows.

## Deployment steps

### 1. Upload files

1. Open the `cbt v6` folder.
2. Copy all files inside it.
3. Replace the files in the GitHub repository root.
4. Commit and push.

### 2. Run repaired SQL

1. Go to Supabase Dashboard.
2. Open SQL Editor.
3. Open `COMPLETE_SQL_SETUP.sql` from the `cbt v6` folder.
4. Copy the whole file.
5. Paste into SQL Editor.
6. Run it from top to bottom.
7. Confirm it completes successfully.

If you previously got the pass-rate error, this repaired SQL is the version to use.

### 3. Redeploy

For Vercel:

1. Open the Vercel project.
2. Redeploy from the latest GitHub commit.
3. Wait for completion.
4. Hard refresh the browser.

For Cloudflare Pages:

1. Push to GitHub.
2. Redeploy Pages project.
3. Hard refresh the browser.

### 4. Verify

Open:

```text
/deployment_validator.html
```

Confirm checks for:

- v6 pass-rate SQL repair;
- SaaS backend readiness;
- result/certificate RPCs;
- SEO/PWA files;
- teacher navigation;
- PWA install helper.

## Functional smoke test

1. Login as teacher.
2. Create an exam.
3. Submit as a student.
4. Confirm result appears in teacher dashboard.
5. Print result/certificate from teacher dashboard.
6. Login as admin.
7. Confirm admin panel loads data.
8. Run deployment validator.

## Notes

- Do not expose a Supabase service-role key in frontend files.
- The platform remains free-tier friendly.
- SaaS institution/audit structures are backend-ready but do not force you to use paid services.
- Existing data is preserved because all SQL changes are idempotent and use `IF NOT EXISTS` where appropriate.
