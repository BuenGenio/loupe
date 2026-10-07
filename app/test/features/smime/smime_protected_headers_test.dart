import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/openpgp/decrypted_mail.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import '../openpgp/openpgp_test_support.dart';
import 'smime_test_support.dart';

final class _Alice implements SmimeSendKeys {
  _Alice(this.smimeState);
  @override
  final SmimeState smimeState;
  @override
  SmimeKeyHandle? smimeKey(String fingerprint) => aliceBundle.keys.single.key;
}

/// What Alice's Loupe sends Bob: S/MIME, signed and encrypted, the subject protected.
String fromAlice({String subject = 'Offsite venue', String text = 'Lighthouse Lodge, 14 to 16 November.'}) {
  final alice = aliceBundle.keys.single;
  final bob = bobBundle.keys.single;
  final now = DateTime.now();
  final state = SmimeState(
    own: [SmimeOwnCertificate(certificate: alice.certificate, chain: aliceBundle.chain, added: now)],
    contacts: [SmimeContactCertificate(certificate: bob.certificate, chain: bobBundle.chain, added: now)],
    authorities: [testRoot],
  );
  final raw = SmimeMessageComposer(MimeMessageComposer(), _Alice(state), backend: smime).compose(
    OutgoingMessage(
      accountId: 'a',
      identityId: 'a',
      to: const [bobAddress],
      subject: subject,
      text: text,
      security: const OutgoingSecurity(
        encrypt: true,
        sign: true,
        technology: SecurityTechnology.smime,
        hideSubject: true,
      ),
    ),
    const Identity(id: 'a', email: 'alice@example.org', name: 'Alice Example'),
    messageId: 'venue@example.org',
    date: now,
  );
  return latin1.decode(raw);
}

void main() {
  testWidgets('the real subject shows instead of "...", without the legacy display, and is kept', (tester) async {
    final raw = fromAlice();
    expect(raw, contains('Subject: ...'));
    final storage = await smimeKeychain(own: [bobBundle], trusted: [testRoot]);
    final repo = FakeMailRepository(
      emails: [
        testEmail('m1', from: aliceAddress, to: const [bobAddress], subject: '...'),
      ],
      contents: {'m1': serverContent('m1', raw)},
    )..rawSources['m1'] = raw;
    final router = await pumpTestApp(tester, repository: repo, overrides: [inlinePgp, keychain(storage)]);
    unawaited(router.push('/message/m1'));
    await tester.pumpAndSettle();

    expect(find.text('Offsite venue'), findsWidgets);
    expect(textContaining('Lighthouse Lodge'), findsWidgets);
    expect(textContaining('Subject: Offsite venue'), findsNothing);
    expect(textContaining('Signed by Alice Example ✓'), findsOneWidget);
    // Kept for the list, search and notifications, as for OpenPGP.
    expect(repo.protectedSubjects, {'m1': 'Offsite venue'});
  });

  group('Decrypt Subjects in the Background', () {
    late FakeMailRepository repo;
    EmailSummary add(String id, String raw) {
      final e = testEmail(id, subject: '...');
      final summary = EmailSummary(
        id: e.id,
        accountId: e.accountId,
        mailboxId: e.mailboxId,
        receivedAt: e.receivedAt,
        from: e.from,
        subject: '...',
        size: raw.length,
        isEncrypted: true,
      );
      repo.emails.add(summary);
      repo.rawSources[id] = raw;
      return summary;
    }

    setUp(() => repo = FakeMailRepository());

    test('S/MIME mail too, with certificates whose keys have no passphrase', () async {
      final bob = bobBundle.keys.single;
      final emails = [add('s1', fromAlice(subject: 'Für dich'))];
      final found = await SubjectDecryptor(
        keys: const [],
        smimeKeys: [SmimeKeyPair(bob.certificate, bob.key)],
        indexText: true,
      ).decrypt(repo, emails);
      expect(found, {'s1': 'Für dich'});
      expect(repo.protectedSubjects, {'s1': 'Für dich'});
      expect(repo.decryptedTexts['s1'], startsWith('Lighthouse Lodge'), reason: 'without the legacy display');
    });

    test('not for its certificates: left alone', () async {
      final alice = aliceBundle.keys.single;
      final emails = [add('s1', fromAlice())];
      // Alice's own copy decrypts too (she is a recipient), Carol's certificate doesn't.
      expect(
        await SubjectDecryptor(
          keys: const [],
          smimeKeys: [SmimeKeyPair(fixtureCert('carol.crt'), alice.key)],
        ).decrypt(repo, emails),
        isEmpty,
      );
      expect(repo.protectedSubjects, isEmpty);
    });

    test('decryptedPartsOf reads S/MIME as well as PGP/MIME', () {
      final bob = bobBundle.keys.single;
      final parts = decryptedPartsOf(
        Uint8List.fromList(latin1.encode(fromAlice())),
        backend: pgp,
        keys: const [],
        smimeKeys: [SmimeKeyPair(bob.certificate, bob.key)],
      );
      expect(parts?.subject, 'Offsite venue');
    });
  });
}
