import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';

import '../../platform/foreground_bridge.dart';
import '../../platform/instant_delivery.dart';
import '../../platform/work_scheduler.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../settings/app_mode.dart';
import '../compose/compose_args.dart';
import 'mail_notifier.dart';
import 'new_mail_check.dart';
import 'notification_actions.dart';
import 'notification_content.dart';
import 'notification_settings.dart';

/// Whether this isolate takes notification buttons from background isolates
/// ([ForegroundBridge]); main() turns it on, on Android.
final servesNotificationActionsProvider = Provider<bool>((ref) => false);

/// The app's side of notifications, for as long as it runs:
///
/// - opens what a notification tap asks for (also the tap that launched it);
/// - runs Archive and Mark as Read handed over from the background isolate;
/// - turns the periodic background sync on in live mode, off otherwise;
/// - runs the Instant Delivery service while it is switched on;
/// - keeps one notification channel per account;
/// - asks for POST_NOTIFICATIONS once, right after the first account is
///   added (never on first launch).
class NotificationsCoordinator extends ConsumerStatefulWidget {
  const NotificationsCoordinator({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<NotificationsCoordinator> createState() => _NotificationsCoordinatorState();
}

class _NotificationsCoordinatorState extends ConsumerState<NotificationsCoordinator> {
  StreamSubscription<NotificationTap>? _taps;
  ForegroundBridgeServer? _bridge;
  String? _channelsFor;

  @override
  void initState() {
    super.initState();
    final taps = ref.read(notificationTapsProvider);
    _taps = taps.stream.listen((tap) => _safely(() => _open(tap)));
    final launch = taps.takeLaunch();
    if (launch != null) WidgetsBinding.instance.addPostFrameCallback((_) => _safely(() => _open(launch)));
    if (ref.read(servesNotificationActionsProvider)) _bridge = ForegroundBridge.serve(_handleRequest);
    ref.listenManual<AppMode>(appModeProvider, (previous, mode) => _safely(() => _modeChanged(previous, mode)));
    _safely(() => _modeChanged(null, ref.read(appModeProvider)));
    ref.listenManual<AsyncValue<List<MailAccount>>>(
      accountsProvider,
      (_, next) => _safely(() => _accountsChanged(next.value)),
      fireImmediately: true,
    );
    ref.listenManual<NotificationSettings>(notificationSettingsProvider, (_, _) => _safely(_applyInstant));
  }

  /// Notifications are a side show: a failure here never reaches the user.
  static void _safely(Future<void> Function() work) {
    unawaited(
      Future(work).catchError((Object e) {
        debugPrint('Notifications: $e');
      }),
    );
  }

  @override
  void dispose() {
    unawaited(_taps?.cancel());
    _bridge?.close();
    super.dispose();
  }

  Future<void> _modeChanged(AppMode? previous, AppMode mode) async {
    final live = mode == AppMode.live;
    await ref.read(periodicSyncProvider).setEnabled(live);
    // Notifications point at real messages; they mean nothing elsewhere.
    if (previous == AppMode.live && !live) {
      _channelsFor = null;
      await ref.read(mailNotifierProvider).cancelAll();
    }
    if (live) await _accountsChanged(ref.read(accountsProvider).value);
    await _applyInstant();
  }

  Future<void> _instant = Future.value();

  /// Runs the Instant Delivery service while it is switched on, in live mode
  /// with an account that notifies; stops it otherwise. Starting needs the
  /// app in the foreground, so opening the app also restarts a service that
  /// Android stopped.
  Future<void> _applyInstant() => _instant = _instant
      .then((_) async {
        if (!mounted) return;
        final settings = ref.read(notificationSettingsProvider);
        final accounts = ref.read(accountsProvider).value;
        final live = ref.read(appModeProvider) == AppMode.live;
        if (live && settings.instant && accounts == null) return; // Still loading.
        final wanted = live && settings.instant && accounts!.any((a) => settings.notifiesFor(a.id));
        final service = ref.read(instantServiceProvider);
        final running = await service.isRunning();
        if (wanted && !running) {
          await service.start();
        } else if (!wanted && running) {
          await service.stop();
        }
      })
      .catchError((Object e) => debugPrint('Instant Delivery: $e'));

  Future<void> _accountsChanged(List<MailAccount>? accounts) async {
    if (accounts == null || !mounted || ref.read(appModeProvider) != AppMode.live) return;
    final notifier = ref.read(mailNotifierProvider);
    final key = [for (final a in accounts) '${a.id}=${accountName(a)}'].join('|');
    if (key != _channelsFor) {
      _channelsFor = key;
      await notifier.syncChannels(accounts);
    }
    await _applyInstant();
    final settings = ref.read(notificationSettingsProvider);
    if (accounts.isEmpty || settings.permissionRequested || !accounts.any((a) => settings.notifiesFor(a.id))) return;
    await ref.read(notificationSettingsProvider.notifier).update((s) => s.copyWith(permissionRequested: true));
    if (!await notifier.permissionGranted()) await notifier.requestPermission();
  }

  Future<void> _open(NotificationTap tap) async {
    if (!mounted) return;
    final router = ref.read(routerProvider);
    switch (tap.target) {
      case MessageTarget(:final emailId):
        unawaited(router.push<void>(Routes.message(emailId)));
        if (tap.action == MailAction.reply) {
          unawaited(
            router.push<void>(
              Routes.compose,
              extra: ComposeArgs(mode: ComposeMode.reply, sourceEmailId: emailId),
            ),
          );
        }
      case AccountTarget(:final accountId):
        final mailboxes = await ref.read(repositoryProvider).watchMailboxes(accountId: accountId).first;
        final inbox = mailboxes.where((m) => m.role == MailboxRole.inbox).firstOrNull;
        if (!mounted) return;
        unawaited(
          router.push<void>(
            Routes.list(inbox == null ? const VirtualMailboxRef(VirtualMailbox.allInboxes) : RealMailboxRef(inbox.id)),
          ),
        );
    }
  }

  /// Archive or Mark as Read, tapped while the app runs (in the foreground
  /// or not): the app's repository does it, so the lists update at once.
  Future<void> _handleRequest(Map<String, Object?> request) async {
    final r = decodeMailActionRequest(request);
    if (r == null || !mounted) return;
    final repository = ref.read(repositoryProvider);
    final notifier = ref.read(mailNotifierProvider);
    final check = ref.read(newMailCheckProvider);
    final settings = ref.read(notificationSettingsProvider);
    await runMailAction(repository, r.action, r.target.emailId);
    await notifier.cancel(messageNotificationId(r.target.emailId));
    await check.tidy(repository, settings);
    // In the background the repository is paused: send it now, then
    // disconnect again.
    final state = WidgetsBinding.instance.lifecycleState;
    if (repository is LiveMailRepository && state != AppLifecycleState.resumed) await repository.flushOps();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
