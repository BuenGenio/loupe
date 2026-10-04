# Thunderbird "Export for Mobile" QR codes

Thunderbird desktop (Tools › Export for Mobile…, also in the ≡ menu and in Settings) shows one or more QR codes. Thunderbird for Android imports them, and so does Loupe. This is a summary of format version 1. Our reader is our own Dart code, written from the format description: `app/lib/features/account_import/thunderbird_qr.dart`.

## Sources

- The format specification, kept with Thunderbird for Android (Apache-2.0): [`feature/migration/qrcode/qr-code-format.md`](https://github.com/thunderbird/thunderbird-android/blob/833ae0325e7f7065fa08740b6e18d520b9a40d76/feature/migration/qrcode/qr-code-format.md) (version 1, 2025-02-06).
- The writer in Thunderbird desktop (MPL-2.0): [`mail/modules/QRExport.sys.mjs`](https://searchfox.org/comm-central/source/mail/modules/QRExport.sys.mjs) ([mirror](https://github.com/mozilla/releases-comm-central/blob/33781a82b24d00a8ef618693117b81b0e992f272/mail/modules/QRExport.sys.mjs)). The UI is `mail/components/preferences/qrExport.mjs` and `qr-code-wizard.mjs`.
- Thunderbird for Android's reader: [`feature/migration/qrcode`](https://github.com/thunderbird/thunderbird-android/tree/main/feature/migration/qrcode) (`QrCodePayloadAdapter`, `QrCodePayloadValidator`, `QrCodeScannerViewModel`).

## Encoding

- The payload is JSON text encoded as UTF-8, in a byte-mode QR code with error correction level L and no ECI header. Some scanners decode such bytes as Latin-1; Loupe repairs that (`normalizeScannedText`).
- Every object is a JSON array, which keeps codes small. Readers must ignore extra elements at the end of any array (forward compatibility); writers only add elements in a new version of the format.
- Thunderbird puts at most **3 accounts in one code** and warns when a code's JSON is longer than **800 characters**. A version 40 code can't hold more than 2,953 bytes, so Loupe rejects payloads over 4,096 characters.

## Structure

```
[FormatVersion, [SequenceNumber, SequenceEnd], IncomingServer, OutgoingServerGroups, IncomingServer, OutgoingServerGroups, …]
```

| Element | Type | Notes |
|---|---|---|
| `FormatVersion` | int | `1`. Any other value: fail (Loupe says "comes from a newer Thunderbird" for higher values). |
| `SequenceNumber`, `SequenceEnd` | int | Part *i* of *n*, 1-based. Codes can be scanned in any order; there is no export id, so a code whose `SequenceEnd` differs from the codes scanned so far means the user started a new export. |
| `IncomingServer` | array | `[IncomingProtocol, Hostname, Port, ConnectionSecurity, AuthenticationType, Username, AccountName?, Password?]` |
| `OutgoingServerGroups` | array | One or more `[OutgoingServer, Identity, Identity…]`. Thunderbird writes one group: the default identity's SMTP server and the identities that use it. |
| `OutgoingServer` | array | `[OutgoingProtocol, Hostname, Port, ConnectionSecurity, AuthenticationType, Username, Password?]` |
| `Identity` | array | `[EmailAddress, DisplayName]` |

An account is an `IncomingServer` and the `OutgoingServerGroups` right after it. One account never spans two codes.

### Values

| Field | Values |
|---|---|
| `IncomingProtocol` | 0 IMAP, 1 POP3 |
| `OutgoingProtocol` | 0 SMTP |
| `ConnectionSecurity` | 0 plain, 1 reserved (old "STARTTLS when available"), 2 STARTTLS, 3 TLS |
| `AuthenticationType` | 0 none, 1 password (cleartext), 2 password (encrypted, CRAM-MD5), 3 GSSAPI (Kerberos), 4 NTLM, 5 TLS client certificate, 6 OAuth2 |
| `Port` | 1–65535 |
| `Hostname` | ASCII only: IDNs in their `xn--` form, or an IP address |
| `EmailAddress` | ASCII only |
| `AccountName` | Optional. Missing, `null` or `""`: use the first readable identity's address. Thunderbird writes the account's name (by default its address). |
| `Password` | Optional. Missing, `null` or `""`: no password. Thunderbird writes `""` unless the user ticked "Include account passwords", and always `""` for OAuth accounts (tokens are never exported). |

Thunderbird only offers accounts with IMAP or POP3 and SMTP, an ASCII address, and an authentication method other than GSSAPI, NTLM or client certificate.

### Errors

- A broken root (not an array, wrong version, bad sequence, an incoming server without its groups) makes the whole code unreadable.
- An unsupported or invalid value in an `IncomingServer`: skip the account.
- In an `OutgoingServer`, or when no identity can be read: skip that group. An account without a readable group is skipped.
- An invalid `Identity`: skip the identity.
- Readers must validate every value, including ones they don't use, so that one reader doesn't accept codes another rejects.

## What Loupe does with it

- **Validation.** Types, ranges and lengths of every value; hostnames (labels, IPv4 ranges, IPv6), addresses (dot-atom local part, hostname domain); control characters, Unicode line separators and bidirectional overrides in text; line breaks and NUL in passwords. Caps: 50 codes per export, 20 accounts per code, 10 groups, 20 identities per group, 256 characters of text, 1,024 of password.
- **Security.** Value 1 maps to STARTTLS, never to plain text. Plain connections need the same confirmation as manual setup.
- **Mapping to `AccountSetup`.** The provider comes from the incoming hostname (Gmail, Microsoft, iCloud, Yahoo/AOL, Fastmail). A username equal to the address becomes "use the address". An account name equal to the address becomes Loupe's default description ("Gmail", "Example").
- **One SMTP server, one password.** Loupe uses the first readable group and the incoming password, or the outgoing one when only that was exported. Identities after the first are added to the account after it is created.
- **Not supported yet.** POP3, Kerberos, NTLM and client certificates are listed but can't be selected. OAuth accounts ask for an app password; Microsoft OAuth accounts wait for Microsoft sign-in.
- **Privacy.** Passwords never reach logs, exception messages, `toString()` or navigation arguments. Scanned codes live in the import screen's state and are dropped when it closes.
