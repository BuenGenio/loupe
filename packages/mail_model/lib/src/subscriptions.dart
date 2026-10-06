// Subscriptions: bulk mail as newsletters (by sender) and discussion lists
// (by List-Id), with how much of it is read; and the ways List-Unsubscribe
// (RFC 2369, RFC 8058) offers to leave.

import 'account.dart';
import 'address.dart';
import 'bulk_names.dart';
import 'email.dart';
import 'lists.dart';
import 'mailbox.dart';
import 'outgoing.dart';

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

/// The message that unsubscribes through [method], sent from [account].
///
/// It goes from the identity the newsletter was addressed to (one of
/// [receivedAs], usually the newest message's recipients), so list managers
/// that check the sender find the subscribed address; else from the default
/// identity. Only the URI's recipients get it: `cc=` and `bcc=` are ignored,
/// so a header can't copy the request to anyone else.
OutgoingMessage unsubscribeMessage(
  MailtoUnsubscribe method,
  MailAccount account, {
  Iterable<EmailAddress> receivedAs = const [],
}) {
  final addressed = {for (final a in receivedAs) a.email.trim().toLowerCase()};
  final identity =
      account.identities.where((i) => addressed.contains(i.email.trim().toLowerCase())).firstOrNull ??
      account.defaultIdentity;
  return OutgoingMessage(
    accountId: account.id,
    identityId: identity.id,
    to: method.to,
    subject: method.subject,
    text: method.body,
  );
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

/// The source of [email] if it is bulk mail, else null: `list:` its List-Id,
/// or `from:` its sender's address (lower-cased). Sources group into
/// [Subscription]s (see [groupSubscriptions]).
///
/// Bulk mail has a List-Id, a List-Unsubscribe header or a Message-ID of a
/// bulk-mail service. (`Precedence: bulk` isn't fetched; mail that sets it
/// nearly always has List-Unsubscribe too.)
String? subscriptionKeyOf(EmailSummary email) {
  final listId = email.listId;
  if (listId != null && listId.isNotEmpty) return Subscription.listKey(listId);
  final from = email.sender?.email.trim().toLowerCase() ?? '';
  if (from.isEmpty) return null;
  if (email.listUnsubscribe != null || isBulkMessageId(email.messageIdHeader)) return Subscription.senderKey(from);
  return null;
}

/// The [Subscription.key] newsletters from [sender] group under: `from:` its
/// normalised address ([normalizeSenderAddress]); or, when the address
/// changes with every campaign ([isPerCampaignAddress]), `sender:` its
/// registrable domain and display name ([Subscription.brandKey]).
String newsletterKeyOf(EmailAddress sender) {
  final address = normalizeSenderAddress(sender.email);
  if (!isPerCampaignAddress(address)) return Subscription.senderKey(address);
  final domain = registrableDomainOf(address.substring(address.lastIndexOf('@') + 1));
  return Subscription.brandKey(domain, humanName(sender.name) ?? '');
}

// ---------------------------------------------------------------------------
// Newsletters and discussions

/// What a subscription is.
enum SubscriptionKind {
  /// Bulk mail from one sender to many: newsletters, offers, notifications.
  /// Grouped by sender.
  newsletter,

  /// A mailing list its members write to. Grouped by List-Id.
  discussion,
}

/// How long before a list's newest message its senders count as posters
/// ([SubscriptionSource.posters]).
const listPostersWindow = Duration(days: 365);

/// Whether a list is a discussion list: it takes posts (List-Post has a
/// `mailto:` URI, not `NO`), and at least two people wrote to it in the
/// [listPostersWindow] before its newest message, or its mail replies to its
/// own mail.
bool isDiscussionList({String? listPost, required int posters, required bool hasReplies}) =>
    listPostAddress(listPost) != null && (posters >= 2 || hasReplies);

/// A value of the newest message that has one, and when that arrived. Of
/// two, the newer counts; at the same time, the greater value (as SQL's
/// `max()` of the two packed after their times).
typedef NewestValue = ({DateTime at, String value});

/// The newer of [a] and [b] (see [NewestValue]).
NewestValue? newerOf(NewestValue? a, NewestValue? b) {
  if (a == null) return b;
  if (b == null) return a;
  final c = a.at.compareTo(b.at);
  if (c != 0) return c > 0 ? a : b;
  return a.value.compareTo(b.value) >= 0 ? a : b;
}

/// The bulk mail of one [subscriptionKeyOf] key, counted as for
/// [Subscription] (copies once; Junk, Sent, Drafts and the user's own mail
/// left out), with what classifying and naming it needs. Sources are what
/// the store keeps up to date; [groupSubscriptions] makes subscriptions of
/// them.
final class SubscriptionSource {
  const SubscriptionSource({
    required this.key,
    required this.address,
    this.keys = const [],
    this.messageCount = 0,
    this.readCount = 0,
    this.unreadCount = 0,
    this.recentCount = 0,
    this.recentReadCount = 0,
    this.inboxCount = 0,
    this.senderCount = 1,
    this.posters = 1,
    this.hasReplies = false,
    this.lastReceived,
    this.mailboxIds = const [],
    this.accountIds = const [],
    this.fromName,
    this.listName,
    this.listPost,
    this.unsubscribe,
  });

  /// `list:<List-Id>` or `from:<address>` ([subscriptionKeyOf]); or, for
  /// [keys] counted together, the [newsletterKey] they share.
  final String key;

  /// The [subscriptionKeyOf] keys counted, when there are several: sources
  /// without a List-Id that go under one newsletter, which the store adds up
  /// before grouping (not lists). Empty for [key] alone.
  final List<String> keys;

  /// The newest message's sender address, lower-cased.
  final String address;
  final int messageCount;
  final int readCount;

  /// Unread messages with a copy outside Trash.
  final int unreadCount;
  final int recentCount;
  final int recentReadCount;
  final int inboxCount;

  /// Distinct sender addresses.
  final int senderCount;

  /// Distinct sender addresses in the [listPostersWindow] before the newest
  /// message.
  final int posters;

  /// A message of the list answers another one of it: its In-Reply-To (or,
  /// without one, its last References entry) is the Message-ID of a stored
  /// message with the same List-Id, in the same account.
  final bool hasReplies;
  final DateTime? lastReceived;
  final List<String> mailboxIds;
  final List<String> accountIds;

  /// The newest non-empty From display name, List-Id phrase and List-Post.
  final NewestValue? fromName;
  final NewestValue? listName;
  final NewestValue? listPost;

  /// The newest List-Unsubscribe, and List-Unsubscribe-Post (or nothing)
  /// after a U+001F.
  final NewestValue? unsubscribe;

  bool get isList => key.startsWith('list:');
  String? get listId => isList ? key.substring(5) : null;

  /// [keys], or [key] alone.
  List<String> get sourceKeys => keys.isEmpty ? [key] : keys;

  /// How it is classified without the user's say: a list is a discussion
  /// when [isDiscussionList]; everything else is a newsletter.
  SubscriptionKind get autoKind =>
      isList && isDiscussionList(listPost: listPost?.value, posters: posters, hasReplies: hasReplies)
      ? SubscriptionKind.discussion
      : SubscriptionKind.newsletter;

  /// Where it goes as a newsletter: with the rest of its sender's mail
  /// ([newsletterKeyOf]), unless it is a list with several senders that
  /// aren't one sender changing address.
  String get newsletterKey {
    final sender = newsletterKeyOf(EmailAddress(address, fromName?.value));
    if (!isList || senderCount <= 1 || sender.startsWith('sender:')) return sender;
    return key;
  }

  @override
  String toString() =>
      'SubscriptionSource($key <$address>: $messageCount, senders $senderCount, posters $posters, '
      'replies $hasReplies, post ${listPost?.value})';
}

/// Makes subscriptions of [sources], ranked by [Subscription.compareByNeglect].
///
/// A list is a discussion by its [SubscriptionSource.autoKind], or as
/// [kinds] (by List-Id, the user's choice) says; a discussion is a
/// subscription of its own, under its List-Id. Newsletters come together
/// under their sender ([SubscriptionSource.newsletterKey]): a sender's
/// per-campaign List-Ids and its mail without one make one subscription.
List<Subscription> groupSubscriptions(
  Iterable<SubscriptionSource> sources, {
  Map<String, SubscriptionKind> kinds = const {},
}) {
  final groups = <String, List<SubscriptionSource>>{};
  final discussions = <String>{};
  for (final s in sources) {
    final kind = s.isList ? kinds[s.listId] ?? s.autoKind : SubscriptionKind.newsletter;
    final key = kind == SubscriptionKind.discussion ? s.key : s.newsletterKey;
    if (kind == SubscriptionKind.discussion) discussions.add(key);
    (groups[key] ??= []).add(s);
  }
  final out = <Subscription>[];
  for (final MapEntry(:key, value: group) in groups.entries) {
    final kind = discussions.contains(key) ? SubscriptionKind.discussion : SubscriptionKind.newsletter;
    NewestValue? address;
    NewestValue? phrase;
    NewestValue? fromName;
    NewestValue? post;
    NewestValue? unsubscribe;
    DateTime? last;
    var messages = 0, read = 0, unread = 0, recent = 0, recentRead = 0, inbox = 0, senders = 0;
    final boxes = <String>{};
    final accounts = <String>{};
    for (final s in group) {
      messages += s.messageCount;
      read += s.readCount;
      unread += s.unreadCount;
      recent += s.recentCount;
      recentRead += s.recentReadCount;
      inbox += s.inboxCount;
      senders = senders < s.senderCount ? s.senderCount : senders;
      boxes.addAll(s.mailboxIds);
      accounts.addAll(s.accountIds);
      if (s.lastReceived case final at?) {
        if (last == null || at.isAfter(last)) last = at;
        address = newerOf(address, (at: at, value: s.address));
      }
      if (humanName(s.listName?.value) != null) phrase = newerOf(phrase, s.listName);
      if (humanName(s.fromName?.value) != null) fromName = newerOf(fromName, s.fromName);
      post = newerOf(post, s.listPost);
      unsubscribe = newerOf(unsubscribe, s.unsubscribe);
    }
    final newest = address?.value ?? group.first.address;
    final postAddress = listPostAddress(post?.value);
    final listId = key.startsWith('list:') ? key.substring(5) : null;
    final unsub = unsubscribe?.value.split('\u001f');
    out.add(
      Subscription(
        key: key,
        kind: kind,
        name: subscriptionName(
          kind: kind,
          phrase: phrase?.value,
          listId: listId,
          postAddress: postAddress,
          fromName: fromName?.value,
          address: newest,
        ),
        address: newest,
        messageCount: messages,
        readCount: read,
        unreadCount: unread,
        recentCount: recent,
        recentReadCount: recentRead,
        inboxCount: inbox,
        senderCount: senders,
        lastReceived: last,
        mailboxIds: boxes.toList()..sort(),
        accountIds: accounts.toList()..sort(),
        sourceKeys: [for (final s in group) ...s.sourceKeys]..sort(),
        postAddress: postAddress,
        listUnsubscribe: unsub?.first,
        listUnsubscribePost: switch (unsub) {
          [_, final p] when p.isNotEmpty => p,
          _ => null,
        },
      ),
    );
  }
  return out..sort(Subscription.compareByNeglect);
}

/// What a subscription is called, never an identifier a machine made
/// ([looksMachineMade]): the List-Id phrase; for a newsletter, else the
/// sender's display name; for a discussion, else the List-Id or the list's
/// address; else the sender's domain.
String subscriptionName({
  required SubscriptionKind kind,
  required String address,
  String? phrase,
  String? listId,
  EmailAddress? postAddress,
  String? fromName,
}) {
  final named = humanName(phrase);
  if (named != null) return named;
  if (kind == SubscriptionKind.discussion) {
    if (listId != null && !looksMachineMade(listId)) return listId;
    if (postAddress != null) return postAddress.email.toLowerCase();
  } else if (humanName(fromName) case final sender?) {
    return sender;
  }
  final at = address.lastIndexOf('@');
  final domain = registrableDomainOf(at < 0 ? '' : address.substring(at + 1));
  return domain.isEmpty ? address : domain;
}

// ---------------------------------------------------------------------------
// Subscriptions

/// Bulk mail the user gets, across accounts: a newsletter (a sender's bulk
/// mail, whatever List-Ids it came with) or a discussion list (by List-Id).
///
/// Counts are of messages (copies in several mailboxes count once), outside
/// Junk, Sent and Drafts, and leave out the user's own mail. "Recent" is
/// the last [Subscription.window] (90 days).
final class Subscription {
  const Subscription({
    required this.key,
    required this.name,
    required this.address,
    this.kind = SubscriptionKind.newsletter,
    this.messageCount = 0,
    this.readCount = 0,
    int? unreadCount,
    this.recentCount = 0,
    this.recentReadCount = 0,
    this.inboxCount = 0,
    this.senderCount = 1,
    this.lastReceived,
    this.mailboxIds = const [],
    this.accountIds = const [],
    this.sourceKeys = const [],
    this.postAddress,
    this.listUnsubscribe,
    this.listUnsubscribePost,
  }) : _unreadCount = unreadCount;

  /// How far back [recentCount] and [perMonth] look.
  static const window = Duration(days: 90);

  /// [readRate] uses the last [window] once this many messages arrived in it.
  static const minRecentForRate = 3;

  static String listKey(String listId) => 'list:${listId.trim().toLowerCase()}';
  static String senderKey(String address) => 'from:${address.trim().toLowerCase()}';

  /// Newsletters from per-campaign addresses: their registrable [domain]
  /// and the display [name] (lower-cased), `sender:example.com/example news`.
  static String brandKey(String domain, String name) =>
      'sender:${domain.trim().toLowerCase()}/${name.trim().toLowerCase()}';

  /// `list:<List-Id>` (a discussion, or a newsletter list with several
  /// senders), `from:<address>` or `sender:<domain>/<name>` (see
  /// [newsletterKeyOf]), lower-cased.
  final String key;
  final SubscriptionKind kind;

  /// A name a person would recognise (see [subscriptionName]).
  final String name;

  /// The newest message's sender address, lower-cased.
  final String address;

  final int messageCount;

  /// Messages opened (`$seen`).
  final int readCount;
  final int? _unreadCount;

  /// Messages received in the last [window], and how many of them were read.
  final int recentCount;
  final int recentReadCount;

  /// Messages in an Inbox now.
  final int inboxCount;

  /// Distinct sender addresses: of a list, its posters' (a discussion has
  /// many); of a newsletter, the most any one of its sources has.
  final int senderCount;
  final DateTime? lastReceived;

  /// Where the messages are, sorted.
  final List<String> mailboxIds;

  /// The accounts that receive it, sorted.
  final List<String> accountIds;

  /// The [subscriptionKeyOf] keys of its mail, sorted; [key] alone when
  /// empty.
  final List<String> sourceKeys;

  /// Where to write to the list (List-Post), if it takes posts.
  final EmailAddress? postAddress;

  /// List-Unsubscribe and List-Unsubscribe-Post of the newest message that
  /// has a List-Unsubscribe header.
  final String? listUnsubscribe;
  final String? listUnsubscribePost;

  bool get isDiscussion => kind == SubscriptionKind.discussion;

  /// Grouped by List-Id.
  bool get isList => key.startsWith('list:');

  /// Grouped by the sender's domain and name: its address changes.
  bool get isBrand => key.startsWith('sender:');

  /// The List-Id, for a list.
  String? get listId => isList ? key.substring(5) : null;

  /// The List-Ids its mail came with: one for a list, any number (the
  /// campaigns) for a newsletter.
  List<String> get listIds => [
    for (final k in sourceKeys.isEmpty ? [key] : sourceKeys)
      if (k.startsWith('list:')) k.substring(5),
  ];

  /// For a [isBrand] newsletter, its registrable domain.
  String? get brandDomain => isBrand ? key.substring(7, key.indexOf('/')) : null;

  /// Unread messages (outside Trash).
  int get unreadCount => _unreadCount ?? messageCount - readCount;

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

  /// Most recent activity first, then by name.
  static int compareByActivity(Subscription a, Subscription b) {
    final at = a.lastReceived;
    final bt = b.lastReceived;
    final c = bt == null || at == null ? (at == null ? 1 : 0) - (bt == null ? 1 : 0) : bt.compareTo(at);
    if (c != 0) return c;
    final n = a.name.toLowerCase().compareTo(b.name.toLowerCase());
    return n != 0 ? n : a.key.compareTo(b.key);
  }

  @override
  bool operator ==(Object other) =>
      other is Subscription &&
      other.key == key &&
      other.kind == kind &&
      other.name == name &&
      other.address == address &&
      other.messageCount == messageCount &&
      other.readCount == readCount &&
      other.unreadCount == unreadCount &&
      other.recentCount == recentCount &&
      other.recentReadCount == recentReadCount &&
      other.inboxCount == inboxCount &&
      other.senderCount == senderCount &&
      other.lastReceived == lastReceived &&
      _listEquals(other.mailboxIds, mailboxIds) &&
      _listEquals(other.accountIds, accountIds) &&
      _listEquals(other.sourceKeys, sourceKeys) &&
      other.postAddress?.email.toLowerCase() == postAddress?.email.toLowerCase() &&
      other.listUnsubscribe == listUnsubscribe &&
      other.listUnsubscribePost == listUnsubscribePost;

  @override
  int get hashCode => Object.hash(key, kind, name, messageCount, readCount, recentCount, inboxCount, lastReceived);

  @override
  String toString() =>
      'Subscription($key ${kind.name} "$name" <$address>: $messageCount, read $readCount, unread $unreadCount, '
      'recent $recentCount/$recentReadCount, inbox $inboxCount, senders $senderCount, last $lastReceived, '
      '$mailboxIds, sources $sourceKeys, post $postAddress)';
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

/// The [SubscriptionSource]s of [emails]: the reference for the store's
/// queries, and what the demo uses. [roleOf] gives a message's mailbox role
/// (copies in [subscriptionExcludedRoles] are left out); [me] are the user's
/// own addresses, lower-cased. Senders found only by their Message-ID need
/// two messages to count.
List<SubscriptionSource> subscriptionSources(
  Iterable<EmailSummary> emails, {
  required MailboxRole? Function(EmailSummary email) roleOf,
  required DateTime now,
  Set<String> me = const {},
}) {
  final all = emails.toList();
  final cutoff = now.subtract(Subscription.window);
  // The lists of every stored message, by account and Message-ID: what
  // replies point at.
  final listsOf = <String, Set<String>>{};
  for (final e in all) {
    final mid = e.messageIdHeader;
    final list = e.listId;
    if (mid != null && list != null) (listsOf['${e.accountId}\u0000$mid'] ??= {}).add(list);
  }
  bool isReply(EmailSummary c) {
    final list = c.listId;
    final target = c.inReplyTo ?? c.references.lastOrNull;
    if (list == null || target == null) return false;
    return listsOf['${c.accountId}\u0000$target']?.contains(list) ?? false;
  }

  // One entry per message: its copies.
  final messages = <String, List<EmailSummary>>{};
  for (final e in all) {
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
  final out = <SubscriptionSource>[];
  for (final MapEntry(:key, value: group) in groups.entries) {
    var read = 0, unread = 0, recent = 0, recentRead = 0, inbox = 0;
    var listHeaders = false, replies = false;
    DateTime? last;
    NewestValue? address, listName, fromName, listPost, unsubscribe;
    final boxes = <String>{};
    final accounts = <String>{};
    final senders = <String>{};
    final copies = [for (final m in group) ...m];
    for (final message in group) {
      final at = message.map((c) => c.receivedAt).reduce((a, b) => a.isAfter(b) ? a : b);
      final seen = message.any((c) => c.isSeen);
      if (seen) read++;
      if (!seen && message.any((c) => roleOf(c) != MailboxRole.trash)) unread++;
      if (!at.isBefore(cutoff)) {
        recent++;
        if (seen) recentRead++;
      }
      if (message.any((c) => roleOf(c) == MailboxRole.inbox)) inbox++;
      if (last == null || at.isAfter(last)) last = at;
    }
    for (final c in copies) {
      final from = c.sender!.email.trim().toLowerCase();
      boxes.add(c.mailboxId);
      accounts.add(c.accountId);
      senders.add(from);
      if (c.listId != null || c.listUnsubscribe != null) listHeaders = true;
      if (isReply(c)) replies = true;
      address = newerOf(address, (at: c.receivedAt, value: from));
      if (c.listName?.trim() case final n? when n.isNotEmpty)
        listName = newerOf(listName, (at: c.receivedAt, value: n));
      if (c.sender?.name?.trim() case final n? when n.isNotEmpty)
        fromName = newerOf(fromName, (at: c.receivedAt, value: n));
      if (c.listPost case final p?) listPost = newerOf(listPost, (at: c.receivedAt, value: p));
      if (c.listUnsubscribe case final u?) {
        unsubscribe = newerOf(unsubscribe, (at: c.receivedAt, value: '$u\u001f${c.listUnsubscribePost ?? ''}'));
      }
    }
    if (!listHeaders && group.length < 2) continue;
    final since = last!.subtract(listPostersWindow);
    out.add(
      SubscriptionSource(
        key: key,
        address: address!.value,
        messageCount: group.length,
        readCount: read,
        unreadCount: unread,
        recentCount: recent,
        recentReadCount: recentRead,
        inboxCount: inbox,
        senderCount: senders.length,
        posters: {
          for (final c in copies)
            if (!c.receivedAt.isBefore(since)) c.sender!.email.trim().toLowerCase(),
        }.length,
        hasReplies: replies,
        lastReceived: last,
        mailboxIds: boxes.toList()..sort(),
        accountIds: accounts.toList()..sort(),
        fromName: fromName,
        listName: listName,
        listPost: listPost,
        unsubscribe: unsubscribe,
      ),
    );
  }
  return out;
}

/// Groups [emails] into subscriptions ([subscriptionSources], then
/// [groupSubscriptions] with the user's [kinds]): the reference for the
/// store, and what the demo uses.
List<Subscription> summarizeSubscriptions(
  Iterable<EmailSummary> emails, {
  required MailboxRole? Function(EmailSummary email) roleOf,
  required DateTime now,
  Set<String> me = const {},
  Map<String, SubscriptionKind> kinds = const {},
}) => groupSubscriptions(
  subscriptionSources(emails, roleOf: roleOf, now: now, me: me),
  kinds: kinds,
);

/// The Subscriptions screen's data: bulk mail grouped into [Subscription]s,
/// newsletters and discussion lists, computed on the device from the stored
/// messages. The repositories implement it next to `MailRepository`; check
/// with `repository is MailSubscriptions`. The streams emit at once and
/// again when mail (or a list's kind) changes.
abstract interface class MailSubscriptions {
  /// Every subscription, ranked by [Subscription.compareByNeglect].
  Stream<List<Subscription>> watchSubscriptions();

  /// The messages of subscription [key] (every [Subscription.sourceKeys]
  /// of it), newest first: every stored copy outside Junk, Sent and Drafts,
  /// or only those in an Inbox with [inboxOnly]. A key that is no
  /// subscription's but one's source ([subscriptionKeyOf]) gives that
  /// source's messages.
  Stream<List<EmailSummary>> watchSubscriptionEmails(String key, {bool inboxOnly = false, int limit = 200});

  /// Treats the lists [listIds] as [kind] from now on ("Treat as
  /// Newsletter"), or as they are classified again with null. Kept on the
  /// device.
  Future<void> setListKind(Iterable<String> listIds, SubscriptionKind? kind);
}
