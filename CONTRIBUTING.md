# 🤝 HMG Academy CBT Pro — Contributing Guide

> **How to contribute to the project.**  
> Built by **HMG Concepts** — *Learning Deliberately. Teaching Authentically.*

---

## Welcome!

Thank you for your interest in contributing to HMG Academy CBT Pro. This platform is designed to be **free, accessible, and enterprise-ready** for African classrooms. All contributions are welcome!

---

## 🚀 Getting Started

### Prerequisites
- **Basic HTML/CSS/JavaScript** knowledge
- A code editor (VS Code recommended)
- A **Supabase** account (free at https://supabase.com)
- A **GitHub** account (free at https://github.com)

### Setting Up Locally

1. **Fork the repository** on GitHub
2. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/cbt-system.git
   cd cbt-system
   ```
3. **Set up Supabase:**
   - Create a new Supabase project
   - Run `COMPLETE_SQL_SETUP.sql` in the SQL Editor
   - Copy the Project URL and anon public key
4. **Update credentials:**
   - In `teacher.html`, `student.html`, and `admin.html`:
     - Replace `SB_URL` with your Supabase Project URL
     - Replace `SB_KEY` with your anon public key
     - Replace `ADMIN_EMAIL` with your email
5. **Open in browser:**
   - Use a local server (e.g., `python -m http.server 8000`)
   - Visit `http://localhost:8000/index.html`

---

## 📁 Project Structure

```
CBT/
├── index.html                    # Landing page
├── teacher.html                  # Teacher dashboard (392KB)
├── student.html                  # Student exam portal (188KB)
├── admin.html                    # Admin management panel (122KB)
├── sw.js                         # Service worker (PWA)
├── manifest.webmanifest          # PWA app manifest
├── offline.html                  # Offline fallback page
├── deployment_validator.html     # Deployment readiness checker
├── feature_guide.html            # Built-in feature documentation
├── link_checker.html             # Exam link/code validator
├── COMPLETE_SQL_SETUP.sql        # Database setup script
├── further_maths_sample.csv      # Sample question bank
├── hmg-academy-logo.png          # Brand logo
├── hmg-icon.svg                  # SVG brand icon
├── _headers                      # Netlify security headers
├── .nojekyll                     # Disable GitHub Pages Jekyll
├── README.md                     # Main documentation
├── DEPLOYMENT.md                 # Deployment guide
├── CHANGELOG.md                  # Version history
├── FEATURES.md                   # Feature documentation
├── SECURITY.md                   # Security policy
├── CONTRIBUTING.md               # This file
├── EXPERT_ENHANCEMENT_REPORT.md  # Expert audit report
├── LICENSE                       # MIT License
└── assets/
    └── hmg-academy-logo.png      # Logo in assets folder
```

---

## 🐛 Reporting Bugs

### Before Reporting
1. Check the **Issues** tab for existing reports
2. Check the **Troubleshooting** section in DEPLOYMENT.md
3. Run the **Deployment Validator** (`deployment_validator.html`)

### When Reporting
Please include:
- **Description:** What happened?
- **Expected:** What should have happened?
- **Steps to Reproduce:** Exact steps to trigger the bug
- **Environment:** Browser, OS, hosting platform
- **Screenshots/Logs:** Error messages or console logs
- **SQL Version:** Have you run the latest `COMPLETE_SQL_SETUP.sql`?

---

## ✨ Suggesting Features

### Before Suggesting
1. Check **FEATURES.md** to see if the feature already exists
2. Consider if it can be implemented with **free tools only** (no paid APIs)

### When Suggesting
Please include:
- **Feature Name:** Short descriptive name
- **Description:** What does it do?
- **Use Case:** Who would use it and why?
- **Implementation Ideas:** How to build with free tools?
- **Priority:** How important for your use case?

---

## 💻 Making Code Contributions

### Guidelines
1. **No paid APIs** — All features must work with free tools only
2. **Don't remove existing features** — Enhance, don't replace
3. **Keep it accessible** — Works in Nigerian classrooms with limited internet
4. **Follow the existing style** — Match code formatting and patterns
5. **Test your changes** — Verify end-to-end
6. **Update documentation** — Document new features in FEATURES.md
7. **Update CHANGELOG.md** — Add your change to the changelog

### Code Style
- **HTML:** Semantic elements, descriptive IDs and classes
- **CSS:** CSS variables for theming, mobile-first responsive design
- **JavaScript:** Vanilla JS (no frameworks), async/await, descriptive names
- **SQL:** Uppercase keywords, consistent indentation, comments

### Testing Checklist
- [ ] Landing page loads correctly
- [ ] Teacher can log in and create an exam
- [ ] Student can take an exam and submit results
- [ ] Results appear in the teacher dashboard
- [ ] Admin panel shows correct data
- [ ] No console errors in the browser
- [ ] PWA works on mobile (installable)
- [ ] Offline page displays when disconnected
- [ ] Deployment validator passes all checks

---

## 🔄 Pull Request Process

1. **Fork** the repository
2. **Create a branch:** `git checkout -b feature/my-new-feature`
3. **Make changes** following guidelines above
4. **Test** thoroughly
5. **Commit** with descriptive message
6. **Push** to your fork
7. **Open a Pull Request** on GitHub
8. **Address feedback** from maintainers
9. **Merge** once approved

---

## 🏷️ Version Numbering

This project follows [Semantic Versioning](https://semver.org/):
- **MAJOR** (3.0.0) — Incompatible API/SQL changes
- **MINOR** (3.1.0) — Backwards-compatible new features
- **PATCH** (3.0.1) — Backwards-compatible bug fixes

---

## 📞 Contact

**HMG Concepts** — Questions or collaboration?

| Channel | Contact |
|---------|---------|
| **WhatsApp** | [+234 810 086 6322](https://wa.me/2348100866322) |
| **Phone** | +234 907 790 7677 |
| **Email** | hismarvellousgrace@gmail.com |
| **Partnerships** | buildingmyictcareer@gmail.com |
| **HMG Academy** | [hmgacademy.pages.dev](https://hmgacademy.pages.dev/) |
| **HMG Concepts** | [hmgconcepts.pages.dev](https://hmgconcepts.pages.dev/) |
| **Founder Portfolio** | [cssadewale.pages.dev](https://cssadewale.pages.dev/) |

---

> **HMG Academy CBT Pro v3.0** — *Learning Deliberately. Teaching Authentically.*  
> © 2026 HMG Concepts. All features free — no paid APIs required.
