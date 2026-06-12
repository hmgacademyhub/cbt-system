# 🚀 HMG Academy CBT Pro — Deployment Guide

## Step-by-Step Instructions

---

## Prerequisites
- Supabase account (free at https://supabase.com)
- GitHub account (free at https://github.com)
- Vercel, Netlify, or GitHub Pages account (all free)
- Institution logo as hmg-academy-logo.png (PNG, 1:1 ratio)
- Admin email address

---

## Step 1: Create Supabase Project
1. Go to https://supabase.com → New project
2. Set project name, database password, and region
3. Wait ~2 minutes for setup
4. Go to Settings → API and copy:
   - Project URL (e.g., https://xxxxx.supabase.co)
   - anon public key (e.g., eyJhbGci...)

---

## Step 2: Update Supabase Credentials
Open teacher.html, student.html, admin.html and replace:

const SB_URL='https://YOUR_PROJECT_ID.supabase.co';
const SB_KEY='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.YOUR_KEY_HERE';
const ADMIN_EMAIL = 'your-admin-email@example.com';

---

## Step 3: Run Database Setup SQL
Go to Supabase Dashboard → SQL Editor and run in order:

### Block 1: Create Tables
CREATE TABLE IF NOT EXISTS exams (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  teacher_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  code TEXT UNIQUE NOT NULL,
  subject TEXT NOT NULL,
  duration INTEGER NOT NULL DEFAULT 45,
  attempt_limit INTEGER NOT NULL DEFAULT 1,
  select_count INTEGER NOT NULL DEFAULT 0,
  is_open BOOLEAN NOT NULL DEFAULT false,
  exam_mode TEXT NOT NULL DEFAULT 'open',
  close_at TIMESTAMPTZ,
  csv_data TEXT NOT NULL DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS results (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  exam_id UUID REFERENCES exams(id) ON DELETE CASCADE,
  student_name TEXT NOT NULL,
  student_id TEXT,
  score INTEGER NOT NULL,
  total INTEGER NOT NULL,
  answers_data TEXT NOT NULL DEFAULT '{}',
  time_taken INTEGER,
  submitted_at TIMESTAMPTZ DEFAULT NOW(),
  proctor_photo TEXT,
  tab_switches INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS students (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  teacher_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT NOT NULL,
  student_id TEXT UNIQUE,
  class TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

### Block 2: Enable Row-Level Security
ALTER TABLE exams ENABLE ROW LEVEL SECURITY;
ALTER TABLE results ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;

### Block 3: Create RLS Policies
CREATE POLICY "Teachers see own exams" ON exams FOR SELECT USING (auth.uid() = teacher_id);
CREATE POLICY "Teachers create own exams" ON exams FOR INSERT WITH CHECK (auth.uid() = teacher_id);
CREATE POLICY "Teachers update own exams" ON exams FOR UPDATE USING (auth.uid() = teacher_id);
CREATE POLICY "Teachers delete own exams" ON exams FOR DELETE USING (auth.uid() = teacher_id);
CREATE POLICY "Students can submit results" ON results FOR INSERT WITH CHECK (true);
CREATE POLICY "Teachers see own results" ON results FOR SELECT USING (EXISTS (SELECT 1 FROM exams WHERE exams.id = results.exam_id AND exams.teacher_id = auth.uid()));
CREATE POLICY "Teachers manage own students" ON students FOR ALL USING (auth.uid() = teacher_id);

---

## Step 4: Enable Email Auth
1. Authentication → Providers → Ensure Email is enabled
2. Authentication → URL Configuration → Set Site URL to your deployment URL
3. Authentication → Email Templates → Customize branding

---

## Step 5: Deploy to Vercel
1. Push all cbt/ files to a GitHub repository
2. Go to https://vercel.com → Add New Project
3. Import your GitHub repo
4. Leave all settings default (no build command needed)
5. Click Deploy → Live in ~30 seconds

---

## Step 6: Deploy to GitHub Pages
1. Push files to GitHub repo main branch
2. Settings → Pages → Source: Deploy from a branch, Branch: main, Folder: /
3. Save → Live at https://username.github.io/repo-name/
4. Ensure .nojekyll file exists in root

---

## Step 7: Deploy to Netlify
1. Go to https://app.netlify.com/drop
2. Drag the cbt/ folder onto the page
3. Instant deployment → Live at random netlify.app subdomain

---

## Step 8: Post-Deployment Verification
- Landing page loads at /index.html
- Teacher login works at /teacher.html
- Student portal works at /student.html
- Admin panel works at /admin.html
- No console errors (F12 → Console)
- Logo displays correctly
- Create test exam → Open it → Take it as student → Verify result appears

---

## Troubleshooting
| Issue | Solution |
|-------|----------|
| Database error | Check SB_URL and SB_KEY are correct in all 3 HTML files |
| Login fails | Verify Email auth enabled and Site URL matches deployment |
| Results don't appear | Check RLS policy allows student INSERT without auth |
| CORS errors | Ensure Supabase allows requests from your domain |
| Edit button doesn't work | Verify you have latest teacher.html with edit modal code |
| CSV import fails | Check UTF-8 encoding and proper quoting |

---

## Cost Breakdown
| Service | Cost |
|---------|------|
| Supabase | Free (500MB, 50K MAU) |
| Vercel | Free |
| GitHub Pages | Free |
| Netlify | Free (100GB/month) |
| AI APIs | Not Used — ₦0 |
| Total | ₦0/month |

---
HMG Academy CBT Pro v2.0 — Learning Deliberately. Teaching Authentically.
© 2026 HMG Concepts
