/* ====================================================================
   chatbot.js — HMG CBT Pro Rule-Based Interactive Assistant Bot
   ====================================================================
   100% Offline, Zero AI API, Free-Tier Rule-Based Knowledge Assistant.
   Answers questions about building exams, taking tests, Google Drive sync,
   free-tier protection, 37+ question types, and whitelabeling.
   ==================================================================== */
const CBTChatbot = {
  isOpen: false,
  messages: [
    { sender: 'bot', text: 'Hello! 👋 I am your **HMG CBT Pro Assistant**. How can I help you today? Ask about creating exams, multi-subject UTME, Google Drive sync, 37+ question types, or free-tier protection.' }
  ],

  kb: [
    {
      keywords: ['create exam', 'make exam', 'upload question', 'csv format', 'csv'],
      reply: 'To create an assessment:\n1. Go to **Teacher Hub (teacher.html)**\n2. Choose **CSV Upload**, **Type Questions**, **XLSX**, or **Reuse Previous Exam**\n3. The standard CSV format uses 14 columns: Question, A, B, C, D, CorrectAnswer, Explanation, Type, Tolerance, Unit, Accept, MRQ_AON, Pairs, Items.'
    },
    {
      keywords: ['multi subject', 'utme', 'jamb', 'waec', '4 subjects'],
      reply: 'The **Multi-Subject CBT Builder (cbt-multi.html)** lets you bundle 4+ subjects (e.g. English, Maths, Physics, Chemistry) under ONE 6-character access code. Students switch subject tabs anytime during the test without losing answers.'
    },
    {
      keywords: ['google drive', 'drive sync', 'cloud backup', 'backup', 'restore'],
      reply: 'Google Drive Sync backs up all exam packages, candidate results, and rosters directly into your school Google Drive (under `drive.file` scope). Setup takes 2 minutes in **Settings ➔ Google Drive Sync** using a free OAuth2 Client ID.'
    },
    {
      keywords: ['free tier', 'supabase pause', 'inactivity', 'keepalive', 'pause'],
      reply: 'The system includes a **10-Layer Supabase Protection Matrix** to prevent 7-day inactivity pauses. This includes browser heartbeats, GitHub Actions cron (`.github/workflows/supabase-heartbeat.yml`), Vercel serverless keepalive (`/api/keepalive.js`), and internal PostgreSQL keepalive pings.'
    },
    {
      keywords: ['question types', '37', '17', 'cloze', 'matching', 'code', 'essay'],
      reply: 'HMG CBT Pro supports **37+ Question Types** including MCQ, Multiple Response, True/False, Short Answer, Numeric, Matching, Ordering, Cloze, Assertion-Reason, Case Study, Matrix, Hot Text, Code/SQL, and Essay. Open-ended questions support Tutor Score Auditing.'
    },
    {
      keywords: ['ai prompt', 'chatgpt', 'claude', 'deepseek', 'prompt studio'],
      reply: 'Use the **AI Question Prompts Studio (cbt-prompts.html)** to generate tailored prompts for ChatGPT, Claude, or DeepSeek. Copy the prompt, paste into the AI chat, and paste the output back into the validator to load directly into the question bank!'
    },
    {
      keywords: ['generator', 'whitelabel', 'custom zip', 'theme', 'font', 'branding'],
      reply: 'The **Whitelabel System Generator (generator.html)** allows you to choose from **50+ Themes**, **50+ Typography Fonts**, and **20+ Layouts** and download a complete customized CBT system ZIP package with one click.'
    },
    {
      keywords: ['disaster recovery', 'new supabase', 'inactive project', 'migrate'],
      reply: 'If a school Supabase project becomes inactive, you can connect a brand-new Supabase project in **Admin Data (admin-data.html)**, authenticate with Google Drive, and restore all previous exams, results, and rosters in under 30 seconds!'
    },
    {
      keywords: ['tutor audit', 'manual grading', 'essay score', 'override'],
      reply: 'For subjective questions (Essay, Code, Comprehension, Oral Prompt), teachers can open the student submission in the Teacher Hub and click **Audit Score / Tutor Override** to enter customized scores and feedback comments.'
    }
  ],

  init() {
    this.injectWidget();
  },

  injectWidget() {
    if (document.getElementById('cbt-chatbot-widget')) return;

    const widget = document.createElement('div');
    widget.id = 'cbt-chatbot-widget';
    widget.innerHTML = `
      <div id="cbt-chatbot-toggle" onclick="CBTChatbot.toggle()" style="position:fixed;bottom:24px;left:24px;z-index:99990;background:linear-gradient(135deg,var(--primary),var(--accent));color:#000;width:52px;height:52px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:24px;cursor:pointer;box-shadow:0 8px 24px rgba(0,0,0,0.4);transition:transform 0.2s;">
        🤖
      </div>
      <div id="cbt-chatbot-window" style="position:fixed;bottom:86px;left:24px;z-index:99990;width:360px;max-width:calc(100vw - 48px);height:480px;background:var(--surface);border:1px solid var(--border);border-radius:var(--radius);box-shadow:0 16px 48px rgba(0,0,0,0.5);display:none;flex-direction:column;overflow:hidden;backdrop-filter:blur(12px);">
        <div style="background:var(--surface-2);padding:14px 16px;border-bottom:1px solid var(--border);display:flex;justify-content:space-between;align-items:center;">
          <div style="display:flex;align-items:center;gap:8px;">
            <span style="font-size:20px;">🤖</span>
            <div>
              <strong style="font-size:13px;display:block;">CBT System Assistant</strong>
              <small style="font-size:11px;color:var(--primary);">Offline Knowledge Bot (Free)</small>
            </div>
          </div>
          <button class="btn btn-sm btn-outline" onclick="CBTChatbot.toggle(false)" style="padding:4px 8px;">✕</button>
        </div>
        <div id="cbt-chatbot-messages" style="flex:1;padding:14px;overflow-y:auto;display:flex;flex-direction:column;gap:10px;font-size:13px;"></div>
        <div style="padding:10px;background:var(--surface-2);border-top:1px solid var(--border);display:flex;gap:6px;">
          <input type="text" id="cbt-chatbot-input" placeholder="Ask a question…" style="margin-bottom:0;padding:8px 12px;font-size:13px;" onkeydown="if(event.key==='Enter') CBTChatbot.send()">
          <button class="btn btn-sm btn-primary" onclick="CBTChatbot.send()">Send</button>
        </div>
      </div>
    `;
    document.body.appendChild(widget);
    this.render();
  },

  toggle(force) {
    this.isOpen = force !== undefined ? force : !this.isOpen;
    const win = document.getElementById('cbt-chatbot-window');
    if (win) win.style.display = this.isOpen ? 'flex' : 'none';
    if (this.isOpen) {
      setTimeout(() => document.getElementById('cbt-chatbot-input')?.focus(), 100);
    }
  },

  send() {
    const inp = document.getElementById('cbt-chatbot-input');
    const text = inp?.value.trim();
    if (!text) return;

    this.messages.push({ sender: 'user', text });
    inp.value = '';
    this.render();

    // Find response
    setTimeout(() => {
      const lower = text.toLowerCase();
      let reply = 'I am not quite sure about that. Try asking about: **create exam**, **multi subject UTME**, **Google Drive sync**, **free tier protection**, **37 question types**, or **whitelabel generator**.';

      for (const item of this.kb) {
        if (item.keywords.some(k => lower.includes(k))) {
          reply = item.reply;
          break;
        }
      }

      if (lower.includes('hello') || lower.includes('hi') || lower.includes('hey')) {
        reply = 'Hello! 👋 How can I assist you with your CBT assessment platform today?';
      } else if (lower.includes('thank')) {
        reply = 'You are very welcome! 🎉 Let me know if you need any other help.';
      }

      this.messages.push({ sender: 'bot', text: reply });
      this.render();
    }, 250);
  },

  render() {
    const container = document.getElementById('cbt-chatbot-messages');
    if (!container) return;
    container.innerHTML = this.messages.map(m => `
      <div style="align-self:${m.sender === 'user' ? 'flex-end' : 'flex-start'};max-width:85%;background:${m.sender === 'user' ? 'var(--primary)' : 'var(--surface-2)'};color:${m.sender === 'user' ? '#000' : 'var(--text)'};padding:10px 14px;border-radius:12px;border:1px solid ${m.sender === 'user' ? 'transparent' : 'var(--border)'};line-height:1.5;">
        ${m.text.replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>').replace(/\n/g, '<br>')}
      </div>
    `).join('');
    container.scrollTop = container.scrollHeight;
  }
};

window.CBTChatbot = CBTChatbot;

document.addEventListener('DOMContentLoaded', () => {
  if (window.SiteHelp) SiteHelp.renderPageGuideBanner();
  CBTChatbot.init();
});
