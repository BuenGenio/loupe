#!/usr/bin/env bash
# Replaces third_party/sqlite3mc with another SQLite3 Multiple Ciphers release
# (see third_party/sqlite3mc/README.md).
#
#   tool/update_sqlite3mc.sh <sqlite3mc version> <SQLite version> <zip sha256>
set -euo pipefail
[ $# -eq 3 ] || { echo "usage: $0 <sqlite3mc version> <SQLite version> <zip sha256>" >&2; exit 2; }
mc=$1 sqlite=$2 sha=$3
cd "$(dirname "$0")/.."
zip="sqlite3mc-$mc-sqlite-$sqlite-amalgamation.zip"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
curl -fsSL -o "$tmp/$zip" "https://github.com/utelle/SQLite3MultipleCiphers/releases/download/v$mc/$zip"
echo "$sha  $tmp/$zip" | sha256sum -c -
unzip -q "$tmp/$zip" -d "$tmp/x"
cp "$tmp/x/sqlite3mc_amalgamation.c" "$tmp/x/sqlite3mc_amalgamation.h" third_party/sqlite3mc/
curl -fsSL -o third_party/sqlite3mc/LICENSE "https://raw.githubusercontent.com/utelle/SQLite3MultipleCiphers/v$mc/LICENSE"
echo "Updated to sqlite3mc $mc (SQLite $sqlite). Now edit the version, file name and sha256 in third_party/sqlite3mc/README.md."
