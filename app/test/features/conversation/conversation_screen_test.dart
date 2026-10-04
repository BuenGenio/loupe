import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/conversation_screen.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_mail_repository.dart';
import 'test_app.dart';

Finder bodyOf(String id) => find.byWidgetPredicate((w) => w is ReadableMessageView && w.content.emailId == id);

FakeMailRepository threadRepository() => FakeMailRepository(
  emails: [
    testEmail('m1', minutesAgo: 120, keywords: {Keywords.seen}),
    testEmail('m2', from: me, to: [alice], minutesAgo: 60, keywords: {Keywords.seen}, mailboxId: 'acc|Sent'),
    testEmail('m3', minutesAgo: 5, cc: [bob]),
  ],
  contents: {
    'm3': const EmailContent(
      emailId: 'm3',
      text: 'See you at noon.',
      headers: [
        ('Authentication-Results', 'mx.example.com; dkim=pass header.d=example.com; spf=pass; dmarc=pass'),
        ('Subject', 'Lunch plans'),
      ],
    ),
  },
);

Future<FakeMailRepository> openThread(WidgetTester tester, {String id = 'm3'}) async {
  final repo = threadRepository();
  final router = await pumpTestApp(tester, repository: repo);
  unawaited(router.push('/message/$id'));
  await tester.pumpAndSettle();
  return repo;
}

Future<void> goBack(WidgetTester tester) async {
  Navigator.of(tester.element(find.byType(Scaffold).last)).pop();
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('stacks the conversation, expands the target and unread, collapses older read ones', (tester) async {
    await openThread(tester);

    expect(find.text('Lunch plans'), findsOneWidget);
    expect(bodyOf('m3'), findsOneWidget);
    expect(bodyOf('m1'), findsNothing);
    expect(find.byKey(const ValueKey('collapsed-m1')), findsOneWidget);
    expect(find.text('Preview of m1'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('collapsed-m1')));
    await tester.pumpAndSettle();
    expect(bodyOf('m1'), findsOneWidget);

    // Tapping the avatar of an expanded message collapses it again.
    await tester.tap(find.byKey(const ValueKey('avatar-m1')));
    await tester.pumpAndSettle();
    expect(bodyOf('m1'), findsNothing);
    expect(find.byKey(const ValueKey('collapsed-m1')), findsOneWidget);
  });

  testWidgets('marks the target as seen when opened', (tester) async {
    final repo = await openThread(tester);
    expect(repo.keywordCalls.where((c) => c.ids.contains('m3') && c.add.contains(Keywords.seen)), hasLength(1));
    expect(repo.keywordCalls.expand((c) => c.ids), isNot(contains('m1')));
  });

  testWidgets('shows the recipient line, its details and the verified badge', (tester) async {
    await openThread(tester);
    expect(find.text('to me, Bob Builder'), findsOneWidget);
    expect(find.byIcon(Icons.verified), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('recipients-m3')));
    await tester.pumpAndSettle();
    expect(find.text('Cc'), findsOneWidget);
    expect(find.text('DKIM pass · SPF pass · DMARC pass'), findsOneWidget);
  });

  testWidgets('the Aa sheet changes the view mode', (tester) async {
    await openThread(tester);
    expect(tester.widget<ReadableMessageView>(bodyOf('m3')).settings.mode, ReaderMode.readable);

    await tester.tap(find.byKey(const Key('reader-options')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Plain'));
    await tester.pumpAndSettle();
    expect(find.text('Mono'), findsOneWidget);
    await tester.tap(find.text('Mono'));
    await tester.pumpAndSettle();

    final settings = tester.widget<ReadableMessageView>(bodyOf('m3')).settings;
    expect(settings.mode, ReaderMode.plain);
    expect(settings.plainFont, PlainTextFont.mono);
  });

  testWidgets('remembers the view mode for the sender', (tester) async {
    await openThread(tester);
    await tester.tap(find.byKey(const Key('reader-options')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('reader-remember')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Plain'));
    await tester.pumpAndSettle();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('reader.senders'), allOf(contains('alice@example.com'), contains('plain')));
  });

  testWidgets('toolbar flag, archive and reply call the repository', (tester) async {
    final repo = await openThread(tester);

    await tester.tap(find.byKey(const Key('toolbar-flag')));
    await tester.pumpAndSettle();
    expect(repo.log, contains('setKeywords [m3] +{\$flagged} -{}'));
    expect(find.byIcon(Icons.flag), findsWidgets);

    await tester.tap(find.byKey(const Key('toolbar-reply')));
    await tester.pumpAndSettle();
    expect(find.text('compose reply m3 ()'), findsOneWidget);
    await goBack(tester);

    await tester.longPress(find.byKey(const Key('toolbar-reply')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Forward'));
    await tester.pumpAndSettle();
    expect(find.text('compose forward m3 ()'), findsOneWidget);
    await goBack(tester);

    // Archives the conversation's messages in this mailbox (not the Sent copy) and closes.
    await tester.tap(find.byKey(const Key('toolbar-archive')));
    await tester.pumpAndSettle();
    expect(repo.log, contains('archive [m1, m3]'));
    expect(find.text('home'), findsOneWidget);
    expect(find.text('Archived'), findsOneWidget);
  });

  testWidgets('toolbar move picks a mailbox', (tester) async {
    final repo = await openThread(tester);
    await tester.tap(find.byKey(const Key('toolbar-move')));
    await tester.pumpAndSettle();
    expect(find.text('Move to…'), findsOneWidget);
    await tester.tap(find.text('Receipts'));
    await tester.pumpAndSettle();
    expect(repo.log, contains('move [m1, m3] acc|Receipts'));
    expect(find.text('Moved to Receipts'), findsOneWidget);
  });

  testWidgets('the … menu marks unread, tags and shows headers', (tester) async {
    final repo = await openThread(tester);

    await tester.tap(find.byKey(const ValueKey('more-m3')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mark as Unread'));
    await tester.pumpAndSettle();
    expect(repo.log.last, 'setKeywords [m3] +{} -{\$seen}');

    await tester.tap(find.byKey(const ValueKey('more-m3')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tags…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Work'));
    await tester.pumpAndSettle();
    expect(repo.log.last, 'setKeywords [m3] +{\$label2} -{}');
    await tester.tapAt(const Offset(200, 40));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('more-m3')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Show All Headers'));
    await tester.pumpAndSettle();
    expect(find.text('All Headers'), findsOneWidget);
    expect(find.textContaining('dkim=pass', findRichText: true), findsOneWidget);
  });

  testWidgets('sender sheet toggles VIP and searches', (tester) async {
    final repo = await openThread(tester);
    await tester.tap(find.byKey(const ValueKey('sender-m3')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('vip-switch')));
    await tester.pumpAndSettle();
    expect(repo.log, contains('setVip alice@example.com true'));

    await tester.tap(find.text('Search Messages from Alice Example'));
    await tester.pumpAndSettle();
    expect(find.text('search f:"alice@example.com"'), findsOneWidget);
  });

  testWidgets('embedded in a split view it shows no Back button and calls onClose', (tester) async {
    var closed = 0;
    await pumpTestApp(
      tester,
      repository: threadRepository(),
      home: Scaffold(
        body: Row(
          children: [
            const Expanded(child: Text('list')),
            Expanded(
              child: ConversationScreen(emailId: 'm3', onClose: () => closed++),
            ),
          ],
        ),
      ),
    );
    expect(bodyOf('m3'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
    await tester.tap(find.byKey(const Key('toolbar-archive')));
    await tester.pumpAndSettle();
    expect(closed, 1);
    expect(find.text('list'), findsOneWidget);
  });

  testWidgets('shows the empty state when the message is gone', (tester) async {
    final repo = FakeMailRepository();
    final router = await pumpTestApp(tester, repository: repo);
    unawaited(router.push('/message/missing'));
    await tester.pumpAndSettle();
    expect(find.text('No Message'), findsOneWidget);
  });

  testWidgets('shows MailException messages when the body fails to load', (tester) async {
    final repo = threadRepository()..contentError = const MailException(MailErrorKind.server, 'Server said no');
    final router = await pumpTestApp(tester, repository: repo);
    unawaited(router.push('/message/m3'));
    await tester.pumpAndSettle();
    expect(find.text('Server said no'), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);
  });
}
