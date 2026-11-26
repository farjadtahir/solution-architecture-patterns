#!/usr/bin/env bash
# Renders every .mmd file in assets/diagrams to SVG and PNG using Mermaid CLI.
#
# Usage: scripts/render-diagrams.sh
# Requires: Node.js, and either a global `mmdc` or network access for npx.
# Optional: set PUPPETEER_CONFIG to a JSON file if Chrome needs custom flags,
# for example {"args": ["--no-sandbox"]} in a container.

set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dir="$root/assets/diagrams"

if command -v mmdc >/dev/null 2>&1; then
  mmdc_cmd=(mmdc)
else
  mmdc_cmd=(npx --yes @mermaid-js/mermaid-cli)
fi

extra=()
if [[ -n "${PUPPETEER_CONFIG:-}" ]]; then
  extra=(-p "$PUPPETEER_CONFIG")
fi

shopt -s nullglob
for src in "$dir"/*.mmd; do
  base="${src%.mmd}"
  echo "Rendering $(basename "$src")"
  "${mmdc_cmd[@]}" "${extra[@]}" -i "$src" -o "$base.svg" -b white
  "${mmdc_cmd[@]}" "${extra[@]}" -i "$src" -o "$base.png" -b white -s 2
done

echo "Done. Output is in $dir"
