import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loupe/demo/demo_brief.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/demo/demo_security.dart';
import 'package:loupe/features/ai/ai_providers.dart';
import 'package:loupe/features/brief/brief_tracker.dart';
import 'package:loupe/features/calendar/device_calendar.dart';
import 'package:loupe/features/calendar/invitation_card.dart';
import 'package:loupe/features/conversation/message_card.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_calendar/mail_calendar.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

import '../../helpers.dart';

const _on = {'settings.aiAssist': true};

/// A tall phone, so a whole Brief fits without scrolling.
const _tall = Size(390, 2400);

DemoMessage _seeded(bool Function(DemoMessage m) test) => DemoSeed.build(testNow).messages.firstWhere(test);

/// The adviser's first message: five requests, one only in the app, a
/// conditional timing and a password.
final _requests = _seeded((m) => m.summary.subject == 'Your mortgage application: what we need next');
final _valuation = _seeded((m) => m.summary.subject == 'Valuation booked: 14 Quay Street');
final _ownReply = _seeded(
  (m) =>
      m.summary.threadId == DemoPrivateAi.threadId(DemoPrivateAi.mortgageThread) &&
      m.summary.from.first.email != DemoPrivateAi.adviser.email,
);
final _impostor = _seeded((m) => m.summary.from.first == DemoSecurityCases.impostor);

Finder _card(String id) => find.byWidgetPredicate((w) => w is MessageCard && w.message.id == id);
Finder _in(String id, Finder finder) => find.descendant(of: _card(id), matching: finder);
Finder _key(String key) => find.byKey(Key(key));
Finder _section(String group) => _key('brief-section-$group');
Finder _items(String group) =>
    find.descendant(of: _section(group), matching: find.byWidgetPredicate((w) => '${w.key}'.contains('brief-item-')));

Future<void> _open(WidgetTester tester, DemoMessage m) => goTo(tester, '/message/${Uri.encodeComponent(m.id)}');

Future<void> _brief(WidgetTester tester, DemoMessage m) async {
  await _open(tester, m);
  await tester.tap(_in(m.id, _key('brief-button')));
  await tester.pumpAndSettle();
}

/// The item of the Brief whose text contains [text]: its index.
int _indexOf(WidgetTester tester, String text) {
  final tile = find
      .ancestor(of: textContaining(text), matching: find.byWidgetPredicate((w) => '${w.key}'.contains('brief-item-')))
      .first;
  final key = '${tester.widget(tile).key}';
  return int.parse(RegExp(r'brief-item-(\d+)').firstMatch(key)!.group(1)!);
}

/// Taps [finder] after scrolling it clear of the top bar and the toolbar.
Future<void> _tapUnderToolbar(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.drag(find.ancestor(of: finder, matching: find.byType(CustomScrollView)).first, const Offset(0, 300));
  await tester.pumpAndSettle();
  await tester.tap(finder);
}

String? _copied;

void _captureClipboard(WidgetTester tester) {
  _copied = null;
  tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
    if (call.method == 'Clipboard.setData') _copied = (call.arguments as Map<Object?, Object?>)['text'] as String?;
    return null;
  });
  addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
}

final class _Calendar implements DeviceCalendar {
  final events = <DeviceEvent>[];

  @override
  Future<bool> add(DeviceEvent event) async {
    events.add(event);
    return true;
  }
}

final class _Tracker implements BriefItemTracker {
  final tracked = <(MessageRef, BriefItem)>[];

  @override
  bool canTrack(BriefItem item) => item.kind == BriefItemKind.action || item.kind == BriefItemKind.document;

  @override
  Future<void> track(MessageRef source, BriefItem item, {AiRunRecord? run}) async => tracked.add((source, item));
}

/// The demo's rules behind a provider a test controls.
FakeProvider _demo({String id = 'fake'}) => FakeProvider.scripted((r) => demoBrief(r, testNow), id: id);

void main() {
  group('offered', () {
    testWidgets('only with Private AI on, and never for the user’s own message', (tester) async {
      await pumpLoupe(tester, size: _tall);
      await _open(tester, _requests);
      expect(_key('brief-button'), findsNothing);
      await tester.tap(_key('reader-options'));
      await tester.pumpAndSettle();
      expect(find.text('Readable'), findsOneWidget);
      expect(find.text('Brief'), findsNothing);
      await drainTimers(tester);
    });

    testWidgets('as a button above the body and a view in the “Aa” sheet', (tester) async {
      await pumpLoupe(tester, prefs: _on, size: _tall);
      await _open(tester, _requests);
      expect(_in(_requests.id, _key('brief-button')), findsOneWidget);
      expect(_in(_ownReply.id, _key('brief-button')), findsNothing, reason: 'Sam’s own reply asks nothing of Sam');

      await tester.tap(_key('reader-options'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: _key('reader-mode'), matching: find.text('Brief')));
      await tester.pumpAndSettle();
      // The text size applies to the Brief; it doesn't switch back.
      await tester.drag(_key('reader-text-size'), const Offset(60, 0));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(195, 100)); // closes the sheet
      await tester.pumpAndSettle();
      expect(_in(_requests.id, _key('brief-view')), findsOneWidget);
      expect(_in(_requests.id, find.byType(ReadableMessageView)), findsNothing);

      await tester.tap(_key('reader-options'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Readable'));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(195, 100));
      await tester.pumpAndSettle();
      expect(_key('brief-view'), findsNothing);
      expect(_in(_requests.id, find.byType(ReadableMessageView)), findsOneWidget);
      await drainTimers(tester);
    });
  });

  testWidgets('the adviser’s requests: five things, the app-only check, a timing from an event, no password', (
    tester,
  ) async {
    await pumpLoupe(tester, prefs: _on, size: _tall);
    await _brief(tester, _requests);

    expect(_key('brief-summary'), findsOneWidget);
    expect(_items('toDo').evaluate().length + _items('documents').evaluate().length, 5);
    expect(find.descendant(of: _section('toDo'), matching: find.text('To Do')), findsOneWidget);
    expect(find.descendant(of: _section('documents'), matching: find.text('Documents to Send')), findsOneWidget);
    expect(textContaining('SA302 tax calculation for 2024/25'), findsOneWidget);
    expect(textContaining('tax year overview for 2025'), findsOneWidget);

    final id = _indexOf(tester, 'The ID check');
    expect(find.descendant(of: _key('brief-channel-$id'), matching: find.text('in the Harbour app')), findsOneWidget);

    final caseManager = _indexOf(tester, 'a case manager will be assigned within 24 hours');
    expect(find.descendant(of: _section('next'), matching: _key('brief-item-$caseManager')), findsOneWidget);
    final timing = tester.widget<Text>(
      find.descendant(of: _key('brief-timing-$caseManager'), matching: find.byType(Text)),
    );
    expect(timing.data, 'Measured from an event: once the case has been submitted to the lender');
    expect(
      timing.data,
      isNot(
        matches(
          RegExp(r'\d{1,2} (January|February|March|April|May|June|July|August|September|October|November|December)'),
        ),
      ),
    );

    expect(textContaining(DemoPrivateAi.password), findsNothing);
    expect(find.text('Made by the built-in demo, not a model.'), findsOneWidget);
    expect(_key('brief-partial'), findsNothing);
    await drainTimers(tester);
  });

  testWidgets('an item shows its passage highlighted in the message; Show Original goes back to the message', (
    tester,
  ) async {
    await pumpLoupe(tester, prefs: _on, size: _tall);
    await _brief(tester, _requests);
    final i = _indexOf(tester, 'The ID check');
    await tester.tap(_key('brief-source-$i'));
    await tester.pumpAndSettle();

    expect(_key('brief-evidence'), findsOneWidget);
    expect(find.text('In the Message'), findsOneWidget);
    final text = tester.widget<Text>(
      find.descendant(
        of: _key('brief-evidence'),
        matching: find.byWidgetPredicate((w) => w is Text && w.textSpan != null),
      ),
    );
    final spans = (text.textSpan! as TextSpan).children!.cast<TextSpan>();
    expect(spans[1].text, 'The ID check, completed in the Harbour app (passport or driving licence).');
    expect(spans[1].style?.backgroundColor, isNotNull);
    expect(spans[0].text, startsWith('Dear Sam,'));

    await tester.tap(_key('brief-evidence-show-original'));
    await tester.pumpAndSettle();
    expect(_key('brief-evidence'), findsNothing);
    expect(_key('brief-view'), findsNothing);
    expect(_in(_requests.id, find.byType(ReadableMessageView)), findsOneWidget);
    expect(_in(_requests.id, _key('brief-button')), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('Show Original is one tap away from the Brief itself', (tester) async {
    await pumpLoupe(tester, prefs: _on, size: _tall);
    await _brief(tester, _requests);
    await tester.tap(_key('brief-show-original'));
    await tester.pumpAndSettle();
    expect(_key('brief-view'), findsNothing);
    expect(_in(_requests.id, find.byType(ReadableMessageView)), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('items are ticked and dismissed, each with Undo, and the ticks outlive the view', (tester) async {
    await pumpLoupe(tester, prefs: _on, size: _tall);
    await _brief(tester, _requests);
    final i = _indexOf(tester, 'The ID check');
    Icon tick() => tester.widget<Icon>(find.descendant(of: _key('brief-check-$i'), matching: find.byType(Icon)));
    final open = tick().icon;

    await tester.tap(_key('brief-check-$i'));
    await tester.pumpAndSettle();
    expect(tick().icon, isNot(open));
    expect(find.text('Marked as done'), findsOneWidget);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(tick().icon, open);

    await tester.tap(_key('brief-check-$i'));
    await tester.pumpAndSettle();
    // Back to the message and to the Brief: the tick is still there.
    await tester.tap(_key('brief-show-original'));
    await tester.pumpAndSettle();
    await tester.tap(_in(_requests.id, _key('brief-button')));
    await tester.pumpAndSettle();
    expect(tick().icon, isNot(open));

    final form = _indexOf(tester, 'The affordability form');
    await tester.tap(_key('brief-more-$form'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dismiss'));
    await tester.pumpAndSettle();
    expect(_key('brief-item-$form'), findsNothing);
    expect(find.text('Dismissed'), findsOneWidget);
    expect(find.text('Show 1 Dismissed Item'), findsOneWidget);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(_key('brief-item-$form'), findsOneWidget);
    expect(find.text('Show 1 Dismissed Item'), findsNothing);
    await drainTimers(tester);
  });

  testWidgets('Copy Checklist copies the items as plain text, ticks included, never the password', (tester) async {
    await pumpLoupe(tester, prefs: _on, size: _tall);
    _captureClipboard(tester);
    await _brief(tester, _requests);
    await tester.tap(_key('brief-check-${_indexOf(tester, "A full month's bank statement")}'));
    await tester.pumpAndSettle();
    await _tapUnderToolbar(tester, _key('brief-copy-checklist'));
    await tester.pumpAndSettle();

    final text = _copied!;
    expect(text, startsWith('Your mortgage application: what we need next\n'));
    expect(
      text,
      contains(
        '\n\nTo Do\n☐ The ID check, completed in the Harbour app (passport or driving licence)\n   in the Harbour app',
      ),
    );
    expect(text, contains("☑ A full month's bank statement"));
    expect(text, contains('☐ Your SA302 tax calculation for 2024/25'));
    expect(text, contains('What Happens Next'));
    expect(text, contains('Measured from an event: once the case has been submitted to the lender'));
    expect(text, isNot(contains(DemoPrivateAi.password)));
    expect(find.text('Checklist copied'), findsOneWidget);
    await drainTimers(tester);
  });

  group('Add to Calendar…', () {
    testWidgets('shows the event first, at the stated date and time, and only then hands it over', (tester) async {
      final calendar = _Calendar();
      await pumpLoupe(
        tester,
        prefs: _on,
        size: _tall,
        overrides: [
          deviceCalendarProvider.overrideWithValue(calendar),
          invitationZoneProvider.overrideWithValue(IanaZone.named('Europe/London')),
        ],
      );
      await _brief(tester, _valuation);
      final booked = _indexOf(tester, 'We have booked the valuation');
      await tester.tap(_key('brief-more-$booked'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add to Calendar…'));
      await tester.pumpAndSettle();

      expect(_key('brief-event-preview'), findsOneWidget);
      // The demo books it eleven days after "now", at 10:00.
      final date = DateTime(testNow.year, testNow.month, testNow.day + 11);
      expect(
        find.descendant(
          of: _key('brief-event-time'),
          matching: find.textContaining(RegExp(r'^10:00\sAM – 11:00\sAM$')),
        ),
        findsOneWidget,
      );
      expect(find.descendant(of: _key('brief-event-zone'), matching: find.text('Europe/London')), findsOneWidget);
      expect(calendar.events, isEmpty);

      await tester.tap(_key('brief-event-add'));
      await tester.pumpAndSettle();
      final event = calendar.events.single;
      expect(event.allDay, isFalse);
      expect(event.start.hour, 10);
      expect((event.start.month, event.start.day), (date.month, date.day));
      expect(event.timeZone, 'Europe/London');
      expect(event.description, contains('Valuation booked: 14 Quay Street'));
      await drainTimers(tester);
    });

    testWidgets('is not offered for a task without a stated date', (tester) async {
      await pumpLoupe(tester, prefs: _on, size: _tall);
      await _brief(tester, _requests);
      await tester.tap(_key('brief-more-${_indexOf(tester, 'The ID check')}'));
      await tester.pumpAndSettle();
      expect(find.text('Mark as Done'), findsOneWidget);
      expect(find.text('Add to Calendar…'), findsNothing);
      expect(find.text('Track'), findsOneWidget, reason: 'the demo keeps actions');
      await drainTimers(tester);
    });
  });

  testWidgets('Track hands an item the reader owns to the tracker', (tester) async {
    final tracker = _Tracker();
    await pumpLoupe(tester, prefs: _on, size: _tall, overrides: [briefItemTrackerProvider.overrideWithValue(tracker)]);
    await _brief(tester, _requests);
    await tester.tap(_key('brief-more-${_indexOf(tester, 'a case manager')}'));
    await tester.pumpAndSettle();
    expect(find.text('Track'), findsNothing, reason: 'what happens next is the lender’s');
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    await tester.tap(_key('brief-more-${_indexOf(tester, 'The ID check')}'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Track'));
    await tester.pumpAndSettle();
    final (source, item) = tracker.tracked.single;
    expect(source.emailId, _requests.id);
    expect(source.subject, 'Your mortgage application: what we need next');
    expect(item.channel, 'in the Harbour app');
    expect(textContaining('Tracking “The ID check'), findsOneWidget);
    await drainTimers(tester);
  });

  group('states', () {
    testWidgets('a failure says so, with no checklist, and Retry asks again', (tester) async {
      final provider = _demo()..failWith = const AiProviderException('No network.', retryable: true);
      await pumpLoupe(tester, prefs: _on, size: _tall, overrides: [aiProviderProvider.overrideWithValue(provider)]);
      await _brief(tester, _requests);
      expect(_key('brief-failed'), findsOneWidget);
      expect(find.text('The model couldn’t make a Brief of this message.'), findsOneWidget);
      expect(find.text('No network.'), findsOneWidget);
      expect(find.byWidgetPredicate((w) => '${w.key}'.contains('brief-section-')), findsNothing);
      expect(_key('brief-copy-checklist'), findsNothing);

      provider.failWith = null;
      await tester.tap(_key('brief-retry'));
      await tester.pumpAndSettle();
      expect(_key('brief-failed'), findsNothing);
      expect(_section('toDo'), findsOneWidget);
      expect(find.text('Made on this phone by fake.'), findsNothing, reason: 'the model is named');
      expect(find.text('Made on this phone by fake · fake-1.'), findsOneWidget);
      await drainTimers(tester);
    });

    testWidgets('an answer that fails the checks shows no checklist and no made-up quote', (tester) async {
      final invented = jsonEncode({
        'summary': 'Send your payslips.',
        'nothing_to_summarise': false,
        'items': [
          {
            'kind': 'document',
            'text': 'Three months of payslips',
            'quote': 'Please send three months of payslips.',
            'channel': null,
            'owner': 'me',
            'due': {'kind': 'none', 'text': null, 'date': null},
          },
        ],
      });
      await pumpLoupe(
        tester,
        prefs: _on,
        size: _tall,
        overrides: [
          aiProviderProvider.overrideWithValue(FakeProvider(answers: [invented])),
        ],
      );
      await _brief(tester, _requests);
      expect(find.text('The answer didn’t pass Loupe’s checks, so no checklist is shown.'), findsOneWidget);
      expect(textContaining('payslips'), findsNothing);
      expect(find.byWidgetPredicate((w) => '${w.key}'.contains('brief-section-')), findsNothing);
      await drainTimers(tester);
    });

    testWidgets('a message that asks nothing has nothing to summarise', (tester) async {
      final nothing = jsonEncode({
        'summary': 'Rhea says the documents arrived.',
        'nothing_to_summarise': true,
        'items': <Object?>[],
      });
      await pumpLoupe(
        tester,
        prefs: _on,
        size: _tall,
        overrides: [
          aiProviderProvider.overrideWithValue(FakeProvider(answers: [nothing])),
        ],
      );
      await _brief(tester, _requests);
      expect(_key('brief-nothing'), findsOneWidget);
      expect(find.text('Nothing to Summarise'), findsOneWidget);
      expect(find.text('Rhea says the documents arrived.'), findsOneWidget);
      expect(_key('brief-copy-checklist'), findsNothing);
      await drainTimers(tester);
    });

    testWidgets('a Brief in progress can be cancelled, and tried again', (tester) async {
      final provider = _demo()..delay = const Duration(seconds: 5);
      await pumpLoupe(tester, prefs: _on, size: _tall, overrides: [aiProviderProvider.overrideWithValue(provider)]);
      await _open(tester, _requests);
      await tester.tap(_in(_requests.id, _key('brief-button')));
      await tester.pump();
      expect(_key('brief-working'), findsOneWidget);
      expect(find.text('Reading the message…'), findsOneWidget);
      await tester.tap(_key('brief-cancel'));
      await tester.pump();
      expect(find.text('You stopped the Brief.'), findsOneWidget);
      await tester.pump(const Duration(seconds: 6));
      expect(find.text('You stopped the Brief.'), findsOneWidget, reason: 'a late answer is ignored');

      provider.delay = Duration.zero;
      await tester.tap(_key('brief-retry'));
      await tester.pumpAndSettle();
      expect(_section('toDo'), findsOneWidget);
      await drainTimers(tester);
    });
  });

  group('fits a small phone', () {
    setUpAll(initializeDateFormatting);
    // English, and languages whose words run long.
    for (final lang in ['en', 'de', 'el', 'fi', 'ga', 'lb']) {
      testWidgets(lang, (tester) async {
        await pumpLoupe(
          tester,
          size: const Size(360, 640),
          prefs: {..._on, if (lang != 'en') 'settings.language': lang},
        );
        addTearDown(() => appLanguage = null);
        await _open(tester, _requests);
        await tester.tap(_in(_requests.id, _key('brief-button')));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'the Brief overflows in $lang');
        await tester.tap(_key('reader-options'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'the “Aa” sheet overflows in $lang');
        await drainTimers(tester);
      });
    }
  });

  testWidgets('a suspicious message’s warning comes first in its Brief', (tester) async {
    await pumpLoupe(tester, prefs: _on, size: _tall);
    await _brief(tester, _impostor);
    expect(_key('brief-security'), findsOneWidget);
    expect(find.text('Be careful with this message'), findsOneWidget);
    final warning = tester.getTopLeft(_key('brief-security')).dy;
    expect(warning, lessThan(tester.getTopLeft(_key('brief-summary')).dy));
    await drainTimers(tester);
  });

  testWidgets('the storyline’s own messages carry no warning', (tester) async {
    await pumpLoupe(tester, prefs: _on, size: _tall);
    await _brief(tester, _requests);
    expect(_key('brief-security'), findsNothing);
    expect(_in(_requests.id, find.byType(ReadableMessageView)), findsNothing);
    await drainTimers(tester);
  });
}
