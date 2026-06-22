# HMG Academy CBT Pro v3.2 Enterprise — Deployment Guide

## Prerequisites
- GitHub account (free)
- Supabase account (free tier)
- Vercel or Netlify account (free)

## Step 1: Deploy Files to GitHub
1. Create a new repo at github.com/new called `cbt-system`
2. Upload all files from the `CBT` folder
3. Commit to main branch

## Step 2: Set Up Supabase
1. Create project at supabase.com
2. Get `SB_URL` and `SB_KEY` from Project Settings → API
3. Update these in: `teacher.html`, `student.html`, `admin.html`, `link_checker.html`, `certificate.html`
4. Go to SQL Editor → paste entire `COMPLETE_SQL_SETUP.sql` → Run

## Step 3: Deploy to Vercel
1. Connect GitHub repo to Vercel
2. Framework: Other → Deploy
3. Update Supabase Auth → Settings with your Vercel URL

## Step 4: Test Flow
1. Teacher signup → Admin approval → Create exam
2. Student takes exam → Submit → Result saves
3. Teacher views result → Export/Delete as needed
4. Issue certificate → Student verifies at certificate.html
