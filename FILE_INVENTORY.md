# File Inventory — HMG Academy CBT Pro v3.1

This inventory lists all project files prepared for upload.

| File | Purpose |
|---|---|
| `.nojekyll` | Ensures GitHub Pages serves files directly without Jekyll processing. |
| `_headers` | Optional static-host security headers, especially for Netlify/Cloudflare-like hosts. |
| `admin.html` | Enterprise admin panel for teacher approval, platform analytics, exports, and security checks. |
| `assets/hmg-academy-logo.png` | Primary HMG Academy logo used by the platform UI. |
| `CHANGELOG.md` | Version history and summary of fixes/enhancements. |
| `COMPLETE_SQL_SETUP.sql` | Canonical Supabase/Postgres setup: tables, upgrades, RLS, RPCs, triggers, grants, verification. |
| `CONTRIBUTING.md` | Contribution rules and development/testing checklist. |
| `DEPLOYMENT.md` | Detailed deployment instructions. |
| `DEPLOYMENT_GUIDE.md` | Quick deployment checklist. |
| `deployment_validator.html` | Browser-only static deployment readiness checker. |
| `DIAGNOSIS_REPORT.md` | Expert diagnosis of issues found and corrected. |
| `EXPERT_ENHANCEMENT_REPORT.md` | Expert summary of enhancements and market-aligned features. |
| `feature_guide.html` | Browser-readable feature/deployment guide. |
| `FEATURES.md` | Detailed written feature documentation. |
| `FEATURES_GUIDE.md` | User-oriented feature guide for teachers/students/admins. |
| `FILE_INVENTORY.md` | This file inventory. |
| `further_maths_sample.csv` | Sample question CSV with extended metadata columns. |
| `hmg-academy-logo.png` | Legacy/root logo copy retained for compatibility. |
| `hmg-icon.svg` | Lightweight SVG icon/favicon. |
| `index.html` | Public landing page. |
| `LICENSE` | Project license. |
| `link_checker.html` | Exam link/code health checker. |
| `manifest.webmanifest` | PWA manifest. |
| `offline.html` | PWA offline fallback page. |
| `PROMPT_TEMPLATE.md` | Prompt template for future AI/developer maintenance. |
| `README.md` | Main project overview and quick start. |
| `SECURITY.md` | Security model, operational precautions, incident response. |
| `student.html` | Student exam portal. |
| `sw.js` | Service worker for PWA/offline shell caching. |
| `teacher.html` | Teacher dashboard for exam creation, student management, results, analytics, and settings. |

## Excluded from upload package

The `.git` directory and local system/cache files are excluded from the upload package and zip.

- `ADVANCED_QUESTION_TYPES_GUIDE.md` — explains all 17 supported question types and CSV JSON schemas.
- `CBT_V3_AUDIT_AND_DEPLOYMENT_STEPS.md` — v3 audit, documentation alignment, prompt-template purpose, and deployment steps.
- `robots.txt` — search engine crawl instructions and sitemap pointer.
- `sitemap.xml` — public page list for Google, Bing and other search engines.
- `llms.txt` — AI/search assistant summary of HMG Academy CBT Pro and HMG Concepts ecosystem.
- `browserconfig.xml` — Windows/PWA tile metadata.
- `SEO_PWA_LEAD_GENERATION.md` — SEO, installability and lead-generation guide.
- `pwa_install_enforcer.js` — browser-native install prompt/enforcement helper.
- `EXAM_COMPATIBILITY_GUIDE.md` — explains exam types and school workflows supported by CBT v4.
- `CBT_V4_ENTERPRISE_ENHANCEMENT_REPORT.md` — v4 feature audit, deployment and smoke-test guide.
- `CBT_V5_EXAM_TYPE_AND_ENTERPRISE_REPORT.md` — explains v5 exam-type expansion, presets, similar-platform features and deployment steps.
- `FULLSTACK_SAAS_ARCHITECTURE.md` — explains the fullstack/SaaS architecture, v6 SQL repair, institutions and audit logs.


- `CBT_V6_SQL_REPAIR_AND_SAAS_DEPLOYMENT.md` — explains the Supabase pass-rate SQL fix, fullstack/SaaS readiness and v6 deployment steps.
- `CBT_V7_BUG_FIX_AND_VISIBILITY_REPORT.md` — explains student result/question print visibility fixes and Math/Science keyboard reliability improvements.

