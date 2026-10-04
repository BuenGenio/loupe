import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/raw_source_screen.dart';

import 'fake_mail_repository.dart';
import 'test_app.dart';

void main() {
  testWidgets('shows the raw source, toggles wrapping and copies', (tester) async {
    final repo = FakeMailRepository(emails: [testEmail('m1')]);
    final router = await pumpTestApp(tester, repository: repo);
    unawaited(router.push('/source/m1'));
    await tester.pumpAndSettle();

    expect(repo.log, contains('loadRawSource m1'));
    final text = tester.widget<SelectableText>(find.byKey(const Key('source-text'))).data!;
    expect(text, contains('Subject: Hello'));
    expect(text, contains('Raw body of m1'));

    expect(find.byTooltip("Don't Wrap Lines"), findsOneWidget);
    await tester.tap(find.byKey(const Key('source-wrap')));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Wrap Lines'), findsOneWidget);
    expect(
      find.ancestor(
        of: find.byKey(const Key('source-text')),
        matching: find.byWidgetPredicate((w) => w is SingleChildScrollView && w.scrollDirection == Axis.horizontal),
      ),
      findsOneWidget,
    );

    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String;
      return null;
    });
    await tester.tap(find.byTooltip('Copy'));
    await tester.pumpAndSettle();
    expect(copied, contains('Raw body of m1'));
    expect(find.text('Source copied'), findsOneWidget);
  });

  test('decodes UTF-8 and falls back to Latin-1', () {
    expect(decodeRawSource([0x63, 0x61, 0x66, 0xC3, 0xA9]), 'café');
    expect(decodeRawSource([0x63, 0x61, 0x66, 0xE9]), 'café');
  });
}
