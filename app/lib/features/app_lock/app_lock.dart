/// App Lock (Settings › Security, off by default): the phone's fingerprint,
/// face or screen lock before mail shows, when Loupe starts and when it comes
/// back after Lock After. Only the app's screens are locked: background sync,
/// Instant Delivery and notification actions run in isolates of their own and
/// carry on.
library;

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../platform/recents_privacy.dart';
import '../../theme/theme.dart';
import 'app_lock_settings.dart';
import 'device_authenticator.dart';

/// Something App Lock tells the user once the app shows.
enum AppLockNotice {
  /// The phone's screen lock was removed, so App Lock turned itself off.
  screenLockRemoved,
}

/// What App Lock shows.
@immutable
class AppLockState {
  const AppLockState({this.locked = false, this.covered = false, this.failure, this.notice});

  /// The lock screen is up; the app under it is neither shown nor usable.
  final bool locked;

  /// Loupe is out of sight and may lock when it's back: the lock screen,
  /// without its button, stands in for the mail until then.
  final bool covered;

  /// Why the last prompt didn't unlock, for the lock screen ([lockFailureText]).
  final AuthResult? failure;

  /// Something to tell the user once the app shows (a SnackBar).
  final AppLockNotice? notice;
}

/// Why a prompt didn't unlock or turn App Lock on, in words; null when
/// there's nothing to say (it worked, or the user cancelled). In [l10n]
/// (a widget's `context.l10n`), else in the device's language.
String? lockFailureText(AuthResult result, [AppLocalizations? l10n]) {
  final strings = l10n ?? deviceL10n();
  return switch (result) {
    AuthResult.failed => strings.appLockFailed,
    AuthResult.lockedOut => strings.appLockLockedOut,
    AuthResult.error => strings.appLockPromptError,
    AuthResult.unavailable => strings.appLockNoScreenLock,
    AuthResult.success || AuthResult.cancelled => null,
  };
}

final appLockProvider = NotifierProvider<AppLockController, AppLockState>(AppLockController.new);

/// Locks on a cold start and, while App Lock is on, when Loupe comes back
/// after Lock After; unlocks with the system prompt. [AppLockGate] reports
/// the app's comings and goings.
class AppLockController extends Notifier<AppLockState> {
  /// When Loupe went out of sight unlocked, with App Lock on.
  DateTime? _hiddenAt;

  /// The lock still shows the system prompt once by itself.
  bool _promptPending = false;

  /// The newest prompt: an older one that ends late doesn't count.
  int _attempt = 0;
  bool _prompting = false;

  RecentsPrivacy get _recents => ref.read(recentsPrivacyProvider);

  @override
  AppLockState build() {
    final enabled = ref.read(appLockSettingsProvider).enabled;
    if (enabled) unawaited(_recents.hideContent(true));
    ref.listen(appLockSettingsProvider.select((s) => s.enabled), (_, enabled) {
      unawaited(_recents.hideContent(enabled));
      // Turning App Lock on doesn't lock: the user has just proved it's
      // them. Turning it off (or Reset App) opens up.
      if (!enabled) {
        _hiddenAt = null;
        _promptPending = false;
        state = const AppLockState();
      }
    });
    // A cold start: locked from the first frame, so no mail shows before
    // the lock does.
    _promptPending = enabled;
    return AppLockState(locked: enabled);
  }

  /// Loupe went out of sight: another app, the home screen, the screen
  /// turned off.
  void appHidden() {
    final settings = ref.read(appLockSettingsProvider);
    if (!settings.enabled) return;
    if (state.locked) {
      // Left at the lock screen: the prompt shows by itself again on the
      // way back. Not when the prompt hid Loupe (Android 10 and earlier show
      // the PIN in a screen of their own), or closing it would open it again.
      if (!_prompting) _promptPending = true;
      return;
    }
    _hiddenAt = clock.now();
    // Locking now means Loupe comes back locked, with no glimpse of mail
    // first. Otherwise the cover stands in until the time away is known.
    state = settings.lockAfter == LockAfter.immediately ? _locked() : const AppLockState(covered: true);
  }

  /// Loupe is in sight again: locks if it was away for Lock After or longer.
  void appShown() {
    final hiddenAt = _hiddenAt;
    _hiddenAt = null;
    if (hiddenAt == null) return;
    final settings = ref.read(appLockSettingsProvider);
    final away = clock.now().difference(hiddenAt);
    // A clock turned back counts as long enough.
    if (settings.enabled && (away.isNegative || away >= settings.lockAfter.duration)) {
      state = _locked();
    } else if (state.covered) {
      state = const AppLockState();
    }
  }

  AppLockState _locked() {
    _promptPending = true;
    return const AppLockState(locked: true);
  }

  /// Shows the system prompt if this lock hasn't shown it by itself yet.
  /// Only while Loupe is in the foreground: Android can't show it otherwise.
  void promptIfPending() {
    if (state.locked && _promptPending && !_prompting) unawaited(unlock());
  }

  /// The lock screen's Unlock button.
  Future<void> unlock() async {
    if (!state.locked) return;
    _promptPending = false;
    state = const AppLockState(locked: true);
    // No widget here: the system prompt speaks the device's language, as the app does.
    final l10n = deviceL10n();
    final result = await _authenticate(title: l10n.appLockUnlockPromptTitle, reason: l10n.appLockUnlockPromptReason);
    if (result == null || !ref.mounted || !state.locked) return;
    switch (result) {
      case AuthResult.success:
        state = const AppLockState();
      case AuthResult.cancelled:
        break;
      case AuthResult.unavailable:
        await _screenLockRemoved();
      case AuthResult.failed || AuthResult.lockedOut || AuthResult.error:
        state = AppLockState(locked: true, failure: result);
    }
  }

  /// The phone's screen lock was removed after App Lock was turned on (which
  /// takes the screen lock's PIN, so it was the owner), and there's nothing
  /// left to check: App Lock turns itself off, and says so.
  Future<void> _screenLockRemoved() async {
    final available = await ref.read(deviceAuthenticatorProvider).isAvailable();
    if (!ref.mounted || !state.locked) return;
    if (available) {
      state = const AppLockState(locked: true, failure: AuthResult.error);
      return;
    }
    state = const AppLockState(notice: AppLockNotice.screenLockRemoved);
    await ref.read(appLockSettingsProvider.notifier).setEnabled(false);
  }

  /// Turns App Lock on once the user has proved it's them, so a phone with
  /// nothing to check can't lock them out. [AuthResult.unavailable]: the
  /// phone has no screen lock.
  Future<AuthResult> enable() async {
    if (_prompting) return AuthResult.cancelled;
    if (!await ref.read(deviceAuthenticatorProvider).isAvailable()) return AuthResult.unavailable;
    if (!ref.mounted) return AuthResult.cancelled;
    final l10n = deviceL10n();
    final result =
        await _authenticate(title: l10n.appLockTurnOnPromptTitle, reason: l10n.appLockTurnOnPromptReason) ??
        AuthResult.cancelled;
    if (result == AuthResult.success && ref.mounted) {
      await ref.read(appLockSettingsProvider.notifier).setEnabled(true);
    }
    return result;
  }

  /// The newest prompt's result; null when a newer prompt took its place.
  Future<AuthResult?> _authenticate({required String title, required String reason}) async {
    final attempt = ++_attempt;
    _prompting = true;
    final result = await ref.read(deviceAuthenticatorProvider).authenticate(title: title, reason: reason);
    if (attempt != _attempt) return null;
    _prompting = false;
    return result;
  }
}

/// Puts the lock screen over the whole app while it's locked, from the first
/// frame of a cold start, and tells [AppLockController] when Loupe goes out
/// of sight and comes back. Goes above everything that can show mail (in
/// MaterialApp's builder), so dialogs, sheets and the account error screen
/// are under it too.
class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate> {
  late final AppLifecycleListener _lifecycle;

  AppLockController get _controller => ref.read(appLockProvider.notifier);

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onHide: () => _controller.appHidden(),
      onShow: () => _controller.appShown(),
      onResume: () => _controller.promptIfPending(),
    );
    // Already in the foreground on a cold start: the prompt can show now.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
        _controller.promptIfPending();
      }
    });
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(appLockProvider.select((s) => s.notice), (_, notice) {
      final text = switch (notice) {
        AppLockNotice.screenLockRemoved => context.l10n.appLockScreenLockRemoved,
        null => null,
      };
      if (text != null) ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(content: Text(text)));
    });
    final lock = ref.watch(appLockProvider);
    return Stack(
      fit: StackFit.expand,
      children: [
        // Kept alive under the lock (the open message, a draft being
        // written), but not painted, not focusable (no keyboard or shortcuts)
        // and not read out.
        Offstage(
          offstage: lock.locked,
          child: TickerMode(
            enabled: !lock.locked,
            child: ExcludeFocus(excluding: lock.locked, child: widget.child),
          ),
        ),
        if (lock.locked || lock.covered)
          LockScreen(
            message: lock.failure == null ? null : lockFailureText(lock.failure!, context.l10n),
            onUnlock: lock.locked ? () => unawaited(_controller.unlock()) : null,
          ),
      ],
    );
  }
}

/// Android's back button on the lock screen leaves Loupe, as on its first
/// screen, rather than going back in the screens under the lock. Goes around
/// MaterialApp, so it hears the button before the router does.
class AppLockBackButton extends ConsumerStatefulWidget {
  const AppLockBackButton({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLockBackButton> createState() => _AppLockBackButtonState();
}

class _AppLockBackButtonState extends ConsumerState<AppLockBackButton> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    if (!ref.read(appLockProvider).locked) return false;
    await SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Loupe's icon and name, and Unlock with the reason the last try failed;
/// without [onUnlock], the cover shown while Loupe is out of sight.
class LockScreen extends StatelessWidget {
  const LockScreen({super.key, this.onUnlock, this.message});

  final VoidCallback? onUnlock;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icon/icon_rounded.png', width: 80, height: 80, excludeFromSemantics: true),
                const SizedBox(height: 14),
                // l10n-ignore: the name
                Semantics(header: true, child: Text('Loupe', style: styles.navTitle)),
                if (onUnlock != null) ...[
                  if (message case final message?)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(message, style: styles.footnote, textAlign: TextAlign.center),
                    ),
                  const SizedBox(height: 28),
                  FilledButton(autofocus: true, onPressed: onUnlock, child: Text(context.l10n.appLockUnlock)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
