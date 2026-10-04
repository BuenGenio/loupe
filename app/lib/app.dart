import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_sync/mail_sync.dart';

import 'data/repositories.dart';
import 'router.dart';
import 'settings/app_mode.dart';
import 'settings/app_settings.dart';
import 'theme/theme.dart';

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
      builder: (context, child) => _SystemBars(child: _LiveGate(child: child ?? const SizedBox.shrink())),
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
              Icon(CupertinoIcons.exclamationmark_triangle, size: 44, color: LoupeColors.of(context).flag),
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

/// Pauses syncing while the app is in the background (queued sends still go
/// out) and resumes it in the foreground.
class _SyncLifecycle extends StatefulWidget {
  const _SyncLifecycle({required this.repository, required this.child});

  final LiveMailRepository repository;
  final Widget child;

  @override
  State<_SyncLifecycle> createState() => _SyncLifecycleState();
}

class _SyncLifecycleState extends State<_SyncLifecycle> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onHide: () => unawaited(widget.repository.pause()),
      onShow: () => unawaited(widget.repository.resume()),
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
