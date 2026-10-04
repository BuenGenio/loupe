import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/account_import/qr_scanner.dart' show openAppSettingsProvider;
import 'package:loupe/features/notifications/notification_content.dart';
import 'package:loupe/features/notifications/notification_settings.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';
import 'fakes.dart';
import 'pump.dart';

CupertinoSwitch switchOf(WidgetTester tester, String title) => tester.widget<CupertinoSwitch>(
  find.descendant(
    of: find.ancestor(of: find.text(title), matching: find.byType(Row)).first,
    matching: find.byType(CupertinoSwitch),
  ),
);

Future<void> toggle(WidgetTester tester, String title) async {
  await tester.scrollTo(find.text(title));
  await tester.tap(find.text(title));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('every account has a switch; muting one persists', (tester) async {
    final notifier = FakeNotifier();
    final repo = await pumpWithNotifications(tester, notifier: notifier);
    await goTo(tester, Routes.notificationSettings);
    expect(find.text('NEW MAIL'), findsOneWidget);
    final accounts = await repo.watchAccounts().first;
    for (final a in accounts) {
      expect(switchOf(tester, accountName(a)).value, isTrue, reason: 'new accounts notify');
    }
    expect(textContaining('Demo mail doesn’t arrive in the background'), findsOneWidget);

    final work = accounts.firstWhere((a) => a.displayName == 'Work');
    await toggle(tester, 'Work');
    expect(switchOf(tester, 'Work').value, isFalse);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList('notifications.mutedAccounts'), [work.id]);
    expect(NotificationSettings.read(prefs).notifiesFor(work.id), isFalse);
  });

  testWidgets('switching an account on asks Android for permission when needed', (tester) async {
    final notifier = FakeNotifier(granted: false);
    final repo = await pumpWithNotifications(
      tester,
      notifier: notifier,
      prefs: {
        'notifications.mutedAccounts': ['work'],
      },
    );
    await goTo(tester, Routes.notificationSettings);
    expect(notifier.permissionRequests, 0, reason: 'never just for opening the page');
    await toggle(tester, 'Work');
    expect(notifier.permissionRequests, 1);
    expect(switchOf(tester, 'Work').value, isTrue);
    expect((await SharedPreferences.getInstance()).getBool('notifications.permissionRequested'), isTrue);
    expect(find.text('Open Android Settings'), findsNothing, reason: 'granted');

    // Turning one off never asks.
    await toggle(tester, 'Personal');
    expect(notifier.permissionRequests, 1);
    expect(await repo.watchAccounts().first, hasLength(3));
  });

  testWidgets('when Android says no, the page offers its settings', (tester) async {
    final notifier = FakeNotifier(granted: false, grants: false);
    await pumpWithNotifications(tester, notifier: notifier);
    await goTo(tester, Routes.notificationSettings);
    expect(textContaining('Android doesn’t let Loupe show notifications'), findsOneWidget);
    await tester.tap(find.text('Open Android Settings'));
    await tester.pumpAndSettle();
    expect(notifier.settingsOpened, 1);
  });

  testWidgets('VIP Only and Hide Content persist', (tester) async {
    await pumpWithNotifications(tester, notifier: FakeNotifier());
    await goTo(tester, Routes.notificationSettings);
    await toggle(tester, 'VIP Only');
    await toggle(tester, 'Hide Content');
    expect(switchOf(tester, 'VIP Only').value, isTrue);
    expect(switchOf(tester, 'Hide Content').value, isTrue);
    expect(textContaining('only say “New message from”'), findsOneWidget);
    final settings = NotificationSettings.read(await SharedPreferences.getInstance());
    expect(settings.vipOnly, isTrue);
    expect(settings.hideContent, isTrue);

    // Read again at the next launch.
    final prefs = await SharedPreferences.getInstance();
    await pumpWithNotifications(
      tester,
      notifier: FakeNotifier(),
      prefs: {for (final k in prefs.getKeys()) k: prefs.get(k)!},
    );
    await goTo(tester, Routes.notificationSettings);
    expect(switchOf(tester, 'Hide Content').value, isTrue);
  });

  testWidgets('a test notification shows the newest unread demo message and points at it', (tester) async {
    final notifier = FakeNotifier();
    final repo = await pumpWithNotifications(tester, notifier: notifier);
    await goTo(tester, Routes.notificationSettings);
    await toggle(tester, 'Send Test Notification');
    final n = notifier.posted.single;
    final unread = await repo
        .watchList(
          const VirtualMailboxRef(VirtualMailbox.allInboxes),
          filters: {QuickFilter.unread},
          threaded: false,
          limit: 1,
        )
        .first;
    final email = unread.single.latest;
    expect(n.target, MessageTarget(email.id, email.accountId));
    expect(n.body, email.subject);
    expect(n.actions, contains(MailAction.reply));

    await toggle(tester, 'Hide Content');
    await toggle(tester, 'Send Test Notification');
    expect(notifier.posted.last.title, startsWith('New message from '));
    expect(notifier.posted.last.body, isNull);
  });

  testWidgets('a test notification without permission says why', (tester) async {
    final notifier = FakeNotifier(granted: false, grants: false);
    await pumpWithNotifications(tester, notifier: notifier, mode: AppMode.live);
    await goTo(tester, Routes.notificationSettings);
    await toggle(tester, 'Send Test Notification');
    expect(notifier.posted, isEmpty);
    expect(find.text('Notifications are off for Loupe in Android Settings.'), findsOneWidget);
    expect(textContaining('checks for new mail about every 15 minutes'), findsOneWidget, reason: 'live mode');
    await drainTimers(tester);
  });

  testWidgets('Instant Delivery is announced where it isn’t available', (tester) async {
    await pumpWithNotifications(tester, notifier: FakeNotifier());
    await goTo(tester, Routes.notificationSettings);
    await tester.scrollTo(find.text('Instant Delivery'));
    expect(find.text('Coming Soon'), findsOneWidget);
    expect(textContaining('Watching for new mail'), findsOneWidget);
  });

  testWidgets('Android and iOS each show only their own background settings', (tester) async {
    // Android (the test default): Instant Delivery, no Background App Refresh.
    final instant = FakeInstantService(batteryRestricted: true);
    await pumpWithNotifications(tester, notifier: FakeNotifier(), instant: instant, mode: AppMode.live);
    await goTo(tester, Routes.notificationSettings);
    await tester.scrollTo(find.text('Instant Delivery'));
    expect(find.text('Background App Refresh'), findsNothing);
    expect(textContaining('checks for new mail about every 15 minutes'), findsOneWidget);
    await drainTimers(tester);

    // iOS: no lasting connection, so no Instant Delivery (even if it were
    // available) and no battery advice; Background App Refresh instead.
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      var settingsOpened = 0;
      await pumpWithNotifications(
        tester,
        notifier: FakeNotifier(granted: false, grants: false),
        instant: FakeInstantService(batteryRestricted: true),
        mode: AppMode.live,
        prefs: {'notifications.instant': true},
        overrides: [openAppSettingsProvider.overrideWithValue(() async => settingsOpened++)],
      );
      await goTo(tester, Routes.notificationSettings);
      expect(textContaining('iOS doesn’t let Loupe show notifications'), findsOneWidget);
      expect(find.text('Open Settings'), findsOneWidget);
      expect(textContaining('when iOS lets it'), findsOneWidget);
      await toggle(tester, 'Background App Refresh');
      expect(settingsOpened, 1);
      expect(find.text('Instant Delivery'), findsNothing);
      expect(find.text('Allow Unrestricted Battery Use'), findsNothing);
      expect(textContaining('Android'), findsNothing);
      await drainTimers(tester);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('Instant Delivery: off by default, asks for permission, offers unrestricted battery', (tester) async {
    final notifier = FakeNotifier(granted: false);
    final instant = FakeInstantService(batteryRestricted: true);
    await pumpWithNotifications(tester, notifier: notifier, instant: instant, mode: AppMode.live);
    await goTo(tester, Routes.notificationSettings);
    await tester.scrollTo(find.text('Instant Delivery'));
    expect(find.text('Experimental'), findsOneWidget);
    expect(switchOf(tester, 'Instant Delivery').value, isFalse);
    expect(find.text('Allow Unrestricted Battery Use'), findsNothing);

    await toggle(tester, 'Instant Delivery');
    expect(switchOf(tester, 'Instant Delivery').value, isTrue);
    expect(NotificationSettings.read(await SharedPreferences.getInstance()).instant, isTrue);
    expect(instant.running, isTrue);
    expect(notifier.permissionRequests, greaterThanOrEqualTo(1));

    await toggle(tester, 'Allow Unrestricted Battery Use');
    expect(instant.batterySettingsOpened, 1);
    expect(textContaining('Android may stop Instant Delivery'), findsOneWidget);

    await toggle(tester, 'Instant Delivery');
    expect(instant.running, isFalse);
    expect(find.text('Allow Unrestricted Battery Use'), findsNothing);
  });
}
