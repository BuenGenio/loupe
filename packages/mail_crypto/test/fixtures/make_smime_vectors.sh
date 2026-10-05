#!/usr/bin/env bash
# Regenerates test/fixtures/smime with OpenSSL 3.4 or later: a test CA with
# an intermediate, user certificates, PKCS#12 files and S/MIME messages.
# Test keys only; the work directory is a throwaway one next to this script.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
out="$here/smime"
work="$(mktemp -d "$here/.smime-work-XXXXXX")"
trap 'rm -rf "$work"' EXIT
cd "$work"
# ext.cnf reads the address of the certificate being issued from $EMAIL.
export EMAIL=none

cat > ext.cnf <<'EOF'
[root]
basicConstraints = critical, CA:TRUE
keyUsage = critical, keyCertSign, cRLSign
subjectKeyIdentifier = hash

[intermediate]
basicConstraints = critical, CA:TRUE, pathlen:0
keyUsage = critical, keyCertSign, cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always

[constrained]
basicConstraints = critical, CA:TRUE, pathlen:0
keyUsage = critical, keyCertSign, cRLSign
nameConstraints = critical, permitted;email:example.org
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always

[rsa_user]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = emailProtection
subjectAltName = email:${ENV::EMAIL}
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always

[ec_user]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature, keyAgreement
extendedKeyUsage = emailProtection
subjectAltName = email:${ENV::EMAIL}
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always

[sign_only]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature
extendedKeyUsage = emailProtection
subjectAltName = email:${ENV::EMAIL}
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always

[tls_only]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = email:${ENV::EMAIL}
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always
EOF

rsa() { openssl genpkey -quiet -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out "$1"; }
ec() { openssl genpkey -quiet -algorithm EC -pkeyopt ec_paramgen_curve:P-256 -out "$1"; }

# issue NAME SUBJECT EMAIL SECTION CA SERIAL FROM TO
issue() {
  openssl req -new -key "$1.key" -subj "$2" -out "$1.csr"
  EMAIL="$3" openssl x509 -req -in "$1.csr" -CA "$5.crt" -CAkey "$5.key" -set_serial "$6" \
    -extfile ext.cnf -extensions "$4" -not_before "$7" -not_after "$8" -sha256 -out "$1.crt" 2>/dev/null
}

# The test root and its intermediate ("Loupe Test Mail CA").
rsa root.key
openssl req -new -key root.key -subj '/O=Loupe Test/CN=Loupe Test Root CA' -out root.csr
openssl x509 -req -in root.csr -signkey root.key -set_serial 1 -extfile ext.cnf -extensions root \
  -not_before 20190101000000Z -not_after 20500101000000Z -sha256 -out root.crt 2>/dev/null
rsa intermediate.key
issue intermediate '/O=Loupe Test/CN=Loupe Test Mail CA' x intermediate root 2 20190601000000Z 20450101000000Z

# Users: Alice (RSA), Bob (EC P-256), Carol (expired), Dave (signing only),
# Erin (a TLS certificate, not for mail).
rsa alice.key
issue alice '/O=Loupe Test/CN=Alice Example/emailAddress=alice@example.org' alice@example.org rsa_user intermediate 100 20260101000000Z 20360101000000Z
ec bob.key
issue bob '/O=Loupe Test/CN=Bob Example' bob@example.net ec_user intermediate 101 20260101000000Z 20360101000000Z
rsa carol.key
issue carol '/O=Loupe Test/CN=Carol Expired' carol@example.org rsa_user intermediate 102 20200101000000Z 20210101000000Z
rsa dave.key
issue dave '/O=Loupe Test/CN=Dave Signonly' dave@example.org sign_only intermediate 103 20260101000000Z 20360101000000Z
rsa erin.key
issue erin '/O=Loupe Test/CN=Erin Tls' erin@example.org tls_only intermediate 104 20260101000000Z 20360101000000Z

# Frank: "issued" by Alice, who isn't a CA. Gina and Hank: from a CA
# limited to example.org addresses (name constraints).
rsa frank.key
issue frank '/CN=Frank Fake' frank@example.org rsa_user alice 200 20260101000000Z 20360101000000Z
rsa constrained.key
issue constrained '/O=Loupe Test/CN=Loupe Test Example.org CA' x constrained root 3 20250101000000Z 20450101000000Z
rsa gina.key
issue gina '/CN=Gina Outside' gina@example.net rsa_user constrained 300 20260101000000Z 20360101000000Z
rsa hank.key
issue hank '/CN=Hank Inside' hank@example.org rsa_user constrained 301 20260101000000Z 20360101000000Z

# Mallory: a certificate from a CA nobody trusts.
rsa evil.key
openssl req -new -key evil.key -subj '/O=Evil/CN=Evil Root CA' -out evil.csr
openssl x509 -req -in evil.csr -signkey evil.key -set_serial 1 -extfile ext.cnf -extensions root \
  -not_before 20250101000000Z -not_after 20500101000000Z -sha256 -out evil.crt 2>/dev/null
rsa mallory.key
issue mallory '/CN=Mallory/emailAddress=alice@example.org' alice@example.org rsa_user evil 7 20260101000000Z 20360101000000Z

# PKCS#12: OpenSSL 3 defaults (PBES2, AES-256-CBC, PBKDF2, HMAC-SHA256),
# the legacy algorithms (RC2-40 for certificates, 3DES for the key, SHA-1
# MAC) as older Windows exports, 3DES throughout, and PBMAC1.
cat intermediate.crt root.crt > chain.pem
openssl pkcs12 -export -inkey alice.key -in alice.crt -certfile chain.pem -name 'Alice Example' \
  -passout pass:alice-pass -out alice.p12
openssl pkcs12 -export -legacy -inkey alice.key -in alice.crt -certfile chain.pem -name 'Alice Example' \
  -passout pass:alice-pass -out alice-legacy.p12
openssl pkcs12 -export -inkey bob.key -in bob.crt -certfile intermediate.crt -name 'Bob Example' \
  -keypbe PBE-SHA1-3DES -certpbe PBE-SHA1-3DES -macalg sha1 -passout pass:bob-pass -out bob-3des.p12
openssl pkcs12 -export -inkey bob.key -in bob.crt -name 'Bob Example' -pbmac1_pbkdf2 \
  -passout pass:bob-pass -out bob-pbmac1.p12
openssl pkcs12 -export -inkey dave.key -in dave.crt -passout pass: -out dave-nopass.p12
# Alice's file with a CA that didn't issue her certificate added: only the
# root her certificate chains to may be offered for trust.
cat intermediate.crt root.crt evil.crt > chain-evil.pem
openssl pkcs12 -export -inkey alice.key -in alice.crt -certfile chain-evil.pem -name 'Alice Example' \
  -passout pass:alice-pass -out alice-extra-ca.p12

# Messages.
printf 'Content-Type: text/plain; charset=utf-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\nHello Bob,\r\n\r\nThis message is signed with S/MIME. Gr=C3=BC=C3=9Fe!\r\n\r\nAlice\r\n' > inner.mime
headers=(-from 'Alice Example <alice@example.org>' -to 'Bob Example <bob@example.net>')

openssl cms -sign -in inner.mime -signer alice.crt -inkey alice.key -certfile intermediate.crt \
  "${headers[@]}" -subject 'Signed (detached)' -out signed-detached.eml
openssl cms -sign -nodetach -md sha384 -in inner.mime -signer bob.crt -inkey bob.key -certfile intermediate.crt \
  -from 'Bob Example <bob@example.net>' -to 'Alice Example <alice@example.org>' -subject 'Signed (opaque)' \
  -out signed-opaque.eml
openssl cms -sign -in inner.mime -signer carol.crt -inkey carol.key -certfile intermediate.crt \
  -from 'Carol Expired <carol@example.org>' -to 'Bob Example <bob@example.net>' -subject 'Expired' \
  -out signed-expired.eml
openssl cms -sign -in inner.mime -signer mallory.crt -inkey mallory.key -certfile evil.crt \
  "${headers[@]}" -subject 'Untrusted' -out signed-untrusted.eml
openssl cms -sign -noattr -in inner.mime -signer alice.crt -inkey alice.key \
  "${headers[@]}" -subject 'No attributes' -out signed-noattr.eml
# Modified on the way: one letter of the signed text changed.
sed 's/signed with S\/MIME/signed with S\/MIMX/' signed-detached.eml > signed-modified.eml

openssl cms -encrypt -aes256 -in inner.mime "${headers[@]}" -subject 'Encrypted to Alice' \
  -out enveloped-rsa.eml alice.crt
openssl cms -encrypt -aes128 -in inner.mime "${headers[@]}" -subject 'Encrypted to Bob' \
  -recip bob.crt -keyopt ecdh_kdf_md:sha256 -out enveloped-ec.eml
openssl cms -encrypt -aes256 -in inner.mime "${headers[@]}" -subject 'Encrypted to Bob (SHA-1 KDF)' \
  -recip bob.crt -out enveloped-ec-sha1kdf.eml
openssl cms -encrypt -aes-256-gcm -in inner.mime "${headers[@]}" -subject 'AuthEnveloped' \
  -out authenveloped.eml alice.crt bob.crt
openssl cms -encrypt -des3 -in inner.mime "${headers[@]}" -subject '3DES' -out enveloped-3des.eml alice.crt
openssl cms -encrypt -aes256 -in inner.mime "${headers[@]}" -subject 'OAEP' \
  -recip alice.crt -keyopt rsa_padding_mode:oaep -out enveloped-oaep.eml
openssl cms -encrypt -aes256 -stream -in inner.mime "${headers[@]}" -subject 'Streamed' \
  -out enveloped-stream.eml alice.crt
openssl cms -encrypt -aes256 -in inner.mime "${headers[@]}" -subject 'For Carol' -out enveloped-other.eml carol.crt

# Signed, then encrypted: multipart/signed inside (as Thunderbird) and
# opaque signed-data inside (as Outlook).
openssl cms -sign -in inner.mime -signer alice.crt -inkey alice.key -certfile intermediate.crt -out inner-signed.mime
openssl cms -encrypt -aes256 -in inner-signed.mime "${headers[@]}" -subject 'Signed and encrypted' \
  -out signed-enveloped.eml bob.crt alice.crt
openssl cms -sign -nodetach -in inner.mime -signer alice.crt -inkey alice.key -certfile intermediate.crt \
  -out inner-opaque.mime
openssl cms -encrypt -aes256 -in inner-opaque.mime "${headers[@]}" -subject 'Opaque signed and encrypted' \
  -out opaque-enveloped.eml bob.crt

rm -rf "$out"
mkdir -p "$out"
cp root.crt intermediate.crt evil.crt constrained.crt "$out/"
for u in alice bob carol dave erin frank gina hank mallory; do cp "$u.crt" "$out/"; done
cp alice.key bob.key "$out/"
cp ./*.p12 ./*.eml "$out/"
echo "Wrote $(ls "$out" | wc -l) files to $out"
