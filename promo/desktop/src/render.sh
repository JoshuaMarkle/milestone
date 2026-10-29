#!/usr/bin/env bash
# Renders each promo/desktop/src/*.html page to promo/images/desktop-<name>.png at 1920x1080.
set -euo pipefail
cd "$(dirname "$0")"
for page in [0-9]*.html; do
  out="../../images/desktop-${page%.html}.png"
  chromium --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --window-size=1920,1080 --virtual-time-budget=2000 \
    --screenshot="$(realpath -m "$out")" "file://$PWD/$page" 2>/dev/null
  echo "rendered $out"
done
