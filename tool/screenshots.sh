#!/usr/bin/env bash
# Renders the website's screenshots of the app (site/src/assets/screenshots/*.png)
# from widget tests against the demo mailbox, with real fonts: Roboto from the
# Flutter SDK, the Fluent icons, and Noto/DejaVu from /usr/share/fonts
# (Debian/Ubuntu: fonts-noto-core, fonts-noto-color-emoji, fonts-dejavu-core).
#
# Not part of CI (tool/ci/test.sh runs only test/ directories). Extra arguments
# go to `flutter test`, e.g. one shot: tool/screenshots.sh --plain-name inbox
#
# Dates in the shots are relative to the day they are rendered (the demo's
# "now" is today at 16:00). site/src/data/screenshots.json describes them.
set -euo pipefail
cd "$(dirname "$0")/../app"
FLUTTER="${FLUTTER:-$(command -v flutter || echo "$HOME/development/flutter/bin/flutter")}"
"$FLUTTER" test screenshots/ "$@"
