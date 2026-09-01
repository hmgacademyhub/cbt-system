/* ====================================================================
   generator.js — HMG CBT Pro Whitelabel System Generator Engine
   ====================================================================
   Includes:
     • 50+ Professional & Sophisticated Themes
     • 50+ Modern Typography Font Stacks (Google Fonts + System Stacks)
     • 20+ Responsive Layout Styles
     • In-Browser ZIP Packaging Engine via JSZip
   ==================================================================== */
const CBTGenerator = {
  // 50+ Professional Themes
  THEMES: [
    { id: 'emerald-elegance', name: 'Emerald Elegance (Default)', primary: '#10b981', accent: '#8b5cf6', bg: '#09090b', surface: '#18181b' },
    { id: 'indigo-prestige', name: 'Indigo Prestige (Oxford)', primary: '#4f46e5', accent: '#ec4899', bg: '#0b0f19', surface: '#111827' },
    { id: 'sapphire-slate', name: 'Sapphire Slate (Cambridge)', primary: '#0ea5e9', accent: '#f59e0b', bg: '#0c1222', surface: '#1e293b' },
    { id: 'crimson-executive', name: 'Crimson Executive (Harvard)', primary: '#dc2626', accent: '#fbbf24', bg: '#180808', surface: '#261010' },
    { id: 'cyberpunk-neon', name: 'Cyberpunk Neon', primary: '#06b6d4', accent: '#f43f5e', bg: '#050508', surface: '#0f0f18' },
    { id: 'nordic-frost', name: 'Nordic Frost (Light Mode)', primary: '#0284c7', accent: '#6366f1', bg: '#f8fafc', surface: '#ffffff' },
    { id: 'obsidian-gold', name: 'Obsidian & Royal Gold', primary: '#eab308', accent: '#a855f7', bg: '#0a0a0a', surface: '#171717' },
    { id: 'deep-forest', name: 'Deep Forest Pine', primary: '#059669', accent: '#d97706', bg: '#06130d', surface: '#0e241b' },
    { id: 'lavender-dream', name: 'Lavender Amethyst', primary: '#a855f7', accent: '#3b82f6', bg: '#10091d', surface: '#1b122c' },
    { id: 'sunset-amber', name: 'Sunset Amber & Coral', primary: '#f97316', accent: '#e11d48', bg: '#140c06', surface: '#24170d' },
    { id: 'tokyo-night', name: 'Tokyo Night Cyber', primary: '#7aa2f7', accent: '#bb9af7', bg: '#1a1b26', surface: '#24283b' },
    { id: 'matrix-terminal', name: 'Matrix Hacker Green', primary: '#22c55e', accent: '#16a34a', bg: '#000000', surface: '#0d160e' },
    { id: 'dracula-pro', name: 'Dracula Pro Vamp', primary: '#bd93f9', accent: '#ff79c6', bg: '#282a36', surface: '#44475a' },
    { id: 'rose-gold', name: 'Rose Gold Luxury', primary: '#fb7185', accent: '#fbbf24', bg: '#150a0d', surface: '#26141a' },
    { id: 'ocean-abyss', name: 'Ocean Abyss Blue', primary: '#38bdf8', accent: '#818cf8', bg: '#030712', surface: '#0f172a' },
    { id: 'titanium-mono', name: 'Titanium Monochrome', primary: '#f4f4f5', accent: '#71717a', bg: '#09090b', surface: '#18181b' },
    { id: 'academic-maroon', name: 'Academic Maroon & Ivory', primary: '#991b1b', accent: '#d97706', bg: '#1c0a0a', surface: '#2e1212' },
    { id: 'electric-violet', name: 'Electric Violet Spark', primary: '#8b5cf6', accent: '#06b6d4', bg: '#0d061a', surface: '#1b0e33' },
    { id: 'teal-oasis', name: 'Teal Oasis Mint', primary: '#14b8a6', accent: '#f59e0b', bg: '#041312', surface: '#0a2322' },
    { id: 'midnight-navy', name: 'Midnight Navy Elite', primary: '#3b82f6', accent: '#60a5fa', bg: '#020617', surface: '#0f172a' },
    { id: 'solar-flare', name: 'Solar Flare Orange', primary: '#ea580c', accent: '#facc15', bg: '#140904', surface: '#26140b' },
    { id: 'coffee-mocha', name: 'Espresso Mocha Warm', primary: '#b45309', accent: '#d97706', bg: '#150d06', surface: '#26190f' },
    { id: 'alpine-snow', name: 'Alpine Snow Minimal (Light)', primary: '#2563eb', accent: '#475569', bg: '#f1f5f9', surface: '#ffffff' },
    { id: 'regal-purple', name: 'Regal Sovereign Purple', primary: '#9333ea', accent: '#f59e0b', bg: '#130421', surface: '#230a3b' },
    { id: 'emerald-mint-light', name: 'Mint Leaf Crisp (Light)', primary: '#059669', accent: '#2563eb', bg: '#f0fdf4', surface: '#ffffff' },
    { id: 'graphite-dark', name: 'Graphite Industrial', primary: '#a1a1aa', accent: '#10b981', bg: '#121214', surface: '#202024' },
    { id: 'neon-synthwave', name: '80s Synthwave Sunset', primary: '#f43f5e', accent: '#8b5cf6', bg: '#11051b', surface: '#220d35' },
    { id: 'coastal-breeze', name: 'Coastal Breeze Turquoise', primary: '#06b6d4', accent: '#10b981', bg: '#051419', surface: '#0d2830' },
    { id: 'vintage-paper', name: 'Vintage Archival (Sepia)', primary: '#854d0e', accent: '#a16207', bg: '#fefce8', surface: '#fef9c3' },
    { id: 'blood-orange', name: 'Blood Orange Zing', primary: '#f97316', accent: '#dc2626', bg: '#180703', surface: '#2b0f07' },
    { id: 'hacker-amber', name: 'Amber CRT Retro', primary: '#fbbf24', accent: '#f59e0b', bg: '#080501', surface: '#170f03' },
    { id: 'steel-blue', name: 'Steel Blue Aerospace', primary: '#64748b', accent: '#38bdf8', bg: '#0b0f19', surface: '#1e293b' },
    { id: 'tropical-flora', name: 'Tropical Flora Coral', primary: '#fb7185', accent: '#2dd4bf', bg: '#14060b', surface: '#290f18' },
    { id: 'glacier-cyan', name: 'Glacier Cyan Crystal', primary: '#22d3ee', accent: '#a855f7', bg: '#041018', surface: '#092130' },
    { id: 'onyx-carbon', name: 'Onyx Carbon Fiber', primary: '#e4e4e7', accent: '#3f3f46', bg: '#050505', surface: '#121212' },
    { id: 'autumn-maple', name: 'Autumn Maple Rust', primary: '#c2410c', accent: '#b45309', bg: '#180904', surface: '#2c1309' },
    { id: 'space-cadet', name: 'Space Cadet Twilight', primary: '#6366f1', accent: '#ec4899', bg: '#0a0a1f', surface: '#16163b' },
    { id: 'sage-herbal', name: 'Sage Herbal Green', primary: '#4ade80', accent: '#06b6d4', bg: '#061309', surface: '#0e2615' },
    { id: 'aurora-borealis', name: 'Aurora Borealis Glow', primary: '#34d399', accent: '#818cf8', bg: '#021516', surface: '#072729' },
    { id: 'champagne-silk', name: 'Champagne Silk (Light)', primary: '#d97706', accent: '#4f46e5', bg: '#fafaf9', surface: '#ffffff' },
    { id: 'cosmic-purple', name: 'Cosmic Nebula Dark', primary: '#c084fc', accent: '#38bdf8', bg: '#10041f', surface: '#220a40' },
    { id: 'cherry-blossom', name: 'Cherry Blossom Pastel', primary: '#f472b6', accent: '#fb7185', bg: '#190610', surface: '#2d0f1f' },
    { id: 'desert-sand', name: 'Desert Sand Dune', primary: '#ca8a04', accent: '#ea580c', bg: '#181203', surface: '#2b2108' },
    { id: 'deep-marina', name: 'Deep Marina Wave', primary: '#0284c7', accent: '#14b8a6', bg: '#040e1a', surface: '#0a1d33' },
    { id: 'platinum-clean', name: 'Platinum Clean SaaS (Light)', primary: '#0f172a', accent: '#2563eb', bg: '#f8fafc', surface: '#ffffff' },
    { id: 'ruby-gem', name: 'Ruby Gem Radiant', primary: '#e11d48', accent: '#f59e0b', bg: '#18040b', surface: '#2c0b17' },
    { id: 'monokai-dev', name: 'Monokai Developer Dark', primary: '#a6e22e', accent: '#fd971f', bg: '#272822', surface: '#3e3d32' },
    { id: 'nord-arctic', name: 'Nord Arctic Frost', primary: '#88c0d0', accent: '#81a1c1', bg: '#2e3440', surface: '#3b4252' },
    { id: 'palenight-modern', name: 'Material Palenight', primary: '#82aaff', accent: '#c792ea', bg: '#292d3e', surface: '#32374d' },
    { id: 'gruvbox-retro', name: 'Gruvbox Retro Warm', primary: '#fabd2f', accent: '#fb4934', bg: '#282828', surface: '#3c3836' }
  ],

  // 50+ Typography Font Stacks
  FONTS: [
    { id: 'plus-jakarta', name: 'Plus Jakarta Sans (Default Modern)', family: "'Plus Jakarta Sans', sans-serif" },
    { id: 'inter', name: 'Inter (Clean Standard UI)', family: "'Inter', sans-serif" },
    { id: 'outfit', name: 'Outfit (Geometric High-Tech)', family: "'Outfit', sans-serif" },
    { id: 'space-grotesk', name: 'Space Grotesk (Neo-Brutalist)', family: "'Space Grotesk', sans-serif" },
    { id: 'syne', name: 'Syne (Bold Expressive)', family: "'Syne', sans-serif" },
    { id: 'lexend', name: 'Lexend (Maximum Reading Fluency)', family: "'Lexend', sans-serif" },
    { id: 'manrope', name: 'Manrope (Modern Precision)', family: "'Manrope', sans-serif" },
    { id: 'dm-sans', name: 'DM Sans (Subtle Low-Contrast)', family: "'DM Sans', sans-serif" },
    { id: 'sora', name: 'Sora (Futuristic UI)', family: "'Sora', sans-serif" },
    { id: 'epilogue', name: 'Epilogue (Contemporary Editorial)', family: "'Epilogue', sans-serif" },
    { id: 'fira-code', name: 'Fira Code (Developer Monospace)', family: "'Fira Code', monospace" },
    { id: 'jetbrains-mono', name: 'JetBrains Mono (STEM Precise)', family: "'JetBrains Mono', monospace" },
    { id: 'roboto', name: 'Roboto (Google Standard)', family: "'Roboto', sans-serif" },
    { id: 'montserrat', name: 'Montserrat (Classic Architectural)', family: "'Montserrat', sans-serif" },
    { id: 'poppins', name: 'Poppins (Geometric Friendly)', family: "'Poppins', sans-serif" },
    { id: 'raleway', name: 'Raleway (Elegant Thin)', family: "'Raleway', sans-serif" },
    { id: 'nunito', name: 'Nunito (Soft Rounded)', family: "'Nunito', sans-serif" },
    { id: 'playfair-display', name: 'Playfair Display (Academic Serif)', family: "'Playfair Display', serif" },
    { id: 'merriweather', name: 'Merriweather (Classic Reading Serif)', family: "'Merriweather', serif" },
    { id: 'lora', name: 'Lora (Contemporary Book Serif)', family: "'Lora', serif" },
    { id: 'cinzel', name: 'Cinzel (Classical Inscriptional)', family: "'Cinzel', serif" },
    { id: 'cormorant-garamond', name: 'Cormorant Garamond (Oxford Serif)', family: "'Cormorant Garamond', serif" },
    { id: 'chivo', name: 'Chivo (High-Impact Grotesque)', family: "'Chivo', sans-serif" },
    { id: 'urbanist', name: 'Urbanist (Digital Minimalist)', family: "'Urbanist', sans-serif" },
    { id: 'work-sans', name: 'Work Sans (Optimized Screen UI)', family: "'Work Sans', sans-serif" },
    { id: 'karla', name: 'Karla (Quirky Grotesque)', family: "'Karla', sans-serif" },
    { id: 'archivo', name: 'Archivo (Technical Headline)', family: "'Archivo', sans-serif" },
    { id: 'red-hat-display', name: 'Red Hat Display (Enterprise Cloud)', family: "'Red Hat Display', sans-serif" },
    { id: 'be-vietnam-pro', name: 'Be Vietnam Pro (International Standard)', family: "'Be Vietnam Pro', sans-serif" },
    { id: 'cabin', name: 'Cabin (Humanist Sans)', family: "'Cabin', sans-serif" },
    { id: 'inconsolata', name: 'Inconsolata (Clean Terminal)', family: "'Inconsolata', monospace" },
    { id: 'albert-sans', name: 'Albert Sans (Modern Nordic)', family: "'Albert Sans', sans-serif" },
    { id: 'source-sans-3', name: 'Source Sans 3 (Adobe Standard)', family: "'Source Sans 3', sans-serif" },
    { id: 'libre-baskerville', name: 'Libre Baskerville (Traditional Exam)', family: "'Libre Baskerville', serif" },
    { id: 'instrument-sans', name: 'Instrument Sans (Contemporary Design)', family: "'Instrument Sans', sans-serif" },
    { id: 'figtree', name: 'Figtree (Fresh Contemporary)', family: "'Figtree', sans-serif" },
    { id: 'overpass', name: 'Overpass (Highway Signage Standard)', family: "'Overpass', sans-serif" },
    { id: 'pt-sans', name: 'PT Sans (Universal Pan-European)', family: "'PT Sans', sans-serif" },
    { id: 'quicksand', name: 'Quicksand (Friendly Display)', family: "'Quicksand', sans-serif" },
    { id: 'exo-2', name: 'Exo 2 (Geometric Sci-Fi)', family: "'Exo 2', sans-serif" },
    { id: 'ibm-plex-sans', name: 'IBM Plex Sans (Corporate Industrial)', family: "'IBM Plex Sans', sans-serif" },
    { id: 'ibm-plex-mono', name: 'IBM Plex Mono (Engineering Code)', family: "'IBM Plex Mono', monospace" },
    { id: 'crimson-pro', name: 'Crimson Pro (Bookish Examination)', family: "'Crimson Pro', serif" },
    { id: 'frank-ruhl-libre', name: 'Frank Ruhl Libre (Literary Editorial)', family: "'Frank Ruhl Libre', serif" },
    { id: 'space-mono', name: 'Space Mono (Fixed Width Retro)', family: "'Space Mono', monospace" },
    { id: 'spectral', name: 'Spectral (Screen Reading Serif)', family: "'Spectral', serif" },
    { id: 'barlow', name: 'Barlow (Low-Contrast Signage)', family: "'Barlow', sans-serif" },
    { id: 'public-sans', name: 'Public Sans (US Web Standards)', family: "'Public Sans', sans-serif" },
    { id: 'fraunces', name: 'Fraunces (Expressive Old Style)', family: "'Fraunces', serif" },
    { id: 'system-ui', name: 'Native System Stack (San Francisco/Segoe)', family: "system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" }
  ],

  // 20+ Layout Styles
  LAYOUTS: [
    { id: 'classic-sidebar', name: 'Classic Sidebar Left (Standard)' },
    { id: 'top-navbar', name: 'Top Navbar Floating' },
    { id: 'glassmorphism-glow', name: 'Glassmorphism Backdrop Glow' },
    { id: 'brutalist-minimal', name: 'Brutalist High-Contrast' },
    { id: 'floating-island', name: 'Floating Island Cards' },
    { id: 'split-executive', name: 'Split Screen Executive' },
    { id: 'terminal-developer', name: 'Compact Developer Terminal' },
    { id: 'tabbed-focus', name: 'Tabbed Focus & Single-Page' },
    { id: 'academic-broadsheet', name: 'Academic Broadsheet Portal' },
    { id: 'mobile-drawer-app', name: 'Mobile App Bottom-Nav Shell' },
    { id: 'dashboard-grid', name: 'Dashboard Modular Grid' },
    { id: 'cinema-wide', name: 'Cinema Ultra-Wide Canvas' },
    { id: 'stacked-feed', name: 'Vertical Stacked Feed' },
    { id: 'zen-distraction-free', name: 'Zen Distraction-Free Center' },
    { id: 'sidebar-right', name: 'Sidebar Right Invigilation' },
    { id: 'compact-kiosk', name: 'Compact Kiosk Lockdown' },
    { id: 'stepper-wizard', name: 'Multi-Step Guided Wizard' },
    { id: 'cards-masonry', name: 'Masonry Assessment Cards' },
    { id: 'dock-bottom', name: 'Mac-Style Floating Bottom Dock' },
    { id: 'dual-pane-review', name: 'Dual-Pane Side-by-Side Review' }
  ],

  defaultConfig: {
    institutionName: 'HMG Academy CBT Pro',
    tagline: 'Computer-Based Testing & Exam Practice Platform',
    themeId: 'emerald-elegance',
    fontId: 'plus-jakarta',
    layoutId: 'classic-sidebar',
    primaryColor: '#10b981',
    accentColor: '#8b5cf6',
    supabaseUrl: 'https://pstnsaqjshmtintjrnas.supabase.co',
    supabaseAnonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzdG5zYXFqc2htdGludGpybmFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU3MDEzODUsImV4cCI6MjA5MTI3NzM4NX0.KNVgpVN0xp1njin1HL3udntc7psfzjnz7mqzpEN_Z6w',
    driveClientId: '',
    supportEmail: 'hismarvellousgrace@gmail.com',
    supportPhone: '+234 810 086 6322',
    defaultPassmark: 50
  },

  async generatePackage(customConfig) {
    const cfg = Object.assign({}, this.defaultConfig, customConfig || {});
    if (typeof JSZip === 'undefined') {
      throw new Error('JSZip library is required for in-browser packaging.');
    }

    const zip = new JSZip();

    // 1. Injected COMPLETE_SCHEMA_SQL.sql
    try {
      const sqlRes = await fetch('COMPLETE_SCHEMA_SQL.sql');
      if (sqlRes.ok) {
        let sqlText = await sqlRes.text();
        sqlText = sqlText.replace(/'HMG Academy CBT Pro'/g, `'${cfg.institutionName.replace(/'/g, "''")}'`)
                         .replace(/'#10b981'/g, `'${cfg.primaryColor}'`)
                         .replace(/'#8b5cf6'/g, `'${cfg.accentColor}'`);
        zip.file('COMPLETE_SCHEMA_SQL.sql', sqlText);
      }
    } catch (_) {}

    // 2. Injected HTML Pages
    const htmlFiles = [
      'index.html', 'student.html', 'teacher.html', 'cbt-multi.html', 'cbt-prompts.html',
      'admin.html', 'admin-data.html', 'storage.html', 'platform-health.html',
      'status-manager.html', 'settings.html', 'license.html', 'activity_log.html',
      'certificate.html', 'generator.html', 'deployment_validator.html', 'feature_guide.html',
      'link_checker.html', 'offline.html'
    ];

    for (const file of htmlFiles) {
      try {
        const res = await fetch(file);
        if (res.ok) {
          let content = await res.text();
          content = content.replace(/https:\/\/pstnsaqjshmtintjrnas\.supabase\.co/g, cfg.supabaseUrl)
                           .replace(/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9\.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzdG5zYXFqc2htdGludGpybmFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU3MDEzODUsImV4cCI6MjA5MTI3NzM4NX0\.KNVgpVN0xp1njin1HL3udntc7psfzjnz7mqzpEN_Z6w/g, cfg.supabaseAnonKey)
                           .replace(/HMG Academy CBT Pro/g, cfg.institutionName)
                           .replace(/HMG Academy/g, cfg.institutionName);
          zip.file(file, content);
        }
      } catch (_) {}
    }

    // 3. Injected JavaScript Assets
    const jsFiles = [
      'assets/js/app.js', 'assets/js/drive-sync.js', 'assets/js/cbt-engine.js',
      'assets/js/cbt-types.js', 'assets/js/license.js', 'assets/js/keepalive.js',
      'assets/js/generator.js', 'assets/js/site-help.js', 'assets/js/chatbot.js',
      'sw.js', 'pwa_install_enforcer.js', 'api/keepalive.js'
    ];

    for (const jsPath of jsFiles) {
      try {
        const res = await fetch(jsPath);
        if (res.ok) {
          let jsContent = await res.text();
          jsContent = jsContent.replace(/https:\/\/pstnsaqjshmtintjrnas\.supabase\.co/g, cfg.supabaseUrl)
                               .replace(/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9\.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzdG5zYXFqc2htdGludGpybmFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU3MDEzODUsImV4cCI6MjA5MTI3NzM4NX0\.KNVgpVN0xp1njin1HL3udntc7psfzjnz7mqzpEN_Z6w/g, cfg.supabaseAnonKey);
          zip.file(jsPath, jsContent);
        }
      } catch (_) {}
    }

    // 4. Injected CSS & Static Configs
    const miscFiles = [
      'assets/css/style.css', 'vercel.json', '_headers', 'manifest.webmanifest',
      'robots.txt', 'sitemap.xml', 'further_maths_sample.csv',
      '.github/workflows/supabase-heartbeat.yml'
    ];

    for (const mPath of miscFiles) {
      try {
        const res = await fetch(mPath);
        if (res.ok) {
          let mContent = await res.text();
          if (mPath.endsWith('style.css')) {
            // Apply selected font & theme colors
            const selectedFont = this.FONTS.find(f => f.id === cfg.fontId);
            if (selectedFont) {
              mContent = mContent.replace(/font-family:[^;]+;/, `font-family: ${selectedFont.family};`);
            }
          }
          zip.file(mPath, mContent);
        }
      } catch (_) {}
    }

    // 5. Generate & Download
    const blob = await zip.generateAsync({ type: 'blob' });
    const slug = cfg.institutionName.toLowerCase().replace(/[^a-z0-9]+/g, '-');
    const filename = `${slug}-cbt-enterprise-package.zip`;

    const a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    a.remove();
    setTimeout(() => URL.revokeObjectURL(a.href), 1000);

    return { success: true, filename, sizeBytes: blob.size };
  }
};

window.CBTGenerator = CBTGenerator;
