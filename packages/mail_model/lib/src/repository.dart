import 'dart:typed_data';

import 'account.dart';
import 'address.dart';
import 'email.dart';
import 'mailbox.dart';
import 'outbox.dart';
import 'outgoing.dart';
import 'rules.dart';
import 'search.dart';
import 'server_documents.dart';
import 'snooze.dart';

enum SyncPhase { idle, syncing, error, offline }

final class AccountSyncStatus {
  const AccountSyncStatus({required this.accountId, required this.phase, this.lastSuccess, this.error});
  final String accountId;
  final SyncPhase phase;
  final DateTime? lastSuccess;

  /// Human-readable error for the status line, e.g. "Password rejected".
  final String? error;
}

/// What the local address book knows about one address: how often it wrote
/// to the user and the user to it. Feeds the phishing check ("first message
/// from this sender", look-alikes of known contacts).
final class SenderHistory {
  const SenderHistory({this.received = 0, this.sent = 0});

  /// Nothing known about the address.
  static const none = SenderHistory();

  /// Messages received from the address outside Junk and Trash, including
  /// the one being read once it is synced.
  final int received;

  /// Messages the user sent to the address.
  final int sent;

  /// The user wrote to the address, or has had mail from it before the
  /// message being read.
  bool get isKnown => sent > 0 || received > 1;

  @override
  bool operator ==(Object other) => other is SenderHistory && other.received == received && other.sent == sent;

  @override
  int get hashCode => Object.hash(received, sent);

  @override
  String toString() => 'SenderHistory(received: $received, sent: $sent)';
}

/// The app-facing API. The UI depends only on this.
///
/// Implementations: the demo repository (app, fake data) and the live
/// repository (mail_sync: store + transports). All `watch*` streams emit the
/// current value immediately and again whenever it changes.
abstract interface class MailRepository {
  // Accounts -----------------------------------------------------------------

  Stream<List<MailAccount>> watchAccounts();

  /// Finds server settings for an address (ISPDB, autoconfig, provider rules).
  Future<AccountDiscovery> discover(String email);

  /// Connects with [setup], and on success stores the account and its
  /// credentials and starts syncing. Throws [MailException] on failure.
  Future<MailAccount> addAccount(AccountSetup setup);
  Future<void> updateAccount(MailAccount account);
  Future<void> removeAccount(String accountId);

  // Mailboxes and lists ------------------------------------------------------

  /// Mailboxes of one account, or of all accounts when [accountId] is null.
  Stream<List<Mailbox>> watchMailboxes({String? accountId});

  /// Subscribes to a folder or unsubscribes from it on the server
  /// (optimistic, like the actions below: [Mailbox.isSubscribed] changes at
  /// once and the server catches up).
  Future<void> setMailboxSubscribed(String mailboxId, {required bool subscribed});

  /// Unread counts of the virtual mailboxes.
  Stream<Map<VirtualMailbox, int>> watchVirtualCounts();

  /// The message list, newest first. With [threaded], one row per
  /// conversation; otherwise every row has messageCount 1.
  Stream<List<ThreadSummary>> watchList(
    MailboxRef ref, {
    Set<QuickFilter> filters = const {},
    bool threaded = true,
    int limit = 200,
  });

  /// Loads older messages of [ref] from the server. Returns false when there
  /// is nothing more.
  Future<bool> loadOlder(MailboxRef ref);

  /// Syncs now (pull to refresh). Completes when the sync has finished.
  Future<void> refresh({MailboxRef? ref});

  Stream<List<AccountSyncStatus>> watchSyncStatus();

  // Messages -----------------------------------------------------------------

  /// All messages of the conversation [emailId] belongs to, oldest first.
  Stream<List<EmailSummary>> watchConversation(String emailId);

  Future<EmailSummary?> getEmail(String emailId);

  /// Body, attachments list and headers. Downloads if not cached.
  Future<EmailContent> loadContent(String emailId);
  Future<Uint8List> loadAttachment(String emailId, String partId);

  /// The raw RFC 822 message, for "View source".
  Future<Uint8List> loadRawSource(String emailId);

  // Actions (optimistic: lists update at once, the server catches up) ---------

  Future<void> setKeywords(List<String> emailIds, {Set<String> add = const {}, Set<String> remove = const {}});
  Future<void> move(List<String> emailIds, String targetMailboxId);

  /// Moves to the account's archive mailbox (Gmail: removes the Inbox label).
  Future<void> archive(List<String> emailIds);

  /// Moves to Trash; deletes permanently if already in Trash.
  Future<void> trash(List<String> emailIds);

  /// Moves to Junk (or back to Inbox) and sets $junk / $notjunk.
  Future<void> markJunk(List<String> emailIds, {required bool junk});

  // Snooze -------------------------------------------------------------------

  /// Snoozes [emailIds] until [until] (see `Snooze` and
  /// docs/snooze-convention.md): they move to their account's Snoozed folder,
  /// created when missing, with a `$snoozed-…` keyword, and come back to the
  /// Inbox, unread, at that time on whichever device syncs first. Messages
  /// already snoozed get the new time. Optimistic and offline-capable like
  /// the actions above.
  ///
  /// Returns [SnoozeStorage.device] when a server can't store keywords: the
  /// time then lives on this device only.
  Future<SnoozeStorage> snooze(List<String> emailIds, DateTime until);

  /// Wakes snoozed messages now ("Wake Now"): back to the Inbox, unread and
  /// marked `$new`, like when their time comes.
  Future<void> unsnooze(List<String> emailIds);

  /// Messages waiting in every account's Snoozed folder, the soonest to wake
  /// first; those without a (valid) time come last.
  Stream<List<EmailSummary>> watchSnoozed();

  // Search -------------------------------------------------------------------

  Stream<SearchResults> search(SearchRequest request);

  // Compose ------------------------------------------------------------------

  /// Queues [message] for sending after [undoDelay]. Returns an outbox id.
  ///
  /// With [sendAt] ("Send Later"), it waits in the outbox until then instead
  /// ([OutboxStatus.scheduled]; [undoDelay] doesn't apply), surviving
  /// restarts, and its draft ([OutgoingMessage.draftId]) is deleted at once:
  /// the outbox holds the message now.
  Future<String> send(OutgoingMessage message, {Duration undoDelay = const Duration(seconds: 10), DateTime? sendAt});

  /// Messages waiting to be sent (queued, scheduled, being sent or failed),
  /// soonest first.
  Stream<List<OutboxItem>> watchOutbox();

  /// Cancels a queued, scheduled or failed message if it isn't being sent.
  /// Returns the message so compose can reopen it, or null if it was already
  /// sent (or is being sent).
  Future<OutgoingMessage?> cancelSend(String outboxId);

  /// Sends a waiting message now (also "Retry" of a failed one). Does nothing
  /// if it is being sent; throws [MailException] (notFound) if it is gone.
  Future<void> sendNow(String outboxId);

  /// Moves a waiting message to [sendAt] (status scheduled, error cleared).
  /// Throws [MailException] if it is gone or being sent.
  Future<void> rescheduleSend(String outboxId, DateTime sendAt);

  /// Saves (or replaces) a draft on the server. Returns the draft's email id.
  Future<String> saveDraft(OutgoingMessage message);
  Future<void> deleteDraft(String draftEmailId);

  /// Recipient autocomplete from previously seen addresses.
  Future<List<EmailAddress>> suggestAddresses(String prefix, {int limit = 8});

  // Documents on the server -------------------------------------------------

  /// Every stored copy of Loupe's document [name] (e.g.
  /// [ServerDocuments.smartMailboxes]) on [accountId]'s server; see
  /// [MailTransport.readDocuments]. Throws [MailException] (kind connection
  /// while offline).
  Future<List<ServerDocument>> readServerDocuments(String accountId, String name);

  /// Stores [content] as document [name] on [accountId]'s server, replacing
  /// the copies in [replaces] (from [readServerDocuments]). Returns where it
  /// went. Throws [MailException] (kind connection while offline).
  Future<ServerStorage> writeServerDocument(
    String accountId,
    String name,
    String content, {
    List<ServerDocument> replaces = const [],
  });

  // People -------------------------------------------------------------------

  Stream<Set<String>> watchVipAddresses();
  Future<void> setVip(String email, {required bool vip});

  // Rules ----------------------------------------------------------------------

  /// Mail rules: the list, Apply to Existing Messages, and server rules
  /// (Sieve through ManageSieve).
  MailRules get rules;

  /// How often [email] wrote to the user and the user to it, from the local
  /// address book (case-insensitive). Unknown addresses give
  /// [SenderHistory.none].
  Future<SenderHistory> senderHistory(String email);
}

/// Errors surfaced to the UI. [message] is shown as is.
class MailException implements Exception {
  const MailException(this.kind, this.message, [this.cause]);
  final MailErrorKind kind;
  final String message;
  final Object? cause;
  @override
  String toString() => 'MailException(${kind.name}): $message';
}

/// A failure that trying again unchanged can't fix: the server refused for
/// good, such as an SMTP 5xx reply (an unknown mailbox, a message rejected
/// as spam, a sender the account may not use) or a login it still refuses
/// with freshly refreshed credentials. Other [MailException]s (offline, a
/// timeout, a 4xx reply) may go away by themselves.
///
/// The Outbox keeps a message that failed this way until the user taps
/// Retry, instead of trying it again and again.
final class PermanentMailException extends MailException {
  const PermanentMailException(super.kind, super.message, [super.cause]);

  @override
  String toString() => 'PermanentMailException(${kind.name}): $message';
}

enum MailErrorKind { authentication, connection, certificate, server, notFound, unsupported, cancelled, unknown }
