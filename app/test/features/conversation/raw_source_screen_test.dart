import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/raw_source_screen.dart';
import 'package:loupe/theme/theme.dart';

import 'fake_mail_repository.dart';
import 'test_app.dart';

/// A long message like the one in the report: many Received and ARC
/// headers, then the body.
String longSource(int lines) => [
  for (var i = 0; i < lines - 3; i++)
    i.isEven
        ? 'Received: from relay$i.example.net (relay$i.example.net [192.0.2.${i % 250}]) by mx.example.com'
        : 'ARC-Seal: i=$i; a=rsa-sha256; t=1759590000; cv=pass; d=example.com; s=arc; b=AbCdEf$i',
  'Subject: Long',
  '',
  'The last line of the body',
].join('\r\n');

ScrollPosition _position(WidgetTester tester) => tester.state<ScrollableState>(_list()).position;

Finder _list() => find.descendant(of: find.byKey(const Key('source-list')), matching: find.byType(Scrollable)).first;

Future<void> _open(WidgetTester tester, FakeMailRepository repo) async {
  // The app's scroll behaviour: always scrollable, bouncing. The old
  // SelectableText screen sprang back to the top under it.
  final router = await pumpTestApp(tester, repository: repo, scrollBehavior: const LoupeScrollBehavior());
  unawaited(router.push('/source/m1'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows the raw source, toggles wrapping and copies all of it', (tester) async {
    final repo = FakeMailRepository(emails: [testEmail('m1')]);
    final router = await pumpTestApp(tester, repository: repo);
    unawaited(router.push('/source/m1'));
    await tester.pumpAndSettle();

    expect(repo.log, contains('loadRawSource m1'));
    expect(find.text('Subject: Hello'), findsOneWidget);
    expect(find.text('Raw body of m1'), findsOneWidget);
    expect(find.byType(SelectionArea), findsOneWidget);
    expect(find.byType(SelectableText), findsNothing);

    expect(find.byTooltip("Don't Wrap Lines"), findsOneWidget);
    expect(tester.widget<Text>(find.text('Subject: Hello')).softWrap, isTrue);
    await tester.tap(find.byKey(const Key('source-wrap')));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Wrap Lines'), findsOneWidget);
    expect(tester.widget<Text>(find.text('Subject: Hello')).softWrap, isFalse);

    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String;
      return null;
    });
    await tester.tap(find.byTooltip('Copy All'));
    await tester.pumpAndSettle();
    expect(copied, contains('Raw body of m1'));
    expect(find.text('Source copied'), findsOneWidget);
  });

  testWidgets('a 5,000-line source scrolls to its last line, wrapped and not', (tester) async {
    final repo = FakeMailRepository(emails: [testEmail('m1')])..rawSources['m1'] = longSource(5000);
    await _open(tester, repo);
    expect(find.text('The last line of the body'), findsNothing);

    // Wrapped: fling like a person would.
    await tester.scrollUntilVisible(find.text('The last line of the body'), 3000, scrollable: _list(), maxScrolls: 200);
    await tester.pumpAndSettle();
    expect(find.text('The last line of the body'), findsOneWidget);
    expect(_position(tester).pixels, greaterThan(0), reason: 'did not spring back');

    // Unwrapped: back at the top, the scrollbar's thumb takes it to the end.
    await tester.tap(find.byKey(const Key('source-wrap')));
    await tester.pumpAndSettle();
    _position(tester).jumpTo(0);
    await tester.pumpAndSettle();
    expect(find.text('The last line of the body'), findsNothing);
    final list = tester.getRect(find.byKey(const Key('source-scrollbar')));
    await tester.dragFrom(list.center, const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(_position(tester).pixels, greaterThan(200), reason: 'scrolls vertically when not wrapped');
    _position(tester).jumpTo(0);
    await tester.pumpAndSettle();
    await tester.dragFrom(Offset(list.right - 3, list.top + 20), Offset(0, list.height));
    await tester.pumpAndSettle();
    expect(find.text('The last line of the body'), findsOneWidget);
    expect(_position(tester).pixels, _position(tester).maxScrollExtent);

    // Long lines scroll sideways.
    final sideways = tester.state<ScrollableState>(
      find.byWidgetPredicate((w) => w is Scrollable && w.axisDirection == AxisDirection.right),
    );
    expect(sideways.position.maxScrollExtent, greaterThan(0));
    await tester.dragFrom(list.center, const Offset(-200, 0));
    await tester.pumpAndSettle();
    expect(sideways.position.pixels, greaterThan(0));
  });

  test('splits lines, drops CRs, cuts very long lines and measures the widest', () {
    final lines = SourceLines.parse('a\r\nbb\r\n\r\n${'x' * 25}\nü', maxLineLength: 10);
    expect(lines.rows, ['a', 'bb', '', 'x' * 10, 'x' * 10, 'x' * 5, 'ü']);
    expect(lines.columns, 10);
    expect(SourceLines.parse('wide 漢字').columns, 9);
    expect(SourceLines.parse('').rows, isEmpty);
    expect(SourceLines.parse('end\r\n').rows, ['end']);
  });

  test('cuts long lines between characters, never inside an emoji', () {
    final lines = SourceLines.parse('${'x' * 9}😀${'y' * 5}', maxLineLength: 10);
    expect(lines.rows, ['x' * 9, '😀${'y' * 5}']);
    for (final row in lines.rows) {
      expect(row.runes.any((r) => r >= 0xD800 && r <= 0xDFFF), isFalse, reason: 'no lone surrogate in "$row"');
    }
  });

  test('decodes UTF-8 and falls back to Latin-1', () {
    expect(decodeRawSource([0x63, 0x61, 0x66, 0xC3, 0xA9]), 'café');
    expect(decodeRawSource([0x63, 0x61, 0x66, 0xE9]), 'café');
  });
}
