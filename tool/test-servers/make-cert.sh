#!/usr/bin/env bash
# Creates the throwaway self-signed certificate Dovecot uses in data/dovecot-ssl/.
set -euo pipefail
dir="$(cd "$(dirname "$0")" && pwd)/data/dovecot-ssl"
mkdir -p "$dir"
openssl req -x509 -newkey rsa:2048 -nodes -days 365 -subj "/CN=localhost" \
  -keyout "$dir/tls.key" -out "$dir/tls.crt" 2>/dev/null
chmod 644 "$dir/tls.key" "$dir/tls.crt" # test key, readable by the container's vmail user
echo "SHA-256 (for LOUPE_TEST_IMAP_SHA256):"
openssl x509 -in "$dir/tls.crt" -outform der | sha256sum | cut -d' ' -f1
