import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:loupe/platform/background.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';

final toField = find.byKey(const ValueKey('recipients-To:'));
final sendButton = find.byKey(const Key('compose-send'));

bool sendEnabled(WidgetTester tester) => tester.widget<IconButton>(sendButton).onPressed != null;

/// Records the wake-ups compose asks for.
class RecordingScheduler implements BackgroundScheduler {
  final times = <DateTime>[];

  @override
  Future<void> scheduleWakeUp(DateTime time) async => times.add(time);
}

Future<GoRouter> openCompose(
  WidgetTester tester,
  FakeMailRepository repo, [
  ComposeArgs args = const ComposeArgs(),
  Map<String, Object> prefs = const {},
  List<Override> overrides = const [],
]) async {
  final router = await pumpTestApp(
    tester,
    repository: repo,
    prefs: prefs,
    overrides: overrides,
    composeBuilder: (args) => ComposeScreen(args: args),
  );
  unawaited(router.push('/compose', extra: args));
  await tester.pumpAndSettle();
  return router;
}

/// The text a [TextField] holds, without the recipient field's sentinel.
String fieldText(WidgetTester tester, Finder finder) =>
    tester.widget<TextField>(finder).controller!.text.replaceAll('​', '');

void main() {
  testWidgets('Send is enabled only with a valid recipient; backspace removes the last chip', (tester) async {
    await openCompose(tester, FakeMailRepository());
    expect(find.text('New Message'), findsOneWidget);
    expect(find.text('Cc/Bcc, From: me@example.com'), findsOneWidget);
    expect(sendEnabled(tester), isFalse);

    await tester.enterText(toField, 'nope,');
    await tester.pump();
    expect(find.text('nope'), findsOneWidget);
    expect(sendEnabled(tester), isFalse);

    await tester.enterText(toField, 'bob@example.com,');
    await tester.pump();
    expect(find.text('bob'), findsOneWidget);
    expect(sendEnabled(tester), isTrue);

    // Backspace in the empty field: the sentinel disappears.
    await tester.enterText(toField, '');
    await tester.pump();
    expect(find.text('bob'), findsNothing);
    expect(find.text('nope'), findsOneWidget);
    expect(sendEnabled(tester), isFalse);
  });

  testWidgets('autocomplete adds a chip', (tester) async {
    await openCompose(tester, FakeMailRepository());
    await tester.enterText(toField, 'ali');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('suggestion-alice@example.com')));
    await tester.pumpAndSettle();
    expect(find.text('Alice Example'), findsOneWidget);
    expect(sendEnabled(tester), isTrue);
  });

  testWidgets('send queues with the undo delay, and Undo cancels and reopens', (tester) async {
    final repo = FakeMailRepository();
    await openCompose(tester, repo, const ComposeArgs(), {'settings.undoSendSeconds': 7});
    await tester.enterText(toField, 'alice@example.com');
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Hello');
    await tester.enterText(find.byKey(const Key('compose-body')), 'Hi Alice');
    await tester.pump();

    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    expect(repo.log, contains('send Hello undo=7'));
    final sent = repo.sent.single;
    expect(sent.to.single.email, 'alice@example.com');
    expect(sent.text, startsWith('Hi Alice'));
    expect(sent.identityId, 'acc/me');
    expect(find.text('home'), findsOneWidget);
    expect(find.text('Sending…'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(repo.cancelled, ['outbox-1']);
    expect(find.byType(ComposeScreen), findsOneWidget);
    expect(fieldText(tester, find.byKey(const Key('compose-subject'))), 'Hello');
    expect(find.text('Alice Example'), findsNothing);
    expect(find.text('alice'), findsOneWidget);
  });

  testWidgets('warns about an empty subject', (tester) async {
    final repo = FakeMailRepository();
    await openCompose(tester, repo, const ComposeArgs(to: [bob]));
    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    expect(find.text('No Subject'), findsOneWidget);
    await tester.tap(find.text('Cancel').last);
    await tester.pumpAndSettle();
    expect(repo.sent, isEmpty);

    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Send'));
    await tester.pumpAndSettle();
    expect(repo.sent, hasLength(1));
  });

  testWidgets('compose keeps Cancel, and no back button, on Android and iOS', (tester) async {
    await openCompose(tester, FakeMailRepository());
    expect(find.byKey(const Key('compose-cancel')), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
    expect(find.bySemanticsLabel('Back'), findsNothing);
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Plans');
    await tester.pump();
    await tester.tap(find.byKey(const Key('compose-cancel')));
    await tester.pumpAndSettle();
    expect(find.text('Save Draft'), findsOneWidget, reason: 'Cancel still goes through the draft sheet');
  }, variant: const TargetPlatformVariant({TargetPlatform.android, TargetPlatform.iOS}));

  testWidgets('closing with content offers Save Draft', (tester) async {
    final repo = FakeMailRepository();
    await openCompose(tester, repo);
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Plans');
    await tester.pump();
    await tester.tap(find.byKey(const Key('compose-cancel')));
    await tester.pumpAndSettle();
    expect(find.text('Delete Draft'), findsOneWidget);
    await tester.tap(find.text('Save Draft'));
    await tester.pumpAndSettle();
    expect(repo.drafts.single.subject, 'Plans');
    expect(find.text('home'), findsOneWidget);
    expect(find.text('Draft saved'), findsOneWidget);
  });

  testWidgets('closing an untouched message asks nothing; Delete Draft discards', (tester) async {
    final repo = FakeMailRepository();
    await openCompose(tester, repo);
    await tester.tap(find.byKey(const Key('compose-cancel')));
    await tester.pumpAndSettle();
    expect(find.text('home'), findsOneWidget);

    await openCompose(tester, repo);
    await tester.enterText(find.byKey(const Key('compose-body')), 'Draft text');
    await tester.pump();
    await tester.tap(find.byKey(const Key('compose-cancel')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Draft'));
    await tester.pumpAndSettle();
    expect(repo.drafts, isEmpty);
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('Reply All quotes the source and excludes my address', (tester) async {
    final repo = FakeMailRepository(
      emails: [
        testEmail('m3', to: [me, bob], cc: [const EmailAddress('carol@example.org', 'Carol')]),
      ],
      contents: {'m3': const EmailContent(emailId: 'm3', text: 'See you at noon.')},
    );
    await openCompose(tester, repo, const ComposeArgs(mode: ComposeMode.replyAll, sourceEmailId: 'm3'));

    expect(fieldText(tester, find.byKey(const Key('compose-subject'))), 'Re: Lunch plans');
    expect(find.text('Alice Example'), findsOneWidget);
    expect(find.text('Bob Builder'), findsOneWidget);
    expect(find.text('Carol'), findsOneWidget, reason: 'Cc is shown expanded');
    expect(find.text('Me Myself'), findsNothing);
    final body = fieldText(tester, find.byKey(const Key('compose-body')));
    expect(body, startsWith('\n\n-- \nCheers,\nMe\n\nOn '));
    expect(body, endsWith('Alice Example wrote:\n> See you at noon.'));

    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    final sent = repo.sent.single;
    expect(sent.mode, ComposeMode.replyAll);
    expect(sent.inReplyTo, 'm3@example.com');
    expect(sent.references, ['m3@example.com']);
    expect(sent.sourceEmailId, 'm3');
    expect(sent.cc.single.email, 'carol@example.org');
  });

  testWidgets('Reply to List goes to the List-Post address only', (tester) async {
    final repo = FakeMailRepository(
      emails: [
        testEmail(
          'm3',
          to: [const EmailAddress('dev@lists.example.org', 'Kestrel developers')],
          cc: [bob],
          subject: '[PATCH 1/2] frob: cache lookups',
          listId: 'dev.lists.example.org',
          listPost: '<mailto:dev@lists.example.org>',
        ),
      ],
      contents: {'m3': const EmailContent(emailId: 'm3', text: '+int frob;')},
    );
    await openCompose(tester, repo, const ComposeArgs(mode: ComposeMode.reply, sourceEmailId: 'm3', toList: true));
    expect(fieldText(tester, find.byKey(const Key('compose-subject'))), 'Re: [PATCH 1/2] frob: cache lookups');
    expect(find.text('Alice Example'), findsNothing);
    expect(find.text('Bob Builder'), findsNothing);
    expect(fieldText(tester, find.byKey(const Key('compose-body'))), endsWith('wrote:\n> +int frob;'));

    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    final sent = repo.sent.single;
    expect(sent.to.map((a) => a.email), ['dev@lists.example.org']);
    expect(sent.cc, isEmpty);
    expect(sent.mode, ComposeMode.reply);
    expect(sent.inReplyTo, 'm3@example.com');
  });

  testWidgets('Forward prefixes the subject once and adds the header block', (tester) async {
    final repo = FakeMailRepository(emails: [testEmail('m3', subject: 'Fwd: Lunch plans')]);
    await openCompose(tester, repo, const ComposeArgs(mode: ComposeMode.forward, sourceEmailId: 'm3'));
    expect(fieldText(tester, find.byKey(const Key('compose-subject'))), 'Fwd: Lunch plans');
    expect(fieldText(tester, find.byKey(const Key('compose-body'))), contains('---------- Forwarded message'));
    expect(sendEnabled(tester), isFalse);
  });

  testWidgets('the From picker switches identity and signature', (tester) async {
    final repo = FakeMailRepository(
      accounts: [
        testAccount,
        testAccount.copyWith(
          identities: const [Identity(id: 'home/me', email: 'me@home.test', name: 'Me', signature: 'From home')],
        ),
      ],
    );
    await openCompose(tester, repo);
    await tester.tap(find.byKey(const Key('compose-ccbcc-from')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('compose-from')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('identity-home/me')));
    await tester.pumpAndSettle();
    expect(find.text('From: Me <me@home.test>', findRichText: true), findsOneWidget);
    expect(fieldText(tester, find.byKey(const Key('compose-body'))), '\n\n-- \nFrom home');
  });

  group('Send Later', () {
    final sendLater = find.byKey(const Key('compose-send-later'));
    Finder onSend(String text) => find.descendant(of: sendButton, matching: find.textContaining(text));
    DateTime tomorrowAt8() {
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day + 1, 8);
    }

    testWidgets('a preset sets the time; Send shows it, schedules and wakes up; Undo reopens it', (tester) async {
      final repo = FakeMailRepository();
      final scheduler = RecordingScheduler();
      await openCompose(tester, repo, const ComposeArgs(to: [bob]), const {}, [
        backgroundSchedulerProvider.overrideWithValue(scheduler),
      ]);
      await tester.enterText(find.byKey(const Key('compose-subject')), 'Later');
      await tester.tap(sendLater);
      await tester.pumpAndSettle();
      expect(find.text('Tomorrow Morning'), findsOneWidget);
      expect(find.text('Pick Date & Time…'), findsOneWidget);
      expect(find.text('Send Without Delay'), findsNothing);
      await tester.tap(find.byKey(const ValueKey('send-later-tomorrowMorning')));
      await tester.pumpAndSettle();
      expect(onSend('Tomorrow'), findsOneWidget);

      await tester.tap(sendButton);
      await tester.pumpAndSettle();
      final at = tomorrowAt8();
      expect(repo.log, contains('send Later at=${at.toIso8601String()}'));
      expect(scheduler.times, [at]);
      expect(find.textContaining('Scheduled for Tomorrow at'), findsOneWidget);
      expect(find.text('home'), findsOneWidget);

      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(repo.cancelled, ['outbox-1']);
      expect(find.byType(ComposeScreen), findsOneWidget);
      expect(onSend('Tomorrow'), findsOneWidget);
    });

    testWidgets('a long-press on Send opens it; a picked time can be cleared again', (tester) async {
      final repo = FakeMailRepository();
      await openCompose(tester, repo, const ComposeArgs(to: [bob], subject: 'Hi'));
      await tester.longPress(sendButton);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('send-later-pick')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('send-later-wheel')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('send-later-done')));
      await tester.pumpAndSettle();
      expect(find.byType(FilledButton), findsOneWidget, reason: 'Send shows the picked time');

      await tester.tap(sendLater);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Send Without Delay'));
      await tester.pumpAndSettle();
      expect(sendEnabled(tester), isTrue);
      await tester.tap(sendButton);
      await tester.pumpAndSettle();
      expect(repo.log, contains('send Hi undo=10'));
    });

    testWidgets('the time on Send fits a narrow phone with large text', (tester) async {
      tester.view
        ..physicalSize = const Size(320, 700) * 3
        ..devicePixelRatio = 3;
      tester.platformDispatcher.textScaleFactorTestValue = 1.3;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      const message = OutgoingMessage(accountId: 'acc', identityId: 'acc/me', to: [bob], subject: 'A long subject');
      for (final at in [tomorrowAt8(), DateTime(2031, 12, 24, 23, 55)]) {
        await openCompose(tester, FakeMailRepository(), ComposeArgs.restore(message, sendAt: at));
        expect(tester.takeException(), isNull);
        expect(find.byType(FilledButton), findsOneWidget);
      }
    });

    testWidgets('from the Outbox: unchanged closes quietly; Send replaces the waiting message', (tester) async {
      final repo = FakeMailRepository();
      final at = DateTime(2030, 1, 7, 8);
      final message = OutgoingMessage(
        accountId: 'acc',
        identityId: 'acc/me',
        to: const [bob],
        subject: 'Report',
        text: 'Numbers',
      );
      repo.outbox.add(OutboxItem(id: 'outbox-9', message: message, sendAt: at, status: OutboxStatus.scheduled));
      final router = await openCompose(tester, repo, ComposeArgs.restore(message, sendAt: at, outboxId: 'outbox-9'));
      expect(onSend('Jan 7'), findsOneWidget);
      await tester.tap(find.byKey(const Key('compose-cancel')));
      await tester.pumpAndSettle();
      expect(find.text('home'), findsOneWidget);
      expect(repo.log, isNot(contains(startsWith('cancelSend'))));

      unawaited(
        router.push(
          '/compose',
          extra: ComposeArgs.restore(message, sendAt: at, outboxId: 'outbox-9'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('compose-subject')), 'Report, final');
      await tester.pump();
      await tester.tap(find.byKey(const Key('compose-cancel')));
      await tester.pumpAndSettle();
      expect(find.text('Delete Draft'), findsNothing);
      await tester.tap(find.text('Save Changes'));
      await tester.pumpAndSettle();
      expect(repo.log, containsAllInOrder(['cancelSend outbox-9', 'send Report, final at=${at.toIso8601String()}']));
      expect(repo.drafts, isEmpty, reason: 'nothing goes to Drafts');
      expect(repo.outbox.single.message.subject, 'Report, final');
    });
  });
}
