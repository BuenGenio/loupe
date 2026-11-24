#!/usr/bin/env bash
# The committed tree is Loupe's Free release type, the one F-Droid builds
# (docs/releasing.md): no non-free dependency, nothing downloaded prebuilt,
# and Flutter at the version CI builds with. Fails with an explanation if not.
#
#   FLUTTER_VERSION=3.47.6 tool/ci/check_free.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
status=0
fail() {
  echo "::error::$*"
  status=1
}

[ ! -e pubspec_overrides.yaml ] ||
  fail "pubspec_overrides.yaml exists: this is a NonFree checkout. Switch back with tool/release_type.sh free."

if grep -nE '^  (_flutterfire_internals|firebase[a-z_]*|google_mobile_ads|google_sign_in[a-z_]*|google_mlkit[a-z_]*):' pubspec.lock; then
  fail "pubspec.lock has the non-free packages above. They belong in nonfree/ (docs/releasing.md)."
fi

if git grep -nE 'com\.google\.(gms|firebase|android\.gms|android\.play)|play-services|google-services' -- \
  '*.gradle' '*.gradle.kts' ':!nonfree/'; then
  fail "Gradle files above name Google's non-free libraries or plugins."
fi

grep -qE '^      source: source$' pubspec.yaml ||
  fail "package:sqlite3 must compile third_party/sqlite3mc (pubspec.yaml hooks), not download a library."

if [ -n "${FLUTTER_VERSION:-}" ]; then
  pinned=$(git ls-files -s .flutter | awk '{print $2}')
  tagged=$(git ls-remote https://github.com/flutter/flutter "refs/tags/$FLUTTER_VERSION" | cut -f1)
  [ -n "$tagged" ] && [ "$pinned" = "$tagged" ] ||
    fail ".flutter is at ${pinned:-nothing}, Flutter $FLUTTER_VERSION at ${tagged:-no such tag}. Keep them the same version (docs/releasing.md)."
fi

[ $status -eq 0 ] && echo "Free release type: OK"
exit $status
