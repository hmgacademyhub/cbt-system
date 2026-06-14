# 🚀 HMG Academy CBT Pro v3.0 — Complete Deployment Guide

> **Step-by-step instructions for deploying your CBT platform from zero to production.**  
> Built by **HMG Concepts** — *Learning Deliberately. Teaching Authentically.*

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Step 1: Create Supabase Project](#step-1-create-supabase-project)
3. [Step 2: Update Credentials](#step-2-update-credentials)
4. [Step 3: Run Database Setup SQL](#step-3-run-database-setup-sql)
5. [Step 4: Configure Authentication](#step-4-configure-authentication)
6. [Step 5: Deploy to Vercel (Recommended)](#step-5-deploy-to-vercel-recommended)
7. [Step 5b: Deploy to GitHub Pages](#step-5b-deploy-to-github-pages)
8. [Step 5c: Deploy to Netlify](#step-5c-deploy-to-netlify)
9. [Step 6: Post-Deployment Verification](#step-6-post-deployment-verification)
10. [Step 7: Ongoing Maintenance](#step-7-ongoing-maintenance)
11. [Troubleshooting](#troubleshooting)
12. [Security Checklist](#security-checklist)
13. [Cost Breakdown](#cost-breakdown)

---

## 📦 Prerequisites

Before you begin, ensure you have:

| Requirement | Details |
|-------------|---------|
| **Supabase Account** | Free at https://supabase.com (provides database + auth) |
| **GitHub Account** | Free at https://github.com (for version control) |
| **Hosting Platform** | Vercel (recommended), GitHub Pages, or Netlify — all free |
| **HMG Academy Logo** | PNG format, 1:1 ratio (e.g., 512×512px) |
| **Admin Email** | The email address that will have super-admin access |
| **Custom Domain** *(optional)* | ~₦5,000/year for yourschool.com |
| **Internet Connection** | Required for initial setup and Supabase communication |

**Total setup time:** 15–30 minutes  
**Monthly cost:** ₦0 (all free tier)

---

## Step 1: Create Supabase Project

1. Go to **https://supabase.com** and sign up (or log in)
2. Click **"New Project"**
3. Fill in the project details:
   - **Name:** e.g., `hmg-academy-cbt`
   - **Database Password:** Create a strong password (save it!)
   - **Region:** Choose the closest to your users (e.g., `West Europe` for Nigeria)
4. Click **"Create new project"** and wait ~2 minutes for provisioning
5. Once ready, go to **Settings → API** in the left sidebar
6. Copy these two values (you'll need them in Step 2):
   - **Project URL:** e.g., `https://pstnsaqjshmtintjrnas.supabase.co`
   - **anon public key:** e.g., `eyJhbGci...` (starts with eyJ)

> ⚠️ **Never share your `service_role` key.** Only the `anon public` key goes in your frontend files.

---

## Step 2: Update Credentials

Open these three files in a text editor (VS Code, Notepad++, or any editor):

- `teacher.html`
- `student.html`
- `admin.html`

In **each file**, find and replace these three constants:

```javascript
// ── FIND these lines ──
const SB_URL = 'https://pstnsaqjshmtintjrnas.supabase.co';
const SB_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
const ADMIN_EMAIL = 'buildingmyictcareer@gmail.com';

// ── REPLACE with YOUR values ──
const SB_URL = 'https://YOUR_PROJECT_ID.supabase.co';
const SB_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.YOUR_ANON_KEY_HERE';
const ADMIN_EMAIL = 'your-admin-email@yourschool.com';
```

**Important:**
- `SB_URL` = The Project URL from Supabase Settings → API
- `SB_KEY` = The **anon public** key (NOT the service_role key)
- `ADMIN_EMAIL` = The email that gets super-admin access to the platform

Save all three files after updating.

---

## Step 3: Run Database Setup SQL

### Option A: Use the Complete SQL File (Recommended)

1. Open **`COMPLETE_SQL_SETUP.sql`** in a text editor
2. Copy **ALL** the SQL content (Ctrl+A, Ctrl+C)
3. Go to **Supabase Dashboard → SQL Editor** in the left sidebar
4. Click **"New Query"**
5. Paste the entire SQL content (Ctrl+V)
6. Click **"Run"** (or press Ctrl+Enter)
7. Wait for the "Success" message
8. Scroll through the results to verify all checks pass

### Option B: Run Step by Step

If you prefer to run blocks individually, follow this exact order:

| Step | What It Does |
|------|-------------|
| 1. Create Tables | Creates `exams`, `results`, `profiles`, `students` |
| 2. Add Missing Columns | Safe upgrade for existing databases |
| 3. Enable RLS | Turns on row-level security (critical!) |
| 4. Drop Old Policies | Clean slate to prevent conflicts |
| 5. Create RLS Policies | Per-teacher data isolation rules |
| 6. Helper Function | `get_exam_teacher_id()` for RLS bypass |
| 7. Auto-Signup Trigger | Creates pending profile on teacher signup |
| 8. Update Triggers | Auto-updates `updated_at` on record changes |
| 9. Admin RPC Functions | Cross-teacher data access for admin panel |
| 10. Migrate Users | Only if teachers existed before profiles table |
| 11. Setup Admin | Insert your admin profile row |
| 12. Verify Setup | Confirmation queries |

> ⚠️ **Critical:** Do NOT skip the RLS steps (3-5). Without RLS, every teacher can see every other teacher's exams and results.

---

## Step 4: Configure Authentication

### Enable Email Provider

1. Go to **Supabase Dashboard → Authentication → Providers**
2. Click on **Email**
3. Ensure the toggle is **ON**
4. Toggle **OFF** the "Confirm email" switch (optional but recommended)
   - Why? For school platforms where admin manually approves teachers, email confirmation adds unnecessary friction
5. Click **Save**

### Configure Site URL

1. Go to **Supabase Dashboard → Authentication → URL Configuration**
2. Set **Site URL** to your deployment URL:
   - Vercel: `https://your-project.vercel.app`
   - GitHub Pages: `https://yourusername.github.io/cbt-system`
   - Netlify: `https://your-site.netlify.app`
   - Custom domain: `https://cbt.yourschool.com`
3. Click **Save**

---

## Step 5: Deploy to Vercel (Recommended)

### Why Vercel?
- Fastest deployment (~30 seconds)
- Automatic HTTPS
- Global CDN
- Preview deployments for testing
- Free tier includes 100GB bandwidth/month

### Deployment Steps

1. **Prepare your files:**
   Ensure all files from the CBT folder are ready for deployment.

2. **Push to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit — HMG Academy CBT Pro v3.0"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/cbt-system.git
   git push -u origin main
   ```

3. **Deploy on Vercel:**
   - Go to https://vercel.com
   - Click **"Add New..." → "Project"**
   - Import your GitHub repository
   - Leave all settings as default (no build command needed)
   - Click **"Deploy"**
   - Wait ~30 seconds — your platform is live!

4. **Set custom domain** *(optional):*
   - Go to your Vercel project → Settings → Domains
   - Add your domain (e.g., `cbt.yourschool.com`)
   - Follow the DNS configuration instructions

---

## Step 5b: Deploy to GitHub Pages

### Why GitHub Pages?
- Completely free
- Integrated with your GitHub repo
- No additional account needed

### Deployment Steps

1. **Push files to GitHub** (same as Step 5, steps 1-2)

2. **Enable GitHub Pages:**
   - Go to your repo on GitHub
   - Click **Settings → Pages** (left sidebar)
   - Under "Source", select **"Deploy from a branch"**
   - Branch: `main`, Folder: `/ (root)`
   - Click **Save**

3. **Wait 1-2 minutes** for deployment

4. **Access your site:**
   - URL: `https://YOUR_USERNAME.github.io/cbt-system/`

5. **Ensure `.nojekyll` file exists** in the root directory

---

## Step 5c: Deploy to Netlify

### Why Netlify?
- Drag-and-drop deployment
- Automatic HTTPS
- Form handling (if needed later)
- Free tier includes 100GB bandwidth/month

### Deployment Steps

1. **Go to https://app.netlify.com/drop**

2. **Drag your entire CBT folder** onto the page

3. **Wait ~10 seconds** — instant deployment!

4. **Access your site:**
   - URL: `https://random-name-12345.netlify.app`

5. **Customize site name:**
   - Go to Site settings → Change site name
   - Set to `hmg-academy-cbt` (or any available name)

---

## Step 6: Post-Deployment Verification

### Run the Checklist

1. ✅ **Landing page loads** at `/index.html`
2. ✅ **Teacher login works** at `/teacher.html`
3. ✅ **Student portal works** at `/student.html`
4. ✅ **Admin panel works** at `/admin.html`
5. ✅ **No console errors** — Open browser DevTools (F12) → Console tab
6. ✅ **Logo displays correctly** on all pages
7. ✅ **PWA install prompt appears** on mobile devices
8. ✅ **Service worker registered** — DevTools → Application → Service Workers
9. ✅ **Deployment validator passes** — Visit `/deployment_validator.html`

### End-to-End Test

1. **Create a teacher account** via the signup form
2. **Approve the teacher** from the admin panel
3. **Log in as the teacher**
4. **Create a test exam** with 3-5 questions
5. **Open the exam** and copy the access code
6. **Open student portal** and enter the code
7. **Submit the exam** as a student
8. **Verify the result** appears in the teacher dashboard
9. **Check analytics** — score distribution, pass rate, etc.
10. **Export results as CSV** and verify data integrity

---

## Step 7: Ongoing Maintenance

### Daily
- Monitor student submissions via the teacher dashboard
- Check for any integrity flags on results

### Weekly
- Export results CSV for backup
- Review the activity log in the admin panel
- Check platform health metrics

### Monthly
- Run the deployment validator
- Review and update exam question banks
- Check Supabase usage (stay within free tier limits)
- Export full platform backup (JSON)

### Per Term
- Archive completed exams
- Create new exams for the upcoming term
- Update student rosters
- Review and update teacher accounts

---

## 🔧 Troubleshooting

| Problem | Cause | Solution |
|---------|-------|----------|
| **Database error on login** | Wrong SB_URL or SB_KEY | Verify credentials in all 3 HTML files match Supabase API settings |
| **Teacher can't log in** | Email confirmation still enabled | Go to Auth → Providers → Email → Toggle OFF "Confirm email" |
| **Teacher sees "Awaiting Approval"** | Account not yet approved by admin | Log in as admin → Pending Approvals → Click Approve |
| **Results don't appear** | RLS policies not set up correctly | Re-run Step 3 SQL (RLS policies) in Supabase SQL Editor |
| **Admin sees zero data** | RPC functions not created | Re-run Step 9 (Admin RPC Functions) from COMPLETE_SQL_SETUP.sql |
| **CSV import fails** | Wrong encoding or format | Ensure UTF-8 encoding, proper quoting, and correct column order |
| **Exam link doesn't work** | Wrong student base URL | Update the student portal URL in the teacher settings page |
| **Console errors** | Missing files or wrong paths | Run deployment_validator.html to check all required files |
| **PWA doesn't install** | Missing manifest or service worker | Ensure manifest.webmanifest and sw.js are in the root directory |
| **Student can't submit** | INSERT policy missing for anon | Re-run the "Students can submit results" policy from Step 5 SQL |
| **Score mismatch** | Questions edited after submission | Run Step 8b SQL to add correct_count/wrong_count/skipped_count columns |
| **"Cannot change return type" error** | Old RPC function exists | Use DROP FUNCTION ... CASCADE before recreating (included in Step 9 SQL) |
| **Tab switch detection not working** | Browser permissions | Ensure the student page has focus; some browsers restrict visibility API |
| **Proctor photos not captured** | Camera permission denied | Student must grant camera access when prompted |

---

## 🛡️ Security Checklist

### Before Going Live

- [ ] RLS enabled on all four tables (exams, results, profiles, students)
- [ ] `service_role` key is **NOT** in any frontend file
- [ ] HTTPS enabled on your hosting platform
- [ ] Admin email is set correctly in `admin.html`
- [ ] Email confirmation is disabled (if using admin approval workflow)
- [ ] Teacher approval workflow is active
- [ ] All RPC functions are created and verified
- [ ] Deployment validator passes all checks

### Ongoing Security

- [ ] Review and approve teacher accounts manually
- [ ] Monitor integrity flags on student submissions
- [ ] Export regular backups (JSON + CSV)
- [ ] Rotate Supabase API keys if compromised
- [ ] Keep student data confidential and GDPR/Nigeria Data Protection Act compliant
- [ ] Use registered-student mode for high-stakes exams
- [ ] Review proctor photos before making decisions about integrity violations

---

## 💰 Cost Breakdown

| Component | Service | Cost |
|-----------|---------|------|
| **Database** | Supabase Free Tier | $0/month (up to 500MB, 2 projects) |
| **Authentication** | Supabase Auth | $0/month (up to 50,000 MAU) |
| **Hosting** | Vercel / Netlify / GitHub Pages | $0/month |
| **Charts** | Chart.js (CDN) | $0 |
| **AI APIs** | **Not Used** | **$0** |
| **Domain** | Custom domain (optional) | ~₦5,000/year (~$3) |
| **Total** | | **₦0/month** |

---

## 📞 Support

**HMG Academy CBT Pro** is built and maintained by:

**Adewale Samson Adeagbo**  
Founder, HMG Concepts  
Data Scientist · STEM Educator · AI-Augmented Solutions Developer  
15+ years in Nigerian classrooms across Lagos and Ogun State

| Channel | Contact |
|---------|---------|
| WhatsApp | [+234 810 086 6322](https://wa.me/2348100866322) |
| Phone | +234 907 790 7677 |
| Email | hismarvellousgrace@gmail.com |
| Partnerships | buildingmyictcareer@gmail.com |
| HMG Academy | [hmgacademy.pages.dev](https://hmgacademy.pages.dev/) |
| HMG Concepts | [hmgconcepts.pages.dev](https://hmgconcepts.pages.dev/) |
| Portfolio | [cssadewale.pages.dev](https://cssadewale.pages.dev/) |

---

> **HMG Academy CBT Pro v3.0** — *Learning Deliberately. Teaching Authentically.*  
> © 2026 HMG Concepts. All features free — no paid APIs required.
