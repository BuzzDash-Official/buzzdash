<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>POPCORN STREAM</title>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">

<!-- ✅ LISTE DES VIDÉOS — modifie le fichier videos.js pour ajouter tes vidéos -->
<script src="videos.js"></script>

<style>
  :root {
    --bg:#080a0f; --surface:#0f1219; --surface2:#161c26;
    --gold:#f5c842; --red:#e8392a; --text:#eaeaea;
    --muted:#7a8499; --border:rgba(255,255,255,0.06); --sidebar:240px;
  }
  * { margin:0; padding:0; box-sizing:border-box; }
  body { background:var(--bg); color:var(--text); font-family:'DM Sans',sans-serif; overflow:hidden; height:100vh; }
  body::before {
    content:''; position:fixed; inset:0; z-index:0; pointer-events:none;
    background-image:url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");
    opacity:.35;
  }

  /* ── INTRO ── */
  #intro {
    position:fixed; inset:0; z-index:9999; background:#000;
    display:flex; flex-direction:column; align-items:center; justify-content:center;
    animation:introFade .7s ease-in forwards 4.5s;
  }
  #intro::before { content:''; position:absolute; inset:0; background:radial-gradient(ellipse at center,rgba(245,200,66,.1) 0%,transparent 70%); }
  .curtain { position:absolute; top:0; width:50%; height:100%; background:linear-gradient(to bottom,#0a0500,#1c0900,#0a0500); z-index:1; }
  .curtain.l { left:0; transform-origin:left; animation:cL 1.2s cubic-bezier(.77,0,.18,1) forwards .4s; }
  .curtain.r { right:0; transform-origin:right; animation:cR 1.2s cubic-bezier(.77,0,.18,1) forwards .4s; }
  .curtain.l::after { content:''; position:absolute; right:0; top:0; bottom:0; width:7px; background:linear-gradient(to bottom,#6b0000,#c02800,#6b0000); box-shadow:0 0 18px rgba(180,40,0,.5); }
  .curtain.r::after { content:''; position:absolute; left:0; top:0; bottom:0; width:7px; background:linear-gradient(to bottom,#6b0000,#c02800,#6b0000); box-shadow:0 0 18px rgba(180,40,0,.5); }
  @keyframes cL { to { transform:scaleX(0); } }
  @keyframes cR { to { transform:scaleX(0); } }
  .intro-logo { position:relative; z-index:2; display:flex; align-items:center; gap:20px; opacity:0; transform:scale(.75); animation:logoIn .8s cubic-bezier(.34,1.56,.64,1) forwards 1.9s; }
  @keyframes logoIn { to { opacity:1; transform:scale(1); } }
  .intro-pop { font-size:90px; filter:drop-shadow(0 0 30px rgba(245,200,66,.55)); position:relative; }
  .intro-eye { position:absolute; font-size:34px; top:50%; left:50%; transform:translate(-50%,-52%) scale(0); animation:eyeIn .4s cubic-bezier(.34,1.56,.64,1) forwards 2.7s, eyeBlink .25s ease-in-out infinite 3.5s; }
  @keyframes eyeIn { to { transform:translate(-50%,-52%) scale(1); } }
  @keyframes eyeBlink { 0%,85%,100% { transform:translate(-50%,-52%) scaleY(1); } 92% { transform:translate(-50%,-52%) scaleY(.08); } }
  .intro-text { display:flex; flex-direction:column; line-height:1; }
  .intro-text .big { font-family:'Bebas Neue'; font-size:64px; color:var(--gold); letter-spacing:4px; }
  .intro-text .small { font-family:'Bebas Neue'; font-size:34px; color:#fff; letter-spacing:8px; opacity:.6; }
  .intro-tag { position:absolute; bottom:80px; z-index:2; font-size:10px; letter-spacing:4px; color:var(--muted); text-transform:uppercase; opacity:0; animation:fadeUp .6s forwards 3.3s; }
  @keyframes fadeUp { to { opacity:1; } }
  @keyframes introFade { to { opacity:0; visibility:hidden; pointer-events:none; } }

  /* ── SIDEBAR ── */
  #sidebar { position:fixed; left:0; top:0; bottom:0; width:var(--sidebar); background:var(--surface); border-right:1px solid var(--border); z-index:100; display:flex; flex-direction:column; padding:26px 18px; }
  .logo { font-family:'Bebas Neue'; font-size:20px; letter-spacing:2px; color:var(--gold); margin-bottom:28px; line-height:1.1; }
  .logo sub { display:block; font-family:'DM Sans'; font-size:9px; letter-spacing:3px; color:var(--muted); font-weight:400; margin-top:2px; }
  .nav-label { font-size:9px; letter-spacing:3px; color:var(--muted); text-transform:uppercase; margin:16px 0 6px 4px; }
  .nav-btn { display:flex; align-items:center; gap:10px; padding:8px 11px; border-radius:7px; cursor:pointer; font-size:13px; font-weight:500; color:var(--muted); transition:.2s; border:none; background:none; width:100%; text-align:left; font-family:'DM Sans'; }
  .nav-btn:hover { background:var(--surface2); color:var(--text); }
  .nav-btn.active { background:rgba(245,200,66,.12); color:var(--gold); }
  .nav-btn .ico { width:20px; text-align:center; font-size:14px; }
  .sidebar-foot { margin-top:auto; padding-top:14px; border-top:1px solid var(--border); }
  .theme-btn { width:100%; padding:7px 11px; border-radius:7px; background:var(--surface2); border:1px solid var(--border); color:var(--muted); font-size:12px; cursor:pointer; font-family:'DM Sans'; transition:.2s; }
  .theme-btn:hover { color:var(--text); border-color:var(--gold); }

  /* ── TOPBAR ── */
  #topbar { position:fixed; top:0; left:var(--sidebar); right:0; height:70px; background:linear-gradient(to bottom,var(--bg) 60%,transparent); z-index:50; display:flex; align-items:center; padding:0 32px; gap:16px; }
  .search-box { flex:1; max-width:380px; position:relative; }
  .search-box input { width:100%; background:var(--surface); border:1px solid var(--border); border-radius:9px; padding:8px 14px 8px 36px; color:var(--text); font-size:13px; font-family:'DM Sans'; outline:none; transition:.2s; }
  .search-box input:focus { border-color:var(--gold); background:var(--surface2); }
  .search-box input::placeholder { color:var(--muted); }
  .search-box::before { content:'🔍'; position:absolute; left:11px; top:50%; transform:translateY(-50%); font-size:13px; pointer-events:none; }
  .topbar-badge { margin-left:auto; font-size:10px; color:var(--muted); letter-spacing:1px; text-transform:uppercase; }

  /* ── MAIN ── */
  #main { position:fixed; left:var(--sidebar); top:0; right:0; bottom:0; overflow-y:auto; padding:86px 32px 40px; scrollbar-width:thin; scrollbar-color:var(--surface2) transparent; }
  .sec-head { display:flex; align-items:baseline; gap:12px; margin-bottom:22px; }
  .sec-title { font-family:'Bebas Neue'; font-size:28px; letter-spacing:2px; }
  .sec-count { font-size:10px; color:var(--muted); letter-spacing:2px; text-transform:uppercase; }

  /* ── HERO ── */
  .hero { position:relative; border-radius:14px; overflow:hidden; aspect-ratio:21/8; cursor:pointer; margin-bottom:32px; }
  .hero img { width:100%; height:100%; object-fit:cover; transition:transform .5s; filter:brightness(.65); display:block; }
  .hero:hover img { transform:scale(1.03); filter:brightness(.8); }
  .hero-grad { position:absolute; inset:0; background:linear-gradient(to right,rgba(8,10,15,.88) 0%,transparent 55%),linear-gradient(to top,rgba(8,10,15,.65) 0%,transparent 50%); }
  .hero-info { position:absolute; bottom:0; left:0; padding:28px; }
  .hero-badge { display:inline-block; background:var(--gold); color:#000; font-size:9px; font-weight:700; letter-spacing:2px; text-transform:uppercase; padding:3px 8px; border-radius:4px; margin-bottom:10px; }
  .hero-title { font-family:'Bebas Neue'; font-size:34px; letter-spacing:2px; line-height:1.05; margin-bottom:14px; text-shadow:0 2px 16px rgba(0,0,0,.7); }
  .hero-play { display:inline-flex; align-items:center; gap:7px; background:var(--gold); color:#000; font-size:13px; font-weight:700; padding:9px 20px; border-radius:7px; border:none; cursor:pointer; transition:.2s; font-family:'DM Sans'; }
  .hero-play:hover { background:#fff; transform:scale(1.03); }

  /* ── GRILLE ── */
  .vgrid { display:grid; grid-template-columns:repeat(auto-fill,minmax(210px,1fr)); gap:16px; }
  .vcard { border-radius:10px; overflow:hidden; cursor:pointer; background:var(--surface); transition:transform .25s,box-shadow .25s; }
  .vcard:hover { transform:translateY(-5px); box-shadow:0 14px 36px rgba(0,0,0,.5); }
  .vcard:hover .voverlay { opacity:1; }
  .vcard:hover .vthumb { transform:scale(1.05); }
  .thumb-box { position:relative; aspect-ratio:16/9; overflow:hidden; }
  .vthumb { width:100%; height:100%; object-fit:cover; transition:transform .4s; display:block; }
  .voverlay { position:absolute; inset:0; background:rgba(0,0,0,.42); display:flex; align-items:center; justify-content:center; opacity:0; transition:.25s; }
  .play-circle { width:46px; height:46px; border-radius:50%; background:rgba(245,200,66,.95); display:flex; align-items:center; justify-content:center; box-shadow:0 4px 18px rgba(245,200,66,.4); transform:scale(.85); transition:transform .2s; }
  .vcard:hover .play-circle { transform:scale(1); }
  .play-circle::after { content:'▶'; margin-left:3px; color:#000; font-size:16px; }
  .vbody { padding:11px 13px 13px; }
  .vtitle { font-size:12px; font-weight:500; line-height:1.45; color:var(--text); display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden; margin-bottom:5px; }
  .vmeta { font-size:10px; color:var(--muted); }

  /* ── VIDE ── */
  .empty-box { grid-column:1/-1; text-align:center; padding:60px 20px; color:var(--muted); font-size:13px; line-height:2; }
  .empty-box span { font-size:36px; display:block; margin-bottom:12px; }

  /* ── MODAL ── */
  #modal { position:fixed; inset:0; z-index:3000; display:none; align-items:center; justify-content:center; background:rgba(0,0,0,.92); backdrop-filter:blur(12px); }
  #modal.open { display:flex; animation:mIn .25s ease; }
  @keyframes mIn { from { opacity:0; } }
  .modal-box { width:90%; max-width:1040px; animation:mScale .3s cubic-bezier(.34,1.2,.64,1); }
  @keyframes mScale { from { transform:scale(.88); opacity:0; } }
  .modal-hd { display:flex; justify-content:space-between; align-items:center; margin-bottom:12px; }
  .modal-ttl { font-family:'Bebas Neue'; font-size:20px; letter-spacing:2px; }
  .modal-x { background:var(--surface); border:1px solid var(--border); color:var(--muted); width:34px; height:34px; border-radius:50%; cursor:pointer; font-size:15px; display:flex; align-items:center; justify-content:center; transition:.2s; }
  .modal-x:hover { background:var(--red); color:#fff; border-color:var(--red); }
  .player-box { aspect-ratio:16/9; border-radius:10px; overflow:hidden; box-shadow:0 28px 70px rgba(0,0,0,.8),0 0 0 1px var(--border); }
  .player-box iframe { width:100%; height:100%; display:block; border:none; }

  /* ── LIGHT MODE ── */
  body.light { --bg:#f0f2f5; --surface:#fff; --surface2:#e8eaed; --text:#1a1c20; --muted:#6b7280; --border:rgba(0,0,0,.08); }
</style>
</head>
<body>

<!-- INTRO -->
<div id="intro">
  <div class="curtain l"></div>
  <div class="curtain r"></div>
  <div class="intro-logo">
    <div class="intro-pop">🍿<div class="intro-eye">👁️</div></div>
    <div class="intro-text"><span class="big">Popcorn</span><span class="small">Stream</span></div>
  </div>
  <p class="intro-tag">Plateforme éducative · Contenu sélectionné</p>
</div>

<!-- SIDEBAR -->
<aside id="sidebar">
  <div class="logo">🍿 POPCORN STREAM<sub>ÉDITION ÉCOLE</sub></div>

  <div class="nav-label">Accueil</div>
  <button class="nav-btn active" onclick="go(this,'alune')">
    <span class="ico">🔥</span> À la une
  </button>

  <div class="nav-label">Catégories</div>
  <button class="nav-btn" onclick="go(this,'documentaires')">
    <span class="ico">🌍</span> Documentaires
  </button>
  <button class="nav-btn" onclick="go(this,'science')">
    <span class="ico">🔬</span> Science & Nature
  </button>
  <button class="nav-btn" onclick="go(this,'espace')">
    <span class="ico">🚀</span> Espace & Univers
  </button>
  <button class="nav-btn" onclick="go(this,'bandesannonces')">
    <span class="ico">🎬</span> Bandes-Annonces
  </button>
  <button class="nav-btn" onclick="go(this,'culture')">
    <span class="ico">🎓</span> Culture Générale
  </button>

  <div class="sidebar-foot">
    <button class="theme-btn" id="theme-btn" onclick="toggleTheme()">☀️ Mode Clair</button>
  </div>
</aside>

<!-- TOPBAR -->
<header id="topbar">
  <div class="search-box">
    <input type="text" id="search" placeholder="Rechercher une vidéo..." oninput="filterCards(this.value)">
  </div>
  <div class="topbar-badge">✦ Contenu éducatif sécurisé</div>
</header>

<!-- MAIN -->
<main id="main">
  <div class="sec-head">
    <h2 class="sec-title" id="sec-title">À LA UNE</h2>
    <span class="sec-count" id="sec-count"></span>
  </div>
  <div id="hero-zone"></div>
  <div class="vgrid" id="grid"></div>
</main>

<!-- PLAYER -->
<div id="modal">
  <div class="modal-box">
    <div class="modal-hd">
      <span class="modal-ttl" id="modal-ttl">Lecture</span>
      <button class="modal-x" onclick="closePlayer()">✕</button>
    </div>
    <div class="player-box">
      <iframe id="player" src="" allowfullscreen allow="autoplay; fullscreen"></iframe>
    </div>
  </div>
</div>

<script>
// Noms affichés pour chaque catégorie
const LABELS = {
  alune:          '🔥 À la une',
  documentaires:  '🌍 Documentaires',
  science:        '🔬 Science & Nature',
  espace:         '🚀 Espace & Univers',
  bandesannonces: '🎬 Bandes-Annonces',
  culture:        '🎓 Culture Générale',
};

// Navigation
function go(btn, cat) {
  document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  renderCat(cat);
}

function renderCat(cat) {
  const list = VIDEOS[cat] || [];
  const label = LABELS[cat] || cat;

  document.getElementById('sec-title').textContent = label.replace(/^../,'').trim().toUpperCase();
  document.getElementById('hero-zone').innerHTML = '';

  if (list.length === 0) {
    document.getElementById('sec-count').textContent = '';
    document.getElementById('grid').innerHTML = `
      <div class="empty-box">
        <span>🎬</span>
        Aucune vidéo dans cette catégorie pour l'instant.<br>
        <small>Ouvre le fichier <strong>videos.js</strong> et ajoute des vidéos !</small>
      </div>`;
    return;
  }

  document.getElementById('sec-count').textContent = list.length + ' vidéo' + (list.length > 1 ? 's' : '');

  // Premier = hero
  const first = list[0];
  document.getElementById('hero-zone').innerHTML = `
    <div class="hero" onclick="openPlayer('${first.id}','${esc(first.titre)}')">
      <img src="https://img.youtube.com/vi/${first.id}/maxresdefault.jpg"
           onerror="this.src='https://img.youtube.com/vi/${first.id}/hqdefault.jpg'" alt="">
      <div class="hero-grad"></div>
      <div class="hero-info">
        <span class="hero-badge">✦ À LA UNE</span>
        <div class="hero-title">${first.titre}</div>
        <button class="hero-play">▶ &nbsp;Regarder</button>
      </div>
    </div>`;

  // Reste = grille
  document.getElementById('grid').innerHTML = list.slice(1).map(v => `
    <div class="vcard" onclick="openPlayer('${v.id}','${esc(v.titre)}')">
      <div class="thumb-box">
        <img class="vthumb"
             src="https://img.youtube.com/vi/${v.id}/mqdefault.jpg"
             onerror="this.src='https://img.youtube.com/vi/${v.id}/hqdefault.jpg'" alt="">
        <div class="voverlay"><div class="play-circle"></div></div>
      </div>
      <div class="vbody">
        <div class="vtitle">${v.titre}</div>
        ${v.date ? `<div class="vmeta">${v.date}</div>` : ''}
      </div>
    </div>`).join('');
}

function esc(s) { return (s||'').replace(/'/g,"\\'").replace(/"/g,'&quot;'); }

// Player
function openPlayer(id, title) {
  document.getElementById('player').src = `https://www.youtube.com/embed/${id}?autoplay=1&rel=0&modestbranding=1`;
  document.getElementById('modal-ttl').textContent = title;
  document.getElementById('modal').classList.add('open');
}
function closePlayer() {
  document.getElementById('player').src = '';
  document.getElementById('modal').classList.remove('open');
}
document.getElementById('modal').addEventListener('click', e => { if(e.target.id==='modal') closePlayer(); });
document.addEventListener('keydown', e => { if(e.key==='Escape') closePlayer(); });

// Recherche
function filterCards(q) {
  const ql = q.toLowerCase();
  document.querySelectorAll('.vcard').forEach(c => {
    c.style.display = c.querySelector('.vtitle').textContent.toLowerCase().includes(ql) ? '' : 'none';
  });
}

// Thème
function toggleTheme() {
  document.body.classList.toggle('light');
  document.getElementById('theme-btn').textContent =
    document.body.classList.contains('light') ? '🌙 Mode Sombre' : '☀️ Mode Clair';
}

// Init
setTimeout(() => renderCat('alune'), 5000);
</script>
</body>
</html>
