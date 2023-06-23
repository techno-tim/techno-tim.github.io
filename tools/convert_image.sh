#!/usr/bin/env bash
# you'll need webp installed
for file in images/*; do cwebp "$file" -o "${file%.*}.webp"; done


# conver single
cwebp images/flower.jpg -o images/flower.webp
