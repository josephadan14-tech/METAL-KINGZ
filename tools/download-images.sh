#!/usr/bin/env bash
# Downloads every project photo the site uses from the Framer CDN into img/,
# so the site no longer depends on Framer. Run from the repository root:
#   bash tools/download-images.sh
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p img
grep -oE '[A-Za-z0-9]{20,32}\.(jpe?g|png|webp)' index.html | sort -u | while read -r f; do
  if [ -s "img/$f" ]; then echo "ok    $f"; continue; fi
  if curl -fsSL "https://framerusercontent.com/images/$f?width=2000" -o "img/$f"; then
    echo "saved $f"
  else
    rm -f "img/$f"; echo "FAIL  $f"
  fi
done
