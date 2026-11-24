#!/usr/bin/env bash
# Switches this checkout between Loupe's two release types (docs/releasing.md):
#
#   tool/release_type.sh free      the committed state: no Google code
#   tool/release_type.sh nonfree   adds Push through Firebase (nonfree/push)
#
# NonFree writes pubspec_overrides.yaml (git-ignored), which swaps
# packages/push for nonfree/push, and resolves; Free removes it again. Build
# as usual afterwards. A NonFree checkout changes pubspec.lock: switch back
# before committing.
set -euo pipefail
cd "$(dirname "$0")/.."
marker='# Written by tool/release_type.sh nonfree.'

case "${1:-}" in
  nonfree)
    if [ -e pubspec_overrides.yaml ] && ! grep -qF "$marker" pubspec_overrides.yaml; then
      echo "pubspec_overrides.yaml exists and isn't ours; move it away first." >&2
      exit 1
    fi
    {
      echo "$marker Remove with: tool/release_type.sh free"
      # This file's overrides replace the workspace's own, so repeat them.
      echo 'dependency_overrides:'
      awk '/^dependency_overrides:/{on=1; next} on && /^[^ #]/{on=0} on && /^  [a-z_]+:/' pubspec.yaml
      echo '  loupe_push: {path: nonfree/push}'
    } > pubspec_overrides.yaml
    ;;
  free)
    if [ -e pubspec_overrides.yaml ]; then
      grep -qF "$marker" pubspec_overrides.yaml || { echo "pubspec_overrides.yaml isn't ours; leaving it." >&2; exit 1; }
      rm pubspec_overrides.yaml
    fi
    ;;
  *)
    echo "usage: $0 free|nonfree" >&2
    exit 2
    ;;
esac
flutter pub get
