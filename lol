name: Mise a jour automatique des videos

on:
  schedule:
    - cron: '0 2 * * *'  # Chaque nuit a 2h du matin
  workflow_dispatch:       # Permet de lancer manuellement

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Recuperer les videos et mettre a jour index.html
        run: |
          python3 << 'PYEOF'
          import urllib.request
          import xml.etree.ElementTree as ET
          import re
          import json

          # ============================================================
          # CHAINES YOUTUBE — MODIFIE ICI LES IDs DE CHAINES
          # ============================================================
          # Pour trouver l'ID d'une chaine YouTube :
          # 1. Va sur la chaine YouTube
          # 2. Clique droit sur la page > "Afficher le code source"
          # 3. Cherche "channel_id" ou "externalId"
          # OU utilise : https://commentpicker.com/youtube-channel-id.php
          # ============================================================

          CHAINES = {
              "documentaires":   "UCwI-JbGNsojunnHbFAc0M4Q",  # ARTE
              "science":         "@DrNozman",  # Science Etonnante
              "espace":          "UC5X4e8ScZI2AFd_vkjSoyoQ",  # AstronoGeek
              "bandesannonces":  "@SonyPicturesFr",  # FilmsActu
              "culture":         "UCqnbDFdCpuN8CMEg0VuEBqA",  # Nota Bene
          }

          # ============================================================

          NS = "{http://www.w3.org/2005/Atom}"
          YT = "{http://www.youtube.com/xml/schemas/2015}"

          def get_videos(channel_id, max_videos=10):
              url = f"https://www.youtube.com/feeds/videos.xml?channel_id={channel_id}"
              try:
                  req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
                  with urllib.request.urlopen(req, timeout=10) as r:
                      tree = ET.parse(r)
              except Exception as e:
                  print(f"  Erreur pour {channel_id}: {e}")
                  return []
              root = tree.getroot()
              videos = []
              for entry in root.findall(f"{NS}entry")[:max_videos]:
                  vid_id = entry.find(f"{YT}videoId")
                  title  = entry.find(f"{NS}title")
                  pub    = entry.find(f"{NS}published")
                  if vid_id is not None and title is not None:
                      from datetime import datetime
                      date_str = ""
                      if pub is not None:
                          try:
                              dt = datetime.fromisoformat(pub.text[:10])
                              mois = ["","Jan","Fév","Mar","Avr","Mai","Jun","Jul","Aoû","Sep","Oct","Nov","Déc"]
                              date_str = f"{mois[dt.month]} {dt.year}"
                          except:
                              pass
                      videos.append({"id": vid_id.text, "titre": title.text, "date": date_str})
              return videos

          # Recupere toutes les videos
          resultats = {}
          for cat, channel_id in CHAINES.items():
              print(f"Recuperation : {cat} ({channel_id})")
              videos = get_videos(channel_id)
              print(f"  -> {len(videos)} videos trouvees")
              resultats[cat] = videos

          # Genere le bloc JS a injecter dans index.html
          def videos_to_js(cat, videos):
              if not videos:
                  return f"  // {cat}: aucune video trouvee\n  {cat}: [],"
              lines = [f"  // Mis a jour automatiquement le $(date +%Y-%m-%d)", f"  {cat}: ["]
              for v in videos:
                  titre = v['titre'].replace("'", "\\'").replace('"', '&quot;')
                  lines.append(f'    {{ id:"{v["id"]}", titre:"{titre}", date:"{v["date"]}" }},')
              lines.append("  ],")
              return "\n".join(lines)

          # Lit index.html
          with open("index.html", "r", encoding="utf-8") as f:
              html = f.read()

          # Remplace chaque categorie dans le bloc VIDEOS
          for cat, videos in resultats.items():
              if not videos:
                  continue
              # Pattern : de "documentaires: [" jusqu'au prochain "],"
              pattern = rf'(\s*// [^\n]*\n\s*{cat}:\s*\[)[^\]]*(\],)'
              nouveau = "\n" + videos_to_js(cat, videos) + "\n"
              html_new = re.sub(pattern, nouveau, html, flags=re.DOTALL)
              if html_new != html:
                  html = html_new
                  print(f"  Categorie '{cat}' mise a jour ({len(videos)} videos)")
              else:
                  print(f"  Categorie '{cat}' : pattern non trouve, skip")

          # Sauvegarde
          with open("index.html", "w", encoding="utf-8") as f:
              f.write(html)

          print("index.html mis a jour avec succes !")
          PYEOF

      - name: Commit et push si changements
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add index.html
          git diff --staged --quiet || git commit -m "Mise a jour automatique des videos $(date +%Y-%m-%d)"
          git push
