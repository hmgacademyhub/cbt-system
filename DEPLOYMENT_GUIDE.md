# HMG Academy CBT — Deployment Guide (Free Tools Only)

This guide gives **clear, unambiguous, step-by-step** instructions to deploy the fixed and enhanced system. Everything here uses **free** services: GitHub (code), and any one of Vercel / GitHub Pages / Cloudflare Pages (hosting), with Supabase free tier as the backend (already configured in the files).

> **You do not need a build step.** These are plain static files. "Deploying" just means putting the files online.

---

## 0. What's in this `cbt/` folder

```
cbt/
├── index.html                 ← landing page / role selector
├── student.html               ← student exam portal (BUG FIXED here)
├── teacher.html               ← teacher dashboard
├── admin.html                 ← admin panel
├── link_checker.html          ← NEW: exam link & code health checker
├── feature_guide.html         ← in-app feature guide
├── deployment_validator.html  ← readiness checker
├── offline.html               ← PWA offline fallback
├── manifest.webmanifest       ← PWA metadata
├── sw.js                      ← service worker (cache bumped to v5)
├── _headers                   ← security headers (Vercel/Cloudflare/Netlify)
├── .nojekyll                  ← required for GitHub Pages
├── hmg-icon.svg               ← app icon
├── hmg-academy-logo.png       ← logo
├── further_maths_sample.csv   ← sample question template
├── assets/                    ← static assets
├── README.md, LICENSE.txt, SECURITY.md, CONTRIBUTING.md, ...docs
├── FIX_REPORT_AND_DIAGNOSIS.md ← what was broken & how it was fixed
├── FEATURES_GUIDE.md          ← every feature explained
├── DEPLOYMENT_GUIDE.md        ← this file
└── cbt-system-FIXED.zip       ← ready-to-upload zip of everything above
```

The matching **`cbt-system-FIXED.zip`** in this folder contains all of these files ready for upload.

---

## 1. Before you start — important note on the fix

The bug was in `student.html`. Because the broken version may already be **cached** on students' phones, the service worker cache was bumped from `v4` to `v5`. This means: **as soon as you deploy, returning devices will automatically download the fixed files on their next visit.** No action needed from students beyond reopening the page.

---

## 2. Option A — Deploy via GitHub + Vercel (recommended, matches current live site)

### Step 1 — Get the files into your GitHub repo
**Easiest (web upload):**
1. Go to your repository: `https://github.com/hmgacademyhub/cbt-system`.
2. Click **Add file → Upload files**.
3. Drag in **all files from this `cbt/` folder** (or unzip `cbt-system-FIXED.zip` and drag those). When asked, choose **"Replace"** existing files.
4. Scroll down, write a commit message like `Fix: student exam-code parser (backspace regex) + add link checker`, and click **Commit changes**.

**Or via Git command line:**
```bash
# from inside the unzipped cbt folder
git init                       # if not already a repo
git remote add origin https://github.com/hmgacademyhub/cbt-system.git
git add .
git commit -m "Fix student access bug + add link checker & guards"
git branch -M main
git push -u origin main        # use --force only if you intend to overwrite
```

### Step 2 — Vercel auto-deploys
- The existing Vercel project is connected to this repo. When you push/commit, **Vercel rebuilds automatically** within ~1 minute.
- If you are setting up Vercel fresh: go to https://vercel.com → **Add New → Project → Import** your GitHub repo → **Framework Preset: Other** → **Root Directory: `/`** → **Deploy**. No build command is needed.

### Step 3 — Confirm
- Visit `https://<your-app>.vercel.app/` and run the post-deploy checklist in Section 6.

---

## 3. Option B — Deploy via GitHub Pages (free, no Vercel)

1. Upload the files to the repo (Section 2, Step 1).
2. In the repo: **Settings → Pages**.
3. Under **Build and deployment → Source**, choose **Deploy from a branch**.
4. Branch: **main**, Folder: **/(root)** → **Save**.
5. Wait 1–2 minutes. Your site appears at `https://hmgacademyhub.github.io/cbt-system/`.
6. The included **`.nojekyll`** file is required (already present) so GitHub Pages serves all files correctly.

> Note: GitHub Pages ignores `_headers`. Security headers still apply on Vercel/Cloudflare/Netlify.

---

## 4. Option C — Deploy via Cloudflare Pages (free)

1. Push files to GitHub (Section 2, Step 1).
2. Go to https://dash.cloudflare.com → **Workers & Pages → Create → Pages → Connect to Git**.
3. Select the repo. **Build command: (leave empty)**. **Build output directory: `/`**.
4. **Save and Deploy.** Cloudflare honours the `_headers` file automatically.

---

## 5. Supabase backend (already configured — reference only)

The files already point to the live Supabase project (`SB_URL` / `SB_KEY` in `student.html`, `teacher.html`, `admin.html`, `link_checker.html`). **You do not need to change anything to fix the bug.**

If you ever create your **own** Supabase project:
1. Create a free project at https://supabase.com.
2. Create tables: `exams`, `results`, `students`, `profiles` (see the SQL in `DIAGNOSIS_FEATURES_DEPLOYMENT.md` / `ENTERPRISE_DEPLOYMENT_GUIDE.md`).
3. Enable **Row Level Security** with policies that allow:
   - anonymous **SELECT** on `exams` (so students can load by code),
   - anonymous **INSERT** on `results` (so students can submit),
   - anonymous **SELECT** on `students` (for registered-mode verification),
   - authenticated teacher/admin access for the rest.
4. Copy your **Project URL** and **anon public key** into the `SB_URL` and `SB_KEY` constants in `student.html`, `teacher.html`, `admin.html`, and `link_checker.html`.
5. Re-deploy.

> Use only the **anon (public)** key in front-end files — never the service role key.

---

## 6. Post-deployment verification checklist (do this every time)

1. **Health checker:** open `…/link_checker.html`, paste a known open exam code → expect **all green** and a working **"Open the student exam page"** link.
2. **Direct link:** open `…/student.html?code=YOURCODE` → the **exam banner + entry form** load (NOT the "enter code" box).
3. **Manual code:** open `…/student.html`, type the code, click **Open Exam →** → same exam loads.
4. **End-to-end:** start the exam, answer, submit → result + certificate appear; the submission shows in the **teacher dashboard** results.
5. **Returning device:** on a phone that used the site before, reopen it → confirm the new version loads (service worker `v5`). If a stale version persists, do a hard refresh or "Add to Home Screen" again.
6. **Teacher share:** in the teacher dashboard, generate a link and a WhatsApp share → open the link as a student to confirm it works.

If steps 1–3 pass, the reported "students can't access the exam" issue is resolved.

---

## 7. Rollback (if ever needed)
- On GitHub: open the repo **Commits**, find the previous commit, and **Revert**.
- On Vercel: **Deployments** tab → pick a previous successful deployment → **Promote to Production**.

---

## 8. Cost summary (all free)
| Component | Service | Cost |
|---|---|---|
| Code hosting | GitHub | Free |
| Site hosting | Vercel / GitHub Pages / Cloudflare Pages | Free |
| Database & Auth | Supabase free tier | Free |
| Proctoring face model | face-api.js via jsDelivr CDN | Free |
| AI API | **None used** | ₦0 |

**Total running cost: ₦0.**
