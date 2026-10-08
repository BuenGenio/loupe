import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/mailing_lists/list_providers.dart';
import 'package:loupe/features/mailing_lists/mailing_list_screen.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:loupe/router.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';

const kestrel = 'dev.lists.example.org';

/// Scrolls [finder] into the middle of the screen, clear of the bars.
Future<void> reveal(WidgetTester tester, Finder finder) async {
  await tester.scrollTo(finder);
  await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => ReadableMessageView.debugSynchronous = true);
  tearDownAll(() => ReadableMessageView.debugSynchronous = false);

  group('thread titles and participants', () {
    test('reply prefixes, the list tag and the patch tag go; other tags stay', () {
      final l10n = lookupAppLocalizations(const Locale('en'));
      expect(listThreadTitle('[PATCH v2 0/3] Cache headers', listId: kestrel, l10n: l10n), 'Cache headers');
      expect(listThreadTitle('Re: [dev] [PATCH] fix', listId: kestrel, l10n: l10n), 'fix');
      expect(
        listThreadTitle('[open-garden] RFC: manifest v2', listId: 'open-garden.lists.opengarden.example', l10n: l10n),
        'RFC: manifest v2',
      );
      expect(
        listThreadTitle('[RFC] [PATCH 1/2] keep the RFC tag', listId: kestrel, l10n: l10n),
        '[RFC] [PATCH 1/2] keep the RFC tag',
      );
      expect(listThreadTitle('[ANN] Kestrel 2.3', listId: kestrel, l10n: l10n), '[ANN] Kestrel 2.3');
      expect(listThreadTitle('[PATCH]', listId: kestrel, l10n: l10n), '[PATCH]');
      expect(listThreadTitle('  ', listId: kestrel, l10n: l10n), 'No Subject');
    });

    test('up to three names, then a count', () {
      const people = [
        EmailAddress('a@x', 'Ann'),
        EmailAddress('b@x', 'Ben'),
        EmailAddress('c@x', 'Cat'),
        EmailAddress('d@x', 'Dan'),
      ];
      expect(participantsLine(people.take(2).toList()), 'Ann, Ben');
      expect(participantsLine(people), 'Ann, Ben, Cat +1');
      expect(participantsLine(const []), '');
    });
  });

  testWidgets('Subscriptions › Discussions lists the mailing lists; a list shows its threads forum style', (
    tester,
  ) async {
    await pumpLoupe(tester);
    // Mailboxes doesn't list every list; Subscriptions does.
    expect(find.text('Mailing Lists'), findsNothing);
    await tester.tap(find.text('Subscriptions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discussions'));
    await tester.pumpAndSettle();
    expect(find.text('Open Garden development'), findsOneWidget);
    await tester.tap(find.text('Kestrel developers'));
    await tester.pumpAndSettle();

    expect(find.byType(MailingListScreen), findsOneWidget);
    expect(find.text(kestrel), findsOneWidget);
    final rows = tester.widgetList<ListThreadRow>(find.byType(ListThreadRow)).toList();
    expect(rows.map((r) => r.thread.patchBadge ?? r.thread.first.subject), [
      'PATCH v2 3/3',
      'PATCH',
      'Planning 2.4: freeze on the 20th?',
    ]);
    expect(find.text('Cache parsed headers on keep-alive connections'), findsOneWidget);
    expect(find.text('PATCH v2 3/3'), findsOneWidget);
    expect(find.text('Ines Duarte, Oskar Lind, Malik Osei'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('the list’s menu pins it to Mailboxes and treats it as a newsletter', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.mailingList(kestrel));
    await tester.tap(find.byTooltip('List Options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pin to Mailboxes'));
    await tester.pumpAndSettle();
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList('subscriptions.pinnedLists'), [kestrel]);

    await tester.tap(find.byTooltip('List Options'));
    await tester.pumpAndSettle();
    expect(find.text('Unpin from Mailboxes'), findsOneWidget);
    await tester.tap(find.text('Treat as Newsletter'));
    await tester.pumpAndSettle();
    final kestrelSub = (await repo.watchSubscriptions().first).firstWhere((s) => s.listId == kestrel);
    expect(kestrelSub.kind, SubscriptionKind.newsletter);
    await drainTimers(tester);
  });

  testWidgets('muting a thread hides it; it can be shown and unmuted', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.mailingList(kestrel));
    await tester.longPress(find.text('Cache parsed headers on keep-alive connections'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mute Thread'));
    await tester.pumpAndSettle();
    expect(find.text('Cache parsed headers on keep-alive connections'), findsNothing);
    expect(find.text('Thread muted. New messages in it arrive read.'), findsOneWidget);
    expect(await repo.watchMutedThreads().first, hasLength(1));

    await tester.tap(find.byTooltip('List Options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Show Muted Threads'));
    await tester.pumpAndSettle();
    final muted = find.text('Cache parsed headers on keep-alive connections');
    expect(muted, findsOneWidget);
    expect(
      find.descendant(of: find.byType(ListThreadRow).first, matching: find.byIcon(LoupeIcons.mute)),
      findsOneWidget,
    );
    await tester.longPress(muted);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Unmute Thread'));
    await tester.pumpAndSettle();
    expect(await repo.watchMutedThreads().first, isEmpty);
    await drainTimers(tester);
  });

  testWidgets('a patch reads as a diff; Reply List and Mute are in the message menu', (tester) async {
    final repo = await pumpLoupe(tester);
    final series = (await repo.watchListThreads(kestrel).first).first;
    final conversation = await repo.watchConversation(series.first.id).first;
    final patch2 = conversation.firstWhere((m) => m.subject.startsWith('[PATCH v2 2/3]'));
    await goTo(tester, Routes.message(patch2.id));

    // The patch, and the review below it that quotes the hunk.
    final hunk = textContaining('@@ -214,10 +215,14 @@ static void conn_reset');
    await tester.scrollTo(hunk.first);
    expect(hunk, findsWidgets);
    expect(textContaining('1 file changed'), findsWidgets);

    await reveal(tester, find.byKey(ValueKey('more-${patch2.id}')));
    await tester.tap(find.byKey(ValueKey('more-${patch2.id}')));
    await tester.pumpAndSettle();
    expect(find.text('Mute Thread'), findsOneWidget);
    await tester.tap(find.text('Reply List'));
    await tester.pumpAndSettle();
    // To the list (its address has no name: the chip says "dev"), not to Ines.
    final to = find.ancestor(of: find.byKey(const ValueKey('recipients-To:')), matching: find.byType(Wrap));
    expect(find.descendant(of: to, matching: find.text('dev')), findsOneWidget);
    expect(find.text('Ines Duarte'), findsNothing);
    await drainTimers(tester);
  });

  testWidgets('Settings › Technical Lists opens a list in plain text, Mono', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.settings);
    await reveal(tester, find.byKey(const Key('technical-lists')));
    expect(find.descendant(of: find.byKey(const Key('technical-lists')), matching: find.text('None')), findsOneWidget);
    await tester.tap(find.byKey(const Key('technical-lists')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kestrel developers'));
    await tester.pumpAndSettle();
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList('reader.technicalLists'), [kestrel]);

    final docs = (await repo.watchListThreads(kestrel).first).firstWhere((t) => t.patchBadge == 'PATCH');
    await goTo(tester, Routes.message(docs.latest.id));
    final view = tester.widget<ReadableMessageView>(find.byType(ReadableMessageView).first);
    expect(view.settings.mode, ReaderMode.plain);
    expect(view.settings.plainFont, PlainTextFont.mono);

    // Other mail keeps the default view.
    final garden = (await repo.watchListThreads('open-garden.lists.opengarden.example').first).first;
    await goTo(tester, Routes.message(garden.latest.id));
    expect(
      tester.widget<ReadableMessageView>(find.byType(ReadableMessageView).last).settings.mode,
      ReaderMode.readable,
    );
    await drainTimers(tester);
  });
}
