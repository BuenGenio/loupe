import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/notifications/app_icon_badge.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers.dart';

/// Records the counts the app puts on its icon.
class RecordingBadge implements AppIconBadge {
  RecordingBadge({this.supported = true});

  final bool supported;
  final shown = <int>[];

  @override
  Future<bool> isSupported() async => supported;

  @override
  Future<void> show(int count) async => shown.add(count);
}

Future<void> _choose(WidgetTester tester, String option) async {
  await goTo(tester, Routes.notificationSettings);
  await tester.scrollTo(find.text('App Icon Badge'));
  await tester.tap(find.text('App Icon Badge'));
  await tester.pumpAndSettle();
  await tester.tap(find.text(option));
  await tester.pumpAndSettle();
  for (var i = 0; i < 2; i++) {
    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();
  }
}

void main() {
  testWidgets('the badge shows unread in the inboxes and follows changes', (tester) async {
    final badge = RecordingBadge();
    final repo = await pumpLoupe(tester, badge: badge);
    final inboxes = (await repo.watchVirtualCounts().first)[VirtualMailbox.allInboxes]!;
    expect(inboxes, greaterThan(0));
    expect(badge.shown.last, inboxes);

    final unread = await repo
        .watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes), filters: {QuickFilter.unread}, threaded: false)
        .first;
    await repo.setKeywords([unread.first.latest.id], add: {Keywords.seen});
    await tester.pumpAndSettle();
    expect(badge.shown.last, inboxes - 1);
  });

  testWidgets('Settings › Notifications chooses VIP or Off', (tester) async {
    final badge = RecordingBadge();
    final repo = await pumpLoupe(tester, badge: badge);
    final counts = await repo.watchVirtualCounts().first;
    expect(counts[VirtualMailbox.vip], isNot(counts[VirtualMailbox.allInboxes]));

    await goTo(tester, Routes.settings);
    await tester.scrollTo(find.text('Notifications'));
    await Scrollable.ensureVisible(tester.element(find.text('Notifications')), alignment: 0.5);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Notifications'));
    await tester.pumpAndSettle();
    await tester.scrollTo(find.text('Unread in Inboxes'));
    expect(find.text('Unread in Inboxes'), findsOneWidget);
    expect(textContaining('The badge updates whenever Loupe checks for mail'), findsOneWidget);
    for (var i = 0; i < 2; i++) {
      await tester.tap(find.bySemanticsLabel('Back'));
      await tester.pumpAndSettle();
    }

    await _choose(tester, 'Unread in VIP');
    expect(badge.shown.last, counts[VirtualMailbox.vip]);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('settings.appIconBadge'), 'vip');

    await _choose(tester, 'Off');
    expect(badge.shown.last, 0, reason: 'cleared');
  });

  testWidgets('no badge where the home screen has none, and none before an account exists', (tester) async {
    final unsupported = RecordingBadge(supported: false);
    await pumpLoupe(tester, badge: unsupported);
    expect(unsupported.shown, isEmpty);
    await goTo(tester, Routes.notificationSettings);
    await tester.scrollTo(textContaining('doesn’t show numbers on app icons'));
    expect(textContaining('doesn’t show numbers on app icons'), findsOneWidget);

    final badge = RecordingBadge();
    await pumpLoupe(tester, mode: AppMode.none, badge: badge);
    expect(badge.shown, [0]);
  });
}
