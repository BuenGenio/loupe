#!/usr/bin/env bash
# Prepares release <version> (docs/releasing.md): sets app/pubspec.yaml's
# version, with the next build number when the version is new, and writes the
# release notes F-Droid shows, one file per APK version code
# (fastlane/metadata/android/en-US/changelogs/<code>.txt), from <notes file>:
# plain text, 500 characters at most.
#
#   tool/release_prepare.sh 0.2.0 notes.txt
#
# Then commit, merge, and tag the merge commit v<version>: the Release
# workflow builds and publishes it.
set -euo pipefail
[ $# -eq 2 ] || { echo "usage: $0 <version> <notes file>" >&2; exit 2; }
version=$1
notes=$(realpath "$2")
[[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "Version must look like 1.2.3, not $version" >&2; exit 2; }
cd "$(dirname "$0")/.."

current=$(sed -n 's/^version: //p' app/pubspec.yaml)
name=${current%%+*}
code=${current##*+}
[ "$name" = "$version" ] || code=$((code + 1))

length=$(tr -d '\n' < "$notes" | wc -m)
[ "$length" -le 500 ] || { echo "The notes are $length characters; F-Droid takes 500 at most." >&2; exit 1; }

sed -i "s/^version: .*/version: $version+$code/" app/pubspec.yaml
dir=fastlane/metadata/android/en-US/changelogs
mkdir -p "$dir"
# One per APK: ten times the build number, plus 1 (armeabi-v7a), 2 (arm64-v8a)
# or 4 (x86_64), as app/android/app/build.gradle.kts numbers them.
for abi in 1 2 4; do
  cp "$notes" "$dir/$((code * 10 + abi)).txt"
done
echo "Loupe $version, build $code: app/pubspec.yaml and $dir/{$((code * 10 + 1)),$((code * 10 + 2)),$((code * 10 + 4))}.txt."
echo "Next: commit, merge, then tag the merge commit: git tag v$version && git push origin v$version"
