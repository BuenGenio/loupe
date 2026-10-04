import 'package:mail_model/mail_model.dart';

/// Refreshes an OAuth access token (injected by the app; mail_platform
/// implements it). Called with the stored credentials when they expire or a
/// transport asks for `forceRefresh`.
typedef OAuthRefresher = Future<OAuthCredentials> Function(MailAccount account, OAuthCredentials current);

/// Tuning of the sync engine. The defaults suit a phone in the foreground.
final class SyncConfig {
  const SyncConfig({
    this.pollInterval = const Duration(minutes: 5),
    this.useIdle = true,
    this.idleDebounce = const Duration(seconds: 1),
    this.initialWindow = 200,
    this.olderPageSize = 100,
    this.reconnectBase = const Duration(seconds: 5),
    this.reconnectMax = const Duration(minutes: 5),
    this.opRetryBase = const Duration(seconds: 10),
    this.opRetryMax = const Duration(minutes: 10),
    this.maxOpAttempts = 5,
    this.sendRetryBase = const Duration(seconds: 30),
    this.sendRetryMax = const Duration(minutes: 30),
    this.searchTimeout = const Duration(seconds: 60),
  });

  /// How often each account syncs while running (the app pauses this in the
  /// background).
  final Duration pollInterval;

  /// Hold IMAP IDLE on the Inbox when the server supports it.
  final bool useIdle;

  /// Coalesces bursts of IDLE notifications into one sync.
  final Duration idleDebounce;

  /// Messages fetched on the first sync of a mailbox.
  final int initialWindow;

  /// Messages fetched per `loadOlder`.
  final int olderPageSize;

  /// Reconnect backoff after connection failures.
  final Duration reconnectBase;
  final Duration reconnectMax;

  /// Retry backoff of failed offline operations.
  final Duration opRetryBase;
  final Duration opRetryMax;

  /// Failures (other than being offline) after which an operation is
  /// reverted and reported.
  final int maxOpAttempts;

  /// Retry backoff of failed sends; sends are retried until cancelled.
  final Duration sendRetryBase;
  final Duration sendRetryMax;

  /// Server searches taking longer count as failed for that account.
  final Duration searchTimeout;
}
