import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/openpgp/decrypted_mail.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import 'openpgp_test_support.dart';

void main() {
  final mine = testKey('Me Myself <me@example.com>');
  final aliceKey = testKey('Alice Example <alice@example.com>');
  final strangerKey = testKey('Stranger <stranger@example.com>');

  String secretTo(PgpKey key, {String subject = 'The real subject'}) => pgpMessage(
    from: alice,
    fromKey: aliceKey,
    to: EmailAddress(key.emails.single),
    toKey: key,
    subject: subject,
    text: 'Only for you.',
  );

  late FakeMailRepository repo;
  EmailSummary add(String id, String raw, {String subject = '...', bool encrypted = true, int size = 4000}) {
    final e = testEmail(id, subject: subject);
    final summary = EmailSummary(
      id: e.id,
      accountId: e.accountId,
      mailboxId: e.mailboxId,
      receivedAt: e.receivedAt,
      from: e.from,
      subject: subject,
      size: size,
      isEncrypted: encrypted,
    );
    repo.emails.add(summary);
    repo.rawSources[id] = raw;
    return summary;
  }

  setUp(() => repo = FakeMailRepository());

  test('decrypts placeholder subjects of encrypted mail for the keys it has, and remembers them', () async {
    final emails = [
      add('mine', secretTo(mine)),
      add('theirs', secretTo(strangerKey)),
      add('clear', secretTo(mine), subject: 'Subject sent in the clear'),
      add('plain', secretTo(mine), encrypted: false),
      add('large', secretTo(mine), size: SubjectDecryptor.defaultMaxBytes + 1),
    ];
    final found = await SubjectDecryptor(keys: [mine]).decrypt(repo, emails);
    expect(found, {'mine': 'The real subject'});
    expect(repo.protectedSubjects, {'mine': 'The real subject'});
    expect(repo.log.where((l) => l.startsWith('loadRawSource')), hasLength(2), reason: 'only what it wants');
  });

  test('with Index Decrypted Messages for Search, their text goes into the index too', () async {
    final emails = [add('mine', secretTo(mine))];
    await SubjectDecryptor(keys: [mine]).decrypt(repo, emails);
    expect(repo.decryptedTexts, isEmpty);
    repo.emails.clear();
    final again = [add('mine', secretTo(mine))];
    await SubjectDecryptor(keys: [mine], indexText: true).decrypt(repo, again);
    expect(repo.decryptedTexts['mine'], contains('Only for you.'));
  });

  test('a message it already knows, or whose source isn’t PGP/MIME, is left alone', () async {
    final known = add('known', secretTo(mine)).copyWith(subject: 'Known', hasDecryptedSubject: true);
    final gone = add('gone', secretTo(mine));
    // The fake's source for it is then a plain message.
    repo.rawSources.remove('gone');
    final decryptor = SubjectDecryptor(keys: [mine]);
    expect(decryptor.wants(known), isFalse);
    expect(await decryptor.decrypt(repo, [known, gone]), isEmpty);
  });

  test('without keys it does nothing; after its budget it starts no more', () async {
    final a = add('a', secretTo(mine));
    final b = add('b', secretTo(mine));
    expect(await SubjectDecryptor(keys: const []).decrypt(repo, [a, b]), isEmpty);
    var now = DateTime(2026);
    final slow = SubjectDecryptor(keys: [mine], clock: () => now = now.add(const Duration(seconds: 10)));
    expect(await slow.decrypt(repo, [a, b], budget: const Duration(seconds: 15)), {'a': 'The real subject'});
  });

  test('protectedSubjectOf: only for keys it is encrypted to', () {
    final raw = latin1.encode(secretTo(mine, subject: 'Für dich'));
    expect(protectedSubjectOf(raw, backend: pgp, keys: [mine]), 'Für dich');
    expect(protectedSubjectOf(raw, backend: pgp, keys: [strangerKey]), isNull);
    expect(protectedSubjectOf(latin1.encode('Subject: hi\r\n\r\nplain'), backend: pgp, keys: [mine]), isNull);
  });
}
