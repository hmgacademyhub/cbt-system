// HMG Academy CBT Pro — PWA Install Encourager / Enforcer
// Free browser-native PWA prompt. Browsers do not allow websites to force installation,
// so this script strongly prompts users and records acknowledgement on this device.
(function(){
  const KEY='hmg_cbt_install_ack_v4';
  const isStandalone=()=>window.matchMedia('(display-mode: standalone)').matches||window.navigator.standalone===true;
  if(isStandalone())return;
  let deferredPrompt=null;
  window.addEventListener('beforeinstallprompt',e=>{e.preventDefault();deferredPrompt=e;showInstallGate(false);});
  window.addEventListener('appinstalled',()=>{localStorage.setItem(KEY,'installed:'+Date.now());hideInstallGate();});
  function css(){
    if(document.getElementById('hmg-install-style'))return;
    const st=document.createElement('style');st.id='hmg-install-style';st.textContent=`
      #hmg-install-gate{position:fixed;inset:0;background:rgba(0,0,0,.86);backdrop-filter:blur(8px);z-index:2147483000;display:flex;align-items:center;justify-content:center;padding:18px;font-family:Inter,system-ui,-apple-system,Segoe UI,Arial,sans-serif;color:#f4f4f5}
      #hmg-install-card{max-width:520px;width:100%;background:#18181b;border:1px solid #27272a;border-radius:22px;box-shadow:0 24px 80px rgba(0,0,0,.55);padding:24px;text-align:left}
      #hmg-install-card h2{margin:0 0 8px;font-size:20px;line-height:1.2}#hmg-install-card p,#hmg-install-card li{color:#a1a1aa;line-height:1.65;font-size:13px}#hmg-install-card ul{padding-left:18px;margin:10px 0 16px}
      .hmg-install-actions{display:flex;gap:9px;flex-wrap:wrap}.hmg-install-actions button{border:0;border-radius:11px;padding:11px 15px;font-weight:900;cursor:pointer;font-size:13px}.hmg-install-primary{background:#10b981;color:#000}.hmg-install-secondary{background:transparent;color:#f4f4f5;border:1px solid #3f3f46!important}.hmg-install-note{font-size:11px!important;color:#f59e0b!important;margin-top:12px!important}
    `;document.head.appendChild(st);
  }
  function showInstallGate(force){
    if(document.getElementById('hmg-install-gate'))return;
    const ack=localStorage.getItem(KEY);
    const age=ack?Date.now()-Number((ack.split(':')[1]||0)):Infinity;
    // Re-prompt weekly unless already installed. This supports the user's requirement to enforce installation without breaking unsupported browsers.
    if(!force && ack && age<7*24*60*60*1000)return;
    css();
    const div=document.createElement('div');div.id='hmg-install-gate';
    div.innerHTML=`<div id="hmg-install-card" role="dialog" aria-modal="true" aria-labelledby="hmg-install-title">
      <h2 id="hmg-install-title">📲 Install HMG Academy CBT Pro</h2>
      <p>For a smoother exam/teaching experience, install this platform on your phone, tablet or computer. It works like an app and loads the CBT shell faster.</p>
      <ul><li><b>Android/Chrome:</b> tap Install app or Add to Home screen.</li><li><b>iPhone/iPad:</b> Safari → Share → Add to Home Screen.</li><li><b>Windows/Mac/Chromebook:</b> Chrome/Edge address bar install icon or menu → Install.</li></ul>
      <div class="hmg-install-actions"><button class="hmg-install-primary" id="hmg-install-now">Install App</button><button class="hmg-install-secondary" id="hmg-install-done">I have installed / Continue</button><button class="hmg-install-secondary" id="hmg-install-later">Remind me later</button></div>
      <p class="hmg-install-note">Note: browsers control the final install button. If no prompt appears, use your browser menu instructions above.</p>
    </div>`;
    document.body.appendChild(div);
    document.getElementById('hmg-install-now').onclick=async()=>{
      if(deferredPrompt){deferredPrompt.prompt();await deferredPrompt.userChoice.catch(()=>{});deferredPrompt=null;localStorage.setItem(KEY,'prompted:'+Date.now());hideInstallGate();}
      else alert('Use your browser menu: Install app / Add to Home Screen. On iPhone use Safari Share → Add to Home Screen.');
    };
    document.getElementById('hmg-install-done').onclick=()=>{localStorage.setItem(KEY,'ack:'+Date.now());hideInstallGate();};
    document.getElementById('hmg-install-later').onclick=()=>{localStorage.setItem(KEY,'later:'+Date.now());hideInstallGate();};
  }
  function hideInstallGate(){document.getElementById('hmg-install-gate')?.remove();}
  window.HMGShowInstallGate=()=>showInstallGate(true);
  window.addEventListener('load',()=>setTimeout(()=>showInstallGate(false),900));
})();
