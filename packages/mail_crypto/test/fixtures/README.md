# OpenPGP test vectors

- `thunderbird/`: keys and messages from Thunderbird's own OpenPGP tests
  (comm-central `mail/test/browser/openpgp/data`, MPL-2.0, at
  releases-comm-central 82e7d9cf). The messages were written by Thunderbird
  (RNP); Alice and Bob are the sample keys of draft-bre-openpgp-samples.
- `gpg/`: made with GnuPG 2.4.8 by `make_gpg_vectors.sh` in a throwaway
  `GNUPGHOME`. Alice: Ed25519/Curve25519, passphrase `alice-pass`. Bob:
  RSA 3072, passphrase `bob-pass`. Test keys only.
- `gpg/leading-zero-*.sig`: Ed25519 signatures by gpg Alice whose R (or S)
  has a leading zero octet, so its MPI is 31 octets: upstream dart_pg 2.1.0
  rejected these (see third_party/dart_pg/CHANGELOG.md).
- `smime/`: made with OpenSSL 3.5 by `make_smime_vectors.sh`: a test root
  and intermediate CA ("Loupe Test Mail CA"), user certificates (Alice RSA,
  Bob EC P-256, Carol expired, Dave signing only, Erin a TLS certificate,
  Frank issued by a non-CA, Gina and Hank under a name-constrained CA,
  Mallory from an untrusted CA), PKCS #12 files (`alice.p12`,
  `alice-legacy.p12` and `alice-extra-ca.p12`, which also carries the Evil
  Root CA: password `alice-pass`; `bob-*.p12`: `bob-pass`;
  `dave-nopass.p12`: empty) and messages signed and encrypted by
  `openssl cms`. Test keys only.
- `thunderbird-smime/`: a subset of Thunderbird's S/MIME test data
  (comm-central `mailnews/test/data/smime`, MPL-2.0, at 829a39b523f0),
  made by NSS's test suite: the NSS test CA, Alice, Bob and Dave (`.p12`
  password `nss`, valid until 2031-07-08) and messages signed, encrypted
  and nested the ways Thunderbird writes and reads them.
  `thunderbird_test.dart` checks Thunderbird's expectations for them
  (`mailnews/mime/test/unit/test_smime_decrypt.js`).
- `smime/revocation/`: made with OpenSSL 3.5 by `make_revocation_vectors.sh`
  on 2026-10-07: the Loupe Revocation Test CA, its delegated OCSP responder
  and a certificate without the OCSP signing purpose, users whose
  certificates name an OCSP responder and a CRL (Gail, good; Rex, revoked
  for key compromise; Nell, unknown to the CA) or only a CRL (Cleo,
  revoked), OCSP responses (good from the CA, revoked from the responder,
  unknown, and a forged "good" from the unauthorised certificate), the CA's
  CRL, and messages signed by Gail and Rex. The responses are valid for ten
  years from when they were made. Test keys only, thrown away.
