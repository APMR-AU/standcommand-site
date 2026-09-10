#!/bin/sh
# Derives the web logo, the icon and the share image in assets/ from
# assets/logo-source.png, the render supplied on 2026-09-11. The three outputs
# are never hand-edited: change this script and rerun it. Needs ImageMagick 7
# (magick). Paths are relative to this script, so it runs from anywhere.
set -e
cd "$(dirname "$0")/assets"
SRC=logo-source.png
PAPER='#FDFCFB'   # the render's own paper; lifted to transparency for the hero

# The logo band, paper made transparent, at twice a 360 px display width.
magick "$SRC" -fuzz 12% -trim +repage -bordercolor "$PAPER" -border 8 \
  -fuzz 12% -transparent "$PAPER" -resize 720x -strip \
  -define png:compression-level=9 logo.png

# The SC monogram alone, square on its paper, for the favicon and touch icon.
# The crop stops short of the "15 m" string on the left and the wordmark on
# the right; the trim then closes on the walls.
magick "$SRC" -crop 654x425+100+315 +repage -fuzz 12% -trim +repage \
  -bordercolor "$PAPER" -border 40 -gravity center -background "$PAPER" \
  -extent 780x780 -resize 192x192 -strip icon.png

# The logo band on its paper at 1200x630, for link previews (og:image).
magick "$SRC" -crop 1402x736+0+137 +repage -resize 1200x630^ -gravity center \
  -extent 1200x630 -strip -quality 85 share.jpg

magick identify -format '%f %wx%h %b\n' logo.png icon.png share.jpg
