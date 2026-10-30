import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/demo/demo_brief.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/ai/ai_providers.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:loupe/features/compose/reply_check.dart';
import 'package:loupe/features/compose/reply_check_panel.dart';
import 'package:loupe/router.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

const _aiOn = {'settings.aiAssist': true};
const _adviser = 'Your mortgage application: what we need next';

final _panel = find.byKey(const Key('reply-check'));
final _summary = find.byKey(const Key('reply-check-summary'));
final _body = find.byKey(const Key('compose-body'));

/// The personal inbox's message whose subject is [subject] and whose text
/// has [text].
Future<String> _idOf(DemoMailRepository repo, String subject, {String text = ''}) async {
  final list = await repo
      .watchList(RealMailboxRef(MailIds.mailbox('personal', 'INBOX')), threaded: false, limit: 1000)
      .first;
  return list.firstWhere((t) => t.latest.subject == subject && t.latest.preview.contains(text)).latest.id;
}

Future<void> _compose(WidgetTester tester, ComposeArgs args) async {
  final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
  unawaited(container.read(routerProvider).push<void>(Routes.compose, extra: args));
  await tester.pumpAndSettle();
}

/// Opens a reply to the adviser's first message, with Private AI on unless
/// [prefs] say otherwise.
Future<DemoMailRepository> _replyToAdviser(
  WidgetTester tester, {
  Map<String, Object> prefs = _aiOn,
  List<Override> overrides = const [],
  ComposeMode mode = ComposeMode.reply,
}) async {
  final repo = await pumpLoupe(tester, prefs: prefs, overrides: overrides);
  await _compose(tester, ComposeArgs(mode: mode, sourceEmailId: await _idOf(repo, _adviser)));
  return repo;
}

/// Picks [name] from the demo's attach sheet.
Future<void> _attachDemo(WidgetTester tester, String name) async {
  await tester.tap(find.byTooltip('Attach'));
  await tester.pumpAndSettle();
  final row = find.byKey(ValueKey('demo-file-$name'));
  await tester.ensureVisible(row);
  await tester.pumpAndSettle();
  await tester.tap(row);
  await tester.pumpAndSettle();
}

Future<void> _expand(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('reply-check-toggle')));
  await tester.pumpAndSettle();
}

String _summaryText(WidgetTester tester) => tester.widget<Text>(_summary).data!;

/// The row of the request whose text has [words].
Finder _row(String words) => find.ancestor(
  of: find.textContaining(words),
  matching: find.byWidgetPredicate(
    (w) =>
        w is InkWell && w.key is ValueKey<String> && (w.key! as ValueKey<String>).value.startsWith('reply-check-item-'),
  ),
);

/// Reads files from a table of names, as a document reader would.
final class _Texts implements AttachmentTextSource {
  _Texts(this.byName);
  final Map<String, AttachmentText> byName;

  @override
  Future<AttachmentText> textOf(OutgoingAttachment attachment) async =>
      byName[attachment.filename] ?? const AttachmentText.notRead();
}

void main() {
  testWidgets(
    'a reply to a message that asks for things shows the panel; nothing attached, all is missing or outside',
    (tester) async {
      await _replyToAdviser(tester);
      expect(_panel, findsOneWidget);
      expect(find.text('Reply Check'), findsOneWidget);
      expect(_summaryText(tester), 'None of 3 attached · 2 to do outside email');

      await _expand(tester);
      expect(find.text('Not attached'), findsNWidgets(3));
      expect(find.text('Outside email'), findsNWidgets(2));
      expect(find.text('Requests found by the built-in demo, not a model.'), findsOneWidget);
      // Their message's own words, one tap away.
      await tester.tap(find.descendant(of: _panel, matching: find.textContaining('Your SA302 tax calculation')));
      await tester.pumpAndSettle();
      expect(find.text('From their message'), findsOneWidget);
      expect(find.text('Your SA302 tax calculation for 2024/25.'), findsOneWidget);
    },
  );

  testWidgets('no panel for a new message, nor for a reply to a message that asks nothing', (tester) async {
    final repo = await pumpLoupe(tester, prefs: _aiOn);
    await _compose(tester, const ComposeArgs());
    expect(_panel, findsNothing);
    await tester.tap(find.byKey(const Key('compose-cancel')));
    await tester.pumpAndSettle();

    final thanks = await _idOf(repo, 'Re: $_adviser', text: 'the bank statement and the SA302 have arrived');
    await _compose(tester, ComposeArgs(mode: ComposeMode.reply, sourceEmailId: thanks));
    expect(_panel, findsNothing);
  });

  testWidgets('forwarding the message checks it too', (tester) async {
    await _replyToAdviser(tester, mode: ComposeMode.forward);
    // The forwarded illustration and schedule are not what was asked for.
    expect(find.textContaining('Mortgage illustration.pdf'), findsOneWidget);
    expect(_summaryText(tester), 'None of 3 attached · 2 to do outside email');
  });

  testWidgets('with Private AI off, no panel; the attachment reminder still works', (tester) async {
    await _replyToAdviser(tester, prefs: const {});
    expect(_panel, findsNothing);
    final reminder = find.byKey(const Key('compose-attachment-reminder'));
    expect(reminder, findsNothing);

    await tester.enterText(_body, 'Hi Rhea,\n\nAttached are my September bank statement and the SA302.\n\nSam');
    await tester.pump();
    expect(reminder, findsOneWidget);
    expect(find.text('Your text mentions an attachment, but nothing is attached.'), findsOneWidget);

    await tester.tap(find.byKey(const Key('compose-attachment-reminder-attach')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('demo-file-Bank statement - September.pdf')));
    await tester.pumpAndSettle();
    expect(reminder, findsNothing);
    expect(find.textContaining('Bank statement - September.pdf'), findsOneWidget);
    expect(_panel, findsNothing);
  });

  testWidgets('the attachment reminder can be hidden, and ignores the quoted original', (tester) async {
    await _replyToAdviser(tester, prefs: const {});
    // The original's "Attached are your mortgage illustration…" is quoted below.
    expect(find.byKey(const Key('compose-attachment-reminder')), findsNothing);
    await tester.enterText(_body, 'Please find the form enclosed.');
    await tester.pump();
    await tester.tap(find.byKey(const Key('compose-attachment-reminder-hide')));
    await tester.pump();
    expect(find.byKey(const Key('compose-attachment-reminder')), findsNothing);
  });

  testWidgets('statuses follow the attachments as they are added and removed', (tester) async {
    await _replyToAdviser(tester);
    await _attachDemo(tester, 'Bank statement - September.pdf');
    expect(_summaryText(tester), '1 of 3 attached · 2 to do outside email');
    await _attachDemo(tester, 'SA302 2024-25.pdf');
    expect(_summaryText(tester), '2 of 3 attached · 2 to do outside email');

    await _expand(tester);
    expect(find.text('Attached'), findsNWidgets(2));
    expect(find.text('Matched “SA302 2024-25.pdf” by its name only.'), findsOneWidget);
    expect(find.text('Matched “Bank statement - September.pdf” by its name only.'), findsOneWidget);
    // A month's name doesn't say it is a whole month.
    expect(find.text('Check that it’s for a full month.'), findsOneWidget);
    expect(find.text('A file’s name doesn’t show what’s in it. Open the files to be sure.'), findsOneWidget);

    await tester.tap(find.byTooltip('Remove').first);
    await tester.pumpAndSettle();
    expect(_summaryText(tester), '1 of 3 attached · 2 to do outside email');
  });

  testWidgets('an SA302 for another tax year is possibly the wrong period', (tester) async {
    await _replyToAdviser(tester);
    await _attachDemo(tester, 'SA302 2023-24.pdf');
    expect(_summaryText(tester), 'None of 3 attached · 1 may be for the wrong period · 2 to do outside email');
    await _expand(tester);
    expect(find.descendant(of: _row('SA302'), matching: find.text('Check the period')), findsOneWidget);
    expect(find.text('They asked for 2024/25; the name “SA302 2023-24.pdf” says 2023-24.'), findsOneWidget);

    // The overview "for 2025" and one named 2024-25.
    await _attachDemo(tester, 'Tax year overview 2024-25.pdf');
    expect(find.text('They asked for 2025; the name “Tax year overview 2024-25.pdf” says 2024-25.'), findsOneWidget);
  });

  testWidgets('the ID check in the Harbour app is a step outside email; a passport scan doesn’t do it', (tester) async {
    await _replyToAdviser(tester);
    await _expand(tester);
    final id = _row('The ID check');
    expect(find.descendant(of: id, matching: find.text('Outside email')), findsOneWidget);
    expect(find.descendant(of: id, matching: find.text('in the Harbour app')), findsOneWidget);
    expect(
      find.descendant(of: id, matching: find.text('Done outside email, not by attaching a file.')),
      findsOneWidget,
    );

    await _attachDemo(tester, 'Passport scan.pdf');
    expect(_summaryText(tester), 'None of 3 attached · 2 to do outside email');
    expect(find.descendant(of: id, matching: find.text('Attached')), findsNothing);
    expect(
      find.descendant(of: id, matching: find.text('“Passport scan.pdf” is attached, but this isn’t done by email.')),
      findsOneWidget,
    );
  });

  testWidgets('the draft saying a step is coming counts as mentioned', (tester) async {
    await _replyToAdviser(tester);
    await tester.enterText(_body, "Hi Rhea,\n\nI'll do the ID check in the app tonight.\n\nSam");
    await tester.pump();
    expect(_summaryText(tester), 'None of 3 attached · 1 to do outside email · 1 in your text');
    await _expand(tester);
    expect(find.text('You wrote: “I\'ll do the ID check in the app tonight.”'), findsOneWidget);
  });

  testWidgets('contents decide when a file can be read; an unreadable one stays unknown', (tester) async {
    await _replyToAdviser(
      tester,
      overrides: [
        attachmentTextSourceProvider.overrideWithValue(
          _Texts({
            // Named for 2024-25, but for the year before inside.
            'SA302 2024-25.pdf': const AttachmentText.read(
              'SA302 tax calculation\nTax calculation for the year 6 April 2023 to 5 April 2024',
            ),
            'Tax calculation.pdf': const AttachmentText.unreadable(),
            'Bank statement - September.pdf': const AttachmentText.read(
              'Lumen Bank statement\nPeriod: 1 to 30 September',
            ),
          }),
        ),
      ],
    );
    await _attachDemo(tester, 'SA302 2024-25.pdf');
    await _attachDemo(tester, 'Bank statement - September.pdf');
    await _expand(tester);
    expect(find.text('They asked for 2024/25; “SA302 2024-25.pdf” says 6 April 2023 to 5 April 2024.'), findsOneWidget);
    expect(find.text('Matched “Bank statement - September.pdf” by what it says.'), findsOneWidget);
    expect(find.text('Check that it’s for a full month.'), findsNothing);

    await tester.tap(find.byTooltip('Remove').first);
    await tester.pumpAndSettle();
    await _attachDemo(tester, 'Tax calculation.pdf');
    expect(find.descendant(of: _row('SA302'), matching: find.text('Can’t tell')), findsOneWidget);
    expect(
      find.text('“Tax calculation.pdf” couldn’t be read, so whether it’s the right file is unknown.'),
      findsOneWidget,
    );
    expect(_summaryText(tester), '1 of 3 attached · 1 couldn’t be read · 2 to do outside email');
  });

  testWidgets('Hide puts the panel away for this message', (tester) async {
    await _replyToAdviser(tester);
    await tester.tap(find.byKey(const Key('reply-check-hide')));
    await tester.pumpAndSettle();
    expect(_panel, findsNothing);
    await _attachDemo(tester, 'SA302 2023-24.pdf');
    expect(_panel, findsNothing);
  });

  testWidgets('Don’t Check This leaves a request out until Check All', (tester) async {
    await _replyToAdviser(tester);
    await _expand(tester);
    await tester.tap(find.descendant(of: _panel, matching: find.textContaining('Your tax year overview')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('reply-check-skip')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('reply-check-skip')));
    await tester.pumpAndSettle();
    expect(_summaryText(tester), 'None of 2 attached · 2 to do outside email');
    expect(find.text('1 request not checked'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('reply-check-check-all')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('reply-check-check-all')));
    await tester.pumpAndSettle();
    expect(_summaryText(tester), 'None of 3 attached · 2 to do outside email');
  });

  testWidgets('Send is never held up by the check', (tester) async {
    final repo = await _replyToAdviser(tester);
    expect(_summaryText(tester), 'None of 3 attached · 2 to do outside email');
    await tester.tap(find.byKey(const Key('compose-send')));
    await tester.pumpAndSettle();
    expect(find.byType(ComposeScreen), findsNothing);
    final outbox = await repo.watchOutbox().first;
    expect(outbox.single.message.subject, 'Re: $_adviser');
    expect(outbox.single.message.attachments, isEmpty);
    // The undo delay runs out and it goes.
    await tester.pump(const Duration(seconds: 11));
    await drainTimers(tester);
  });

  testWidgets('a failure is quiet, with Retry, and doesn’t stop Send', (tester) async {
    final provider = FakeProvider.scripted((request) => demoBrief(request, DateTime.now()))
      ..failWith = const AiProviderException('offline');
    await _replyToAdviser(tester, prefs: const {}, overrides: [aiProviderProvider.overrideWithValue(provider)]);
    expect(_summaryText(tester), 'Couldn’t read what they asked for.');
    expect(tester.widget<IconButton>(find.byKey(const Key('compose-send'))).onPressed, isNotNull);

    provider.failWith = null;
    await tester.tap(find.byKey(const Key('reply-check-retry')));
    await tester.pumpAndSettle();
    expect(_summaryText(tester), 'None of 3 attached · 2 to do outside email');
    await _expand(tester);
    expect(find.text('Requests found by fake-1.'), findsOneWidget);
  });

  test('the content hook reads nothing until document extraction is wired in', () async {
    final text = await const NoAttachmentText().textOf(
      OutgoingAttachment(filename: 'SA302 2024-25.pdf', mimeType: 'application/pdf', data: Uint8List(0)),
    );
    expect(text.state, AttachmentTextState.notRead);
  });
}
