import urllib.request
import json
from datetime import datetime

# ================================================================
#  CLÉ GOOGLE API
# ================================================================
API_KEY = "AIzaSyDXc2iuxIR4TXYr53Co43RHVii2Tc7FLgs"

# ================================================================
#  CHAÎNES YOUTUBE PAR CATÉGORIE
#  Pour changer : remplace l'ID entre guillemets
#  Pour trouver un ID : commentpicker.com/youtube-channel-id.php
# ================================================================
CHAINES = {
    "documentaires":  "UCwI-JbGNsojunnHbFAc0M4Q",  # ARTE
    "science":        "hU-_aY_1DMrE2fcP0IPmOA",    # Dr Nozman
    "espace":         "UC5X4e8ScZI2AFd_vkjSoyoQ",  # AstronoGeek
    "bandesannonces": "",                           # Laisse vide jusqu'à avoir l'ID Sony
    "culture":        "UCqnbDFdCpuN8CMEg0VuEBqA",  # Nota Bene
}

# ================================================================
#  À LA UNE — modifie cette liste manuellement
#  id = les caractères après ?v= dans l'URL YouTube
# ================================================================
ALUNE = [
    {"id": "wrFsapf0Enk", "titre": "KAIZEN — Le défi de l'impossible", "date": "2024"},
    {"id": "p0Z-9Q_jM2Y", "titre": "Inoxtag : Nouveau Départ",          "date": "2024"},
    {"id": "PCMrUGqH6fQ", "titre": "La face cachée des océans",         "date": "2024"},
    {"id": "7Xfk9CN6S4E", "titre": "L'univers en 1 heure",              "date": "2024"},
    # Ajoute tes vidéos ici :
    # {"id": "XXXXXXXXXXX", "titre": "Titre", "date": "Mai 2025"},
]

# ================================================================
#  NE TOUCHE PAS AU CODE EN DESSOUS
# ================================================================

MOIS = ["","Jan","Fév","Mar","Avr","Mai","Jun","Jul","Aoû","Sep","Oct","Nov","Déc"]

def get_videos(channel_id, max_results=10):
    url = (
        f"https://www.googleapis.com/youtube/v3/search"
        f"?key={API_KEY}"
        f"&channelId={channel_id}"
        f"&part=snippet,id"
        f"&order=date"
        f"&maxResults={max_results}"
        f"&type=video"
    )
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        with urllib.request.urlopen(req, timeout=15) as r:
            data = json.loads(r.read())
        if "error" in data:
            print(f"  Erreur API : {data['error']['message']}")
            return []
        videos = []
        for item in data.get("items", []):
            vid_id = item["id"].get("videoId", "")
            title  = item["snippet"].get("title", "")
            pub    = item["snippet"].get("publishedAt", "")
            thumb  = item["snippet"].get("thumbnails", {}).get("medium", {}).get("url", "")
            if not vid_id:
                continue
            date_str = ""
            if pub:
                try:
                    dt = datetime.fromisoformat(pub[:10])
                    date_str = f"{MOIS[dt.month]} {dt.year}"
                except Exception:
                    pass
            t = title.replace("\\", "\\\\").replace("'", "\\'").replace('"', "&quot;").replace("<", "&lt;")
            videos.append({"id": vid_id, "titre": t, "date": date_str, "thumb": thumb})
        return videos
    except Exception as e:
        print(f"  Erreur fetch : {e}")
        return []


def videos_to_js(name, videos):
    if not videos:
        return f"  {name}: [],"
    lines = [f"  {name}: ["]
    for v in videos:
        lines.append(f'    {{id:"{v["id"]}", titre:"{v["titre"]}", date:"{v["date"]}", thumb:"{v["thumb"]}"}},')
    lines.append("  ],")
    return "\n".join(lines)


# Récupère toutes les vidéos
print("=== Mise à jour Popcorn Stream ===")
all_videos = {}
for cat, cid in CHAINES.items():
    if not cid:
        print(f"[{cat}] Ignoré (pas d'ID)")
        all_videos[cat] = []
        continue
    print(f"[{cat}] Chargement...")
    vids = get_videos(cid)
    all_videos[cat] = vids
    print(f"[{cat}] {len(vids)} vidéos récupérées")

today = datetime.now().strftime("%d/%m/%Y à %Hh%M")

# Construit le bloc JS complet
js_videos = "const VIDEOS = {\n\n"
js_videos += "  // À LA UNE — modifie dans generate.py\n"

alune_lines = ["  alune: ["]
for v in ALUNE:
    t = v['titre'].replace("'", "\\'").replace('"', '&quot;')
    alune_lines.append(f'    {{id:"{v["id"]}", titre:"{t}", date:"{v["date"]}", thumb:""}},')
alune_lines.append("  ],")
js_videos += "\n".join(alune_lines) + "\n\n"

for cat in ["documentaires", "science", "espace", "bandesannonces", "culture"]:
    js_videos += f"  // Mis à jour le {today}\n"
    js_videos += videos_to_js(cat, all_videos.get(cat, [])) + "\n\n"

js_videos += "};"

# Template HTML complet
HTML = r"""<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>POPCORN STREAM</title>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
  :root{--bg:#080a0f;--surface:#0f1219;--surface2:#161c26;--gold:#f5c842;--red:#e8392a;--text:#eaeaea;--muted:#7a8499;--border:rgba(255,255,255,0.06);--sidebar:240px;}
  *{margin:0;padding:0;box-sizing:border-box;}
  body{background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;overflow:hidden;height:100vh;}
  body::before{content:'';position:fixed;inset:0;z-index:0;pointer-events:none;
    background:radial-gradient(circle at 25% 25%,rgba(139,92,246,0.07) 0%,transparent 60%),
    url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");opacity:.5;}
  #intro-site{position:fixed;inset:0;z-index:9999;background:#000;display:flex;flex-direction:column;align-items:center;justify-content:center;animation:introFade .8s ease-in forwards 5s;}
  #intro-site::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse at center,rgba(245,200,66,.08) 0%,transparent 70%);}
  .curtain{position:absolute;top:0;width:50%;height:100%;background:linear-gradient(to bottom,#080300,#1c0900,#080300);z-index:1;}
  .curtain.l{left:0;transform-origin:left;animation:cL 1.4s cubic-bezier(.77,0,.18,1) forwards .5s;}
  .curtain.r{right:0;transform-origin:right;animation:cR 1.4s cubic-bezier(.77,0,.18,1) forwards .5s;}
  .curtain.l::after,.curtain.r::after{content:'';position:absolute;top:0;bottom:0;width:5px;background:linear-gradient(to bottom,#6b0000,#cc2200,#6b0000);box-shadow:0 0 20px rgba(200,30,0,.6);}
  .curtain.l::after{right:0;}.curtain.r::after{left:0;}
  @keyframes cL{to{transform:scaleX(0);}}@keyframes cR{to{transform:scaleX(0);}}
  .site-logo{position:relative;z-index:2;display:flex;align-items:center;gap:22px;opacity:0;transform:scale(.75);animation:logoIn .8s cubic-bezier(.34,1.56,.64,1) forwards 2.2s;}
  @keyframes logoIn{to{opacity:1;transform:scale(1);}}
  .site-pop{font-size:96px;filter:drop-shadow(0 0 30px rgba(245,200,66,.6));position:relative;animation:popSpin 1.6s ease-out;}
  @keyframes popSpin{from{transform:rotate(-180deg) scale(0);}to{transform:rotate(0) scale(1);}}
  .site-eye{position:absolute;font-size:36px;top:50%;left:50%;transform:translate(-50%,-52%) scale(0);animation:eyeIn .4s cubic-bezier(.34,1.56,.64,1) forwards 3s,eyeBlink .3s ease-in-out infinite 4s;}
  @keyframes eyeIn{to{transform:translate(-50%,-52%) scale(1);}}
  @keyframes eyeBlink{0%,85%,100%{transform:translate(-50%,-52%) scaleY(1);}92%{transform:translate(-50%,-52%) scaleY(.08);}}
  .site-name{display:flex;flex-direction:column;line-height:1;}
  .site-name .big{font-family:'Bebas Neue';font-size:72px;color:var(--gold);letter-spacing:5px;filter:blur(12px);animation:blurIn 1s forwards 3.4s;}
  .site-name .small{font-family:'Bebas Neue';font-size:36px;color:#fff;letter-spacing:10px;opacity:.55;filter:blur(8px);animation:blurIn .8s forwards 3.6s;}
  @keyframes blurIn{to{filter:blur(0);}}
  .site-tag{position:absolute;bottom:70px;z-index:2;font-size:10px;letter-spacing:5px;color:var(--muted);text-transform:uppercase;opacity:0;animation:fadeUp .6s forwards 3.8s;}
  @keyframes fadeUp{to{opacity:1;}}
  @keyframes introFade{to{opacity:0;visibility:hidden;pointer-events:none;}}
  #intro-video{position:fixed;inset:0;z-index:4000;background:#000;display:none;flex-direction:column;align-items:center;justify-content:center;}
  #intro-video.show{display:flex;}
  .iv-curtain{position:absolute;top:0;width:50%;height:100%;background:linear-gradient(to bottom,#080300,#1c0900,#080300);z-index:1;}
  .iv-curtain.l{left:0;transform-origin:left;}.iv-curtain.r{right:0;transform-origin:right;}
  .iv-curtain.l::after,.iv-curtain.r::after{content:'';position:absolute;top:0;bottom:0;width:4px;background:linear-gradient(to bottom,#6b0000,#cc2200,#6b0000);box-shadow:0 0 15px rgba(200,30,0,.5);}
  .iv-curtain.l::after{right:0;}.iv-curtain.r::after{left:0;}
  .iv-content{position:relative;z-index:2;display:flex;flex-direction:column;align-items:center;gap:16px;opacity:0;}
  .iv-pop{font-size:72px;filter:drop-shadow(0 0 20px rgba(245,200,66,.5));}
  .iv-msg{font-family:'Bebas Neue';font-size:52px;color:var(--gold);letter-spacing:6px;}
  .iv-sub{font-size:12px;letter-spacing:4px;color:var(--muted);text-transform:uppercase;}
  .iv-bar{width:200px;height:2px;background:var(--surface2);border-radius:2px;margin-top:6px;overflow:hidden;}
  .iv-progress{height:100%;background:var(--gold);width:0%;border-radius:2px;}
  #sidebar{position:fixed;left:0;top:0;bottom:0;width:var(--sidebar);background:var(--surface);border-right:1px solid var(--border);z-index:100;display:flex;flex-direction:column;padding:26px 18px;}
  .logo{font-family:'Bebas Neue';font-size:20px;letter-spacing:2px;color:var(--gold);margin-bottom:28px;line-height:1.1;}
  .logo sub{display:block;font-family:'DM Sans';font-size:9px;letter-spacing:3px;color:var(--muted);font-weight:400;margin-top:2px;}
  .nav-label{font-size:9px;letter-spacing:3px;color:var(--muted);text-transform:uppercase;margin:14px 0 5px 4px;}
  .nav-btn{display:flex;align-items:center;gap:10px;padding:8px 11px;border-radius:7px;cursor:pointer;font-size:13px;font-weight:500;color:var(--muted);transition:.2s;border:none;background:none;width:100%;text-align:left;font-family:'DM Sans';}
  .nav-btn:hover{background:var(--surface2);color:var(--text);}
  .nav-btn.active{background:rgba(245,200,66,.12);color:var(--gold);}
  .nav-btn .ico{width:20px;text-align:center;font-size:14px;}
  .sidebar-foot{margin-top:auto;padding-top:14px;border-top:1px solid var(--border);}
  .theme-btn{width:100%;padding:7px 11px;border-radius:7px;background:var(--surface2);border:1px solid var(--border);color:var(--muted);font-size:12px;cursor:pointer;font-family:'DM Sans';transition:.2s;}
  .theme-btn:hover{color:var(--text);border-color:var(--gold);}
  #topbar{position:fixed;top:0;left:var(--sidebar);right:0;height:70px;background:linear-gradient(to bottom,var(--bg) 60%,transparent);z-index:50;display:flex;align-items:center;padding:0 32px;}
  .search-box{flex:1;max-width:420px;position:relative;}
  .search-box input{width:100%;background:var(--surface);border:1px solid var(--border);border-radius:9px;padding:8px 14px 8px 36px;color:var(--text);font-size:13px;font-family:'DM Sans';outline:none;transition:.2s;}
  .search-box input:focus{border-color:var(--gold);background:var(--surface2);}
  .search-box input::placeholder{color:var(--muted);}
  .search-box::before{content:'🔍';position:absolute;left:11px;top:50%;transform:translateY(-50%);font-size:13px;pointer-events:none;}
  #main{position:fixed;left:var(--sidebar);top:0;right:0;bottom:0;overflow-y:auto;padding:86px 32px 40px;scrollbar-width:thin;scrollbar-color:var(--surface2) transparent;}
  .sec-head{display:flex;align-items:baseline;gap:12px;margin-bottom:22px;}
  .sec-title{font-family:'Bebas Neue';font-size:28px;letter-spacing:2px;}
  .sec-count{font-size:10px;color:var(--muted);letter-spacing:2px;text-transform:uppercase;}
  .hero{position:relative;border-radius:14px;overflow:hidden;aspect-ratio:21/8;cursor:pointer;margin-bottom:32px;background:var(--surface2);}
  .hero img{width:100%;height:100%;object-fit:cover;transition:transform .5s;filter:brightness(.6);display:block;}
  .hero:hover img{transform:scale(1.03);filter:brightness(.78);}
  .hero-grad{position:absolute;inset:0;background:linear-gradient(to right,rgba(8,10,15,.9) 0%,transparent 55%),linear-gradient(to top,rgba(8,10,15,.7) 0%,transparent 50%);}
  .hero-info{position:absolute;bottom:0;left:0;padding:28px;}
  .hero-badge{display:inline-block;background:var(--gold);color:#000;font-size:9px;font-weight:700;letter-spacing:2px;text-transform:uppercase;padding:3px 8px;border-radius:4px;margin-bottom:10px;}
  .hero-title{font-family:'Bebas Neue';font-size:36px;letter-spacing:2px;line-height:1.05;margin-bottom:14px;text-shadow:0 2px 16px rgba(0,0,0,.8);}
  .hero-play{display:inline-flex;align-items:center;gap:8px;background:var(--gold);color:#000;font-size:13px;font-weight:700;padding:10px 22px;border-radius:8px;border:none;cursor:pointer;transition:.2s;font-family:'DM Sans';}
  .hero-play:hover{background:#fff;transform:scale(1.04);}
  .vgrid{display:grid;grid-template-columns:repeat(auto-fill,minmax(210px,1fr));gap:16px;}
  .vcard{border-radius:10px;overflow:hidden;cursor:pointer;background:var(--surface);transition:transform .25s,box-shadow .25s;}
  .vcard:hover{transform:translateY(-6px);box-shadow:0 16px 40px rgba(0,0,0,.55);}
  .vcard:hover .voverlay{opacity:1;}.vcard:hover .vthumb{transform:scale(1.06);}
  .thumb-box{position:relative;aspect-ratio:16/9;overflow:hidden;background:var(--surface2);}
  .vthumb{width:100%;height:100%;object-fit:cover;transition:transform .4s;display:block;}
  .voverlay{position:absolute;inset:0;background:rgba(0,0,0,.4);display:flex;align-items:center;justify-content:center;opacity:0;transition:.25s;}
  .play-circle{width:50px;height:50px;border-radius:50%;background:rgba(245,200,66,.95);display:flex;align-items:center;justify-content:center;box-shadow:0 4px 20px rgba(245,200,66,.5);transform:scale(.8);transition:transform .2s;}
  .vcard:hover .play-circle{transform:scale(1);}
  .play-circle::after{content:'▶';margin-left:4px;color:#000;font-size:17px;}
  .vbody{padding:11px 13px 14px;}
  .vtitle{font-size:12px;font-weight:500;line-height:1.45;color:var(--text);display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;margin-bottom:5px;}
  .vmeta{font-size:10px;color:var(--muted);}
  .info-box{grid-column:1/-1;text-align:center;padding:50px 20px;color:var(--muted);font-size:13px;line-height:2.2;}
  #modal{position:fixed;inset:0;z-index:3500;display:none;align-items:center;justify-content:center;background:rgba(0,0,0,.95);backdrop-filter:blur(16px);}
  #modal.open{display:flex;animation:mIn .3s ease;}
  @keyframes mIn{from{opacity:0;}}
  .modal-inner{width:90%;max-width:1060px;animation:mScale .35s cubic-bezier(.34,1.2,.64,1);}
  @keyframes mScale{from{transform:scale(.85);opacity:0;}}
  .modal-hd{display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;}
  .modal-ttl{font-family:'Bebas Neue';font-size:22px;letter-spacing:2px;}
  .modal-x{background:var(--surface);border:1px solid var(--border);color:var(--muted);width:36px;height:36px;border-radius:50%;cursor:pointer;font-size:15px;display:flex;align-items:center;justify-content:center;transition:.2s;}
  .modal-x:hover{background:var(--red);color:#fff;border-color:var(--red);}
  .player-box{aspect-ratio:16/9;border-radius:12px;overflow:hidden;box-shadow:0 30px 80px rgba(0,0,0,.9),0 0 0 1px rgba(245,200,66,.15);}
  .player-box iframe{width:100%;height:100%;display:block;border:none;}
  body.light{--bg:#f0f2f5;--surface:#fff;--surface2:#e8eaed;--text:#1a1c20;--muted:#6b7280;--border:rgba(0,0,0,.08);}
</style>
</head>
<body>
<div id="intro-site">
  <div class="curtain l"></div><div class="curtain r"></div>
  <div class="site-logo">
    <div class="site-pop">🍿<div class="site-eye">👁️</div></div>
    <div class="site-name"><span class="big">Popcorn</span><span class="small">Stream</span></div>
  </div>
  <p class="site-tag">Plateforme éducative · Contenu sélectionné</p>
</div>
<div id="intro-video">
  <div class="iv-curtain l"></div><div class="iv-curtain r"></div>
  <div class="iv-content" id="iv-content">
    <div class="iv-pop">🍿</div>
    <div class="iv-msg">Bon Visionnage</div>
    <div class="iv-sub">Une sélection Popcorn Stream · YouTube</div>
    <div class="iv-bar"><div class="iv-progress" id="iv-progress"></div></div>
  </div>
</div>
<aside id="sidebar">
  <div class="logo">🍿 POPCORN STREAM<sub>ÉDITION ÉCOLE</sub></div>
  <div class="nav-label">Accueil</div>
  <button class="nav-btn active" onclick="go(this,'alune')"><span class="ico">🔥</span> À la une</button>
  <div class="nav-label">Catégories</div>
  <button class="nav-btn" onclick="go(this,'documentaires')"><span class="ico">🌍</span> Documentaires</button>
  <button class="nav-btn" onclick="go(this,'science')"><span class="ico">🔬</span> Science &amp; Nature</button>
  <button class="nav-btn" onclick="go(this,'espace')"><span class="ico">🚀</span> Espace &amp; Univers</button>
  <button class="nav-btn" onclick="go(this,'bandesannonces')"><span class="ico">🎬</span> Bandes-Annonces</button>
  <button class="nav-btn" onclick="go(this,'culture')"><span class="ico">🎓</span> Culture Générale</button>
  <div class="sidebar-foot">
    <button class="theme-btn" id="theme-btn" onclick="toggleTheme()">☀️ Mode Clair</button>
  </div>
</aside>
<header id="topbar">
  <div class="search-box">
    <input type="text" id="search" placeholder="Rechercher une vidéo..." oninput="filterCards(this.value)">
  </div>
</header>
<main id="main">
  <div class="sec-head">
    <h2 class="sec-title" id="sec-title">À LA UNE</h2>
    <span class="sec-count" id="sec-count"></span>
  </div>
  <div id="hero-zone"></div>
  <div class="vgrid" id="grid"></div>
</main>
<div id="modal">
  <div class="modal-inner">
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
%%VIDEOS%%
const LABELS={alune:'À la une',documentaires:'Documentaires',science:'Science & Nature',espace:'Espace & Univers',bandesannonces:'Bandes-Annonces',culture:'Culture Générale'};
function esc(s){return(s||'').replace(/'/g,"\\'").replace(/"/g,'&quot;').replace(/</g,'&lt;');}
function img(id,q,cls,thumb){const src=thumb||`https://img.youtube.com/vi/${id}/${q}.jpg`;return `<img ${cls?`class="${cls}"`:''}src="${src}"alt=""onerror="if(!this.dataset.t){this.dataset.t=1;this.src='https://img.youtube.com/vi/${id}/hqdefault.jpg';}else{this.style.opacity='.1';}">`;}
function renderHero(v){document.getElementById('hero-zone').innerHTML=`<div class="hero"onclick="play('${v.id}','${esc(v.titre)}')">${img(v.id,'maxresdefault','',v.thumb)}<div class="hero-grad"></div><div class="hero-info"><span class="hero-badge">✦ À LA UNE</span><div class="hero-title">${v.titre}</div><button class="hero-play">▶ Regarder</button></div></div>`;}
function renderCards(list){return list.map(v=>`<div class="vcard"onclick="play('${v.id}','${esc(v.titre)}')" ><div class="thumb-box">${img(v.id,'mqdefault','vthumb',v.thumb)}<div class="voverlay"><div class="play-circle"></div></div></div><div class="vbody"><div class="vtitle">${v.titre}</div>${v.date?`<div class="vmeta">${v.date}</div>`:''}</div></div>`).join('');}
function go(btn,cat){document.querySelectorAll('.nav-btn').forEach(b=>b.classList.remove('active'));btn.classList.add('active');show(cat);}
function show(cat){
  document.getElementById('sec-title').textContent=(LABELS[cat]||cat).toUpperCase();
  document.getElementById('hero-zone').innerHTML='';
  const list=VIDEOS[cat]||[];
  if(!list.length){document.getElementById('sec-count').textContent='';document.getElementById('grid').innerHTML='<div class="info-box">Aucune vidéo dans cette catégorie.</div>';return;}
  document.getElementById('sec-count').textContent=list.length+' vidéo'+(list.length>1?'s':'');
  renderHero(list[0]);
  document.getElementById('grid').innerHTML=renderCards(list.slice(1));
}
function play(id,title){
  const iv=document.getElementById('intro-video'),c=document.getElementById('iv-content'),p=document.getElementById('iv-progress');
  const lc=iv.querySelector('.iv-curtain.l'),rc=iv.querySelector('.iv-curtain.r');
  lc.style.cssText='transform:scaleX(1);transition:none;transform-origin:left;';
  rc.style.cssText='transform:scaleX(1);transition:none;transform-origin:right;';
  c.style.cssText='opacity:0;transform:scale(.9);transition:none;';
  p.style.cssText='width:0%;transition:none;background:var(--gold);height:100%;border-radius:2px;';
  iv.classList.add('show');
  setTimeout(()=>{lc.style.cssText='transform:scaleX(0);transition:transform 1.2s cubic-bezier(.77,0,.18,1);transform-origin:left;';rc.style.cssText='transform:scaleX(0);transition:transform 1.2s cubic-bezier(.77,0,.18,1);transform-origin:right;';},80);
  setTimeout(()=>{c.style.cssText='opacity:1;transform:scale(1);transition:opacity .5s,transform .5s cubic-bezier(.34,1.4,.64,1);';},900);
  setTimeout(()=>{p.style.width='100%';p.style.transition='width 1.8s linear';},1000);
  setTimeout(()=>{iv.classList.remove('show');document.getElementById('player').src=`https://www.youtube.com/embed/${id}?autoplay=1&rel=0&modestbranding=1`;document.getElementById('modal-ttl').textContent=title;document.getElementById('modal').classList.add('open');},3000);
}
function closePlayer(){document.getElementById('player').src='';document.getElementById('modal').classList.remove('open');}
document.getElementById('modal').addEventListener('click',e=>{if(e.target.id==='modal')closePlayer();});
document.addEventListener('keydown',e=>{if(e.key==='Escape')closePlayer();});
function filterCards(q){const ql=q.toLowerCase();document.querySelectorAll('.vcard').forEach(c=>{c.style.display=c.querySelector('.vtitle').textContent.toLowerCase().includes(ql)?'':'none';});}
function toggleTheme(){document.body.classList.toggle('light');document.getElementById('theme-btn').textContent=document.body.classList.contains('light')?'🌙 Mode Sombre':'☀️ Mode Clair';}
setTimeout(()=>show('alune'),5200);
</script>
</body>
</html>"""

final = HTML.replace("%%VIDEOS%%", js_videos)
with open("index.html", "w", encoding="utf-8") as f:
    f.write(final)

print(f"\n✅ index.html généré avec succès ! ({today})")
