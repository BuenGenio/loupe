import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/snooze/snooze_sheet.dart';
import 'package:loupe/platform/background.dart';
import 'package:loupe/router.dart';
import 'package:loupe/shared/message_row.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

const _allInboxes = VirtualMailboxRef(VirtualMailbox.allInboxes);
const _hike = 'Photos from Sunday’s hike';
const _tickets = 'Your tickets: Lisbon Oriente, Friday 07:42';

class _RecordingScheduler implements BackgroundScheduler {
  final times = <DateTime>[];

  @override
  Future<void> scheduleWakeUp(DateTime time) async => times.add(time);
}

/// A demo account whose server can't store keywords.
class _DeviceOnlyRepository extends DemoMailRepository {
  _DeviceOnlyRepository() : super(latency: DemoLatency.zero, clock: () => testNow);

  @override
  Future<SnoozeStorage> snooze(List<String> emailIds, DateTime until) async {
    await super.snooze(emailIds, until);
    return SnoozeStorage.device;
  }
}

Future<List<EmailSummary>> _snoozed(DemoMailRepository repo) => repo.watchSnoozed().first;

Future<EmailSummary> _find(DemoMailRepository repo, String subject) async {
  final boxes = await repo.watchMailboxes().first;
  for (final b in boxes) {
    for (final t in await repo.watchList(RealMailboxRef(b.id), threaded: false, limit: 1000).first) {
      if (t.latest.subject == subject) return t.latest;
    }
  }
  throw StateError('No message “$subject”');
}

/// Picks "Tomorrow", which every time of day offers.
Future<void> _pickTomorrow(WidgetTester tester) async {
  expect(find.byKey(const ValueKey('snooze-tomorrow')), findsOneWidget);
  await tester.tap(find.byKey(const ValueKey('snooze-tomorrow')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Mailboxes shows Snoozed with its count, and hides the Snoozed folders', (tester) async {
    final repo = await pumpLoupe(tester);
    final row = find.byKey(const ValueKey('snoozed'));
    expect(row, findsOneWidget);
    final count = (await _snoozed(repo)).length;
    expect(count, 3);
    expect(find.descendant(of: row, matching: find.text('$count')), findsOneWidget);
    // Only the Snoozed mailbox: the accounts' Snoozed folders aren't listed.
    expect(find.text('Snoozed'), findsOneWidget);

    await tester.tap(row);
    await tester.pumpAndSettle();
    expect(find.text(_tickets), findsOneWidget);
    expect(find.text('Your card on file expires this month'), findsOneWidget);
    // Each row shows when it comes back, with a clock, soonest first.
    expect(find.byIcon(LoupeIcons.snooze), findsNWidgets(3));
    final rows = tester.widgetList<MessageRow>(find.byType(MessageRow)).toList();
    expect(rows.map((r) => r.email.subject).last, 'Weekly backup report: 2 warnings');
    expect(rows.every((r) => r.wakeTime != null), isTrue);
    await drainTimers(tester);
  });

  testWidgets('a woken message shows a small Snoozed mark while unread', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.list(_allInboxes));
    await tester.scrollTo(find.text('Re: Lisbon in November?'));
    final lisbon = find.ancestor(of: find.text('Re: Lisbon in November?'), matching: find.byType(MessageRow));
    expect(lisbon, findsOneWidget);
    expect(find.descendant(of: lisbon, matching: find.text('Snoozed')), findsOneWidget);
    expect(find.descendant(of: lisbon, matching: find.byIcon(LoupeIcons.snoozeFilled)), findsOneWidget);
    // Reading it clears the mark.
    await tester.tap(find.text('Re: Lisbon in November?'));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.descendant(of: lisbon, matching: find.text('Snoozed')), findsNothing);
    expect((await _find(repo, 'Re: Lisbon in November?')).keywords, isNot(contains(Keywords.newAgain)));
    await drainTimers(tester);
  });

  testWidgets('Snooze from the More sheet asks for a wake-up; Undo brings it back', (tester) async {
    final scheduler = _RecordingScheduler();
    final repo = await pumpLoupe(tester, overrides: [backgroundSchedulerProvider.overrideWithValue(scheduler)]);
    await goTo(tester, Routes.list(_allInboxes));
    final before = await _find(repo, _hike);
    scheduler.times.clear();

    await tester.longPress(find.text(_hike));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Snooze…'));
    await tester.pumpAndSettle();
    expect(find.text('SNOOZE'), findsOneWidget);
    // A time of its own: a preset may match a seeded snooze's wake-up.
    await tester.tap(find.byKey(const ValueKey('snooze-pick')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('send-later-done')));
    await tester.pumpAndSettle();

    expect(find.text(_hike), findsNothing);
    expect(textContaining('Snoozed 1 message until'), findsOneWidget);
    final snoozed = await _find(repo, _hike);
    expect(snoozed.snoozedUntil, isNotNull);
    expect(scheduler.times, [snoozed.snoozedUntil!.toLocal()]);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(find.text(_hike), findsOneWidget);
    final back = await _find(repo, _hike);
    expect(back.mailboxId, before.mailboxId);
    expect(back.snoozedUntil, isNull);
    await drainTimers(tester);
    repo.dispose();
  });

  testWidgets('Snooze as the swipe action', (tester) async {
    final repo = await pumpLoupe(tester, prefs: {'settings.swipeTrailing': 'snooze'});
    await goTo(tester, Routes.list(_allInboxes));
    await tester.drag(find.text(_hike), const Offset(-330, 0));
    await tester.pumpAndSettle();
    await _pickTomorrow(tester);
    expect(find.text(_hike), findsNothing);
    expect((await _snoozed(repo)).map((e) => e.subject), contains(_hike));
    await drainTimers(tester);
    repo.dispose();
  });

  testWidgets('Snooze several messages from multi-select', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.list(_allInboxes));
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(_hike));
    await tester.tap(find.text('Re: Dinner Saturday?'));
    await tester.pump();
    expect(find.text('2 Selected'), findsWidgets);
    await tester.tap(find.text('Mark'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Snooze…'));
    await tester.pumpAndSettle();
    await _pickTomorrow(tester);
    expect(find.text(_hike), findsNothing);
    expect(find.text('Re: Dinner Saturday?'), findsNothing);
    expect(find.text('Edit'), findsOneWidget, reason: 'edit mode ends');
    expect(textContaining('Snoozed'), findsWidgets);
    await drainTimers(tester);
    repo.dispose();
  });

  testWidgets('Snooze from the message menu closes the conversation', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.list(_allInboxes));
    await tester.tap(find.text(_hike));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(LoupeIcons.more).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Snooze…'));
    await tester.pumpAndSettle();
    await _pickTomorrow(tester);
    // Back on the list, without the conversation.
    expect(find.text('All Inboxes'), findsWidgets);
    expect(find.text(_hike), findsNothing);
    expect((await _snoozed(repo)).map((e) => e.subject), contains(_hike));
    await drainTimers(tester);
    repo.dispose();
  });

  testWidgets('the Snoozed mailbox wakes a message now and changes another one\'s time', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.snoozed);

    await tester.longPress(find.text(_tickets));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wake Now'));
    await tester.pumpAndSettle();
    expect(find.text(_tickets), findsNothing);
    expect(textContaining('Moved 1 message to Inbox'), findsOneWidget);
    final woken = await _find(repo, _tickets);
    expect(woken.isNewAgain, isTrue);
    expect(woken.snoozedUntil, isNull);
    await drainTimers(tester);

    const renewal = 'Your card on file expires this month';
    final before = (await _find(repo, renewal)).snoozedUntil;
    await tester.longPress(find.text(renewal));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Change Snooze Time…'));
    await tester.pumpAndSettle();
    expect(find.text('CHANGE SNOOZE TIME'), findsOneWidget);
    final tomorrow = snoozePresets(DateTime.now()).firstWhere((p) => p.$1 == SnoozePreset.tomorrow).$2;
    await _pickTomorrow(tester);
    final after = (await _find(repo, renewal)).snoozedUntil;
    expect(after, tomorrow.toUtc());
    expect(before, isNotNull);
    expect(find.text(renewal), findsOneWidget, reason: 'still snoozed');
    await drainTimers(tester);
    repo.dispose();
  });

  testWidgets('a server without keywords: the snack bar says the snooze stays on this device', (tester) async {
    final repo = _DeviceOnlyRepository();
    await pumpLoupe(tester, repository: repo);
    await goTo(tester, Routes.list(_allInboxes));
    await tester.longPress(find.text(_hike));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Snooze…'));
    await tester.pumpAndSettle();
    await _pickTomorrow(tester);
    expect(textContaining('on this device only'), findsOneWidget);
    await drainTimers(tester);
    repo.dispose();
  });

  testWidgets('Settings › Swipe Actions offers Snooze', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.swipeSettings);
    expect(find.text('Snooze'), findsNWidgets(2));
    await drainTimers(tester);
  });
}
