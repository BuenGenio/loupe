import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/openpgp/decrypted_mail.dart';
import 'package:loupe/features/openpgp/subjects_watcher.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import 'openpgp_test_support.dart';

/// The inbox lists every message.
final class _Inbox extends FakeMailRepository {
  _Inbox({super.emails});

  @override
  Stream<List<ThreadSummary>> watchList(
    MailboxRef ref, {
    Set<QuickFilter> filters = const {},
    bool threaded = true,
    int limit = 200,
  }) =>
      Stream.value([for (final e in emails) ThreadSummary(threadId: e.id, latest: e, messageCount: 1, unreadCount: 1)]);
}

void main() {
  final aliceKey = testKey('Alice Example <alice@example.com>');

  Future<_Inbox> pump(WidgetTester tester, PgpKey mine, {required bool on}) async {
    final raw = pgpMessage(
      from: alice,
      fromKey: aliceKey,
      to: me,
      toKey: mine,
      subject: 'The real subject',
      text: 'Only for you.',
    );
    final secret = testEmail('s1', subject: '...');
    final repo = _Inbox(
      emails: [
        EmailSummary(
          id: secret.id,
          accountId: secret.accountId,
          mailboxId: secret.mailboxId,
          receivedAt: secret.receivedAt,
          from: secret.from,
          subject: '...',
          size: raw.length,
          isEncrypted: true,
        ),
      ],
    )..rawSources['s1'] = raw;
    final storage = await keychainWith(own: [mine]);
    await pumpTestApp(
      tester,
      repository: repo,
      prefs: {'e2ee.subjectsInBackground': on},
      home: ProtectedSubjectsWatcher(repository: repo, child: const Text('home')),
      overrides: [inlinePgp, keychain(storage)],
    );
    await tester.pumpAndSettle();
    return repo;
  }

  testWidgets('while on, decrypts the subjects of encrypted mail in the inboxes', (tester) async {
    final repo = await pump(tester, testKey('Me Myself <me@example.com>'), on: true);
    expect(repo.protectedSubjects, {'s1': 'The real subject'});
  });

  testWidgets('off: nothing until it is turned on', (tester) async {
    final repo = await pump(tester, testKey('Me Myself <me@example.com>'), on: false);
    expect(repo.protectedSubjects, isEmpty);
    expect(repo.log.where((l) => l.startsWith('loadRawSource')), isEmpty);

    final container = ProviderScope.containerOf(tester.element(find.text('home')));
    await container.read(decryptedMailSettingsProvider.notifier).update((s) => s.copyWith(subjectsInBackground: true));
    await tester.pumpAndSettle();
    expect(repo.protectedSubjects, {'s1': 'The real subject'});
  });

  testWidgets('a key with a passphrase is never used, nor asked for', (tester) async {
    final repo = await pump(tester, testKey('Me Myself <me@example.com>', passphrase: 'secret'), on: true);
    expect(repo.protectedSubjects, isEmpty);
    expect(repo.log.where((l) => l.startsWith('loadRawSource')), isEmpty);
  });
}
