import 'dart:typed_data';

import 'account.dart';
import 'email.dart';
import 'mailbox.dart';
import 'outgoing.dart';
import 'repository.dart';
import 'search.dart';
import 'server_documents.dart';

/// A mailbox as the server lists it.
final class RemoteMailbox {
  const RemoteMailbox({
    required this.path,
    required this.name,
    this.role = MailboxRole.none,
    this.parentPath,
    this.isSelectable = true,
    this.isSubscribed = true,
  });

  final String path;
  final String name;
  final MailboxRole role;
  final String? parentPath;
  final bool isSelectable;
  final bool isSubscribed;
}

/// Opaque per-mailbox sync state, owned by the transport (UIDVALIDITY,
/// UIDNEXT, HIGHESTMODSEQ, oldest synced UID, JMAP state…). The store only
/// persists it as JSON.
final class MailboxSyncState {
  const MailboxSyncState(this.data);
  final Map<String, Object?> data;
}

/// What changed in a mailbox since the previous state.
final class MailboxSyncResult {
  const MailboxSyncResult({
    required this.state,
    this.added = const [],
    this.keywordUpdates = const {},
    this.vanishedIds = const [],
    this.resetAll = false,
    this.totalCount,
    this.unreadCount,
    this.hasOlder = false,
    this.canStoreKeywords,
  });

  final MailboxSyncState state;

  /// New messages (final local ids, see MailIds).
  final List<EmailSummary> added;

  /// Keyword changes of known messages: email id → complete keyword set.
  final Map<String, Set<String>> keywordUpdates;

  /// Messages removed on the server.
  final List<String> vanishedIds;

  /// True if the mailbox was reset (e.g. UIDVALIDITY changed): the store
  /// must drop everything it has for this mailbox before applying [added].
  final bool resetAll;
  final int? totalCount;
  final int? unreadCount;

  /// More, older messages exist on the server.
  final bool hasOlder;

  /// Whether the mailbox keeps new keywords permanently (IMAP: PERMANENTFLAGS
  /// lists `\*`). Null when the server didn't say, which means yes (RFC 9051).
  /// Snooze needs it for its wake-time keyword.
  final bool? canStoreKeywords;
}

final class TransportCapabilities {
  const TransportCapabilities({
    this.supportsIdle = false,
    this.supportsCondstore = false,
    this.supportsQresync = false,
    this.supportsMove = false,
    this.supportsGmailExtensions = false,
    this.supportsEsearch = false,
    this.supportsUtf8 = false,
    this.raw = const {},
  });

  final bool supportsIdle;
  final bool supportsCondstore;
  final bool supportsQresync;
  final bool supportsMove;

  /// X-GM-EXT-1: labels, X-GM-RAW, X-GM-THRID.
  final bool supportsGmailExtensions;
  final bool supportsEsearch;
  final bool supportsUtf8;

  /// All capability strings as the server sent them.
  final Set<String> raw;
}

/// Returns current credentials; [forceRefresh] asks OAuth to refresh the token
/// (after the server rejected the old one).
typedef CredentialsCallback = Future<Credentials> Function({bool forceRefresh});

/// One connection-oriented view of an account's server. Implemented by
/// mail_imap (IMAP) and later mail_jmap. Not thread-safe: the sync engine
/// serialises calls per transport and uses a second transport for searches.
abstract interface class MailTransport {
  String get accountId;

  /// Valid after [connect].
  TransportCapabilities get capabilities;

  /// Connects and authenticates. Throws MailException (authentication,
  /// connection, certificate).
  Future<void> connect();
  Future<void> disconnect();
  bool get isConnected;

  Future<List<RemoteMailbox>> listMailboxes();

  /// Subscribes to [mailbox] or unsubscribes from it (IMAP SUBSCRIBE /
  /// UNSUBSCRIBE). Throws [MailException] of kind [MailErrorKind.notFound]
  /// when the server no longer has the mailbox.
  Future<void> setSubscribed(RemoteMailbox mailbox, bool subscribed);

  /// Creates the mailbox [path] (IMAP CREATE) and subscribes to it. Succeeds
  /// when it exists already (another client may have been faster). Used for
  /// the Snoozed folder.
  Future<void> createMailbox(String path);

  /// Brings a mailbox up to date. With [previous] null, fetches the newest
  /// [initialWindow] messages. Uses CONDSTORE/QRESYNC when available.
  Future<MailboxSyncResult> syncMailbox(RemoteMailbox mailbox, MailboxSyncState? previous, {int initialWindow = 200});

  /// Fetches up to [count] messages older than what [state] covers.
  Future<MailboxSyncResult> fetchOlder(RemoteMailbox mailbox, MailboxSyncState state, {int count = 100});

  /// Summaries for specific ids (e.g. server search hits not stored yet).
  /// Without [previews] their preview stays empty, which saves fetching the
  /// start of every body (refreshing header fields of stored summaries).
  Future<List<EmailSummary>> fetchSummaries(List<String> emailIds, {bool previews = true});

  Future<EmailContent> fetchContent(String emailId);
  Future<Uint8List> fetchAttachment(String emailId, String partId);
  Future<Uint8List> fetchRaw(String emailId);

  Future<void> setKeywords(List<String> emailIds, {Set<String> add = const {}, Set<String> remove = const {}});

  /// Moves messages; returns old id → new id where the server reports it
  /// (IMAP UIDPLUS COPYUID).
  Future<Map<String, String>> move(List<String> emailIds, RemoteMailbox target);

  /// Flags \Deleted and expunges just these messages (UID EXPUNGE when available).
  Future<void> deletePermanently(List<String> emailIds);

  /// Server-side search. Terms the server can't evaluate are widened, so the
  /// result may be a superset; the caller filters locally.
  /// [mailbox] null means all selectable mailboxes (Gmail: All Mail).
  Future<List<String>> search(SearchExpr expr, {RemoteMailbox? mailbox, int limit = 200});

  /// Appends a message (drafts, sent copies). Returns the new email id if known.
  Future<String?> append(RemoteMailbox mailbox, Uint8List rfc822, {Set<String> keywords = const {}});

  /// Emits whenever the server reports a change in [mailbox] (IMAP IDLE).
  /// The stream ends when the connection drops.
  Stream<void> watch(RemoteMailbox mailbox);

  /// Every stored copy of Loupe's document [name] on this server (empty when
  /// there is none): the METADATA entry [ServerDocuments.metadataEntry] where
  /// the server supports it, and messages in the [ServerDocuments.folderName]
  /// folder.
  Future<List<ServerDocument>> readDocuments(String name);

  /// Stores [content] as document [name], as METADATA when the server
  /// accepts it and otherwise as a message in the documents folder (created
  /// when missing), then removes the copies in [replaces]. Returns where it
  /// went.
  Future<ServerStorage> writeDocument(String name, String content, {List<ServerDocument> replaces = const []});
}

/// Sends a ready-made message (SMTP).
abstract interface class MailSender {
  /// Hands [rfc822] to the server for [recipients].
  ///
  /// Throws when nothing was sent: a [PermanentMailException] when the
  /// server refused for good (sending it again fails the same way), another
  /// [MailException] when it may work later. When the server refuses only
  /// some recipients, the message goes to the others and the receipt names
  /// the refused ones.
  Future<SendReceipt> send(Uint8List rfc822, {required String envelopeFrom, required List<String> recipients});
  Future<void> close();
}

/// What [MailSender.send] did with a message the server took.
final class SendReceipt {
  const SendReceipt({this.refused = const {}});

  /// Recipients the server refused while it took the message for the
  /// others: address → why (a [PermanentMailException] when for good).
  /// Empty when it took every recipient.
  final Map<String, MailException> refused;
}

/// Builds RFC 822 bytes from an [OutgoingMessage].
abstract interface class MessageComposer {
  Uint8List compose(OutgoingMessage message, Identity from, {required String messageId, DateTime? date});
}

/// Creates transports for accounts. Implemented by mail_imap.
abstract interface class TransportFactory {
  MailTransport createTransport(MailAccount account, CredentialsCallback credentials);
  MailSender createSender(MailAccount account, CredentialsCallback credentials);
  MessageComposer get composer;

  /// Finds settings for an address (ISPDB, autoconfig, MX, provider rules).
  Future<AccountDiscovery> discover(String email);
}

/// Persists secrets in the platform keychain. Implemented by mail_platform.
abstract interface class CredentialStore {
  Future<Credentials?> read(String accountId);
  Future<void> write(String accountId, Credentials credentials);
  Future<void> delete(String accountId);
}
