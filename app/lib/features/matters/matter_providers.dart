import 'dart:math';

import 'package:clock/clock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../actions/action_providers.dart';

/// The repository's matters, if it keeps them.
MatterRecords? matterRecordsOf(MailRepository repository) => switch (repository) {
  final MatterRecords records => records,
  _ => null,
};

/// Every matter, the oldest first; none when the repository keeps no matters.
final mattersProvider = StreamProvider<List<Matter>>((ref) {
  final records = matterRecordsOf(ref.watch(repositoryProvider));
  return records?.watchMatters() ?? Stream.value(const <Matter>[]);
});

/// When each matter last had mail, by matter id.
final matterActivityProvider = StreamProvider<Map<String, DateTime>>((ref) {
  final records = matterRecordsOf(ref.watch(repositoryProvider));
  return records?.watchMatterActivity() ?? Stream.value(const <String, DateTime>{});
});

/// One matter; null once it is gone (deleted, or merged into another).
final matterProvider = Provider.autoDispose.family<AsyncValue<Matter?>, String>(
  (ref, id) => ref.watch(mattersProvider).whenData((all) => all.where((m) => m.id == id).firstOrNull),
);

/// The messages of a matter's conversations, oldest first.
final matterMessagesProvider = StreamProvider.autoDispose.family<List<EmailSummary>, String>((ref, id) {
  final records = matterRecordsOf(ref.watch(repositoryProvider));
  return records?.watchMatterMessages(id) ?? Stream.value(const <EmailSummary>[]);
});

/// The matters [conversation] (any of its messages) is in.
List<Matter> mattersWith(List<Matter> matters, Iterable<EmailSummary> conversation) => [
  for (final m in matters)
    if (conversation.any(m.includes)) m,
];

/// An open request or a wait about a matter's mail, from Needs My Action
/// and Waiting on Others ([matterOpenItemsProvider]).
final class MatterOpenItem {
  const MatterOpenItem({
    required this.text,
    required this.source,
    this.waitingOnOthers = false,
    this.due = ActionDue.none,
  });

  /// The request in a few words, as the action shows it.
  final String text;

  /// The message it comes from (opened on a tap).
  final MessageRef source;

  /// Someone else has to act (Waiting on Others), not the user.
  final bool waitingOnOthers;

  /// When, as the action has it: a date, or the timing as written.
  final ActionDue due;
}

/// The open actions and waits of matter [matterId]'s messages, from Needs My
/// Action and Waiting on Others: every action still in one of the two
/// folders whose message is one of the matter's, wherever it is now.
final matterOpenItemsProvider = Provider.autoDispose.family<List<MatterOpenItem>, String>((ref, matterId) {
  final messages = ref.watch(matterMessagesProvider(matterId)).value ?? const <EmailSummary>[];
  final actions = ref.watch(allActionsProvider).value ?? const <ActionRecord>[];
  return [
    for (final a in actions)
      if (a.folder case final folder? when messages.any(a.source.matches))
        MatterOpenItem(
          text: a.currentRequest,
          source: a.source,
          waitingOnOthers: folder == VirtualMailbox.waitingOnOthers,
          due: a.due,
        ),
  ];
});

/// Edits matters: every change is a [Matter] value written back whole, so
/// what an edit means is mail_model's, the same in the demo and live.
final class MattersController {
  MattersController(this.records, {DateTime Function()? now, Random? random})
    : _now = now ?? (() => clock.now()),
      _random = random ?? Random();

  final MatterRecords records;
  final DateTime Function() _now;
  final Random _random;

  Future<Matter?> _get(String id) async => (await records.watchMatters().first).where((m) => m.id == id).firstOrNull;

  String _newId() =>
      'matter-${_now().microsecondsSinceEpoch.toRadixString(36)}-${_random.nextInt(1 << 30).toRadixString(36)}';

  /// A new matter [name], with the conversations of [emails] in it.
  Future<Matter> create(String name, {List<EmailSummary> emails = const []}) async {
    final at = _now();
    var matter = Matter.create(id: _newId(), name: name.trim(), at: at);
    for (final e in emails) {
      matter = matter.adding(MatterMember.of(e, at: at), subject: e.subject);
    }
    await records.writeMatters(save: [matter]);
    return matter;
  }

  Future<void> rename(String id, String name) => _edit(id, (m) => m.renamed(name, at: _now()));

  /// Deletes the matter; its mail stays where it is.
  Future<void> delete(String id) => records.writeMatters(delete: [id]);

  /// Adds [email]'s conversation; [reason] when it was a suggestion.
  Future<void> add(String id, EmailSummary email, {MatterReason? reason}) => _edit(
    id,
    (m) => m.adding(
      MatterMember.of(email, at: _now(), reason: reason),
      subject: email.subject,
    ),
  );

  /// Takes [conversation] out, remembering it as a correction. Returns the
  /// member it was, for Undo ([restore]).
  Future<MatterMember?> remove(String id, ConversationKey conversation, {String subject = ''}) async {
    final matter = await _get(id);
    final member = matter?.memberOf(conversation);
    if (matter == null || member == null) return null;
    await records.writeMatters(
      save: [matter.removing(conversation, at: _now(), subject: subject)],
    );
    return member;
  }

  /// Puts back a member [remove] took out.
  Future<void> restore(String id, MatterMember member, {String subject = ''}) => _edit(
    id,
    (m) => m.adding(
      MatterMember(
        accountId: member.accountId,
        threadId: member.threadId,
        ref: member.ref,
        addedAt: _now(),
        source: member.source,
        reason: member.reason,
      ),
      subject: subject,
    ),
  );

  /// Not This One: [email]'s conversation isn't suggested for the matter again.
  Future<void> decline(String id, EmailSummary email) {
    final c = conversationOf(email);
    return _edit(
      id,
      (m) => m.declining(
        MatterExclusion(accountId: c.accountId, threadId: c.threadId, at: _now(), ref: MessageRef.of(email)),
      ),
    );
  }

  /// Moves [fromId]'s conversations into [intoId] and deletes [fromId].
  Future<void> merge(String fromId, String intoId) async {
    if (fromId == intoId) return;
    final from = await _get(fromId);
    final into = await _get(intoId);
    if (from == null || into == null) return;
    await records.writeMatters(
      save: [into.merging(from, at: _now())],
      delete: [fromId],
    );
  }

  /// Moves [conversations] to a new matter [name]; returns it.
  Future<Matter?> split(String id, Set<ConversationKey> conversations, String name) async {
    final matter = await _get(id);
    if (matter == null || conversations.isEmpty) return null;
    final (:rest, :split) = matter.splitting(conversations, id: _newId(), name: name, at: _now());
    await records.writeMatters(save: [rest, split]);
    return split;
  }

  /// [member] is in another thread now, last seen as [email].
  Future<void> relocate(String id, MatterMember member, EmailSummary email) =>
      _edit(id, (m) => m.relocating(member, email));

  Future<void> _edit(String id, Matter Function(Matter matter) change) async {
    final matter = await _get(id);
    if (matter == null) return;
    final changed = change(matter);
    if (!identical(changed, matter)) await records.writeMatters(save: [changed]);
  }
}

/// Edits the repository's matters; null when it keeps none.
final mattersControllerProvider = Provider<MattersController?>((ref) {
  final records = matterRecordsOf(ref.watch(repositoryProvider));
  return records == null ? null : MattersController(records);
});
