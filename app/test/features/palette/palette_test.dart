import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/features/palette/command_palette.dart';
import 'package:loupe/features/palette/fuzzy.dart';
import 'package:loupe/features/palette/palette_items.dart';
import 'package:loupe/features/panes/mail_selection.dart';
import 'package:loupe/features/search/search_screen.dart';
import 'package:loupe/features/settings/swipe_settings_screen.dart';
import 'package:loupe/shared/message_row.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:mail_model/mail_model.dart';

import '../panes/fake_app.dart';

const wide = Size(1280, 800);
const phone = Size(390, 844);

PaletteItem item(
  String title, {
  String? subtitle,
  PaletteKind kind = PaletteKind.mailbox,
  List<String> keywords = const [],
}) => PaletteItem(
  id: '$subtitle/$title',
  title: title,
  subtitle: subtitle,
  kind: kind,
  icon: LoupeIcons.folder,
  keywords: keywords,
  run: () {},
);

List<String> titles(List<PaletteItem> items) => [for (final i in items) i.title];

ProviderContainer containerOf(WidgetTester tester) => ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));

Future<void> openPalette(WidgetTester tester) => press(tester, LogicalKeyboardKey.keyK, ctrl: true);

Future<void> type(WidgetTester tester, String text) async {
  await tester.enterText(find.byKey(const Key('palette-field')), text);
  await tester.pumpAndSettle();
}

void main() {
  group('fuzzy matching', () {
    test('needs the letters in order, ignoring case, accents and spaces', () {
      expect(fuzzyScore('arch', 'Archive'), isNotNull);
      expect(fuzzyScore('ARCH', 'archive'), isNotNull);
      expect(fuzzyScore('resume', 'Résumé drafts'), isNotNull);
      expect(fuzzyScore('mark read', 'Mark All as Read'), isNotNull);
      expect(fuzzyScore('hcra', 'Archive'), isNull);
      expect(fuzzyScore('xyz', 'Archive'), isNull);
      expect(fuzzyScore('archives', 'Archive'), isNull);
    });

    test('a prefix beats a word inside, which beats scattered letters', () {
      final prefix = fuzzyScore('inbox', 'Inbox')!;
      final word = fuzzyScore('inbox', 'All Inboxes')!;
      final scattered = fuzzyScore('inbox', 'Invoices from Box')!;
      expect(prefix, greaterThan(word));
      expect(word, greaterThan(scattered));
    });

    test('word starts count: initials find their words', () {
      expect(fuzzyScore('mar', 'Mark All as Read')!, greaterThan(fuzzyScore('mar', 'Summary')!));
      expect(fuzzyScore('ks', 'Keyboard Shortcuts')!, greaterThan(fuzzyScore('ks', 'Bookshelves')!));
    });
  });

  group('ranking', () {
    final items = [
      item('Archive', kind: PaletteKind.action),
      item('All Inboxes'),
      item('Inbox', subtitle: 'Personal'),
      item('Inbox', subtitle: 'Work'),
      item('Settings', kind: PaletteKind.setting),
      item('New Message', kind: PaletteKind.action, keywords: ['compose']),
    ];

    test('best match first; nothing that doesn’t match', () {
      expect(titles(rankPalette(items, 'arch')), ['Archive']);
      expect(titles(rankPalette(items, 'inbox')).take(2), ['Inbox', 'Inbox']);
      expect(titles(rankPalette(items, 'inbox')), contains('All Inboxes'));
    });

    test('keywords and the subtitle are searched too', () {
      expect(titles(rankPalette(items, 'compose')), ['New Message']);
      expect(rankPalette(items, 'work inbox').first.subtitle, 'Work');
    });

    test('the recently used come first, with or without a query', () {
      final recent = items[3]; // Work's Inbox
      expect(rankPalette(items, 'inbox', recents: [recent.id]).first, recent);
      expect(rankPalette(items, '', recents: ['null/Settings']).first.title, 'Settings');
      expect(rankPalette(items, ''), hasLength(items.length));
    });
  });

  group('the palette', () {
    testWidgets('Ctrl+K, a few letters and Enter run an action on the conversation shown', (tester) async {
      final repo = threeConversations();
      await pumpAppOn(tester, repo, size: wide);
      await tester.tap(find.descendant(of: find.byType(MessageRow), matching: find.text('Lunch plans')));
      await tester.pumpAndSettle();
      await openPalette(tester);
      expect(find.byType(CommandPalette), findsOneWidget);
      await type(tester, 'arch');
      await press(tester, LogicalKeyboardKey.enter);
      expect(find.byType(CommandPalette), findsNothing);
      expect(repo.log, contains('archive [m1]'));
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
    });

    testWidgets('jumps to a mailbox, which is then first next time', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: wide);
      await openPalette(tester);
      await type(tester, 'receipts');
      await press(tester, LogicalKeyboardKey.enter);
      expect(containerOf(tester).read(mailSelectionProvider).list, const MailboxTarget(RealMailboxRef('acc|Receipts')));
      await openPalette(tester);
      final first = tester.widget<Text>(
        find
            .descendant(
              of: find.descendant(of: find.byType(CommandPalette), matching: find.byType(ListView)),
              matching: find.byType(Text),
            )
            .first,
      );
      expect(first.data, 'Receipts');
    });

    testWidgets('the arrows choose; Enter opens a settings page', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: phone);
      await openPalette(tester);
      await type(tester, 'swipe');
      await press(tester, LogicalKeyboardKey.arrowDown);
      await press(tester, LogicalKeyboardKey.arrowUp);
      await press(tester, LogicalKeyboardKey.enter);
      expect(find.byType(SwipeSettingsScreen), findsOneWidget);
    });

    testWidgets('“Search mail for …” searches every mailbox and is remembered', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: wide);
      await openPalette(tester);
      await type(tester, 'gooseberry');
      expect(find.text('Search mail for “gooseberry”'), findsOneWidget);
      await press(tester, LogicalKeyboardKey.enter);
      expect(tester.widget<SearchScreen>(find.byType(SearchScreen)).initialQuery, 'gooseberry');
      // A recent search now.
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      await openPalette(tester);
      await type(tester, 'goose');
      expect(find.text('Recent Search'), findsOneWidget);
    });

    testWidgets('a long press on the search field opens it on a phone', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: phone);
      await tester.longPress(find.text('Search'));
      await tester.pumpAndSettle();
      expect(find.byType(CommandPalette), findsOneWidget);
      // Esc closes it.
      await press(tester, LogicalKeyboardKey.escape);
      expect(find.byType(CommandPalette), findsNothing);
    });
  });
}
