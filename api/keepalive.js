// Vercel Serverless Function — Supabase Free-Tier Keepalive
export default async function handler(req, res) {
  const sbUrl = process.env.SUPABASE_URL || process.env.SB_URL || 'https://pstnsaqjshmtintjrnas.supabase.co';
  const sbKey = process.env.SUPABASE_ANON_KEY || process.env.SB_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzdG5zYXFqc2htdGludGpybmFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU3MDEzODUsImV4cCI6MjA5MTI3NzM4NX0.KNVgpVN0xp1njin1HL3udntc7psfzjnz7mqzpEN_Z6w';

  try {
    const response = await fetch(`${sbUrl}/rest/v1/institutions?select=id,name,last_keepalive_at&limit=1`, {
      headers: {
        'apikey': sbKey,
        'Authorization': `Bearer ${sbKey}`
      }
    });

    if (!response.ok) {
      throw new Error(`Supabase query failed: HTTP ${response.status}`);
    }

    const data = await response.json();
    return res.status(200).json({
      status: 'success',
      message: 'Supabase free-tier keepalive ping successful',
      timestamp: new Date().toISOString(),
      institution: data[0]?.name || 'HMG Academy'
    });
  } catch (err) {
    return res.status(500).json({
      status: 'error',
      message: err.message,
      timestamp: new Date().toISOString()
    });
  }
}
