/* ====================================================================
   site-help.js — HMG CBT Pro Comprehensive Interactive Page Guides
   ====================================================================
   Provides elaborate, detailed explanations for first-time users, teachers,
   and administrators for every page, section, and workflow on the platform.
   ==================================================================== */
const SiteHelp = {
  pages: {
    'index.html': {
      title: '🏠 Public Portal & Welcome Hub',
      summary: 'The main landing page for candidates, educators, and administrators.',
      sections: [
        { name: 'Portal Launcher', desc: 'Direct access buttons to Candidate Exam Portal, Teacher Hub, Multi-Subject Builder, AI Prompts, and Admin Super Panel.' },
        { name: 'PWA Install Helper', desc: 'Prompts mobile and desktop users to install the web app for offline testing resilience and fullscreen lockdown.' },
        { name: 'Feature Showcase', desc: 'Interactive feature catalog highlighting 37+ question types, anti-cheating tools, and Google Drive sync.' }
      ]
    },
    'student.html': {
      title: '📝 Candidate Exam Taking Portal',
      summary: 'Distraction-free, proctored assessment runner for single-subject and multi-subject exams.',
      sections: [
        { name: 'Identity Verification', desc: 'Open mode (Candidate Name & Class) or Registered mode (Student ID verified against teacher roster).' },
        { name: 'Proctoring Gate', desc: 'Webcam Face Gate captures 3 baseline photos; Web Audio detects voice activity; Fullscreen lockdown blocks cheating.' },
        { name: 'Exam Navigation', desc: 'Subject switcher tabs (for UTME/JAMB exams), question navigator grid, flag button, and STEM math keyboard.' },
        { name: 'Submissions & Results', desc: 'Automatic 10-second draft saves, offline backup downloads, instant Grade Ring score, and printable PDF certificates.' }
      ]
    },
    'teacher.html': {
      title: '👨‍🏫 Teacher Assessment Hub & Question Builder',
      summary: 'Comprehensive examination creator, question bank editor, live invigilation monitor, and broadsheet generator.',
      sections: [
        { name: 'Creation Methods', desc: 'Upload 14-column CSV spreadsheets, extract from Excel XLSX/PDF, or build visually with all 37+ question types.' },
        { name: 'Batch Actions', desc: 'Select multiple assessments to Open, Lock, Archive, or Delete in one click.' },
        { name: 'Assessment Controls', desc: 'Generate unique 6-character access codes, duplicate exams, schedule auto-close timers, and print invigilation sheets.' },
        { name: 'Tutor Score Audit', desc: 'Review and manually override scores for subjective open-ended and essay questions with tutor feedback.' }
      ]
    },
    'cbt-multi.html': {
      title: '🧪 Multi-Subject UTME / JAMB Builder',
      summary: 'Build combined multi-subject examination packages with separate question pools under one unified candidate code.',
      sections: [
        { name: 'Subject Manager', desc: 'Add 4+ subjects (e.g. English, Maths, Physics, Chemistry) and upload individual CSV question banks.' },
        { name: 'Combined Timer', desc: 'Set a total combined exam duration (e.g. 120 minutes) and questions-per-subject counts.' },
        { name: 'Unified Access Code', desc: 'Candidates receive one code and can switch subject tabs during the exam without losing progress.' }
      ]
    },
    'cbt-prompts.html': {
      title: '🤖 AI Question Prompts Studio',
      summary: 'Build structured, copy-paste prompts for ChatGPT, Claude, Gemini, and DeepSeek without paid AI APIs.',
      sections: [
        { name: 'Prompt Configurator', desc: 'Select Subject, Topic, Grade level, Question Count, Target Exam Style (UTME, WAEC, SAT), and Question Type.' },
        { name: '1-Click Copy', desc: 'Copy formatted prompt to clipboard to get guaranteed 14-column CSV output.' },
        { name: 'AI Output Validator', desc: 'Paste the AI response to validate syntax, preview questions, and load directly into the Teacher Hub.' }
      ]
    },
    'generator.html': {
      title: '⚙️ Whitelabel CBT System Generator',
      summary: 'Customize, brand, and package standalone CBT Pro platforms with 50+ themes, 50+ fonts, and 20+ layouts.',
      sections: [
        { name: 'Branding & Theme Engine', desc: 'Pick from 50+ curated color palettes, 50+ typography font stacks, and 20+ interface layout styles.' },
        { name: 'Supabase & Cloud Injection', desc: 'Embed your Supabase database keys and Google Drive Client ID directly into the generated codebase.' },
        { name: 'In-Browser ZIP Generator', desc: 'Generates a ready-to-deploy customized system package in seconds via JSZip.' }
      ]
    },
    'admin-data.html': {
      title: '💾 Data Portability, Google Drive Sync & Envelopes',
      summary: 'Manage portable JSON backup archives, automated Google Drive cloud sync, and disaster recovery.',
      sections: [
        { name: 'Google Drive Sync', desc: 'Background automatic backup sync directly to your institution Google Drive storage.' },
        { name: 'Full Envelope Export', desc: 'Download complete platform snapshot (exams, questions, candidates, results, audit logs) as a single JSON file.' },
        { name: 'Disaster Recovery Migration', desc: 'Restore all Google Drive backups into a brand-new blank Supabase project in under 30 seconds.' }
      ]
    },
    'platform-health.html': {
      title: '🩺 Platform Health & Diagnostics',
      summary: 'Real-time database latency tracker, 19+ RPC smoke tests, and 10-layer free-tier protection matrix.',
      sections: [
        { name: 'Latency Monitor', desc: 'Tests connection speed to Supabase PostgreSQL in milliseconds.' },
        { name: 'RPC Smoke Tester', desc: 'Automated runner verifying all 19+ security functions and policies.' },
        { name: '10-Layer Protection Matrix', desc: 'Verifies active keepalive mechanisms preventing Supabase 7-day inactivity pause.' }
      ]
    },
    'status-manager.html': {
      title: '👥 Roles & User Status Manager',
      summary: 'Manage user permissions, roles (Super Admin, Admin, Teacher, Student), and teacher account approvals.',
      sections: [
        { name: 'Approval Queue', desc: 'Approve or reject newly registered teacher accounts.' },
        { name: 'Role Assignment', desc: 'Promote teachers to administrative supervisors or deactivate accounts.' }
      ]
    },
    'settings.html': {
      title: '⚙️ Platform & Institution Settings',
      summary: 'Global configuration for institution branding, exam defaults, Supabase credentials, and Google Drive sync.',
      sections: [
        { name: 'Institution Branding', desc: 'Configure school name, logo, primary/accent theme colors, and support contacts.' },
        { name: 'Assessment Defaults', desc: 'Set default passmark, durations, attempt limits, and STEM virtual keyboard availability.' },
        { name: 'Supabase Credentials', desc: 'Update Project URL and public anon key with live connectivity verification.' }
      ]
    },
    'storage.html': {
      title: '📦 Storage Manager & Quota Monitor',
      summary: 'Track database row counts against the Supabase 500MB free-tier quota, monitor browser localStorage, and optimize media assets.',
      sections: [
        { name: 'Database Quota Gauge', desc: 'Estimated storage footprint across all tables against the 500MB free limit.' },
        { name: 'Browser LocalStorage', desc: 'Inspects cached offline drafts and calculation histories.' },
        { name: 'Asset Optimizer', desc: 'Purges historical webcam photos and stale offline drafts.' }
      ]
    },
    'license.html': {
      title: '📜 Site License & Perpetual Certificate',
      summary: 'Offline cryptographic HMAC-SHA256 perpetual license certificate verifying institution ownership.',
      sections: [
        { name: 'Perpetual Certificate', desc: 'Printable authorization certificate granting non-expiring deployment rights.' },
        { name: 'Cryptographic Hash', desc: 'Offline HMAC-SHA256 token verification without phone-home servers.' }
      ]
    },
    'activity_log.html': {
      title: '📊 System Audit & Activity Trail',
      summary: 'Immutable chronological event trail tracking all assessment creations, score revisions, user approvals, and syncs.',
      sections: [
        { name: 'Event Timeline', desc: 'Filter by Actor email, Action type, Target entity, and Date range.' },
        { name: 'Export Utilities', desc: 'Download audit logs as CSV, JSON, or print-ready invigilation audit sheets.' }
      ]
    },
    'certificate.html': {
      title: '🏅 Certificate Verification Portal',
      summary: 'Public-facing verification tool to authenticate student result certificates via unique 8-character codes.',
      sections: [
        { name: 'Code Verification', desc: 'Validates certificate code directly against Supabase result records.' },
        { name: 'Printable Certificate', desc: 'Renders verified certificate with dynamic QR code for third-party confirmation.' }
      ]
    }
  },

  getCurrentPageHelp() {
    const page = window.location.pathname.split('/').pop() || 'index.html';
    return this.pages[page] || this.pages['index.html'];
  },

  renderPageGuideBanner() {
    const guide = this.getCurrentPageHelp();
    const existing = document.getElementById('cbt-page-guide-banner');
    if (existing) existing.remove();

    const banner = document.createElement('div');
    banner.id = 'cbt-page-guide-banner';
    banner.style.cssText = 'background:var(--surface);border:1px solid var(--border);border-radius:var(--radius);padding:18px 22px;margin-bottom:20px;box-shadow:var(--shadow);';
    banner.innerHTML = `
      <div style="display:flex;justify-content:space-between;align-items:flex-start;gap:12px;flex-wrap:wrap;">
        <div style="flex:1;min-width:280px;">
          <div style="font-size:16px;font-weight:800;color:var(--text);margin-bottom:4px;">${guide.title}</div>
          <p style="margin:0 0 10px;font-size:13px;color:var(--text-muted);">${guide.summary}</p>
          <div style="display:flex;gap:16px;flex-wrap:wrap;font-size:12px;">
            ${guide.sections.map(s => `<div><strong style="color:var(--primary);">${s.name}:</strong> <span style="color:var(--text-muted);">${s.desc}</span></div>`).join('')}
          </div>
        </div>
        <button class="btn btn-sm btn-outline" onclick="this.parentElement.parentElement.remove()" style="align-self:flex-start;">✕ Dismiss</button>
      </div>
    `;

    const mainWrap = document.querySelector('.main-wrap');
    if (mainWrap) mainWrap.insertBefore(banner, mainWrap.firstChild);
  }
};

window.SiteHelp = SiteHelp;
