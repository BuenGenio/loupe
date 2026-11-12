import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/changes/email_changes_sheet.dart';
import 'package:mail_model/mail_model.dart';

import 'fake_mail_repository.dart';
import 'test_app.dart';

List<EmailSummary> _messages() => [
  testEmail('old', minutesAgo: 120, keywords: {Keywords.seen}),
  testEmail('reply', from: me, to: [alice], minutesAgo: 60, keywords: {Keywords.seen}),
  testEmail('new', minutesAgo: 5),
];

const _contents = {
  'old': EmailContent(
    emailId: 'old',
    text: 'The fee is £295.\nPlease complete the ID check in the app.',
    attachments: [Attachment(partId: '2', mimeType: 'application/pdf', filename: 'illustration.pdf', size: 100)],
  ),
  'reply': EmailContent(emailId: 'reply', text: 'Thanks, I will send it tomorrow.'),
  'new': EmailContent(
    emailId: 'new',
    text: 'The fee is £395.\nPlease complete the ID check in the app.',
    attachments: [Attachment(partId: '9', mimeType: 'application/pdf', filename: 'illustration.pdf', size: 100)],
  ),
};

/// Native compute runs outside the widget test's fake event loop.
Future<void> _finishComparison(WidgetTester tester) async {
  await tester.runAsync(() async {
    for (var attempt = 0; attempt < 100; attempt++) {
      await tester.pump();
      if (find.byType(CircularProgressIndicator).evaluate().isEmpty) return;
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  });
  await tester.pumpAndSettle();
  expect(find.byType(CircularProgressIndicator), findsNothing);
}

Future<void> _openMenuComparison(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('more-new')));
  await tester.pumpAndSettle();
  final action = find.text('Compare Messages…');
  await tester.ensureVisible(action);
  await tester.tap(action);
  await _finishComparison(tester);
}

Future<void> _openSheet(
  WidgetTester tester, {
  required Future<EmailContent> Function(EmailSummary message) loadContent,
}) async {
  await pumpTestApp(
    tester,
    repository: FakeMailRepository(),
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          onPressed: () => unawaited(
            showEmailChangesSheet(context, messages: _messages(), initialEmailId: 'new', loadContent: loadContent),
          ),
          child: const Text('Open'),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await _finishComparison(tester);
}

Finder _diffText(String text) =>
    find.descendant(of: find.byType(EmailChangesSheet), matching: find.textContaining(text, findRichText: true));

void main() {
  testWidgets('comparison controls and text fit a narrow phone with large text', (tester) async {
    tester.view.physicalSize = const Size(360 * 3, 740 * 3);
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await _openSheet(tester, loadContent: (message) async => _contents[message.id]!);
    expect(tester.takeException(), isNull);
    expect(find.byKey(const ValueKey('changes-from')), findsOneWidget);
    expect(find.byKey(const ValueKey('changes-to')), findsOneWidget);
    await tester.scrollUntilVisible(_diffText('The fee is £395.'), 200, scrollable: find.byType(Scrollable).last);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens from a message menu, compares the previous sender version and marks metadata limits', (
    tester,
  ) async {
    final repo = FakeMailRepository(emails: _messages(), contents: _contents);
    final router = await pumpTestApp(tester, repository: repo);
    unawaited(router.push('/message/new'));
    await tester.pumpAndSettle();
    await _openMenuComparison(tester);

    expect(find.byType(EmailChangesSheet), findsOneWidget);
    expect(find.text('Changes'), findsOneWidget);
    expect(repo.log, contains('loadContent old'));
    expect(repo.log, isNot(contains('loadContent reply')));
    expect(_diffText('The fee is £295.'), findsOneWidget);
    expect(_diffText('The fee is £395.'), findsOneWidget);
    await tester.scrollUntilVisible(_diffText('Matching Details'), 200, scrollable: find.byType(Scrollable).last);
    expect(find.textContaining('Matching Details'), findsOneWidget);
    expect(find.text('Attachment names, types and sizes are compared. File contents are not checked.'), findsOneWidget);
    expect(
      repo.log.where((call) => call.startsWith('archive') || call.startsWith('move') || call.startsWith('send')),
      isEmpty,
    );
  });

  testWidgets('a single message has no comparison action', (tester) async {
    final repo = FakeMailRepository(emails: [testEmail('only')]);
    final router = await pumpTestApp(tester, repository: repo);
    unawaited(router.push('/message/only'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('more-only')));
    await tester.pumpAndSettle();
    expect(find.text('Compare Messages…'), findsNothing);
  });

  testWidgets('can choose a different baseline and hides the previous result while loading', (tester) async {
    final pending = Completer<EmailContent>();
    final loads = <String>[];
    await _openSheet(
      tester,
      loadContent: (message) async {
        loads.add(message.id);
        return message.id == 'reply' ? pending.future : _contents[message.id]!;
      },
    );
    await _finishComparison(tester);
    await tester.tap(find.byKey(const ValueKey('changes-from')));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Me Myself').last);
    await tester.pump();
    expect(loads, contains('reply'));
    expect(find.textContaining('The fee is £295.', findRichText: true), findsNothing);
    pending.complete(_contents['reply']);
    await _finishComparison(tester);
    expect(find.textContaining('Thanks, I will send it tomorrow.', findRichText: true), findsOneWidget);
  });

  testWidgets('load failures offer Retry without losing the selected messages', (tester) async {
    var failing = true;
    final loads = <String>[];
    await _openSheet(
      tester,
      loadContent: (message) async {
        loads.add(message.id);
        if (failing) throw StateError('Offline');
        return _contents[message.id]!;
      },
    );
    await tester.pumpAndSettle();
    expect(find.text('These messages couldn’t be compared.'), findsOneWidget);
    failing = false;
    await tester.tap(find.text('Retry'));
    await _finishComparison(tester);
    expect(find.textContaining('The fee is £395.', findRichText: true), findsOneWidget);
    expect(loads, ['old', 'new', 'old', 'new']);
  });

  testWidgets('equal truncated prefixes do not claim the full messages are unchanged', (tester) async {
    final prefix = 'x' * 40001;
    await _openSheet(
      tester,
      loadContent: (message) async => EmailContent(emailId: message.id, text: '$prefix${message.id}'),
    );
    await _finishComparison(tester);
    expect(find.textContaining('too large for a detailed comparison'), findsOneWidget);
    expect(find.text('No text changes.'), findsNothing);
  });
}
