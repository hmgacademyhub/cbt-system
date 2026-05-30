const CACHE_NAME = 'hmg-cbt-shell-v5';
const SHELL_ASSETS = [
  './',
  './index.html',
  './teacher.html',
  './student.html',
  './admin.html',
  './offline.html',
  './manifest.webmanifest',
  './hmg-icon.svg',
  './assets/hmg-academy-logo.png',
  './README.md',
  './DIAGNOSIS_FEATURES_DEPLOYMENT.md',
  './ENTERPRISE_DEPLOYMENT_GUIDE.md',
  './ENHANCEMENT_REPORT_DEPLOYMENT.md',
  './deployment_validator.html',
  './feature_guide.html',
  './link_checker.html',
  './EXPERT_ENHANCEMENT_AND_DEPLOYMENT_REPORT.md',
  './_headers',
  './DEPLOY_NOW.txt'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => Promise.allSettled(SHELL_ASSETS.map(asset => cache.add(asset))))
      .then(() => self.skipWaiting())
      .catch(() => self.skipWaiting())
  );
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys => Promise.all(
      keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k))
    )).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', event => {
  const req = event.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);

  // Never intercept Supabase/API/CDN calls. They must always use live network.
  if (url.origin !== location.origin) return;

  event.respondWith(
    fetch(req).then(res => {
      const copy = res.clone();
      caches.open(CACHE_NAME).then(cache => cache.put(req, copy)).catch(() => {});
      return res;
    }).catch(() => caches.match(req).then(cached => {
      if (cached) return cached;
      if (req.mode === 'navigate') {
        return caches.match('./offline.html').then(page => page || caches.match('./index.html'));
      }
      return new Response('Offline and not cached.', {status: 503, headers: {'Content-Type':'text/plain'}});
    }))
  );
});
