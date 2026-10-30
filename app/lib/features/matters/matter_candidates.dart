import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../conversation/mail_streams.dart';
import 'matter_providers.dart';

/// A conversation that may belong to a matter, and why. Never added on its
/// own: the user adds it or says Not This One.
final class MatterCandidate {
  const MatterCandidate({required this.email, required this.reason, required this.score});

  /// The newest message found of the conversation.
  final EmailSummary email;

  /// The strongest reason: a mention before a shared sender, a sender
  /// before a shared domain.
  final MatterReason reason;
  final int score;
}

/// References such as QS-4471, INV-2207 or #10482.
final _reference = RegExp(r'\b[A-Z]{2,5}-\d{3,}\b|(?<![\w#])#\d{4,}\b');

/// Street addresses such as "14 Quay Street".
final _address = RegExp(
  r'\b\d{1,4}[A-Za-z]?\s+(?:[A-Z][\w’\x27-]*\s+){1,3}(?:Street|Road|Lane|Avenue|Close|Way|Drive|Place|Row|Court|'
  r'Crescent|Terrace|Gardens|Square|Hill|Park|Mews|Grove|Walk)\b',
);

/// Domains many unrelated people share: a shared one says nothing.
const _sharedDomains = {
  'gmail.com',
  'googlemail.com',
  'outlook.com',
  'hotmail.com',
  'hotmail.co.uk',
  'live.com',
  'msn.com',
  'yahoo.com',
  'yahoo.co.uk',
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
  'mail.com',
  'fastmail.com',
  'fastmail.fm',
  'zoho.com',
  'yandex.com',
  'yandex.ru',
  'mail.ru',
  'hey.com',
  'tutanota.com',
  'tuta.io',
  'orange.fr',
  'free.fr',
  'btinternet.com',
  'sky.com',
  'virginmedia.com',
};

/// The words worth looking for in other mail: references (QS-4471) and
/// addresses (14 Quay Street) in the matter's name, subjects and previews,
/// and the longest run of capitalised words or numbers of the name that its
/// mail also has ("14 Quay Street" of "Buying 14 Quay Street"). A word that
/// is part of a longer one is left out. At most [limit].
List<String> matterTerms(Matter matter, List<EmailSummary> messages, {int limit = 6}) {
  final texts = [
    matter.name,
    for (final m in messages) ...[m.subject, m.preview],
  ];
  final found = <String>[
    for (final t in texts) ...[
      for (final m in _address.allMatches(t)) m.group(0)!,
      for (final m in _reference.allMatches(t)) m.group(0)!,
    ],
  ];
  final mail = [for (final m in messages) '${m.subject}\n${m.preview}'.toLowerCase()].join('\n');
  final tokens = matter.name.split(RegExp(r'\s+')).where((t) => t.isNotEmpty).toList();
  bool distinctive(String token) => RegExp(r'^\p{Lu}|\p{N}', unicode: true).hasMatch(token);
  for (var start = 0; start < tokens.length; start++) {
    if (!distinctive(tokens[start])) continue;
    var end = start;
    while (end < tokens.length && distinctive(tokens[end])) {
      end++;
    }
    // The longest part of the run, of two words or more, that the mail has.
    String? best;
    for (var from = start; from < end && best == null; from++) {
      for (var to = end; to - from >= 2 && best == null; to--) {
        final phrase = tokens.sublist(from, to).join(' ').replaceAll(RegExp(r'[,.;:!?]+$'), '');
        if (mail.contains(phrase.toLowerCase())) best = phrase;
      }
    }
    if (best != null) found.add(best);
    start = end;
  }
  final unique = <String, String>{};
  for (final term in found) {
    final t = term.trim();
    if (t.length >= 4) unique.putIfAbsent(t.toLowerCase(), () => t);
  }
  final keys = unique.keys.toList();
  return [
    for (final k in keys)
      if (!keys.any((other) => other != k && other.contains(k))) unique[k]!,
  ].take(limit).toList();
}

/// Looks through the mail on this phone for conversations that may belong
/// to [matter], without asking any server or model: those mentioning its
/// words ([matterTerms]), then those from someone who writes in it, then
/// those from their domain. Members, conversations the user said don't
/// belong, Trash and Junk are left out, and so are newsletters and list
/// mail found by sender alone. A shared sender or domain is a weak reason
/// and ranks below any mention. At most [limit], the best first.
Future<List<MatterCandidate>> findMatterCandidates({
  required MailRepository repository,
  required Matter matter,
  required List<EmailSummary> messages,
  required Set<String> ownAddresses,
  required Map<String, Mailbox> mailboxes,
  int limit = 8,
}) async {
  Future<List<EmailSummary>> search(SearchExpr expr) async {
    try {
      return (await repository
              .search(SearchRequest(expr: expr, scope: const AllMailboxesScope(), includeServer: false, limit: 40))
              .first)
          .items;
    } on Object {
      return const [];
    }
  }

  final senders = <String, EmailAddress>{};
  final count = <String, int>{};
  for (final m in messages) {
    final s = m.sender;
    if (s == null || ownAddresses.contains(s.email.toLowerCase())) continue;
    final address = s.email.toLowerCase();
    senders.putIfAbsent(address, () => s);
    count[address] = (count[address] ?? 0) + 1;
  }
  final topSenders = senders.keys.toList()..sort((a, b) => count[b]!.compareTo(count[a]!));
  final ownDomains = {for (final a in ownAddresses) _domainOf(a)};
  final domains = <String>{
    for (final s in topSenders)
      if (_domainOf(s) case final d when d.isNotEmpty && !_sharedDomains.contains(d) && !ownDomains.contains(d)) d,
  };

  final best = <ConversationKey, MatterCandidate>{};
  void consider(EmailSummary e, MatterReason reason, int score) {
    final box = mailboxes[e.mailboxId];
    if (box != null && (box.role == MailboxRole.trash || box.role == MailboxRole.junk)) return;
    if (matter.includes(e) || matter.excludes(e)) return;
    if (reason.isWeak && (e.listId != null || e.listUnsubscribe != null)) return;
    final key = conversationOf(e);
    final previous = best[key];
    if (previous == null) {
      best[key] = MatterCandidate(email: e, reason: reason, score: score);
      return;
    }
    final strongest = _strength(reason) > _strength(previous.reason) ? reason : previous.reason;
    final newest = e.receivedAt.isAfter(previous.email.receivedAt) ? e : previous.email;
    // Another term or sender adds to it; the same one found twice doesn't.
    final added = previous.reason == reason ? 0 : score;
    best[key] = MatterCandidate(email: newest, reason: strongest, score: previous.score + added);
  }

  for (final term in matterTerms(matter, messages)) {
    for (final e in await search(TextTerm(SearchField.any, term))) {
      consider(e, MatterReason(MatterReasonKind.mentions, term), 10);
    }
  }
  for (final address in topSenders.take(4)) {
    for (final e in await search(TextTerm(SearchField.from, address))) {
      if (e.sender?.email.toLowerCase() == address) {
        consider(e, MatterReason(MatterReasonKind.sameSender, senders[address]!.displayName), 3);
      }
    }
  }
  for (final domain in domains.take(4)) {
    for (final e in await search(TextTerm(SearchField.from, domain))) {
      final d = _domainOf(e.sender?.email ?? '');
      if (d == domain || d.endsWith('.$domain')) consider(e, MatterReason(MatterReasonKind.sameDomain, domain), 2);
    }
  }
  final out = best.values.toList()
    ..sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      return byScore != 0 ? byScore : b.email.receivedAt.compareTo(a.email.receivedAt);
    });
  return out.take(limit).toList();
}

int _strength(MatterReason r) => switch (r.kind) {
  MatterReasonKind.mentions => 2,
  MatterReasonKind.sameSender => 1,
  MatterReasonKind.sameDomain => 0,
};

String _domainOf(String address) {
  final at = address.lastIndexOf('@');
  return at < 0 ? '' : address.substring(at + 1).toLowerCase();
}

/// The suggestions for matter [matterId], found again whenever the matter
/// or its mail changes.
final matterCandidatesProvider = FutureProvider.autoDispose.family<List<MatterCandidate>, String>((ref, id) async {
  final matter = ref.watch(matterProvider(id)).value;
  if (matter == null) return const [];
  final messages = await ref.watch(matterMessagesProvider(id).future);
  final accounts = await ref.watch(accountsProvider.future);
  final mailboxes = await ref.watch(mailboxesProvider.future);
  return findMatterCandidates(
    repository: ref.watch(repositoryProvider),
    matter: matter,
    messages: messages,
    ownAddresses: ownAddresses(accounts),
    mailboxes: {for (final m in mailboxes) m.id: m},
  );
});
