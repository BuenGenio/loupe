import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/conversation_bar.dart';
import 'package:loupe/features/conversation/conversation_screen.dart';
import 'package:loupe/features/conversation/message_card.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loupe/theme/loupe_icons.dart';

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

const carol = EmailAddress('carol@example.com', 'Carol Singer');

/// Three unread messages with long bodies, all shown expanded.
FakeMailRepository longThread() {
  String body(String id) => [for (var i = 1; i <= 30; i++) 'Paragraph $i of $id, long enough to read.'].join('\n\n');
  const subject = 'Your statement is ready';
  return FakeMailRepository(
    emails: [
      testEmail('a1', minutesAgo: 120, subject: subject),
      testEmail('a2', from: bob, minutesAgo: 60, subject: 'Re: $subject'),
      testEmail('a3', from: carol, minutesAgo: 5, subject: 'Re: $subject'),
    ],
    contents: {
      for (final id in ['a1', 'a2', 'a3']) id: EmailContent(emailId: id, text: body(id)),
    },
  );
}

Future<void> openLongThread(WidgetTester tester, {String id = 'a1'}) async {
  final router = await pumpTestApp(tester, repository: longThread());
  unawaited(router.push('/message/$id'));
  await tester.pumpAndSettle();
}

final compactTitle = find.byKey(ConversationBar.compactTitleKey);

Finder inCompactTitle(Finder finder) => find.descendant(of: compactTitle, matching: finder);

ScrollPosition conversationScroll(WidgetTester tester) =>
    PrimaryScrollController.of(tester.element(find.byType(ConversationBar))).position;

double barBottom(WidgetTester tester) => tester.getBottomLeft(find.byType(ConversationBar)).dy;

/// Scrolls so that [id]'s card has just reached the top bar.
Future<void> scrollCardUnderBar(WidgetTester tester, String id) async {
  final card = find.byWidgetPredicate((w) => w is MessageCard && w.message.id == id);
  final position = conversationScroll(tester);
  position.jumpTo(position.pixels + tester.getTopLeft(card).dy - barBottom(tester) + 4);
  await tester.pumpAndSettle();
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
    expect(find.byIcon(LoupeIcons.verified), findsOneWidget);

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
    expect(find.byIcon(LoupeIcons.flaggedFilled), findsWidgets);

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
    expect(find.text('Archived 2 messages'), findsOneWidget);
  });

  testWidgets('toolbar move picks a mailbox', (tester) async {
    final repo = await openThread(tester);
    await tester.tap(find.byKey(const Key('toolbar-move')));
    await tester.pumpAndSettle();
    expect(find.text('Move to…'), findsOneWidget);
    await tester.tap(find.text('Receipts'));
    await tester.pumpAndSettle();
    expect(repo.log, contains('move [m1, m3] acc|Receipts'));
    expect(find.text('Moved 2 messages to Receipts'), findsOneWidget);
  });

  group('Undo', () {
    testWidgets('after Archive puts the messages back where they were', (tester) async {
      final repo = await openThread(tester);
      await tester.tap(find.byKey(const Key('toolbar-archive')));
      await tester.pumpAndSettle();
      expect(find.text('home'), findsOneWidget);
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(repo.log, containsAllInOrder(['archive [m1, m3]', 'move [m1, m3] acc|INBOX']));
    });

    testWidgets('after Move to Junk restores the mailbox and the junk keywords', (tester) async {
      final repo = await openThread(tester);
      await tester.tap(find.byKey(const ValueKey('more-m3')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Move to Junk'));
      await tester.pumpAndSettle();
      expect(repo.log, contains('markJunk [m3] true'));
      expect(find.text('Moved 1 message to Junk'), findsOneWidget);
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(
        repo.log,
        containsAllInOrder([
          'move [m3] acc|INBOX',
          'setKeywords [m3] +{} -{\$junk}',
          'setKeywords [m3] +{} -{\$notjunk}',
        ]),
      );
    });

    testWidgets('after Move puts the messages back; a mailbox of each message is kept', (tester) async {
      final repo = FakeMailRepository(
        emails: [
          testEmail('a1', minutesAgo: 30, keywords: {Keywords.seen}),
          testEmail('a2', minutesAgo: 10, keywords: {Keywords.seen}),
        ],
      );
      final router = await pumpTestApp(tester, repository: repo);
      unawaited(router.push('/message/a2'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('toolbar-move')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Receipts'));
      await tester.pumpAndSettle();
      expect(repo.emails.map((e) => e.mailboxId), everyElement('acc|Receipts'));
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(repo.emails.map((e) => e.mailboxId), everyElement('acc|INBOX'));
    });

    testWidgets('deleting permanently from Trash asks first and offers no Undo', (tester) async {
      final repo = FakeMailRepository(
        emails: [
          testEmail('t1', mailboxId: 'acc|Trash', keywords: {Keywords.seen}),
        ],
      );
      final router = await pumpTestApp(tester, repository: repo);
      unawaited(router.push('/message/t1'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('more-t1')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete Permanently'));
      await tester.pumpAndSettle();
      expect(find.text('Delete this message permanently?'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(repo.log.where((l) => l.startsWith('trash')), isEmpty);
      expect(bodyOf('t1'), findsOneWidget, reason: 'still open');

      await tester.tap(find.byKey(const ValueKey('more-t1')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete Permanently'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete Permanently').last);
      await tester.pumpAndSettle();
      expect(repo.log, contains('trash [t1]'));
      expect(find.text('Deleted 1 message'), findsOneWidget);
      expect(find.text('Undo'), findsNothing);
      expect(find.text('home'), findsOneWidget);
    });
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

  group('top bar', () {
    testWidgets('is clear at rest, without a compact title, over the subject and sender', (tester) async {
      await openLongThread(tester);
      expect(compactTitle, findsNothing);
      expect(find.byType(BackButton), findsNothing);
      expect(find.bySemanticsLabel('Back'), findsNothing, reason: 'Android goes back with its own gesture');
      // The large subject and the sender row start below the bar.
      expect(tester.getTopLeft(find.text('Your statement is ready')).dy, greaterThanOrEqualTo(barBottom(tester)));
      expect(tester.getTopLeft(find.byKey(const ValueKey('sender-a1'))).dy, greaterThan(barBottom(tester)));
      expect(conversationScroll(tester).pixels, 0);
    });

    testWidgets('once the subject scrolls under it, shows the sender and the subject', (tester) async {
      await openLongThread(tester);
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -40));
      await tester.pumpAndSettle();
      expect(compactTitle, findsNothing, reason: 'the subject is still partly in view');

      await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(compactTitle, findsOneWidget);
      expect(inCompactTitle(find.text('Alice Example')), findsOneWidget);
      expect(inCompactTitle(find.text('Your statement is ready')), findsOneWidget);
      // At the left gutter, on the top line.
      expect(tester.getTopLeft(compactTitle).dx, 16);
      expect(tester.getRect(compactTitle).bottom, lessThanOrEqualTo(barBottom(tester)));
      // The content scrolls on under the bar.
      expect(tester.getBottomLeft(find.text('Your statement is ready')).dy, lessThanOrEqualTo(barBottom(tester)));
    });

    testWidgets('in a three-message thread, the sender follows the message being read', (tester) async {
      await openLongThread(tester);
      await scrollCardUnderBar(tester, 'a1');
      expect(inCompactTitle(find.text('Alice Example')), findsOneWidget);

      await scrollCardUnderBar(tester, 'a2');
      expect(inCompactTitle(find.text('Bob Builder')), findsOneWidget);
      expect(inCompactTitle(find.text('Alice Example')), findsNothing);
      expect(inCompactTitle(find.text('Your statement is ready')), findsOneWidget, reason: 'the subject stays');

      await scrollCardUnderBar(tester, 'a3');
      expect(inCompactTitle(find.text('Carol Singer')), findsOneWidget);
      expect(inCompactTitle(find.text('Your statement is ready')), findsOneWidget);

      // Back up into the first message.
      final position = conversationScroll(tester);
      position.jumpTo(position.pixels - tester.getTopLeft(find.byKey(const ValueKey('avatar-a3'))).dy);
      await tester.pumpAndSettle();
      expect(inCompactTitle(find.text('Bob Builder')), findsOneWidget);
    });

    testWidgets('a conversation opened at a later message shows it under the bar, with its sender', (tester) async {
      await openLongThread(tester, id: 'a2');
      // a1 is unread, so it's open above; a2's header sits right under the bar.
      expect(bodyOf('a1'), findsOneWidget);
      final header = tester.getTopLeft(find.byKey(const ValueKey('avatar-a2'))).dy;
      expect(header, greaterThanOrEqualTo(barBottom(tester)));
      expect(header, lessThan(barBottom(tester) + 40));
      expect(inCompactTitle(find.text('Bob Builder')), findsOneWidget);
      expect(inCompactTitle(find.text('Your statement is ready')), findsNothing);
      expect(inCompactTitle(find.text('Re: Your statement is ready')), findsOneWidget, reason: "the target's subject");
    });

    testWidgets('tapping the compact title scrolls back to the top', (tester) async {
      await openLongThread(tester);
      await scrollCardUnderBar(tester, 'a3');
      expect(compactTitle, findsOneWidget);
      await tester.tap(compactTitle);
      await tester.pumpAndSettle();
      expect(conversationScroll(tester).pixels, 0);
      expect(compactTitle, findsNothing);
      expect(find.text('Your statement is ready'), findsOneWidget);
    });

    testWidgets('with reduced motion, the compact title appears without animating', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        disableAnimations: true,
      );
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
      await openLongThread(tester);
      final position = conversationScroll(tester);
      position.jumpTo(400);
      await tester.pump();
      await tester.pump();
      final fade = tester.widget<FadeTransition>(
        find.ancestor(of: compactTitle, matching: find.byType(FadeTransition)).first,
      );
      expect(fade.opacity.value, 1);
    });

    testWidgets('has a back button on iOS only, and none embedded in a pane', (tester) async {
      final ios = debugDefaultTargetPlatformOverride == TargetPlatform.iOS;
      await openLongThread(tester);
      expect(find.bySemanticsLabel('Back'), ios ? findsOneWidget : findsNothing);
      expect(find.byType(BackButton), findsNothing);
      if (ios) {
        await scrollCardUnderBar(tester, 'a2');
        // The compact title sits after the chevron.
        expect(
          tester.getTopLeft(compactTitle).dx,
          greaterThanOrEqualTo(tester.getRect(find.bySemanticsLabel('Back')).right),
        );
        await tester.tap(find.bySemanticsLabel('Back'));
      } else {
        await tester.binding.handlePopRoute();
      }
      await tester.pumpAndSettle();
      expect(find.text('home'), findsOneWidget);

      await pumpTestApp(
        tester,
        repository: threadRepository(),
        home: Scaffold(
          body: Row(
            children: [
              const Expanded(child: Text('list')),
              Expanded(
                child: ConversationScreen(emailId: 'm3', onClose: () {}),
              ),
            ],
          ),
        ),
      );
      expect(find.bySemanticsLabel('Back'), findsNothing);
    }, variant: const TargetPlatformVariant({TargetPlatform.android, TargetPlatform.iOS}));
  });

  group('bottom bar', () {
    testWidgets('Aa is in the bottom bar, first, and opens the reader options; none in the top bar', (tester) async {
      await openThread(tester);
      final aa = find.byKey(const Key('reader-options'));
      expect(find.text('Aa'), findsOneWidget);
      expect(find.descendant(of: find.byType(ConversationBar), matching: find.text('Aa')), findsNothing);
      expect(find.descendant(of: aa, matching: find.text('Aa')), findsOneWidget);
      final flag = tester.getCenter(find.byKey(const Key('toolbar-flag')));
      expect(tester.getCenter(aa).dy, flag.dy);
      expect(tester.getCenter(aa).dx, lessThan(flag.dx));
      expect(tester.getCenter(aa).dy, greaterThan(tester.getCenter(find.text('See you at noon.')).dy));

      await tester.tap(aa);
      await tester.pumpAndSettle();
      expect(find.text('Readable'), findsOneWidget);
      expect(find.text('Original'), findsOneWidget);
      expect(find.text('Plain'), findsOneWidget);
    });

    testWidgets('fits six evenly spaced buttons on a 360 dp phone with large text', (tester) async {
      tester.view.physicalSize = const Size(360 * 3, 740 * 3);
      tester.view.devicePixelRatio = 3;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await openThread(tester);
      expect(tester.takeException(), isNull);
      final keys = [
        'reader-options',
        'toolbar-flag',
        'toolbar-move',
        'toolbar-archive',
        'toolbar-reply',
        'toolbar-compose',
      ];
      final rects = [for (final k in keys) tester.getRect(find.byKey(Key(k)))];
      final gaps = [for (var i = 1; i < rects.length; i++) rects[i].center.dx - rects[i - 1].center.dx];
      for (final g in gaps) {
        expect(g, closeTo(60, 0.5));
      }
      for (final r in rects) {
        expect(r.left, greaterThanOrEqualTo(0));
        expect(r.right, lessThanOrEqualTo(360));
        expect(r.height, greaterThanOrEqualTo(44));
        expect(r.center.dy, closeTo(rects.first.center.dy, 0.5));
      }
      // "Aa" keeps the icons' size and isn't clipped.
      final aa = tester.getRect(find.text('Aa'));
      expect(aa.height, lessThanOrEqualTo(24));
      expect(aa.width, lessThan(rects.first.width));
    });
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
