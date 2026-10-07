import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';

import 'demo_data.dart';

/// S/MIME in the demo: the Northwind demo CA (trusted, as a company's own
/// CA would be), Sam's certificate with its key, and three messages in the
/// work inbox, so the header's states can be seen without real
/// certificates: Aisha's signed one ("Signed by Aisha Karimi ✓"), her
/// signed and encrypted one with a protected subject ("Encrypted (S/MIME)"),
/// and Hana's, whose certificate the CA revoked after her laptop was stolen:
/// "Signed by Hana Sato ✓" until Check Certificate Revocation Online is on,
/// then "certificate revoked". The demo answers revocation from responses
/// made with the demo CA ([DemoRevocationFetcher]); it never goes online.
///
/// The messages are written by the S/MIME composer Loupe sends with, when
/// first opened, dated like the demo mailbox around them. Throwaway keys made
/// for the demo with OpenSSL (EC P-256, valid 2025 to 2045, OCSP answers until
/// 2036); never use them for anything else.
extension DemoSmimeCases on DemoSeed {
  void smimeCases() {
    const me = DemoPeople.work;
    add(
      account: DemoAccounts.work,
      box: 'INBOX',
      at: at(2, 10, 18),
      from: DemoPeople.aisha,
      to: const [me],
      subject: 'Q4 budget, signed off',
      text: _aishaText,
      raw: (summary) => _write(
        from: _aisha,
        summary: summary,
        subject: 'Q4 budget, signed off',
        text: _aishaText,
        security: const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime),
      ),
    );
    add(
      account: DemoAccounts.work,
      box: 'INBOX',
      at: at(1, 16, 2),
      from: DemoPeople.aisha,
      to: const [me],
      subject: '...',
      text: '',
      encrypted: true,
      raw: (summary) => _write(
        from: _aisha,
        summary: summary,
        subject: 'Salary review dates (confidential)',
        text:
            'Hi Sam,\n\nThe salary reviews are on 2 and 3 December. Your slot is Tuesday at 10:00 with me and Ben.\n\n'
            'This one is encrypted with our company certificates, so only you and I can read it.\n\nAisha',
        security: const OutgoingSecurity(sign: true, encrypt: true, technology: SecurityTechnology.smime),
      ),
    );
    add(
      account: DemoAccounts.work,
      box: 'INBOX',
      at: at(1, 11, 37),
      from: DemoPeople.hana,
      to: const [me],
      subject: 'New bank details for the Fabrikam invoice',
      text: _hanaText,
      raw: (summary) => _write(
        from: _hana,
        summary: summary,
        subject: 'New bank details for the Fabrikam invoice',
        text: _hanaText,
        security: const OutgoingSecurity(sign: true, technology: SecurityTechnology.smime),
      ),
    );
  }

  static const _aishaText =
      'Sam,\n\nI signed off the Q4 budget this morning: the numbers you sent on Monday, unchanged. I sign my mail '
      'with my Northwind certificate, so you can tell it is really me.\n\nAisha';

  static const _hanaText =
      'Hi Sam,\n\nFabrikam changed banks. Please pay their invoice to the new account below today, before the old '
      'one closes:\n\nIBAN GB00 DEMO 0000 0000 0000 00\n\nThanks,\nHana';
}

/// Sam's certificate and key, and the demo CA trusted, in the demo's S/MIME store.
Future<void> seedDemoSmime(SmimeStore store) async {
  if (store.state.hasOwnCertificates) return;
  await store.addOwn(SmimeKeyPair(_sam.certificate, _sam.key), chain: [demoSmimeCa]);
  await store.trust(demoSmimeCa);
}

/// The Northwind demo CA.
final demoSmimeCa = _certificate(_ca);

/// Revocation in the demo: the demo CA's OCSP answers (Aisha's and Sam's
/// certificates good, Hana's revoked for key compromise), made in advance.
/// Nothing goes online.
final class DemoRevocationFetcher implements SmimeRevocationFetcher {
  const DemoRevocationFetcher();

  @override
  Future<Uint8List> postOcsp(Uri url, Uint8List request, {required int maxBytes}) async {
    for (final (who, answer) in [(_aisha, _ocspAisha), (_hana, _ocspHana), (_sam, _ocspSam)]) {
      final expected = ocspRequest(who.certificate, demoSmimeCa);
      if (expected.length == request.length && _same(expected, request)) return base64.decode(answer);
    }
    throw const SmimeException(SmimeErrorKind.failed, 'The demo only knows the Northwind demo certificates.');
  }

  @override
  Future<Uint8List> getCrl(Uri url, {required int maxBytes}) async =>
      throw const SmimeException(SmimeErrorKind.failed, 'The demo has no revocation lists.');

  static bool _same(List<int> a, List<int> b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

final class _DemoIdentity {
  _DemoIdentity(this.address, String certificate, String key)
    : certificate = _certificate(certificate),
      key = SmimePrivateKey(base64.decode(key));

  final EmailAddress address;
  final SmimeCertificate certificate;
  final SmimePrivateKey key;
}

SmimeCertificate _certificate(String b64) => SmimeCertificate.fromDer(base64.decode(b64));

final _sam = _DemoIdentity(DemoPeople.work, _samCertificate, _samKey);
final _aisha = _DemoIdentity(DemoPeople.aisha, _aishaCertificate, _aishaKey);
final _hana = _DemoIdentity(DemoPeople.hana, _hanaCertificate, _hanaKey);

final class _Sender implements SmimeSendKeys {
  _Sender(this.smimeState, this.key);

  @override
  final SmimeState smimeState;
  final SmimePrivateKey key;

  @override
  SmimeKeyHandle? smimeKey(String fingerprint) => key;
}

Uint8List _write({
  required _DemoIdentity from,
  required EmailSummary summary,
  required String subject,
  required String text,
  required OutgoingSecurity security,
}) {
  final date = summary.sentAt ?? summary.receivedAt;
  final state = SmimeState(
    own: [
      SmimeOwnCertificate(certificate: from.certificate, chain: [demoSmimeCa], added: date),
    ],
    contacts: [
      SmimeContactCertificate(certificate: _sam.certificate, chain: [demoSmimeCa], added: date),
    ],
    authorities: [demoSmimeCa],
  );
  final composer = SmimeMessageComposer(
    MimeMessageComposer(),
    _Sender(state, from.key),
    backend: const DartSmimeBackend(),
    clock: () => date,
  );
  return composer.compose(
    OutgoingMessage(
      accountId: 'demo',
      identityId: 'demo',
      to: summary.to,
      subject: subject,
      text: text,
      security: security,
    ),
    Identity(id: 'demo', email: from.address.email, name: from.address.name),
    messageId: summary.messageIdHeader ?? '${summary.id}@demo.example',
    date: date,
  );
}

// Made with OpenSSL 3.5 for the demo, base64 DER: the CA, Sam's, Aisha's and
// Hana's certificates (each naming http://ocsp.northwind.example/), their
// keys (PKCS #8), and the CA's OCSP answers.

const _ca =
    'MIIBuDCCAV+gAwIBAgIBATAKBggqhkjOPQQDAjBEMSEwHwYDVQQKDBhOb3J0aHdpbmQgVHJhZGVycyAoZGVtbykxHzAdBgNVBAMM'
    'Fk5vcnRod2luZCBEZW1vIE1haWwgQ0EwHhcNMjUwMTAxMDAwMDAwWhcNNDUwMTAxMDAwMDAwWjBEMSEwHwYDVQQKDBhOb3J0aHdp'
    'bmQgVHJhZGVycyAoZGVtbykxHzAdBgNVBAMMFk5vcnRod2luZCBEZW1vIE1haWwgQ0EwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNC'
    'AATBVBPXcOgBklJvzDnnWEIwFk9jpKdB+E+XtRtkIcI8rhZ5EjALYSo0g3K0QUFafr2duBiFYaAxg3Sx79aW2JVAo0IwQDAPBgNV'
    'HRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUjFpjelsidi/0lajws5BrfSuRqtwwCgYIKoZIzj0EAwIDRwAw'
    'RAIgPSHsNylQxc9lIfmWb9WpXCjBEXqeb2KfhRcIF6mWHQcCIDWRKa5h2VV0KXwFFJAvbrNnG8X3svbLChVgd8dDa/2I';

const _samCertificate =
    'MIICSDCCAe6gAwIBAgICUQEwCgYIKoZIzj0EAwIwRDEhMB8GA1UECgwYTm9ydGh3aW5kIFRyYWRlcnMgKGRlbW8pMR8wHQYDVQQD'
    'DBZOb3J0aHdpbmQgRGVtbyBNYWlsIENBMB4XDTI1MDEwMTAwMDAwMFoXDTQ1MDEwMTAwMDAwMFowODEhMB8GA1UECgwYTm9ydGh3'
    'aW5kIFRyYWRlcnMgKGRlbW8pMRMwEQYDVQQDDApTYW0gUml2ZXJhMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEvtj52JgtHVms'
    '0ld38tbFngNlteZedrxOtz2w0ZOiZHLRhklAPMPI4tEyZdVbSprFFWmIyG8u49Z84OftPOmZh6OB2zCB2DAMBgNVHRMBAf8EAjAA'
    'MA4GA1UdDwEB/wQEAwIDiDATBgNVHSUEDDAKBggrBgEFBQcDBDAnBgNVHREEIDAegRxzYW0ucml2ZXJhQG5vcnRod2luZC5leGFt'
    'cGxlMDoGCCsGAQUFBwEBBC4wLDAqBggrBgEFBQcwAYYeaHR0cDovL29jc3Aubm9ydGh3aW5kLmV4YW1wbGUvMB0GA1UdDgQWBBR9'
    'UjFjIAZJyQHiae/p2wnvvWQGIzAfBgNVHSMEGDAWgBSMWmN6WyJ2L/SVqPCzkGt9K5Gq3DAKBggqhkjOPQQDAgNIADBFAiBm4tFC'
    'RJxWeFOi4o7/kzutaSE02BR2WDhzAo24gqWrZAIhANO1ujCMWuFo/yMOCW9WhvpnUkLAtxUya9sDGc9q3rH4';

const _aishaCertificate =
    'MIICSzCCAfKgAwIBAgICUQIwCgYIKoZIzj0EAwIwRDEhMB8GA1UECgwYTm9ydGh3aW5kIFRyYWRlcnMgKGRlbW8pMR8wHQYDVQQD'
    'DBZOb3J0aHdpbmQgRGVtbyBNYWlsIENBMB4XDTI1MDEwMTAwMDAwMFoXDTQ1MDEwMTAwMDAwMFowOjEhMB8GA1UECgwYTm9ydGh3'
    'aW5kIFRyYWRlcnMgKGRlbW8pMRUwEwYDVQQDDAxBaXNoYSBLYXJpbWkwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAAQA70XII7S+'
    's2Co/awLFPrnAlxaiVRU+raUszGTB7BhqZZeiwZofqIIwil6UoC9cddqdJchOx9ODUi6Pqv1BSZ4o4HdMIHaMAwGA1UdEwEB/wQC'
    'MAAwDgYDVR0PAQH/BAQDAgOIMBMGA1UdJQQMMAoGCCsGAQUFBwMEMCkGA1UdEQQiMCCBHmFpc2hhLmthcmltaUBub3J0aHdpbmQu'
    'ZXhhbXBsZTA6BggrBgEFBQcBAQQuMCwwKgYIKwYBBQUHMAGGHmh0dHA6Ly9vY3NwLm5vcnRod2luZC5leGFtcGxlLzAdBgNVHQ4E'
    'FgQUNfR7hxFYHvDzDFvex+xyqgXM0QYwHwYDVR0jBBgwFoAUjFpjelsidi/0lajws5BrfSuRqtwwCgYIKoZIzj0EAwIDRwAwRAIg'
    'NmUAxom7sNcC8LO/3HK5VmcmqVinnA9zrffJyT/DUQICIBDUPWlxO/XlUNn+F8jEgUoxuVKAS7lXamtnmHHsHYe9';

const _hanaCertificate =
    'MIICRjCCAeygAwIBAgICUQMwCgYIKoZIzj0EAwIwRDEhMB8GA1UECgwYTm9ydGh3aW5kIFRyYWRlcnMgKGRlbW8pMR8wHQYDVQQD'
    'DBZOb3J0aHdpbmQgRGVtbyBNYWlsIENBMB4XDTI1MDEwMTAwMDAwMFoXDTQ1MDEwMTAwMDAwMFowNzEhMB8GA1UECgwYTm9ydGh3'
    'aW5kIFRyYWRlcnMgKGRlbW8pMRIwEAYDVQQDDAlIYW5hIFNhdG8wWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAATmWzOeBKsM+bjE'
    '7Y2Mf/R3QahCmDtUpwqpUdqWGmwjbXM1VNQ4wpWNmXtTQwnEuorHxY7vikebil+DbdGonOVGo4HaMIHXMAwGA1UdEwEB/wQCMAAw'
    'DgYDVR0PAQH/BAQDAgOIMBMGA1UdJQQMMAoGCCsGAQUFBwMEMCYGA1UdEQQfMB2BG2hhbmEuc2F0b0Bub3J0aHdpbmQuZXhhbXBs'
    'ZTA6BggrBgEFBQcBAQQuMCwwKgYIKwYBBQUHMAGGHmh0dHA6Ly9vY3NwLm5vcnRod2luZC5leGFtcGxlLzAdBgNVHQ4EFgQUxiDu'
    'WWhAw8M57E+S6fdiGt885hgwHwYDVR0jBBgwFoAUjFpjelsidi/0lajws5BrfSuRqtwwCgYIKoZIzj0EAwIDSAAwRQIgV7Q1PZWT'
    'wFaTPY97jiCY6wT6hyAhIK6/cjbGZ2J7y+sCIQDDalpABbA4dJMEXBhQs0OWNA/PLaCT+uWN9FN3Evzypw==';

const _samKey =
    'MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg9AXWodjRlHJFSWA9VgrmETT0QMJdozF74Uhg0yhYQJahRANCAAS+'
    '2PnYmC0dWazSV3fy1sWeA2W15l52vE63PbDRk6JkctGGSUA8w8ji0TJl1VtKmsUVaYjIby7j1nzg5+086ZmH';

const _aishaKey =
    'MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQgv1tU7HCtsD1KNpFXRmIYzpgnKCnrvWYbuMjSgYgNNPGhRANCAAQA'
    '70XII7S+s2Co/awLFPrnAlxaiVRU+raUszGTB7BhqZZeiwZofqIIwil6UoC9cddqdJchOx9ODUi6Pqv1BSZ4';

const _hanaKey =
    'MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQgQeLKInjF9qDuXrzE2D28bIhTd6mI2aq4B+7GJ6TjhtShRANCAATm'
    'WzOeBKsM+bjE7Y2Mf/R3QahCmDtUpwqpUdqWGmwjbXM1VNQ4wpWNmXtTQwnEuorHxY7vikebil+DbdGonOVG';

const _ocspAisha =
    'MIIC+woBAKCCAvQwggLwBgkrBgEFBQcwAQEEggLhMIIC3TCBwKFGMEQxITAfBgNVBAoMGE5vcnRod2luZCBUcmFkZXJzIChkZW1v'
    'KTEfMB0GA1UEAwwWTm9ydGh3aW5kIERlbW8gTWFpbCBDQRgPMjAyNjEwMDcyMjIzNDhaMGUwYzA7MAkGBSsOAwIaBQAEFB2D97om'
    'YLxtf2N6fLZDd4AW12ruBBSMWmN6WyJ2L/SVqPCzkGt9K5Gq3AICUQKAABgPMjAyNjEwMDcyMjIzNDhaoBEYDzIwMzYxMDA0MjIy'
    'MzQ4WjAKBggqhkjOPQQDAgNIADBFAiEAvx9dfOmUr8envnvob+orHKe9i039Wpq9wdg1zWGZ+D0CIFEj8u579iO21BAEYcoAGm0c'
    'ZzKkeNu6IZ+1EAyzIIiwoIIBwDCCAbwwggG4MIIBX6ADAgECAgEBMAoGCCqGSM49BAMCMEQxITAfBgNVBAoMGE5vcnRod2luZCBU'
    'cmFkZXJzIChkZW1vKTEfMB0GA1UEAwwWTm9ydGh3aW5kIERlbW8gTWFpbCBDQTAeFw0yNTAxMDEwMDAwMDBaFw00NTAxMDEwMDAw'
    'MDBaMEQxITAfBgNVBAoMGE5vcnRod2luZCBUcmFkZXJzIChkZW1vKTEfMB0GA1UEAwwWTm9ydGh3aW5kIERlbW8gTWFpbCBDQTBZ'
    'MBMGByqGSM49AgEGCCqGSM49AwEHA0IABMFUE9dw6AGSUm/MOedYQjAWT2Okp0H4T5e1G2QhwjyuFnkSMAthKjSDcrRBQVp+vZ24'
    'GIVhoDGDdLHv1pbYlUCjQjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBSMWmN6WyJ2L/SVqPCz'
    'kGt9K5Gq3DAKBggqhkjOPQQDAgNHADBEAiA9Iew3KVDFz2Uh+ZZv1alcKMERep5vYp+FFwgXqZYdBwIgNZEprmHZVXQpfAUUkC9u'
    's2cbxfey9ssKFWB3x0Nr/Yg=';

const _ocspHana =
    'MIIDEQoBAKCCAwowggMGBgkrBgEFBQcwAQEEggL3MIIC8zCB1qFGMEQxITAfBgNVBAoMGE5vcnRod2luZCBUcmFkZXJzIChkZW1v'
    'KTEfMB0GA1UEAwwWTm9ydGh3aW5kIERlbW8gTWFpbCBDQRgPMjAyNjEwMDcyMjIzNDhaMHsweTA7MAkGBSsOAwIaBQAEFB2D97om'
    'YLxtf2N6fLZDd4AW12ruBBSMWmN6WyJ2L/SVqPCzkGt9K5Gq3AICUQOhFhgPMjAyNjA5MDEwMDAwMDBaoAMKAQEYDzIwMjYxMDA3'
    'MjIyMzQ4WqARGA8yMDM2MTAwNDIyMjM0OFowCgYIKoZIzj0EAwIDSAAwRQIgRQgbLeT2xMngQn+XdOB9gYzlRn9kEhZkzhhH9dbi'
    'rRECIQDiYKwXY54rIeypOXbOdOztyGrFpmtowr6STa0LKc5OF6CCAcAwggG8MIIBuDCCAV+gAwIBAgIBATAKBggqhkjOPQQDAjBE'
    'MSEwHwYDVQQKDBhOb3J0aHdpbmQgVHJhZGVycyAoZGVtbykxHzAdBgNVBAMMFk5vcnRod2luZCBEZW1vIE1haWwgQ0EwHhcNMjUw'
    'MTAxMDAwMDAwWhcNNDUwMTAxMDAwMDAwWjBEMSEwHwYDVQQKDBhOb3J0aHdpbmQgVHJhZGVycyAoZGVtbykxHzAdBgNVBAMMFk5v'
    'cnRod2luZCBEZW1vIE1haWwgQ0EwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAATBVBPXcOgBklJvzDnnWEIwFk9jpKdB+E+XtRtk'
    'IcI8rhZ5EjALYSo0g3K0QUFafr2duBiFYaAxg3Sx79aW2JVAo0IwQDAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBBjAd'
    'BgNVHQ4EFgQUjFpjelsidi/0lajws5BrfSuRqtwwCgYIKoZIzj0EAwIDRwAwRAIgPSHsNylQxc9lIfmWb9WpXCjBEXqeb2KfhRcI'
    'F6mWHQcCIDWRKa5h2VV0KXwFFJAvbrNnG8X3svbLChVgd8dDa/2I';

const _ocspSam =
    'MIIC/AoBAKCCAvUwggLxBgkrBgEFBQcwAQEEggLiMIIC3jCBwKFGMEQxITAfBgNVBAoMGE5vcnRod2luZCBUcmFkZXJzIChkZW1v'
    'KTEfMB0GA1UEAwwWTm9ydGh3aW5kIERlbW8gTWFpbCBDQRgPMjAyNjEwMDcyMjIzNDhaMGUwYzA7MAkGBSsOAwIaBQAEFB2D97om'
    'YLxtf2N6fLZDd4AW12ruBBSMWmN6WyJ2L/SVqPCzkGt9K5Gq3AICUQGAABgPMjAyNjEwMDcyMjIzNDhaoBEYDzIwMzYxMDA0MjIy'
    'MzQ4WjAKBggqhkjOPQQDAgNJADBGAiEA/RZUuf54CcS9Zeu9bXdbqgXH3szkzYK562qmOpRbuUECIQC3g8hLwQvyIHJTISWKTxcr'
    'sc6nQWANskvS6Gu5WYS1sKCCAcAwggG8MIIBuDCCAV+gAwIBAgIBATAKBggqhkjOPQQDAjBEMSEwHwYDVQQKDBhOb3J0aHdpbmQg'
    'VHJhZGVycyAoZGVtbykxHzAdBgNVBAMMFk5vcnRod2luZCBEZW1vIE1haWwgQ0EwHhcNMjUwMTAxMDAwMDAwWhcNNDUwMTAxMDAw'
    'MDAwWjBEMSEwHwYDVQQKDBhOb3J0aHdpbmQgVHJhZGVycyAoZGVtbykxHzAdBgNVBAMMFk5vcnRod2luZCBEZW1vIE1haWwgQ0Ew'
    'WTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAATBVBPXcOgBklJvzDnnWEIwFk9jpKdB+E+XtRtkIcI8rhZ5EjALYSo0g3K0QUFafr2d'
    'uBiFYaAxg3Sx79aW2JVAo0IwQDAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUjFpjelsidi/0lajw'
    's5BrfSuRqtwwCgYIKoZIzj0EAwIDRwAwRAIgPSHsNylQxc9lIfmWb9WpXCjBEXqeb2KfhRcIF6mWHQcCIDWRKa5h2VV0KXwFFJAv'
    'brNnG8X3svbLChVgd8dDa/2I';
