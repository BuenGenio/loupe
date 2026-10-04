// Subscriptions: bulk mail grouped by List-Id or sender, with how much of it
// is read, for the unsubscribe centre; and the ways List-Unsubscribe
// (RFC 2369, RFC 8058) offers to leave.

import 'address.dart';
import 'email.dart';
import 'lists.dart';
import 'mailbox.dart';

// ---------------------------------------------------------------------------
// mailto: URIs (RFC 6068)

/// The parts of a `mailto:` URI that matter for sending it: the recipients
/// (the path and `to=`), `cc=`, `bcc=`, `subject=` and `body=`. Other header
/// fields are dropped.
final class MailtoLink {
  const MailtoLink({required this.to, this.cc = const [], this.bcc = const [], this.subject, this.body});

  final List<EmailAddress> to;
  final List<EmailAddress> cc;
  final List<EmailAddress> bcc;
  final String? subject;
  final String? body;

  /// Parses a `mailto:` URI. Unlike `Uri.queryParameters`, `+` stays a plus
  /// (RFC 6068 has no form encoding). Returns null for other schemes and for
  /// links without a recipient.
  static MailtoLink? parse(Uri uri) {
    if (uri.scheme.toLowerCase() != 'mailto') return null;
    String decode(String s) {
      try {
        return Uri.decodeComponent(s);
      } on ArgumentError {
        return s;
      }
    }

    List<EmailAddress> addresses(String raw) => [
      for (final part in raw.split(','))
        if (decode(part).trim() case final a when a.contains('@')) EmailAddress(a),
    ];

    final to = addresses(uri.path);
    final cc = <EmailAddress>[];
    final bcc = <EmailAddress>[];
    String? subject;
    String? body;
    for (final pair in uri.query.split('&')) {
      final eq = pair.indexOf('=');
      if (eq <= 0) continue;
      final name = decode(pair.substring(0, eq)).toLowerCase();
      final value = pair.substring(eq + 1);
      switch (name) {
        case 'to':
          to.addAll(addresses(value));
        case 'cc':
          cc.addAll(addresses(value));
        case 'bcc':
          bcc.addAll(addresses(value));
        case 'subject':
          subject ??= decode(value);
        case 'body':
          body ??= decode(value);
      }
    }
    if (to.isEmpty) return null;
    return MailtoLink(to: to, cc: cc, bcc: bcc, subject: subject, body: body);
  }
}

// ---------------------------------------------------------------------------
// Unsubscribe methods

/// One way to leave a list, from its List-Unsubscribe header.
sealed class UnsubscribeMethod {
  const UnsubscribeMethod(this.uri);

  /// The URI as the header gives it.
  final Uri uri;
}

/// RFC 8058 one-click: an HTTPS POST of `List-Unsubscribe=One-Click` to
/// [uri], without cookies or anything else about the user. Offered when
/// List-Unsubscribe-Post says `List-Unsubscribe=One-Click` and
/// List-Unsubscribe has an `https` URI.
final class OneClickUnsubscribe extends UnsubscribeMethod {
  const OneClickUnsubscribe(super.uri);

  @override
  bool operator ==(Object other) => other is OneClickUnsubscribe && other.uri == uri;
  @override
  int get hashCode => Object.hash('oneClick', uri);
  @override
  String toString() => 'OneClick($uri)';
}

/// An unsubscribe message to send, as the `mailto:` URI describes it.
final class MailtoUnsubscribe extends UnsubscribeMethod {
  const MailtoUnsubscribe(super.uri, this.link);

  final MailtoLink link;

  /// Where the message goes.
  List<EmailAddress> get to => link.to;

  /// The subject to send: the URI's, else "unsubscribe" (what list
  /// managers' -request addresses understand).
  String get subject => (link.subject?.trim().isNotEmpty ?? false) ? link.subject! : 'unsubscribe';

  /// The body to send: the URI's, else empty.
  String get body => link.body ?? '';

  @override
  bool operator ==(Object other) => other is MailtoUnsubscribe && other.uri == uri;
  @override
  int get hashCode => Object.hash('mailto', uri);
  @override
  String toString() => 'Mailto($uri)';
}

/// A web page where the user unsubscribes themselves (`https`, or `http`).
final class WebUnsubscribe extends UnsubscribeMethod {
  const WebUnsubscribe(super.uri);

  bool get isSecure => uri.scheme.toLowerCase() == 'https';

  @override
  bool operator ==(Object other) => other is WebUnsubscribe && other.uri == uri;
  @override
  int get hashCode => Object.hash('web', uri);
  @override
  String toString() => 'Web($uri)';
}

/// The ways to unsubscribe that [listUnsubscribe] (with
/// [listUnsubscribePost]) offers, best first: one-click (RFC 8058), then a
/// `mailto:` message, then the web page (`https` before `http`). The page
/// of a one-click URI is also offered as a web fallback.
List<UnsubscribeMethod> unsubscribeMethods(String? listUnsubscribe, String? listUnsubscribePost) {
  final uris = parseListUris(listUnsubscribe);
  final out = <UnsubscribeMethod>[];
  bool isWeb(Uri u, String scheme) => u.scheme.toLowerCase() == scheme && u.host.isNotEmpty && u.userInfo.isEmpty;
  final https = uris.where((u) => isWeb(u, 'https')).firstOrNull;
  if (https != null && isOneClickUnsubscribe(listUnsubscribePost)) out.add(OneClickUnsubscribe(https));
  for (final u in uris) {
    if (MailtoLink.parse(u) case final link?) {
      out.add(MailtoUnsubscribe(u, link));
      break;
    }
  }
  final web = https ?? uris.where((u) => isWeb(u, 'http')).firstOrNull;
  if (web != null) out.add(WebUnsubscribe(web));
  return out;
}

// ---------------------------------------------------------------------------
// Bulk mail

/// Message-ID domains of bulk-mail services (ESPs). Mail whose Message-ID
/// ends in one of them counts as bulk even without List-* headers.
const bulkMessageIdDomains = [
  'mcsv.net', // Mailchimp
  'mcdlv.net',
  'rsgsv.net',
  'mandrillapp.com',
  'sendgrid.net',
  'amazonses.com',
  'sparkpostmail.com',
  'mailgun.org',
  'mailgun.net',
  'createsend.com', // Campaign Monitor
  'exacttarget.com', // Salesforce Marketing Cloud
];

/// Whether a Message-ID (without angle brackets) comes from a bulk-mail
/// service ([bulkMessageIdDomains]).
bool isBulkMessageId(String? messageId) {
  if (messageId == null) return false;
  final at = messageId.lastIndexOf('@');
  if (at < 0) return false;
  final domain = messageId.substring(at + 1).toLowerCase().trim();
  return bulkMessageIdDomains.any((d) => domain == d || domain.endsWith('.$d'));
}

/// The [Subscription.key] of [email] if it is bulk mail, else null.
///
/// Bulk mail has a List-Id, a List-Unsubscribe header or a Message-ID of a
/// bulk-mail service. (`Precedence: bulk` isn't fetched; mail that sets it
/// nearly always has List-Unsubscribe too.) It groups by List-Id, else by
/// the sender's address.
String? subscriptionKeyOf(EmailSummary email) {
  final listId = email.listId;
  if (listId != null && listId.isNotEmpty) return Subscription.listKey(listId);
  final from = email.sender?.email.trim().toLowerCase() ?? '';
  if (from.isEmpty) return null;
  if (email.listUnsubscribe != null || isBulkMessageId(email.messageIdHeader)) return Subscription.senderKey(from);
  return null;
}

// ---------------------------------------------------------------------------
// Subscriptions

/// One source of bulk mail: a mailing list or newsletter (by List-Id), or a
/// sender of bulk mail without one (by address), across accounts.
///
/// Counts are of messages (copies in several mailboxes count once), outside
/// Junk, Sent and Drafts, and leave out the user's own mail. "Recent" is
/// the last [Subscription.window] (90 days).
final class Subscription {
  const Subscription({
    required this.key,
    required this.name,
    required this.address,
    this.messageCount = 0,
    this.readCount = 0,
    this.recentCount = 0,
    this.recentReadCount = 0,
    this.inboxCount = 0,
    this.senderCount = 1,
    this.lastReceived,
    this.mailboxIds = const [],
    this.accountIds = const [],
    this.listUnsubscribe,
    this.listUnsubscribePost,
  });

  /// How far back [recentCount] and [perMonth] look.
  static const window = Duration(days: 90);

  /// [readRate] uses the last [window] once this many messages arrived in it.
  static const minRecentForRate = 3;

  static String listKey(String listId) => 'list:${listId.trim().toLowerCase()}';
  static String senderKey(String address) => 'from:${address.trim().toLowerCase()}';

  /// `list:<List-Id>` or `from:<address>`, lower-cased; see [listKey] and
  /// [senderKey].
  final String key;

  /// The List-Id phrase, else the sender's name, else [address] (or the
  /// List-Id); of the newest message that has one.
  final String name;

  /// The newest message's sender address, lower-cased.
  final String address;

  final int messageCount;

  /// Messages opened (`$seen`).
  final int readCount;

  /// Messages received in the last [window], and how many of them were read.
  final int recentCount;
  final int recentReadCount;

  /// Messages in an Inbox now.
  final int inboxCount;

  /// Distinct sender addresses (a discussion list has many).
  final int senderCount;
  final DateTime? lastReceived;

  /// Where the messages are, sorted.
  final List<String> mailboxIds;

  /// The accounts that receive it, sorted.
  final List<String> accountIds;

  /// List-Unsubscribe and List-Unsubscribe-Post of the newest message that
  /// has a List-Unsubscribe header.
  final String? listUnsubscribe;
  final String? listUnsubscribePost;

  /// Grouped by List-Id.
  bool get isList => key.startsWith('list:');

  /// The List-Id, for a list.
  String? get listId => isList ? key.substring(5) : null;

  int get unreadCount => messageCount - readCount;

  /// Messages a month over the last [window].
  double get perMonth => recentCount * 30 / window.inDays;

  /// The share of messages read, 0–1: of the last [window]'s messages once
  /// there are [minRecentForRate], else of all of them.
  double get readRate {
    if (recentCount >= minRecentForRate) return recentReadCount / recentCount;
    return messageCount == 0 ? 0 : readCount / messageCount;
  }

  /// None of the messages [readRate] looks at was read.
  bool get neverRead => messageCount > 0 && readRate == 0;

  /// Unread mail a month: the ranking of [compareByNeglect].
  double get neglect => perMonth * (1 - readRate);

  /// The ways to unsubscribe, best first (see [unsubscribeMethods]).
  List<UnsubscribeMethod> get unsubscribe => unsubscribeMethods(listUnsubscribe, listUnsubscribePost);

  /// "Most mail you never read" first: unread mail a month, then unread
  /// messages, then messages, then by name.
  static int compareByNeglect(Subscription a, Subscription b) {
    var c = b.neglect.compareTo(a.neglect);
    if (c != 0) return c;
    c = b.unreadCount.compareTo(a.unreadCount);
    if (c != 0) return c;
    c = b.messageCount.compareTo(a.messageCount);
    if (c != 0) return c;
    c = a.name.toLowerCase().compareTo(b.name.toLowerCase());
    return c != 0 ? c : a.key.compareTo(b.key);
  }

  @override
  bool operator ==(Object other) =>
      other is Subscription &&
      other.key == key &&
      other.name == name &&
      other.address == address &&
      other.messageCount == messageCount &&
      other.readCount == readCount &&
      other.recentCount == recentCount &&
      other.recentReadCount == recentReadCount &&
      other.inboxCount == inboxCount &&
      other.senderCount == senderCount &&
      other.lastReceived == lastReceived &&
      _listEquals(other.mailboxIds, mailboxIds) &&
      _listEquals(other.accountIds, accountIds) &&
      other.listUnsubscribe == listUnsubscribe &&
      other.listUnsubscribePost == listUnsubscribePost;

  @override
  int get hashCode => Object.hash(key, name, messageCount, readCount, recentCount, inboxCount, lastReceived);

  @override
  String toString() =>
      'Subscription($key "$name" <$address>: $messageCount, read $readCount, recent $recentCount/$recentReadCount, '
      'inbox $inboxCount, senders $senderCount, last $lastReceived, $mailboxIds)';
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// Mailbox roles whose mail isn't counted: spam, and the user's own.
const subscriptionExcludedRoles = {MailboxRole.junk, MailboxRole.sent, MailboxRole.drafts};

/// Groups [emails] into subscriptions, ranked by
/// [Subscription.compareByNeglect]: the reference for the store's query, and
/// what the demo uses. [roleOf] gives a message's mailbox role (copies in
/// [subscriptionExcludedRoles] are left out); [me] are the user's own
/// addresses, lower-cased. Senders found only by their Message-ID need two
/// messages to count.
List<Subscription> summarizeSubscriptions(
  Iterable<EmailSummary> emails, {
  required MailboxRole? Function(EmailSummary email) roleOf,
  required DateTime now,
  Set<String> me = const {},
}) {
  final cutoff = now.subtract(Subscription.window);
  // One entry per message: its copies, newest first.
  final messages = <String, List<EmailSummary>>{};
  for (final e in emails) {
    if (subscriptionExcludedRoles.contains(roleOf(e))) continue;
    final from = e.sender?.email.trim().toLowerCase() ?? '';
    if (from.isEmpty || me.contains(from)) continue;
    if (subscriptionKeyOf(e) == null) continue;
    (messages['${e.accountId}\u0000${e.messageIdHeader ?? e.id}'] ??= []).add(e);
  }
  final groups = <String, List<List<EmailSummary>>>{};
  for (final copies in messages.values) {
    final keys = [for (final c in copies) subscriptionKeyOf(c)!]..sort();
    (groups[keys.first] ??= []).add(copies);
  }
  final out = <Subscription>[];
  for (final MapEntry(key: key, value: group) in groups.entries) {
    var read = 0;
    var recent = 0;
    var recentRead = 0;
    var inbox = 0;
    var listHeaders = false;
    DateTime? last;
    EmailSummary? newest;
    EmailSummary? newestListName;
    EmailSummary? newestSenderName;
    EmailSummary? newestUnsubscribe;
    final boxes = <String>{};
    final accounts = <String>{};
    final senders = <String>{};
    bool newer(EmailSummary e, EmailSummary? than) => than == null || e.receivedAt.isAfter(than.receivedAt);
    for (final copies in group) {
      final at = copies.map((c) => c.receivedAt).reduce((a, b) => a.isAfter(b) ? a : b);
      final seen = copies.any((c) => c.isSeen);
      if (seen) read++;
      if (!at.isBefore(cutoff)) {
        recent++;
        if (seen) recentRead++;
      }
      if (copies.any((c) => roleOf(c) == MailboxRole.inbox)) inbox++;
      if (last == null || at.isAfter(last)) last = at;
      for (final c in copies) {
        boxes.add(c.mailboxId);
        accounts.add(c.accountId);
        senders.add(c.sender!.email.trim().toLowerCase());
        if (c.listId != null || c.listUnsubscribe != null) listHeaders = true;
        if (newer(c, newest)) newest = c;
        if ((c.listName?.trim().isNotEmpty ?? false) && newer(c, newestListName)) newestListName = c;
        if ((c.sender?.name?.trim().isNotEmpty ?? false) && newer(c, newestSenderName)) newestSenderName = c;
        if (c.listUnsubscribe != null && newer(c, newestUnsubscribe)) newestUnsubscribe = c;
      }
    }
    if (!listHeaders && group.length < 2) continue;
    final address = newest!.sender!.email.trim().toLowerCase();
    final isList = key.startsWith('list:');
    final named = (isList ? newestListName?.listName : null) ?? newestSenderName?.sender?.name;
    out.add(
      Subscription(
        key: key,
        name: named?.trim() ?? (isList ? key.substring(5) : address),
        address: address,
        messageCount: group.length,
        readCount: read,
        recentCount: recent,
        recentReadCount: recentRead,
        inboxCount: inbox,
        senderCount: senders.length,
        lastReceived: last,
        mailboxIds: boxes.toList()..sort(),
        accountIds: accounts.toList()..sort(),
        listUnsubscribe: newestUnsubscribe?.listUnsubscribe,
        listUnsubscribePost: newestUnsubscribe?.listUnsubscribePost,
      ),
    );
  }
  return out..sort(Subscription.compareByNeglect);
}

/// The unsubscribe centre's data: bulk mail grouped into [Subscription]s,
/// computed on the device from the stored messages. The repositories
/// implement it next to `MailRepository`; check with `repository is
/// MailSubscriptions`. The streams emit at once and again when mail changes.
abstract interface class MailSubscriptions {
  /// Every subscription, ranked by [Subscription.compareByNeglect].
  Stream<List<Subscription>> watchSubscriptions();

  /// The messages of subscription [key] (see [subscriptionKeyOf]), newest
  /// first: every stored copy outside Junk, Sent and Drafts, or only those
  /// in an Inbox with [inboxOnly].
  Stream<List<EmailSummary>> watchSubscriptionEmails(String key, {bool inboxOnly = false, int limit = 200});
}
