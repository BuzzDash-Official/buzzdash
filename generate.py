name: Mise a jour videos

on:
  schedule:
    - cron: '0 1 * * *'
  workflow_dispatch:

jobs:
  update:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4
      - name: Mettre a jour les videos
        run: python3 generate.py
      - name: Publier
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add index.html
          git diff --staged --quiet || (git commit -m "Videos mises a jour $(date +%Y-%m-%d)" && git push)
