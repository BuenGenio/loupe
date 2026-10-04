import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:loupe/features/conversation/conversation_screen.dart';
import 'package:loupe/features/message_list/message_list_screen.dart';
import 'package:loupe/features/notifications/mail_notifier.dart';
import 'package:loupe/features/notifications/new_mail.dart';
import 'package:loupe/features/notifications/notification_content.dart';
import 'package:loupe/features/notifications/notification_settings.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/features/notifications/notification_actions.dart';
import 'package:loupe/platform/foreground_bridge.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fakes.dart';
import 'pump.dart';

ProviderContainer containerOf(WidgetTester tester) => ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));

void main() {
  late FakeNotifier notifier;

  setUp(() => notifier = FakeNotifier());

  Future<EmailSummary> newestInboxMessage(MailRepository repo) async =>
      (await repo.watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes), threaded: false, limit: 1).first)
          .single
          .latest;

  testWidgets('tapping a notification opens its message; Reply opens compose over it', (tester) async {
    final taps = NotificationTaps();
    final repo = await pumpWithNotifications(tester, notifier: notifier, taps: taps, mode: AppMode.live);
    final email = await newestInboxMessage(repo);

    taps.add(NotificationTap(MessageTarget(email.id, email.accountId)));
    await tester.pumpAndSettle();
    expect(find.byType(ConversationScreen), findsOneWidget);
    expect(tester.widget<ConversationScreen>(find.byType(ConversationScreen)).emailId, email.id);

    taps.add(NotificationTap(MessageTarget(email.id, email.accountId), action: MailAction.reply));
    await tester.pumpAndSettle();
    expect(find.byType(ComposeScreen), findsOneWidget);
  });

  testWidgets('the tap that launched the app opens its message once the app is up', (tester) async {
    final first = await pumpWithNotifications(tester, notifier: notifier, mode: AppMode.live);
    final email = await newestInboxMessage(first);
    final taps = NotificationTaps(launch: NotificationTap(MessageTarget(email.id, email.accountId)));
    await pumpWithNotifications(tester, notifier: notifier, taps: taps, mode: AppMode.live);
    expect(find.byType(ConversationScreen), findsOneWidget);
    expect(taps.launch, isNull, reason: 'handed out once');
  });

  testWidgets('tapping an account’s summary opens its inbox', (tester) async {
    final taps = NotificationTaps();
    final repo = await pumpWithNotifications(tester, notifier: notifier, taps: taps, mode: AppMode.live);
    final account = (await repo.watchAccounts().first).last;
    taps.add(NotificationTap(AccountTarget(account.id)));
    await tester.pumpAndSettle();
    final list = tester.widget<MessageListScreen>(find.byType(MessageListScreen));
    final inbox = (await repo.watchMailboxes(accountId: account.id).first).firstWhere(
      (m) => m.role == MailboxRole.inbox,
    );
    expect(list.mailboxRef, RealMailboxRef(inbox.id));
  });

  testWidgets('background sync runs in live mode only; leaving it clears the notifications', (tester) async {
    final periodic = RecordingPeriodicSync();
    final repo = await pumpWithNotifications(tester, notifier: notifier, periodic: periodic, mode: AppMode.live);
    expect(periodic.enabled, isTrue);
    expect([for (final a in notifier.channels!) a.id], [for (final a in await repo.watchAccounts().first) a.id]);

    final email = await newestInboxMessage(repo);
    await notifier.show([
      messageNotification(
        NewMail(email, fromVip: false),
        (await repo.watchAccounts().first).firstWhere((a) => a.id == email.accountId),
        hideContent: false,
      ),
    ]);
    await containerOf(tester).read(appModeProvider.notifier).set(AppMode.demo);
    await tester.pumpAndSettle();
    expect(periodic.enabled, isFalse);
    expect(notifier.showing, isEmpty);

    final demo = RecordingPeriodicSync();
    await pumpWithNotifications(tester, notifier: FakeNotifier(), periodic: demo);
    expect(demo.enabled, isFalse, reason: 'demo mail never syncs in the background');
  });

  testWidgets('starting outside live mode clears notifications left from live mode', (tester) async {
    await notifier.show([
      const MailNotification(
        id: 1,
        channel: MailChannel.vip,
        groupKey: 'g',
        title: 'Left over',
        target: MessageTarget('work|INBOX|1|1', 'work'),
      ),
    ]);
    await pumpWithNotifications(tester, notifier: notifier);
    expect(notifier.showing, isEmpty);
  });

  testWidgets('asks for notifications right after the first account, and only once', (tester) async {
    final notifier = FakeNotifier(granted: false);
    await pumpWithNotifications(tester, notifier: notifier, mode: AppMode.none);
    expect(find.text('Try with demo mail'), findsOneWidget);
    expect(notifier.permissionRequests, 0, reason: 'never on first launch');

    // Account setup switches to live mode once the first account works.
    await containerOf(tester).read(appModeProvider.notifier).set(AppMode.live);
    await tester.pumpAndSettle();
    expect(notifier.permissionRequests, 1);

    final prefs = await SharedPreferences.getInstance();
    await pumpWithNotifications(
      tester,
      notifier: notifier,
      mode: AppMode.live,
      prefs: {for (final k in prefs.getKeys()) k: prefs.get(k)!},
    );
    expect(notifier.permissionRequests, 1, reason: 'asked once; Settings can ask again');
  });

  testWidgets('no question when every account is muted', (tester) async {
    final notifier = FakeNotifier(granted: false);
    await pumpWithNotifications(
      tester,
      notifier: notifier,
      mode: AppMode.live,
      prefs: {
        'notifications.mutedAccounts': ['personal', 'work', 'fastmail'],
      },
    );
    expect(notifier.permissionRequests, 0);
  });

  testWidgets('Archive and Mark as Read tapped while the app runs are done by the app', (tester) async {
    final repo = await pumpWithNotifications(tester, notifier: notifier, mode: AppMode.live, servesActions: true);
    final accounts = await repo.watchAccounts().first;
    final unread = await repo
        .watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes), filters: {QuickFilter.unread}, threaded: false)
        .first;
    final first = unread[0].latest;
    final second = unread[1].latest;
    for (final e in [first, second]) {
      await notifier.show([
        messageNotification(
          NewMail(e, fromVip: false),
          accounts.firstWhere((a) => a.id == e.accountId),
          hideContent: false,
        ),
      ]);
    }

    Future<void> tapButton(MailAction action, EmailSummary e) async {
      final accepted = await tester.runAsync(
        () => ForegroundBridge.forward(encodeMailActionRequest(action, MessageTarget(e.id, e.accountId))),
      );
      expect(accepted, isTrue);
      for (var i = 0; i < 5; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
        await tester.pumpAndSettle();
      }
    }

    await tapButton(MailAction.markRead, first);
    expect((await repo.getEmail(first.id))!.isSeen, isTrue);
    expect(notifier.isShowing(messageNotificationId(first.id)), isFalse);

    await tapButton(MailAction.archive, second);
    final archived = await repo.getEmail(second.id);
    final inboxes = {
      for (final m in await repo.watchMailboxes().first)
        if (m.role == MailboxRole.inbox) m.id,
    };
    expect(archived == null || !inboxes.contains(archived.mailboxId), isTrue, reason: 'out of the inbox');
    expect(notifier.showing.values.where((n) => !n.isSummary), isEmpty);
  });

  test('a request nobody serves is not accepted', () async {
    expect(
      await ForegroundBridge.forward(
        encodeMailActionRequest(MailAction.archive, const MessageTarget('a|INBOX|1|1', 'a')),
        timeout: const Duration(milliseconds: 100),
      ),
      isFalse,
    );
    expect(decodeMailActionRequest({'type': 'other'}), isNull);
    expect(decodeMailActionRequest(encodeMailActionRequest(MailAction.markRead, const MessageTarget('e', 'a'))), (
      action: MailAction.markRead,
      target: const MessageTarget('e', 'a'),
    ));
  });

  testWidgets('Instant Delivery runs while it is on, in live mode, for accounts that notify', (tester) async {
    final instant = FakeInstantService();
    await pumpWithNotifications(tester, notifier: notifier, instant: instant, mode: AppMode.live);
    expect(instant.running, isFalse, reason: 'off by default');

    final container = containerOf(tester);
    await container.read(notificationSettingsProvider.notifier).update((s) => s.copyWith(instant: true));
    await tester.pumpAndSettle();
    expect(instant.running, isTrue);

    final accounts = await container.read(repositoryProvider).watchAccounts().first;
    await container
        .read(notificationSettingsProvider.notifier)
        .update((s) => s.copyWith(mutedAccounts: {for (final a in accounts) a.id}));
    await tester.pumpAndSettle();
    expect(instant.running, isFalse, reason: 'nothing to deliver');

    await container.read(notificationSettingsProvider.notifier).update((s) => s.copyWith(mutedAccounts: {}));
    await tester.pumpAndSettle();
    expect(instant.running, isTrue);
    await container.read(appModeProvider.notifier).set(AppMode.demo);
    await tester.pumpAndSettle();
    expect(instant.running, isFalse);
  });

  testWidgets('opening the app restarts an Instant Delivery service Android stopped', (tester) async {
    final instant = FakeInstantService();
    await pumpWithNotifications(
      tester,
      notifier: notifier,
      instant: instant,
      mode: AppMode.live,
      prefs: {'notifications.instant': true},
    );
    expect(instant.starts, 1);
    expect(instant.running, isTrue);

    final demo = FakeInstantService();
    await pumpWithNotifications(tester, notifier: notifier, instant: demo, prefs: {'notifications.instant': true});
    expect(demo.starts, 0, reason: 'demo mail never syncs in the background');
  });
}
