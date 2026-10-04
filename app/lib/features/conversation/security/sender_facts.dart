// What the repository knows about a message's sender, for the phishing
// check: the address book's history, the user's own addresses, and known
// people whose name the sender uses with another address. Pure Dart.

import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart' show latinSkeleton;

import 'assessment.dart';

/// Gathers [SenderFacts] for [message]. Lookups that fail are left out
/// rather than failing the check.
Future<SenderFacts> gatherSenderFacts(MailRepository repo, EmailSummary message) async {
  final sender = message.sender;
  final accounts = await _orEmpty(repo.watchAccounts().first, const <MailAccount>[]);
  final ownAddresses = {
    for (final a in accounts) ...[a.email.toLowerCase(), for (final i in a.identities) i.email.toLowerCase()],
  };
  final ownDomains = {for (final e in ownAddresses) e.substring(e.lastIndexOf('@') + 1)};
  if (sender == null) return SenderFacts(ownAddresses: ownAddresses, ownDomains: ownDomains);

  final email = sender.email.toLowerCase();
  final vips = await _orEmpty(repo.watchVipAddresses().first, const <String>{});
  SenderHistory? history;
  try {
    history = await repo.senderHistory(email);
  } on Object {
    history = null;
  }

  final namesakes = <Namesake>[];
  final name = normalizeName(sender.name ?? '');
  if (isDistinctiveName(name) && !ownAddresses.contains(email)) {
    final mine = [
      for (final a in accounts)
        for (final i in a.identities)
          if (normalizeName(i.name ?? '') == name) EmailAddress(i.email, i.name),
    ];
    if (mine.isNotEmpty) namesakes.add(Namesake(mine.first, you: true));
    final queries = {sender.name!.trim(), name};
    final seen = <String>{email};
    for (final q in queries) {
      final candidates = await _orEmpty(repo.suggestAddresses(q, limit: 8), const <EmailAddress>[]);
      for (final c in candidates) {
        final e = c.email.toLowerCase();
        if (!seen.add(e) || ownAddresses.contains(e) || normalizeName(c.name ?? '') != name) continue;
        final vip = vips.contains(e);
        final known = vip || (await _orEmpty(repo.senderHistory(e), SenderHistory.none)).isKnown;
        if (known) namesakes.add(Namesake(c, vip: vip));
      }
    }
  }
  return SenderFacts(
    history: history,
    namesakes: namesakes,
    ownAddresses: ownAddresses,
    ownDomains: ownDomains,
    senderIsVip: vips.contains(email),
  );
}

Future<T> _orEmpty<T>(Future<T> future, T fallback) async {
  try {
    return await future;
  } on Object {
    return fallback;
  }
}

/// A display name folded for comparison: lower-case, look-alike letters
/// mapped to Latin, quotes and punctuation dropped, spaces collapsed.
String normalizeName(String name) =>
    latinSkeleton(name).replaceAll(RegExp(r'''["'“”‘’`()\[\],.]'''), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();

/// Names too generic to impersonate anyone ("Support", "Team").
const _genericNames = {
  'support',
  'customer service',
  'customer support',
  'service',
  'team',
  'info',
  'admin',
  'administrator',
  'no-reply',
  'noreply',
  'notifications',
  'notification',
  'help desk',
  'helpdesk',
  'billing',
  'security',
  'it',
  'hr',
  'mailer-daemon',
};

/// A name specific enough that someone else using it is worth noticing.
bool isDistinctiveName(String normalized) {
  if (normalized.isEmpty || _genericNames.contains(normalized) || normalized.contains('@')) return false;
  return normalized.contains(' ') ? normalized.length >= 5 : normalized.length >= 6;
}
