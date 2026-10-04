#!/usr/bin/env bash
# Appends sample messages for manual testing (the integration tests seed
# their own). Usage: seed.sh [imap-url] [user] [password] [count]
# Default: GreenMail, imap://127.0.0.1:3143/INBOX as alice@example.test.
set -euo pipefail
url="${1:-imap://127.0.0.1:3143/INBOX}"
user="${2:-alice@example.test}"
pass="${3:-secret}"
count="${4:-20}"
data="$(cd "$(dirname "$0")" && pwd)/data"
mkdir -p "$data"
msg="$data/seed.eml"
for i in $(seq 1 "$count"); do
  printf 'From: Seeder <seed@example.test>\r\nTo: %s\r\nSubject: Sample %d\r\nDate: %s\r\nMessage-ID: <sample-%d-%s@example.test>\r\nMIME-Version: 1.0\r\nContent-Type: text/plain; charset=utf-8\r\n\r\nSample message number %d.\r\n' \
    "$user" "$i" "$(date -R)" "$i" "$RANDOM$RANDOM" "$i" >"$msg"
  # --insecure: the test servers use self-signed certificates.
  curl -sS --insecure --url "$url" --user "$user:$pass" -T "$msg"
done
rm -f "$msg"
echo "Appended $count messages to $url"
