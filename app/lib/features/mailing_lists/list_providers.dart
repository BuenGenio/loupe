import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';

/// The repository's mailing-list side, if it has one.
MailingLists? mailingListsOf(MailRepository repository) => switch (repository) {
  final MailingLists lists => lists,
  _ => null,
};

/// Ids of the muted conversations.
final mutedThreadsProvider = StreamProvider<Set<String>>((ref) {
  final lists = mailingListsOf(ref.watch(repositoryProvider));
  return lists?.watchMutedThreads() ?? Stream.value(const <String>{});
});

/// The threads of one list; value-equal so it can key a provider family.
@immutable
final class ListThreadsQuery {
  const ListThreadsQuery(this.listId, {this.includeMuted = false});

  final String listId;
  final bool includeMuted;

  @override
  bool operator ==(Object other) =>
      other is ListThreadsQuery && other.listId == listId && other.includeMuted == includeMuted;

  @override
  int get hashCode => Object.hash(listId, includeMuted);
}

final listThreadsProvider = StreamProvider.autoDispose.family<List<ListThread>, ListThreadsQuery>((ref, query) {
  final lists = mailingListsOf(ref.watch(repositoryProvider));
  return lists?.watchListThreads(query.listId, includeMuted: query.includeMuted) ?? Stream.value(const <ListThread>[]);
});

final _replyPrefix = RegExp(r'^\s*(re|fwd?|aw|wg|sv|vs|antw|tr|r)(\s*\[\d+\])?\s*[:：]\s*', caseSensitive: false);
final _leadingTag = RegExp(r'^\s*\[([^\[\]]*)\]\s*');

/// A thread's title in the list view: its first subject without reply
/// prefixes, the list's own `[tag]` and the `[PATCH …]` tag (the row shows
/// that as a badge). Other tags (`[RFC]`, `[ANN]`) stay. An empty subject
/// is [l10n]'s No Subject.
String listThreadTitle(String subject, {required String listId, required AppLocalizations l10n}) {
  final short = listId.split('.').first.toLowerCase();
  var s = subject;
  for (var guard = 0; guard < 8; guard++) {
    final reply = _replyPrefix.firstMatch(s);
    if (reply != null) {
      s = s.substring(reply.end);
      continue;
    }
    final tag = _leadingTag.firstMatch(s);
    if (tag == null) break;
    final inside = tag[1]!.trim().toLowerCase();
    final isPatch = RegExp(r'\bpatch', caseSensitive: false).hasMatch(inside);
    if (!isPatch && inside != short) break;
    s = s.substring(tag.end);
  }
  s = s.trim();
  return s.isEmpty ? (subject.trim().isEmpty ? l10n.mailNoSubject : subject.trim()) : s;
}

/// Who wrote in a thread, for its row: up to three names, then "+N".
String participantsLine(List<EmailAddress> people) {
  if (people.isEmpty) return '';
  final names = [for (final p in people.take(3)) p.displayName];
  final more = people.length - names.length;
  return more > 0 ? '${names.join(', ')} +$more' : names.join(', ');
}
