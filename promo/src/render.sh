#!/usr/bin/env bash
# Renders each promo/src/*.html page to promo/images/mobile-<name>.png at 1080x1920.
set -euo pipefail
cd "$(dirname "$0")"
for page in [0-9]*.html; do
  out="../images/mobile-${page%.html}.png"
  chromium --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --window-size=1080,1920 --virtual-time-budget=2000 \
    --screenshot="$(realpath -m "$out")" "file://$PWD/$page" 2>/dev/null
  echo "rendered $out"
done
