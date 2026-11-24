import 'dart:math';

import 'address.dart';
import 'email.dart';

/// One conversation as topic finding sees it.
final class TopicThread {
  TopicThread({required this.accountId, required this.threadId, required this.latest, required this.subject});

  final String accountId;
  final String threadId;

  /// Its newest message (for opening it and for "all its messages").
  EmailSummary latest;

  /// The subject without Re:/Fwd: and list tags.
  final String subject;

  DateTime first = DateTime.utc(9999);
  DateTime last = DateTime.utc(0);

  /// The other people in it (lower-cased addresses) and their names.
  final people = <String, String>{};

  /// Messages the user sent; messages addressed to the user personally.
  int mine = 0;
  int toMe = 0;
  int bulk = 0;
  final projectIds = <String>{};
  String? listId;
  String? listName;

  String get key => '$accountId|$threadId';

  /// The user took part: wrote in it, or it was written to them, not to a list.
  bool get tookPart => mine > 0 || (toMe > 0 && bulk == 0);
}

enum TopicKind {
  /// The people of one organisation (a domain that isn't a free-mail one).
  organisation,

  /// A word that recurs in these subjects and is rare elsewhere.
  word,

  /// A discussion list the user writes to.
  list,

  /// Named and grouped by an AI server the user chose.
  named,
}

/// A suggested project: conversations that seem to belong together.
final class TopicSuggestion {
  const TopicSuggestion({
    required this.key,
    required this.label,
    required this.kind,
    required this.threads,
    this.query = '',
  });

  /// Stable across runs (`org:harbourline.com`, `word:mortgage`, `list:…`), for
  /// Not a Topic.
  final String key;

  /// The name offered for the project ("Harbourline", "Mortgage").
  final String label;
  final TopicKind kind;

  /// Newest first.
  final List<TopicThread> threads;

  /// A search that finds its future mail (for a project's rule); empty for none.
  final String query;

  DateTime get last => threads.first.last;

  TopicSuggestion withLabel(String label) =>
      TopicSuggestion(key: key, label: label, kind: kind, threads: threads, query: query);
}

/// Domains of free-mail providers: their people share nothing but a provider.
const freeMailDomains = {
  'gmail.com',
  'googlemail.com',
  'outlook.com',
  'hotmail.com',
  'hotmail.co.uk',
  'live.com',
  'msn.com',
  'yahoo.com',
  'yahoo.co.uk',
  'ymail.com',
  'icloud.com',
  'me.com',
  'mac.com',
  'aol.com',
  'proton.me',
  'protonmail.com',
  'pm.me',
  'gmx.com',
  'gmx.de',
  'gmx.net',
  'web.de',
  'mail.ru',
  'yandex.ru',
  'yandex.com',
  'zoho.com',
  'hey.com',
  'fastmail.com',
  'tutanota.com',
  'tuta.io',
  'mail.com',
  'qq.com',
  '163.com',
  'btinternet.com',
  'orange.fr',
  'free.fr',
  'laposte.net',
  'libero.it',
  't-online.de',
  'seznam.cz',
  'wp.pl',
  'o2.pl',
  'abv.bg',
  'ukr.net',
  // Reserved for examples (RFC 2606): no one's organisation.
  'example.com',
  'example.org',
  'example.net',
};

/// Senders that are machines (alerts, receipts, statements): mail from them
/// counts like a newsletter unless the user wrote in the conversation.
final _automated = RegExp(
  r'^(no-?reply|do-?not-?reply|notifications?|notify|alerts?|statements?|receipts?|billing|invoices?|orders?|'
  r'news(letter)?|info|mailer(-daemon)?|accounts?|updates?|support|service|bounces?|auto(mated)?|system|'
  r'security|hello|team|calendar|tracker|builds?|ci|postmaster)([._+-]|$)',
  caseSensitive: false,
);

bool _isAutomated(EmailAddress a) => _automated.hasMatch(a.email.split('@').first);

/// Words of subjects that say nothing about a topic.
const _stopWords = {
  'review',
  'reviews',
  'plan',
  'plans',
  'draft',
  'final',
  'agenda',
  'minutes',
  'invitation',
  'invite',
  'updated',
  'sync',
  'items',
  'ready',
  'week',
  'weekly',
  'monthly',
  'daily',
  'summary',
  'report',
  'status',
  'about',
  'after',
  'again',
  'also',
  'and',
  'any',
  'are',
  'back',
  'been',
  'before',
  'being',
  'both',
  'but',
  'can',
  'could',
  'dear',
  'did',
  'does',
  'done',
  'each',
  'for',
  'from',
  'further',
  'get',
  'have',
  'hello',
  'here',
  'hey',
  'how',
  'into',
  'just',
  'last',
  'let',
  'like',
  'more',
  'most',
  'need',
  'next',
  'note',
  'notes',
  'now',
  'only',
  'other',
  'our',
  'out',
  'over',
  'please',
  'quick',
  'question',
  'questions',
  'really',
  'regarding',
  'reminder',
  'same',
  'some',
  'soon',
  'still',
  'such',
  'than',
  'thank',
  'thanks',
  'that',
  'the',
  'their',
  'them',
  'then',
  'there',
  'these',
  'they',
  'this',
  'those',
  'today',
  'tomorrow',
  'update',
  'updates',
  'very',
  'want',
  'were',
  'what',
  'when',
  'where',
  'which',
  'will',
  'with',
  'would',
  'your',
  'yours',
  'info',
  'information',
  'request',
  'follow',
  'following',
  'fwd',
  'meeting',
  'call',
  'chat',
  'hi',
  'new',
  'message',
  'email',
  'mail',
};

final _prefix = RegExp(
  r'^\s*((re|fw|fwd|aw|wg|sv|vs|tr|rif|antw|odp|ynt|vb|res|enc|ref)\s*(\[\d+\])?\s*[:：]\s*|\[[^\]]{1,40}\]\s*)+',
  caseSensitive: false,
);
final _notAlphanumeric = RegExp(r'[^\p{L}\p{N}]', unicode: true);
final _word = RegExp(r'[\p{L}][\p{L}\p{M}]{3,}', unicode: true);

/// [subject] without reply and forward prefixes or list tags.
String topicSubject(String subject) => subject.replaceFirst(_prefix, '').trim();

/// The organisation part of an address's domain: `mail.harbourline.com` →
/// `harbourline.com`, `x.example.co.uk` → `example.co.uk`.
String organisationDomain(String email) {
  final at = email.lastIndexOf('@');
  final labels = email.substring(at + 1).toLowerCase().split('.')..removeWhere((l) => l.isEmpty);
  if (labels.length <= 2) return labels.join('.');
  final second = labels[labels.length - 2];
  final keep =
      labels.last.length == 2 && const {'co', 'com', 'org', 'net', 'ac', 'gov', 'edu', 'ltd', 'plc'}.contains(second)
      ? 3
      : 2;
  return labels.sublist(labels.length - keep).join('.');
}

/// Groups [emails] (any messages of the last months, from every account and
/// folder) into conversations.
List<TopicThread> topicThreads(Iterable<EmailSummary> emails, {required Set<String> myAddresses}) {
  final mine = {for (final a in myAddresses) a.toLowerCase()};
  final byKey = <String, TopicThread>{};
  for (final e in emails) {
    final id = e.threadId ?? e.messageIdHeader ?? e.id;
    final t = byKey.putIfAbsent('${e.accountId}|$id', () {
      return TopicThread(accountId: e.accountId, threadId: id, latest: e, subject: topicSubject(e.subject));
    });
    if (e.receivedAt.isAfter(t.latest.receivedAt)) t.latest = e;
    if (e.receivedAt.isBefore(t.first)) t.first = e.receivedAt;
    if (e.receivedAt.isAfter(t.last)) t.last = e.receivedAt;
    t.projectIds.addAll(e.projectIds);
    final fromMe = e.from.any((a) => mine.contains(a.email.toLowerCase()));
    if (fromMe) {
      t.mine++;
    } else if ([...e.to, ...e.cc].any((a) => mine.contains(a.email.toLowerCase()))) {
      t.toMe++;
    }
    final machine = e.from.any(_isAutomated);
    if (!fromMe && (e.listUnsubscribe != null || (e.listId != null && e.listPost == null) || machine)) t.bulk++;
    if (e.listId != null) {
      t.listId ??= e.listId;
      t.listName ??= e.listName;
    }
    for (final a in [...e.from, ...e.to, ...e.cc]) {
      final email = a.email.toLowerCase();
      if (email.isEmpty || mine.contains(email)) continue;
      t.people.putIfAbsent(email, () => a.name ?? '');
    }
  }
  return byKey.values.toList();
}

/// Suggests projects among [threads] (see [topicThreads]): conversations the
/// user took part in, in no project yet, that share an organisation, a
/// distinctive subject word or a discussion list. A suggestion needs at
/// least [minThreads] conversations spread over at least [minSpan]. Those
/// whose key is in [dismissed] or whose label is a project's name in
/// [projectNames] (any case) are left out. At most [limit], the strongest
/// first; one that mostly repeats a stronger one is dropped.
List<TopicSuggestion> suggestTopics(
  List<TopicThread> threads, {
  required Set<String> myAddresses,
  Set<String> dismissed = const {},
  Set<String> projectNames = const {},
  int minThreads = 3,
  Duration minSpan = const Duration(days: 14),
  int limit = 6,
}) {
  final myDomains = {for (final a in myAddresses) organisationDomain(a)};
  final names = {for (final n in projectNames) n.toLowerCase()};
  final open = [
    for (final t in threads)
      if (t.tookPart && t.projectIds.isEmpty) t,
  ];
  if (open.length < minThreads) return const [];

  final byOrg = <String, List<TopicThread>>{};
  final byWord = <String, List<TopicThread>>{};
  final byList = <String, List<TopicThread>>{};
  for (final t in open) {
    final domains = <String>{};
    for (final email in t.people.keys) {
      final d = organisationDomain(email);
      if (d.isEmpty || freeMailDomains.contains(d) || myDomains.contains(d)) continue;
      domains.add(d);
    }
    for (final d in domains) {
      (byOrg[d] ??= []).add(t);
    }
    final words = {for (final m in _word.allMatches(t.subject.toLowerCase())) m[0]!}..removeAll(_stopWords);
    for (final w in words) {
      (byWord[w] ??= []).add(t);
    }
    if (t.listId case final id? when t.mine > 0) (byList[id] ??= []).add(t);
  }

  final total = open.length;
  final candidates = <(TopicSuggestion, double)>[];
  bool spread(List<TopicThread> ts) {
    final first = ts.map((t) => t.first).reduce((a, b) => a.isBefore(b) ? a : b);
    final last = ts.map((t) => t.last).reduce((a, b) => a.isAfter(b) ? a : b);
    return last.difference(first) >= minSpan;
  }

  List<TopicThread> newestFirst(List<TopicThread> ts) => [...ts]..sort((a, b) => b.last.compareTo(a.last));

  for (final MapEntry(key: domain, value: ts) in byOrg.entries) {
    if (ts.length < minThreads || !spread(ts)) continue;
    // Most of the conversations: the user's own employer or school, not a topic.
    if (ts.length > max(minThreads, total * 0.6)) continue;
    final label = _organisationLabel(domain, [
      for (final t in ts)
        for (final MapEntry(key: email, value: name) in t.people.entries)
          if (organisationDomain(email) == domain) name,
    ]);
    candidates.add((
      TopicSuggestion(
        key: 'org:$domain',
        label: label,
        kind: TopicKind.organisation,
        threads: newestFirst(ts),
        query: 'from:$domain',
      ),
      // The strongest sign: people of one organisation.
      ts.length * 2.0,
    ));
  }
  for (final MapEntry(key: word, value: ts) in byWord.entries) {
    if (ts.length < minThreads || !spread(ts)) continue;
    // Common across the mail: says nothing.
    if (ts.length / total > 0.2) continue;
    final idf = log(total / ts.length) + 1;
    candidates.add((
      TopicSuggestion(
        key: 'word:$word',
        label: '${word[0].toUpperCase()}${word.substring(1)}',
        kind: TopicKind.word,
        threads: newestFirst(ts),
        query: 'subject:$word',
      ),
      ts.length * min(idf, 3) * 0.5,
    ));
  }
  for (final MapEntry(key: id, value: ts) in byList.entries) {
    if (ts.length < minThreads || !spread(ts)) continue;
    final name = ts.map((t) => t.listName).nonNulls.firstOrNull;
    candidates.add((
      TopicSuggestion(
        key: 'list:$id',
        label: name ?? id.split('.').first,
        kind: TopicKind.list,
        threads: newestFirst(ts),
      ),
      ts.length * 1.5,
    ));
  }
  candidates.sort((a, b) {
    final c = b.$2.compareTo(a.$2);
    return c != 0 ? c : b.$1.last.compareTo(a.$1.last);
  });

  final chosen = <TopicSuggestion>[];
  for (final (s, _) in candidates) {
    if (dismissed.contains(s.key) || names.contains(s.label.toLowerCase())) continue;
    final keys = {for (final t in s.threads) t.key};
    final repeats = chosen.any((c) {
      final shared = c.threads.where((t) => keys.contains(t.key)).length;
      return shared >= keys.length * 0.6;
    });
    if (repeats) continue;
    chosen.add(s);
    if (chosen.length >= limit) break;
  }
  return chosen;
}

/// An organisation's name: a sender's display name that spells its domain
/// (`Harbor Coffee` for harborcoffee.example), else the domain's first label
/// capitalised.
String _organisationLabel(String domain, List<String> names) {
  final first = domain.split('.').first;
  for (final n in names) {
    if (n.toLowerCase().replaceAll(_notAlphanumeric, '') == first) return n.trim();
  }
  if (first.length < 3 || RegExp(r'\d').hasMatch(first)) return domain;
  return '${first[0].toUpperCase()}${first.substring(1)}';
}
