/* ====================================================================
   app.js — HMG CBT Pro Core Application Layer & Global Helpers
   ==================================================================== */
const App = {
  SB_URL: 'https://pstnsaqjshmtintjrnas.supabase.co',
  SB_KEY: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzdG5zYXFqc2htdGludGpybmFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU3MDEzODUsImV4cCI6MjA5MTI3NzM4NX0.KNVgpVN0xp1njin1HL3udntc7psfzjnz7mqzpEN_Z6w',
  user: null,
  profile: null,
  institution: null,

  init() {
    this.initTheme();
    this.restoreSession();
    this.bindHeader();
    if (window.FreeTierKeeper) {
      FreeTierKeeper.ping();
    }
  },

  /* ── Theme Management ── */
  initTheme() {
    const saved = localStorage.getItem('cbt_theme') || 'dark';
    document.documentElement.setAttribute('data-theme', saved);
  },
  toggleTheme() {
    const cur = document.documentElement.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
    document.documentElement.setAttribute('data-theme', cur);
    localStorage.setItem('cbt_theme', cur);
    this.showToast(`Switched to ${cur} theme`);
  },

  /* ── Session & Auth ── */
  getSession() {
    try {
      const raw = localStorage.getItem('cbt_session') || localStorage.getItem('cbt_teacher_session') || localStorage.getItem('cbt_admin_session');
      return raw ? JSON.parse(raw) : null;
    } catch (_) { return null; }
  },
  setSession(sessionData) {
    if (sessionData) {
      localStorage.setItem('cbt_session', JSON.stringify(sessionData));
      this.user = sessionData.user;
    } else {
      localStorage.removeItem('cbt_session');
      localStorage.removeItem('cbt_teacher_session');
      localStorage.removeItem('cbt_admin_session');
      this.user = null;
      this.profile = null;
    }
  },
  restoreSession() {
    const s = this.getSession();
    if (s && s.user) {
      this.user = s.user;
    }
  },
  async logout() {
    this.setSession(null);
    window.location.href = 'index.html';
  },

  /* ── REST / PostgREST Pure Fetch Client ── */
  async sbFetch(path, method = 'GET', body = null) {
    const session = this.getSession();
    const token = session?.access_token || this.SB_KEY;
    const headers = {
      'apikey': this.SB_KEY,
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json',
      'Prefer': method === 'POST' ? 'return=representation' : undefined
    };
    if (!headers.Prefer) delete headers.Prefer;

    const res = await fetch(`${this.SB_URL}${path}`, {
      method,
      headers,
      body: body ? JSON.stringify(body) : undefined
    });

    const text = await res.text();
    let data = null;
    try { data = text ? JSON.parse(text) : null; } catch (_) { data = text; }

    if (!res.ok) {
      const err = (data && (data.message || data.error || data.hint)) || `HTTP ${res.status}`;
      throw new Error(err);
    }
    return data;
  },

  async sbRpc(name, body = {}) {
    return this.sbFetch(`/rest/v1/rpc/${name}`, 'POST', body);
  },

  /* ── Global UI Notifications ── */
  showToast(msg, type = 'info') {
    let t = document.getElementById('cbt-toast');
    if (!t) {
      t = document.createElement('div');
      t.id = 'cbt-toast';
      document.body.appendChild(t);
    }
    const icons = { info: 'ℹ️', success: '✅', warning: '⚠️', danger: '🚨' };
    t.innerHTML = `${icons[type] || 'ℹ️'} ${msg}`;
    t.className = 'show ' + type;
    setTimeout(() => { t.className = t.className.replace('show', '').trim(); }, 3500);
  },

  /* ── Header Binding ── */
  bindHeader() {
    const nav = document.getElementById('main-nav');
    if (!nav) return;
    const page = window.location.pathname.split('/').pop() || 'index.html';
    const links = [
      { href: 'index.html', label: '🏠 Home' },
      { href: 'student.html', label: '📝 Take Exam' },
      { href: 'teacher.html', label: '👨‍🏫 Teacher Hub' },
      { href: 'cbt-multi.html', label: '🧪 Multi-Subject' },
      { href: 'cbt-prompts.html', label: '🤖 AI Prompts' },
      { href: 'generator.html', label: '⚙️ Generator' },
      { href: 'admin.html', label: '🛡️ Admin' },
      { href: 'admin-data.html', label: '💾 Data & Sync' },
      { href: 'storage.html', label: '📦 Storage' },
      { href: 'platform-health.html', label: '🩺 Health' },
      { href: 'status-manager.html', label: '👥 Roles' },
      { href: 'settings.html', label: '⚙️ Settings' },
      { href: 'license.html', label: '📜 License' },
      { href: 'activity_log.html', label: '📊 Audit' },
      { href: 'certificate.html', label: '🏅 Verify' }
    ];

    nav.innerHTML = links.map(l => `
      <a href="${l.href}" class="nav-btn ${page === l.href ? 'active' : ''}">${l.label}</a>
    `).join('') + `<button class="nav-btn" onclick="App.toggleTheme()" title="Toggle Dark/Light mode">🌓</button>`;
  },

  /* ── Formatting Helpers ── */
  escapeHtml(str) {
    return String(str || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  },

  decodeMeta(str) {
    if (!str || !str.includes('|')) return { subject: str || 'General', cls: '—', term: '—', topic: '—', type: '—', session: '—', passmark: 50 };
    const p = str.split('|');
    return {
      subject: p[0] || '—',
      cls: p[1] || '—',
      term: p[2] || '—',
      topic: p[3] || '—',
      type: p[4] || '—',
      session: p[5] || '—',
      passmark: parseInt(p[6]) || 50
    };
  }
};

window.App = App;
window.showToast = (msg, type) => App.showToast(msg, type);
window.escapeHtml = (s) => App.escapeHtml(s);
window.decodeMeta = (s) => App.decodeMeta(s);

document.addEventListener('DOMContentLoaded', () => App.init());
