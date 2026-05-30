# Contributing to HMG Academy CBT Pro

Thank you for helping improve a free EdTech platform built for real classrooms.

This project must remain:

- free to deploy
- mobile-friendly
- framework-free
- backward compatible
- usable without paid AI APIs

---

## Project Values

### 1. Free first

Do not add features that require paid subscriptions, paid AI APIs, paid hosting, or proprietary services.

Acceptable tools:

- browser APIs
- Supabase free tier
- GitHub Pages / Cloudflare Pages / Vercel free tiers
- open-source CDN libraries
- local rule-based logic

### 2. No AI API dependency

You may improve prompts, documentation, and local rule-based analysis. Do not add OpenAI, Gemini, Claude, or other AI API calls into the platform. The system must work at zero AI cost.

### 3. Mobile-first

Many students use phones. Every student-facing feature must work on a small screen.

### 4. Keep it simple

This is a plain HTML/CSS/JavaScript project. Do not introduce React, Vue, Angular, TypeScript, npm, Webpack, or build steps.

### 5. Preserve existing features

Enhance; do not remove. Existing question banks must continue importing.

---

## Current Question Types

The platform supports 11+ question types:

- `mcq`
- `tf`
- `mrq`
- `short`
- `numeric`
- `matching`
- `ordering`
- `cloze`
- `essay`
- `categorization`
- `multi_numeric`

When adding a new question type, update all relevant areas:

1. CSV parser in `teacher.html`
2. XLSX parser in `teacher.html`
3. PDF parser in `teacher.html`, if possible
4. Student renderer in `student.html`
5. Student scoring in `submitExam()`
6. Student result review cards
7. Teacher `scoreQuestion()` helper
8. Teacher result View modal
9. CSV templates
10. README
11. Prompt template
12. Sample CSV

---

## Data Integrity Rules

### Do not re-score teacher results

The teacher dashboard should use:

- `score`
- `total`
- `correct_count`
- `wrong_count`
- `skipped_count`

These are written by the student session at submission time and are the ground truth.

Do not replace them with teacher-side re-scoring because the question bank may have been edited after submission.

### Preserve `_orig` question keys

Student answers are stored by the original CSV question index, not the shuffled display order. This keeps answer review aligned after randomization.

---

## Testing Checklist

Before submitting changes, test:

### Student access

- [ ] Student direct link works.
- [ ] Student raw code entry works.
- [ ] Invalid code shows clear error.
- [ ] Open mode works.
- [ ] Registered mode works.

### Question types

- [ ] MCQ
- [ ] True/False
- [ ] MRQ partial credit
- [ ] Short answer alternates
- [ ] Numeric tolerance
- [ ] Matching partial score
- [ ] Ordering partial score
- [ ] Cloze multi-blank partial score
- [ ] Essay keyword/minimum-word score
- [ ] Categorization partial score
- [ ] Multi-part numeric partial score

### Teacher dashboard

- [ ] Exam creation works.
- [ ] Link and code display.
- [ ] Copy instructions works.
- [ ] Package export works.
- [ ] Package import restores exam.
- [ ] Result appears after submission.
- [ ] Teacher View modal opens.
- [ ] Analytics render.
- [ ] CSV export works.

### Free-tool compliance

- [ ] No paid API keys added.
- [ ] No `service_role` Supabase key added.
- [ ] No framework/build system added.

---

## Security Reports

Do not open public issues for security vulnerabilities. Email:

```text
buildingmyictcareer@gmail.com
Subject: CBT Pro Security Report
```

---

## Pull Request Guidance

A good PR explains:

- what changed
- why it changed
- how to test it
- screenshots or screen recordings for UI changes
- any database SQL needed

Commit prefix examples:

- `feat:`
- `fix:`
- `docs:`
- `security:`
- `refactor:`

---

## What Will Be Rejected

- paid AI API integration
- service_role key in frontend
- framework migration
- breaking CSV compatibility
- removing existing features
- teacher-side re-scoring replacing stored counts
- untested question-type changes

Thank you for contributing to free, practical EdTech for African classrooms.
