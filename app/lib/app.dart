import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_sync/mail_sync.dart';

import 'data/repositories.dart';
import 'features/notifications/app_icon_badge.dart';
import 'features/notifications/new_mail_check.dart';
import 'features/notifications/notification_settings.dart';
import 'features/notifications/notifications_coordinator.dart';
import 'features/snooze/snooze_wakeups.dart';
import 'platform/background.dart';
import 'platform/background_entry.dart';
import 'platform/foreground_sync.dart';
import 'platform/instant_delivery.dart';
import 'platform/support_directory.dart';
import 'platform/sync_leases.dart';
import 'router.dart';
import 'settings/app_mode.dart';
import 'settings/app_settings.dart';
import 'theme/theme.dart';
import 'theme/loupe_icons.dart';

class LoupeApp extends ConsumerWidget {
  const LoupeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    return MaterialApp.router(
      title: 'Loupe',
      debugShowCheckedModeBanner: false,
      theme: LoupeTheme.light(density: settings.density),
      darkTheme: LoupeTheme.dark(density: settings.density),
      themeMode: settings.themeMode,
      scrollBehavior: const LoupeScrollBehavior(),
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) => _SystemBars(
        // The badge and notification taps need the repository, so they wait
        // behind the live gate.
        child: _LiveGate(
          child: AppIconBadgeUpdater(child: NotificationsCoordinator(child: child ?? const SizedBox.shrink())),
        ),
      ),
    );
  }
}

/// Edge-to-edge system bars whose icons follow the theme.
class _SystemBars extends StatelessWidget {
  const _SystemBars({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark).copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
      ),
      child: child,
    );
  }
}

/// In live mode, waits for the real repository before showing any screen,
/// and offers a way out if it can't be created.
class _LiveGate extends ConsumerWidget {
  const _LiveGate({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(appModeProvider) != AppMode.live) return child;
    return ref
        .watch(liveRepositoryProvider)
        .when(
          data: (repository) =>
              repository is LiveMailRepository ? _SyncLifecycle(repository: repository, child: child) : child,
          loading: () => const ColoredBox(
            color: Colors.black12,
            child: Center(child: CupertinoActivityIndicator(radius: 14)),
          ),
          error: (error, _) => _LiveUnavailable(error: error),
        );
  }
}

class _LiveUnavailable extends ConsumerWidget {
  const _LiveUnavailable({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = LoupeTextStyles.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LoupeIcons.warning, size: 44, color: LoupeColors.of(context).flag),
              const SizedBox(height: 16),
              Text('Your accounts couldn’t be opened', style: styles.navTitle, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                error is UnimplementedError ? 'Real accounts aren’t available in this build yet.' : '$error',
                style: styles.footnote,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => ref.read(appModeProvider.notifier).set(AppMode.demo),
                child: const Text('Use Demo Mail'),
              ),
              TextButton(onPressed: () => ref.read(appModeProvider.notifier).reset(), child: const Text('Start Over')),
            ],
          ),
        ),
      ),
    );
  }
}

/// Syncs while the app is in the foreground and pauses in the background
/// (queued sends still go out), never at the same time as the background
/// sync (see [ForegroundSync]). Going to the background also marks the mail
/// that arrived meanwhile as seen for notifications, and asks for a wake-up
/// when a queued message is due.
class _SyncLifecycle extends ConsumerStatefulWidget {
  const _SyncLifecycle({required this.repository, required this.child});

  final LiveMailRepository repository;
  final Widget child;

  @override
  ConsumerState<_SyncLifecycle> createState() => _SyncLifecycleState();
}

class _SyncLifecycleState extends ConsumerState<_SyncLifecycle> {
  late final AppLifecycleListener _listener;
  late final ForegroundSync _sync;

  @override
  void initState() {
    super.initState();
    final repository = widget.repository;
    final container = ProviderScope.containerOf(context, listen: false);
    _sync = ForegroundSync(
      leases: container.read(supportDirectoryProvider.future).then(SyncLeases.new),
      pause: repository.pause,
      resume: repository.resume,
      onBackground: () => _wentToBackground(container, repository),
      // Instant Delivery holds the database in the background: let go now.
      onClaimed: container.read(instantServiceProvider).nudge,
    );
    _listener = AppLifecycleListener(
      onHide: () => unawaited(_sync.enterBackground()),
      onShow: () => unawaited(_sync.enterForeground()),
    );
    final state = WidgetsBinding.instance.lifecycleState;
    if (state == null || state == AppLifecycleState.resumed || state == AppLifecycleState.inactive) {
      unawaited(_sync.enterForeground());
    }
  }

  static Future<void> _wentToBackground(ProviderContainer container, LiveMailRepository repository) async {
    try {
      await container
          .read(newMailCheckProvider)
          .run(repository, container.read(notificationSettingsProvider), silent: true);
      final scheduler = container.read(backgroundSchedulerProvider);
      final due = await nextOutboxDue(repository);
      if (due != null) await scheduler.scheduleWakeUp(due);
      final wake = await nextSnoozeWake(repository);
      if (wake != null) await scheduler.scheduleWakeUp(wake);
    } on Object catch (e) {
      debugPrint('Going to the background: $e');
    }
  }

  @override
  void dispose() {
    _listener.dispose();
    // Left live mode: stop syncing and let background work have the database.
    unawaited(_sync.enterBackground().then((_) => _sync.dispose()));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
