import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/openpgp/openpgp_providers.dart';
import 'package:loupe/features/openpgp/passphrase_dialog.dart';
import 'package:loupe/features/outbox/outbox_screen.dart';
import 'package:loupe/platform/background.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import '../openpgp/openpgp_test_support.dart';

OutgoingMessage _message(String subject, {List<EmailAddress> to = const [bob]}) =>
    OutgoingMessage(accountId: 'acc', identityId: 'acc/me', to: to, subject: subject, text: 'Text of $subject');

DateTime _tomorrowAt8() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day + 1, 8);
}

void main() {
  final scheduledAt = DateTime(2030, 1, 7, 8);

  FakeMailRepository repoWithOutbox() => FakeMailRepository()
    ..outbox.addAll([
      OutboxItem(
        id: 'o1',
        message: _message('Invoice', to: const [alice]),
        sendAt: DateTime(2026, 10, 4, 12),
        status: OutboxStatus.failed,
        error: '550 Mailbox unavailable',
      ),
      OutboxItem(id: 'o2', message: _message('Report'), sendAt: scheduledAt, status: OutboxStatus.scheduled),
    ]);

  Future<void> pumpOutbox(WidgetTester tester, FakeMailRepository repo) => pumpTestApp(
    tester,
    repository: repo,
    home: const OutboxScreen(),
    composeBuilder: (args) => Scaffold(body: Text('edit ${args.outboxId} ${args.sendAt} ${args.message?.subject}')),
  );

  testWidgets('lists failed and scheduled messages; Retry and swipes send now', (tester) async {
    final repo = repoWithOutbox();
    await pumpOutbox(tester, repo);
    expect(find.text('Outbox'), findsOneWidget);
    expect(find.text('NOT SENT'), findsOneWidget);
    expect(find.text('SCHEDULED'), findsOneWidget);
    expect(find.text('Alice Example'), findsOneWidget);
    expect(find.text('550 Mailbox unavailable'), findsOneWidget);
    expect(find.textContaining('Jan 7, 2030'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('outbox-retry-o1')));
    await tester.pumpAndSettle();
    expect(repo.log, contains('sendNow o1'));
    expect(find.text('NOT SENT'), findsNothing);

    await tester.drag(find.text('Report'), const Offset(600, 0));
    await tester.pumpAndSettle();
    expect(repo.log, contains('sendNow o2'));
    expect(find.text('Nothing to Send'), findsOneWidget);
  });

  group('signed mail', () {
    final locked = testKey('Me Myself <me@example.com>', passphrase: 'pass');
    const signed = OutgoingSecurity(encrypt: true, sign: true);

    Future<FakeMailRepository> pumpSigned(WidgetTester tester, {DateTime? composedFor}) async {
      final storage = await keychainWith(own: [locked]);
      final repo = FakeMailRepository()
        ..outbox.add(
          OutboxItem(
            id: 'o1',
            message: _message('Signed').copyWith(security: signed),
            sendAt: DateTime(2026, 10, 4, 12),
            status: OutboxStatus.failed,
            error: 'Your OpenPGP key is locked.',
            composedFor: composedFor,
          ),
        );
      await pumpTestApp(
        tester,
        repository: repo,
        home: const OutboxScreen(),
        overrides: [
          inlinePgp,
          keychain(storage),
          passphrasePromptProvider.overrideWithValue(
            (key, {error}) => showPassphraseDialog(tester.element(find.byType(OutboxScreen)), key: key, error: error),
          ),
        ],
      );
      return repo;
    }

    testWidgets('Retry asks for the passphrase of a locked key first; Cancel keeps it waiting', (tester) async {
      final repo = await pumpSigned(tester);
      await tester.tap(find.byKey(const ValueKey('outbox-retry-o1')));
      await tester.pumpAndSettle();
      expect(find.byType(PassphraseDialog), findsOneWidget);
      await tester.tap(find.widgetWithText(CupertinoDialogAction, 'Cancel'));
      await tester.pumpAndSettle();
      expect(repo.log, isNot(contains('sendNow o1')));

      await tester.tap(find.byKey(const ValueKey('outbox-retry-o1')));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('passphrase-field')), 'pass');
      await tester.tap(find.byKey(const ValueKey('passphrase-unlock')));
      await tester.pumpAndSettle();
      expect(repo.log, contains('sendNow o1'));
    });

    testWidgets('composed when it was queued, it is retried without the key', (tester) async {
      final repo = await pumpSigned(tester, composedFor: DateTime(2026, 10, 4, 11));
      await tester.tap(find.byKey(const ValueKey('outbox-retry-o1')));
      await tester.pumpAndSettle();
      expect(find.byType(PassphraseDialog), findsNothing);
      expect(repo.log, contains('sendNow o1'));
    });
  });

  testWidgets('Reschedule, and Cancel back to Drafts, from the menu', (tester) async {
    final repo = repoWithOutbox();
    await pumpOutbox(tester, repo);

    await tester.longPress(find.text('Report'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reschedule…'));
    await tester.pumpAndSettle();
    expect(find.text('RESCHEDULE'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('send-later-tomorrowMorning')));
    await tester.pumpAndSettle();
    expect(repo.log, contains('rescheduleSend o2 ${_tomorrowAt8().toIso8601String()}'));
    expect(find.textContaining('Rescheduled for Tomorrow at'), findsOneWidget);

    await tester.longPress(find.text('Report'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel Sending…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move to Drafts'));
    await tester.pumpAndSettle();
    expect(repo.log, containsAllInOrder(['saveDraft Report', 'cancelSend o2']));
    expect(find.text('Moved to Drafts'), findsOneWidget);
    expect(find.text('Report'), findsNothing);
  });

  testWidgets('Move to Drafts that can’t save keeps the message in the Outbox', (tester) async {
    final repo = repoWithOutbox()..draftError = const MailException(MailErrorKind.server, 'APPEND: quota exceeded');
    await pumpOutbox(tester, repo);
    await tester.longPress(find.text('Report'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel Sending…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move to Drafts'));
    await tester.pumpAndSettle();
    expect(repo.log, isNot(contains('cancelSend o2')));
    expect(find.textContaining('quota exceeded'), findsOneWidget);
    expect(find.text('Report'), findsOneWidget);

    repo.draftError = null;
    await tester.longPress(find.text('Report'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel Sending…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Move to Drafts'));
    await tester.pumpAndSettle();
    expect(repo.log, containsAllInOrder(['saveDraft Report', 'cancelSend o2']));
    expect(find.text('Report'), findsNothing);
  });

  testWidgets('tapping a message reopens it in compose with its time', (tester) async {
    final repo = repoWithOutbox();
    await pumpOutbox(tester, repo);
    await tester.tap(find.text('Report'));
    await tester.pumpAndSettle();
    expect(find.text('edit o2 $scheduledAt Report'), findsOneWidget);
  });

  testWidgets('Mailboxes shows an Outbox row while something waits; Discard has Undo (demo)', (tester) async {
    final repo = await pumpLoupe(tester);
    expect(find.text('Outbox'), findsNothing);
    const message = OutgoingMessage(
      accountId: DemoAccounts.personal,
      identityId: 'personal/default',
      to: [EmailAddress('jordan.lee@example.com', 'Jordan Lee')],
      subject: 'See you Monday',
      text: 'Hi!',
    );
    await repo.send(message, sendAt: testNow.add(const Duration(days: 1)));
    await tester.pumpAndSettle();
    final row = find.byKey(const ValueKey('outbox'));
    expect(find.descendant(of: row, matching: find.text('Outbox')), findsOneWidget);
    expect(find.descendant(of: row, matching: find.text('1')), findsOneWidget);

    await tester.tap(row);
    await tester.pumpAndSettle();
    expect(find.text('See you Monday'), findsOneWidget);
    await tester.drag(find.text('See you Monday'), const Offset(-320, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard Message'));
    await tester.pumpAndSettle();
    expect(find.text('Nothing to Send'), findsOneWidget);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(find.text('See you Monday'), findsOneWidget);
    expect((await repo.watchOutbox().first).single.status, OutboxStatus.scheduled);

    repo.dispose();
    await drainTimers(tester);
  });

  testWidgets('scheduled messages ask for their wake-up again at launch, once per time', (tester) async {
    final repo = DemoMailRepository.instant(clock: () => testNow);
    const message = OutgoingMessage(
      accountId: DemoAccounts.personal,
      identityId: 'personal/default',
      to: [EmailAddress('jordan.lee@example.com')],
      subject: 'Tomorrow',
    );
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    await repo.send(message, sendAt: tomorrow);
    await repo.send(message, sendAt: tomorrow);
    final scheduler = _RecordingScheduler();
    await pumpLoupe(tester, repository: repo, overrides: [backgroundSchedulerProvider.overrideWithValue(scheduler)]);
    // The demo's snoozed messages ask for theirs too.
    expect(scheduler.times.where((t) => t.isAtSameMomentAs(tomorrow)), [tomorrow]);
    repo.dispose();
  });
}

class _RecordingScheduler implements BackgroundScheduler {
  final times = <DateTime>[];

  @override
  Future<void> scheduleWakeUp(DateTime time) async => times.add(time);
}
