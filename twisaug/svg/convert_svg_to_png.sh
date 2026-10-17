#!/bin/sh

HEIGHT=256

for file in *.svg; do
  [ -f "$file" ] || break
  filename="${file%.*}"
  rsvg-convert -h $HEIGHT $file > $filename.png
done
