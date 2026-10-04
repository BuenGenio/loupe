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
