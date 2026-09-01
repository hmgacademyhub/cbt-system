/* ====================================================================
   keepalive.js — HMG CBT Pro 10-Layer Supabase Free-Tier Protection Client
   ====================================================================
   Prevents Supabase free-tier project from pausing after 7 days of inactivity.
   Executes automatic browser heartbeat, triggers Vercel keepalive endpoints,
   and tests internal RPC connectivity.
   ==================================================================== */
const FreeTierKeeper = {
  LS_LAST_PING: 'cbt_last_keepalive_ping',

  async ping(sbClient) {
    const sb = sbClient || window.sb;
    const now = Date.now();
    const lastPing = Number(localStorage.getItem(this.LS_LAST_PING) || 0);

    // Throttle client pings to once every 12 hours per browser
    if (now - lastPing < 12 * 60 * 60 * 1000) {
      return { skipped: true, message: 'Ping throttled (last pinged recently)' };
    }

    try {
      if (sb) {
        // Layer 1 & 4: Touch database via RPC or select
        const rpcRes = await sb.rpc('keep_alive_ping').catch(() => null);
        if (!rpcRes) {
          await sb.from('institutions').select('id,name').limit(1);
        }
      }

      // Layer 3: Call Vercel keepalive endpoint if deployed
      fetch('/api/keepalive', { method: 'GET', cache: 'no-store' }).catch(() => {});

      localStorage.setItem(this.LS_LAST_PING, String(now));
      console.log('[FreeTierKeeper] Supabase keepalive heartbeat sent successfully.');
      return { success: true, timestamp: new Date().toISOString() };
    } catch (e) {
      console.warn('[FreeTierKeeper] Keepalive ping warning:', e.message);
      return { success: false, error: e.message };
    }
  },

  getProtectionLayers() {
    return [
      { layer: 1, name: 'Browser Client Heartbeat', status: 'Active (Built-in)', description: 'Pings Supabase on every admin/teacher portal visit.' },
      { layer: 2, name: 'GitHub Actions Cron', status: 'Available', description: 'Scheduled workflow (.github/workflows/supabase-heartbeat.yml) runs every 3 days.' },
      { layer: 3, name: 'Vercel Serverless Endpoint', status: 'Active (/api/keepalive.js)', description: 'Edge function that queries database via REST API.' },
      { layer: 4, name: 'Internal PostgreSQL Ping', status: 'Active (RPC keep_alive_ping)', description: 'Database function updating institution keepalive timestamp.' },
      { layer: 5, name: 'Manual Heartbeat Button', status: 'Available', description: 'One-click manual ping trigger in Platform Health & Settings.' },
      { layer: 6, name: 'UptimeRobot / External Ping', status: 'Configurable', description: 'Free external HTTP monitoring pinging /api/keepalive every 5 mins.' },
      { layer: 7, name: 'Vercel Cron Schedule', status: 'Active (vercel.json)', description: 'Native Vercel cron triggering keepalive endpoint.' },
      { layer: 8, name: 'Google Apps Script Trigger', status: 'Available', description: 'Serverless Google Drive script calling Supabase REST API.' },
      { layer: 9, name: 'Auto-Commit Keepalive', status: 'Available', description: 'Self-committing GitHub workflow preventing 60-day repo idle pause.' },
      { layer: 10, name: 'Connection Watchdog & Auto-Recovery', status: 'Active', description: 'Live frontend latency watchdog alerting on connection drops.' }
    ];
  }
};

window.FreeTierKeeper = FreeTierKeeper;
