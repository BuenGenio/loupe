#!/usr/bin/env bash
# Runs the tests of every workspace member that has a test/ directory.
set -euo pipefail
cd "$(dirname "$0")/../.."
status=0
for dir in packages/* app; do
  [ -d "$dir/test" ] || continue
  echo "::group::test $dir"
  if grep -q "sdk: flutter" "$dir/pubspec.yaml"; then
    (cd "$dir" && flutter test --reporter expanded) || status=1
  else
    (cd "$dir" && dart test --reporter expanded) || status=1
  fi
  echo "::endgroup::"
done
exit $status
