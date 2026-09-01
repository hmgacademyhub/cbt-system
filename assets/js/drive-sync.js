/* ====================================================================
   drive-sync.js — HMG CBT Pro Google Drive Cloud Backup & Auto-Sync
   ====================================================================
   Provides zero-server, 100% free Google Drive automated and 1-click
   cloud backup and restore. Uses Google Identity Services (GIS) token model
   and Google Drive REST API v3. Scope: drive.file (safe sandbox).
   ==================================================================== */
const DriveSync = {
  SCOPE: 'https://www.googleapis.com/auth/drive.file',
  LS_KEY: 'hmg-cbt-drive-sync',
  MAX_KEEP: 20,
  token: null,
  tokenExp: 0,
  _tokenClient: null,
  _gisLoading: null,
  cfg: {
    clientId: '',
    enabled: false,
    days: 7,
    folderId: '',
    lastBackup: null
  },

  state() {
    try { return JSON.parse(localStorage.getItem(this.LS_KEY) || '{}'); } catch (_) { return {}; }
  },
  setState(patch) {
    try { localStorage.setItem(this.LS_KEY, JSON.stringify(Object.assign(this.state(), patch))); } catch (_) {}
  },

  async loadCfg(sbClient) {
    const sb = sbClient || window.sb;
    if (!sb) return this.cfg;
    try {
      const { data } = await sb.from('institutions').select('drive_client_id,drive_sync_enabled,drive_sync_days,drive_folder_id,drive_last_backup').limit(1).maybeSingle();
      if (data) {
        this.cfg = {
          clientId: data.drive_client_id || '',
          enabled: !!data.drive_sync_enabled,
          days: Math.max(1, Number(data.drive_sync_days) || 7),
          folderId: data.drive_folder_id || '',
          lastBackup: data.drive_last_backup || null
        };
      }
    } catch (e) {
      console.warn('[DriveSync] settings load skipped:', e.message || e);
    }
    return this.cfg;
  },

  async saveCfg(patch, sbClient) {
    Object.assign(this.cfg, patch || {});
    const sb = sbClient || window.sb;
    if (!sb) return this.cfg;
    try {
      const inst = await sb.from('institutions').select('id').limit(1).maybeSingle();
      if (inst?.data?.id) {
        await sb.from('institutions').update({
          drive_client_id: this.cfg.clientId,
          drive_sync_enabled: this.cfg.enabled,
          drive_sync_days: this.cfg.days,
          drive_folder_id: this.cfg.folderId,
          drive_last_backup: this.cfg.lastBackup,
          updated_at: new Date().toISOString()
        }).eq('id', inst.data.id);
      }
    } catch (e) {
      console.warn('[DriveSync] saveCfg error:', e.message || e);
    }
    return this.cfg;
  },

  isConfigured() {
    return !!(this.cfg.clientId && this.cfg.clientId.trim().length > 10);
  },

  async loadGIS() {
    if (window.google?.accounts?.oauth2) return true;
    if (this._gisLoading) return this._gisLoading;
    this._gisLoading = new Promise((resolve, reject) => {
      const s = document.createElement('script');
      s.src = 'https://accounts.google.com/gsi/client';
      s.async = true;
      s.defer = true;
      s.onload = () => resolve(true);
      s.onerror = () => reject(new Error('Failed to load Google Identity Services SDK'));
      document.head.appendChild(s);
    });
    return this._gisLoading;
  },

  async getToken(prompt = false) {
    if (this.token && Date.now() < this.tokenExp - 60000) return this.token;
    if (!this.isConfigured()) throw new Error('Google Drive Client ID is not configured. Add it in Settings / Admin Data.');
    await this.loadGIS();

    return new Promise((resolve, reject) => {
      try {
        this._tokenClient = google.accounts.oauth2.initTokenClient({
          client_id: this.cfg.clientId.trim(),
          scope: this.SCOPE,
          prompt: prompt ? 'consent' : '',
          callback: (resp) => {
            if (resp.error) return reject(new Error(resp.error_description || resp.error));
            this.token = resp.access_token;
            this.tokenExp = Date.now() + (Number(resp.expires_in) || 3500) * 1000;
            this.setState({ granted: true, lastAuth: Date.now() });
            resolve(this.token);
          }
        });
        this._tokenClient.requestAccessToken({ prompt: prompt ? 'consent' : '' });
      } catch (err) {
        reject(err);
      }
    });
  },

  async ensureFolder(token) {
    if (this.cfg.folderId) return this.cfg.folderId;
    const q = encodeURIComponent("name = 'HMG_CBT_Backups' and mimeType = 'application/vnd.google-apps.folder' and trashed = false");
    const listRes = await fetch(`https://www.googleapis.com/drive/v3/files?q=${q}&spaces=drive&fields=files(id,name)`, {
      headers: { Authorization: `Bearer ${token}` }
    });
    const listData = await listRes.json();
    if (listData.files && listData.files.length > 0) {
      this.cfg.folderId = listData.files[0].id;
      await this.saveCfg({ folderId: this.cfg.folderId });
      return this.cfg.folderId;
    }

    // Create folder
    const createRes = await fetch('https://www.googleapis.com/drive/v3/files', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        name: 'HMG_CBT_Backups',
        mimeType: 'application/vnd.google-apps.folder'
      })
    });
    const createData = await createRes.json();
    this.cfg.folderId = createData.id;
    await this.saveCfg({ folderId: this.cfg.folderId });
    return this.cfg.folderId;
  },

  async uploadBackup(envelope, customFilename) {
    const token = await this.getToken(false);
    const folderId = await this.ensureFolder(token);
    const filename = customFilename || `HMG_CBT_Backup_${new Date().toISOString().replace(/[:.]/g, '-')}.json`;
    const jsonStr = typeof envelope === 'string' ? envelope : JSON.stringify(envelope, null, 2);

    const boundary = '-------314159265358979323846';
    const delimiter = `\r\n--${boundary}\r\n`;
    const closeDelim = `\r\n--${boundary}--`;

    const metadata = {
      name: filename,
      parents: [folderId],
      mimeType: 'application/json',
      description: 'HMG Academy CBT Pro Portable Cloud Backup'
    };

    const multipartRequestBody =
      delimiter +
      'Content-Type: application/json; charset=UTF-8\r\n\r\n' +
      JSON.stringify(metadata) +
      delimiter +
      'Content-Type: application/json\r\n\r\n' +
      jsonStr +
      closeDelim;

    const res = await fetch('https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': `multipart/related; boundary=${boundary}`
      },
      body: multipartRequestBody
    });

    if (!res.ok) {
      const err = await res.json().catch(() => ({}));
      throw new Error(err.error?.message || `Google Drive upload failed (${res.status})`);
    }

    const file = await res.json();
    this.cfg.lastBackup = new Date().toISOString();
    await this.saveCfg({ lastBackup: this.cfg.lastBackup });

    // Auto prune old backups to keep max 20
    this.pruneOldBackups(token, folderId).catch(() => {});

    return file;
  },

  async listBackups() {
    const token = await this.getToken(false);
    const folderId = await this.ensureFolder(token);
    const q = encodeURIComponent(`'${folderId}' in parents and trashed = false and mimeType = 'application/json'`);
    const res = await fetch(`https://www.googleapis.com/drive/v3/files?q=${q}&orderBy=createdTime desc&fields=files(id,name,size,createdTime,webViewLink)`, {
      headers: { Authorization: `Bearer ${token}` }
    });
    if (!res.ok) throw new Error('Could not list Google Drive files');
    const data = await res.json();
    return data.files || [];
  },

  async downloadBackup(fileId) {
    const token = await this.getToken(false);
    const res = await fetch(`https://www.googleapis.com/drive/v3/files/${fileId}?alt=media`, {
      headers: { Authorization: `Bearer ${token}` }
    });
    if (!res.ok) throw new Error('Failed to download backup from Google Drive');
    return await res.json();
  },

  async pruneOldBackups(token, folderId) {
    try {
      const q = encodeURIComponent(`'${folderId}' in parents and trashed = false`);
      const res = await fetch(`https://www.googleapis.com/drive/v3/files?q=${q}&orderBy=createdTime desc&fields=files(id,name,createdTime)`, {
        headers: { Authorization: `Bearer ${token}` }
      });
      const data = await res.json();
      const files = data.files || [];
      if (files.length > this.MAX_KEEP) {
        const toDelete = files.slice(this.MAX_KEEP);
        for (const f of toDelete) {
          await fetch(`https://www.googleapis.com/drive/v3/files/${f.id}`, {
            method: 'DELETE',
            headers: { Authorization: `Bearer ${token}` }
          });
        }
      }
    } catch (_) {}
  },

  async checkAutoSync(envelopeProvider) {
    await this.loadCfg();
    if (!this.cfg.enabled || !this.isConfigured()) return;
    const last = this.cfg.lastBackup ? new Date(this.cfg.lastBackup).getTime() : 0;
    const intervalMs = this.cfg.days * 24 * 60 * 60 * 1000;
    if (Date.now() - last >= intervalMs) {
      console.log('[DriveSync] Auto-backup is due. Creating background snapshot...');
      try {
        const envelope = typeof envelopeProvider === 'function' ? await envelopeProvider() : null;
        if (envelope) {
          await this.uploadBackup(envelope);
          console.log('[DriveSync] Auto-backup successfully synced to Google Drive.');
        }
      } catch (e) {
        console.warn('[DriveSync] Auto-sync attempt deferred:', e.message);
      }
    }
  }
};

window.DriveSync = DriveSync;
