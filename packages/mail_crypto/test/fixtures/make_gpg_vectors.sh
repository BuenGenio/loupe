#!/usr/bin/env bash
# Regenerates test/fixtures/gpg with a throwaway GNUPGHOME (never the user's keyring).
set -euo pipefail
cd "$(dirname "$0")"
export GNUPGHOME=$(mktemp -d "${TMPDIR:-/tmp}/loupe-gpg-XXXXXX")
trap 'gpgconf --kill all; rm -rf "$GNUPGHOME"' EXIT
q=(--batch --pinentry-mode loopback)
gpg "${q[@]}" --passphrase alice-pass --quick-gen-key 'Alice Example <alice@example.org>' ed25519 sign,cert never
afpr=$(gpg --list-keys --with-colons alice@example.org | awk -F: '/^fpr/{print $10; exit}')
gpg "${q[@]}" --passphrase alice-pass --quick-add-key "$afpr" cv25519 encr never
gpg "${q[@]}" --passphrase bob-pass --quick-gen-key 'Bob Example <bob@example.org>' rsa3072 sign,cert never
bfpr=$(gpg --list-keys --with-colons bob@example.org | awk -F: '/^fpr/{print $10; exit}')
gpg "${q[@]}" --passphrase bob-pass --quick-add-key "$bfpr" rsa3072 encr never
mkdir -p gpg && cd gpg
gpg --armor --export alice@example.org > alice.pub.asc
gpg "${q[@]}" --passphrase alice-pass --armor --export-secret-keys alice@example.org > alice.sec.asc
gpg --armor --export bob@example.org > bob.pub.asc
gpg "${q[@]}" --passphrase bob-pass --armor --export-secret-keys bob@example.org > bob.sec.asc
printf 'Content-Type: text/plain; charset=utf-8\r\n\r\nHello from gpg, Gr\xc3\xbc\xc3\x9fe!\r\n' > inner.txt
gpg "${q[@]}" --passphrase bob-pass --armor -u bob@example.org --sign --encrypt -r alice@example.org -o bob_to_alice.asc inner.txt
gpg "${q[@]}" --passphrase alice-pass --armor -u alice@example.org --detach-sign -o inner.sig inner.txt
gpg "${q[@]}" --passphrase alice-pass --armor -u alice@example.org --sign --encrypt -r bob@example.org -r alice@example.org -o alice_to_bob.asc inner.txt
gpg "${q[@]}" --passphrase bob-pass -u bob@example.org --clearsign -o clear.asc inner.txt
