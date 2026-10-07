#!/usr/bin/env bash
# Regenerates test/fixtures/smime/revocation with OpenSSL 3.4 or later: a CA
# whose certificates name an OCSP responder and a CRL, a delegated OCSP
# responder, one without the OCSP signing purpose, users, OCSP responses
# (good, revoked, unknown, signed by the CA itself, by the delegated
# responder, and a forged "good" from the unauthorised one) and a CRL.
# Responses are dated when made and valid for ten years: tests read them a
# little later (revocation_test.dart). Test keys only, thrown away.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
out="$here/smime/revocation"
work="$(mktemp -d "$here/.revocation-work-XXXXXX")"
trap 'rm -rf "$work"' EXIT
cd "$work"
export EMAIL=none

cat > ext.cnf <<'EOF'
[ca]
basicConstraints = critical, CA:TRUE
keyUsage = critical, keyCertSign, cRLSign
subjectKeyIdentifier = hash

[responder]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature
extendedKeyUsage = OCSPSigning
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always

[rogue]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature
extendedKeyUsage = emailProtection
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always

[user]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = emailProtection
subjectAltName = email:${ENV::EMAIL}
authorityInfoAccess = OCSP;URI:http://ocsp.revocation.test/, caIssuers;URI:http://revocation.test/ca.crt
crlDistributionPoints = URI:http://crl.revocation.test/ca.crl
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always

[crl_only]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = emailProtection
subjectAltName = email:${ENV::EMAIL}
crlDistributionPoints = URI:http://crl.revocation.test/ca.crl
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always
EOF

cat > ca.cnf <<'EOF'
[ca]
default_ca = test
[test]
database = index.txt
crlnumber = crlnumber
default_md = sha256
default_crl_days = 3650
crl_extensions = crl_ext
[crl_ext]
authorityKeyIdentifier = keyid:always
EOF

rsa() { openssl genpkey -quiet -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out "$1"; }
ec() { openssl genpkey -quiet -algorithm EC -pkeyopt ec_paramgen_curve:P-256 -out "$1"; }

# issue NAME SUBJECT EMAIL SECTION SERIAL
issue() {
  openssl req -new -key "$1.key" -subj "$2" -out "$1.csr"
  EMAIL="$3" openssl x509 -req -in "$1.csr" -CA ca.crt -CAkey ca.key -set_serial "$5" \
    -extfile ext.cnf -extensions "$4" -not_before 20260101000000Z -not_after 20360101000000Z -sha256 \
    -out "$1.crt" 2>/dev/null
}

rsa ca.key
openssl req -new -key ca.key -subj '/O=Loupe Test/CN=Loupe Revocation Test CA' -out ca.csr
openssl x509 -req -in ca.csr -signkey ca.key -set_serial 1 -extfile ext.cnf -extensions ca \
  -not_before 20250101000000Z -not_after 20450101000000Z -sha256 -out ca.crt 2>/dev/null

ec responder.key
issue responder '/O=Loupe Test/CN=Loupe Test OCSP Responder' x responder 0x0F01
ec rogue.key
issue rogue '/O=Loupe Test/CN=Not A Responder' x rogue 0x0F02
rsa gail.key
issue gail '/O=Loupe Test/CN=Gail Good' gail@revocation.test user 0x1001
rsa rex.key
issue rex '/O=Loupe Test/CN=Rex Revoked' rex@revocation.test user 0x1002
ec cleo.key
issue cleo '/O=Loupe Test/CN=Cleo Crl' cleo@revocation.test crl_only 0x1003
ec nell.key
issue nell '/O=Loupe Test/CN=Nell Unlisted' nell@revocation.test user 0x1004

# The CA's database: Rex revoked (key compromise), Cleo revoked (superseded),
# Gail valid; Nell isn't listed.
touch index.txt
echo 1000 > crlnumber
for c in gail rex cleo; do
  openssl ca -config ca.cnf -cert ca.crt -keyfile ca.key -valid "$c.crt" -notext -batch 2>/dev/null
done
openssl ca -config ca.cnf -cert ca.crt -keyfile ca.key -revoke rex.crt -crl_reason keyCompromise -batch 2>/dev/null
openssl ca -config ca.cnf -cert ca.crt -keyfile ca.key -revoke cleo.crt -crl_reason superseded -batch 2>/dev/null
openssl ca -config ca.cnf -cert ca.crt -keyfile ca.key -gencrl -out ca.crl.pem -batch 2>/dev/null
openssl crl -in ca.crl.pem -outform DER -out ca.crl

# respond USER SIGNER INDEX OUT: an OCSP response for USER from SIGNER.
respond() {
  openssl ocsp -issuer ca.crt -cert "$1.crt" -no_nonce -reqout "$1.req" 2>/dev/null
  openssl ocsp -index "$3" -CA ca.crt -rsigner "$2.crt" -rkey "$2.key" -reqin "$1.req" \
    -respout "$4" -ndays 3650 2>/dev/null
}
respond gail ca index.txt ocsp-good.der
respond rex responder index.txt ocsp-revoked.der
respond nell ca index.txt ocsp-unknown.der
# The unauthorised responder claims Rex is fine.
sed 's/^R\t\([^\t]*\)\t[^\t]*\t/V\t\1\t\t/' index.txt > forged.txt
respond rex rogue forged.txt ocsp-forged.der
cp gail.req ocsp-request-gail.der

# Signed mail from Gail and Rex, as multipart/signed.
printf 'Content-Type: text/plain; charset=utf-8\r\n\r\nSigned with a certificate whose revocation can be checked.\r\n' > body.mime
for c in gail rex; do
  openssl cms -sign -in body.mime -signer "$c.crt" -inkey "$c.key" -md sha256 \
    -from "$c@revocation.test" -to bob@example.net -subject "Signed by $c" -out "signed-$c.eml"
done

mkdir -p "$out"
cp ca.crt responder.crt rogue.crt gail.crt rex.crt cleo.crt nell.crt ca.crl \
  ocsp-good.der ocsp-revoked.der ocsp-unknown.der ocsp-forged.der ocsp-request-gail.der \
  signed-gail.eml signed-rex.eml "$out/"
echo "Wrote $out"
