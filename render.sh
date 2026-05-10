#!/usr/bin/env bash
# Render uno o varios STL desde llavero.scad
# Uso:
#   ./render.sh "LORETO" "DIEGO" "AVIOT" ...
set -e
OPENSCAD="${OPENSCAD:-/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD}"
mkdir -p stl
for word in "$@"; do
  out="stl/${word}.stl"
  echo "→ Rendering $word → $out"
  "$OPENSCAD" -o "$out" -D "TEXT=\"$word\"" llavero.scad
  echo "  $(du -h "$out" | cut -f1)"
done
echo "Done. STLs en stl/"
