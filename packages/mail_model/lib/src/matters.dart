// Matters: conversations the user groups because they are about one thing
// (buying a house: the adviser, the solicitor, the lender and the removal
// firm), whoever sent them and wherever they are filed. See
// docs/plan/PLAN-combined.md §8.

import 'email.dart';
import 'message_ref.dart';

/// A conversation: its account and thread id.
typedef ConversationKey = ({String accountId, String threadId});

/// The conversation [email] belongs to.
ConversationKey conversationOf(EmailSummary email) =>
    (accountId: email.accountId, threadId: email.threadId ?? email.id);

/// How a conversation came into a matter.
enum MatterSource {
  /// The user added it.
  manual,

  /// The user accepted a suggestion; [MatterMember.reason] says which.
  suggested,
}

/// Why a conversation was suggested for a matter.
enum MatterReasonKind {
  /// It mentions the matter's own words or references ("14 Quay Street", "QS-4471").
  mentions,

  /// Someone who writes in the matter sent it.
  sameSender,

  /// It comes from the domain of someone who writes in the matter.
  sameDomain,
}

/// What a suggestion rests on. Only a mention is evidence: one adviser or one
/// firm can handle several matters, so a shared sender or domain alone is a
/// weak hint and is shown as one ([isWeak]).
final class MatterReason {
  const MatterReason(this.kind, this.value);

  factory MatterReason.fromJson(Map<String, Object?> json) => MatterReason(
    MatterReasonKind.values.asNameMap()[json['kind']] ?? MatterReasonKind.mentions,
    (json['value'] as String?) ?? '',
  );

  final MatterReasonKind kind;

  /// The words mentioned, the sender's address or the domain.
  final String value;

  bool get isWeak => kind != MatterReasonKind.mentions;

  Map<String, Object?> toJson() => {'kind': kind.name, 'value': value};

  @override
  bool operator ==(Object other) => other is MatterReason && other.kind == kind && other.value == value;

  @override
  int get hashCode => Object.hash(kind, value);

  @override
  String toString() => 'MatterReason(${kind.name}: $value)';
}

/// One conversation of a matter, by account and thread id. [ref] is one of
/// its messages: when the thread id changes (a late reply joins two threads)
/// or the messages move, the conversation is found again through it.
final class MatterMember {
  const MatterMember({
    required this.accountId,
    required this.threadId,
    required this.ref,
    required this.addedAt,
    this.source = MatterSource.manual,
    this.reason,
  });

  /// The conversation of [email]; [reason] when it came from a suggestion.
  factory MatterMember.of(EmailSummary email, {required DateTime at, MatterReason? reason}) => MatterMember(
    accountId: email.accountId,
    threadId: email.threadId ?? email.id,
    ref: MessageRef.of(email),
    addedAt: at,
    source: reason == null ? MatterSource.manual : MatterSource.suggested,
    reason: reason,
  );

  final String accountId;
  final String threadId;
  final MessageRef ref;
  final DateTime addedAt;
  final MatterSource source;
  final MatterReason? reason;

  ConversationKey get key => (accountId: accountId, threadId: threadId);

  /// Whether [email] is part of this conversation: in its thread, or the
  /// message [ref] refers to wherever it is now.
  bool includes(EmailSummary email) =>
      email.accountId == accountId && ((email.threadId ?? email.id) == threadId || ref.matches(email));

  /// The same conversation, last seen as [email]: its thread id may have
  /// changed.
  MatterMember seenAs(EmailSummary email) => MatterMember(
    accountId: accountId,
    threadId: email.threadId ?? threadId,
    ref: ref.seenAs(email),
    addedAt: addedAt,
    source: source,
    reason: reason,
  );
}

/// A conversation the user said is not part of a matter: a suggestion they
/// turned down, or a member they removed ([removed]). Suggestions leave it
/// out from then on; adding it by hand lifts it.
final class MatterExclusion {
  const MatterExclusion({
    required this.accountId,
    required this.threadId,
    required this.at,
    this.ref,
    this.removed = false,
  });

  final String accountId;
  final String threadId;
  final DateTime at;
  final MessageRef? ref;
  final bool removed;

  ConversationKey get key => (accountId: accountId, threadId: threadId);

  /// Whether [email] is part of the excluded conversation.
  bool includes(EmailSummary email) =>
      email.accountId == accountId && ((email.threadId ?? email.id) == threadId || (ref?.matches(email) ?? false));
}

enum MatterEventKind {
  created,
  renamed,
  added,
  removed,

  /// Another matter's conversations came in, and that matter was deleted.
  merged,

  /// Conversations went to a new matter.
  splitOff,

  /// The matter was made from another one's conversations.
  splitFrom,
}

/// One entry of a matter's history: what the user changed, and when.
final class MatterEvent {
  const MatterEvent(this.kind, this.at, {this.text = '', this.count = 0, this.accountId, this.source});

  final MatterEventKind kind;
  final DateTime at;

  /// renamed: the new name. added and removed: the conversation's subject.
  /// merged: the name of the matter merged in. splitOff and splitFrom: the
  /// other matter's name.
  final String text;

  /// merged, splitOff and splitFrom: how many conversations moved.
  final int count;

  /// added and removed: the conversation's account. The entry names its
  /// mail, so it goes when the account does.
  final String? accountId;

  /// added: how the conversation came in.
  final MatterSource? source;
}

/// A matter: a name, the conversations in it, the corrections the user made
/// and its history. It is a record kept on this device, apart from the mail.
/// Every edit returns a new value; [MatterRecords] only stores them, so
/// the demo and the live repository behave alike.
final class Matter {
  const Matter({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.members = const [],
    this.exclusions = const [],
    this.history = const [],
  });

  /// A new, empty matter.
  factory Matter.create({required String id, required String name, required DateTime at}) =>
      Matter(id: id, name: name, createdAt: at, updatedAt: at, history: [MatterEvent(MatterEventKind.created, at)]);

  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// In the order they were added.
  final List<MatterMember> members;
  final List<MatterExclusion> exclusions;

  /// Oldest first.
  final List<MatterEvent> history;

  Set<ConversationKey> get conversations => {for (final m in members) m.key};

  MatterMember? memberOf(ConversationKey conversation) => members.where((m) => m.key == conversation).firstOrNull;

  /// Whether [email]'s conversation is in this matter.
  bool includes(EmailSummary email) => members.any((m) => m.includes(email));

  /// Whether the user said [email]'s conversation doesn't belong here.
  bool excludes(EmailSummary email) => exclusions.any((x) => x.includes(email)) && !includes(email);

  Matter _copy({
    String? name,
    DateTime? updatedAt,
    List<MatterMember>? members,
    List<MatterExclusion>? exclusions,
    List<MatterEvent>? history,
  }) => Matter(
    id: id,
    name: name ?? this.name,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    members: members ?? this.members,
    exclusions: exclusions ?? this.exclusions,
    history: history ?? this.history,
  );

  Matter renamed(String name, {required DateTime at}) {
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed == this.name) return this;
    return _copy(
      name: trimmed,
      updatedAt: at,
      history: [
        ...history,
        MatterEvent(MatterEventKind.renamed, at, text: trimmed),
      ],
    );
  }

  /// With [member]'s conversation, whose subject is [subject]. It lifts an
  /// exclusion of it; a conversation already in the matter stays as it was.
  Matter adding(MatterMember member, {String subject = ''}) {
    if (memberOf(member.key) != null) return this;
    return _copy(
      updatedAt: member.addedAt,
      members: [...members, member],
      exclusions: [
        for (final x in exclusions)
          if (x.key != member.key) x,
      ],
      history: [
        ...history,
        MatterEvent(
          MatterEventKind.added,
          member.addedAt,
          text: subject,
          accountId: member.accountId,
          source: member.source,
        ),
      ],
    );
  }

  /// Without [conversation]. The removal is remembered, so it isn't
  /// suggested again.
  Matter removing(ConversationKey conversation, {required DateTime at, String subject = ''}) {
    final member = memberOf(conversation);
    if (member == null) return this;
    return _copy(
      updatedAt: at,
      members: [
        for (final m in members)
          if (m.key != conversation) m,
      ],
      exclusions: [
        for (final x in exclusions)
          if (x.key != conversation) x,
        MatterExclusion(
          accountId: conversation.accountId,
          threadId: conversation.threadId,
          at: at,
          ref: member.ref,
          removed: true,
        ),
      ],
      history: [
        ...history,
        MatterEvent(MatterEventKind.removed, at, text: subject, accountId: conversation.accountId),
      ],
    );
  }

  /// Remembers that [exclusion]'s conversation doesn't belong here (Not This
  /// One on a suggestion).
  Matter declining(MatterExclusion exclusion) {
    if (memberOf(exclusion.key) != null) return this;
    return _copy(
      updatedAt: exclusion.at,
      exclusions: [
        for (final x in exclusions)
          if (x.key != exclusion.key) x,
        exclusion,
      ],
    );
  }

  /// With [member], last seen as [email] (its thread id changed). Not an
  /// edit: the history and [updatedAt] stay. When the conversation it is in
  /// now is a member already, the two are one.
  Matter relocating(MatterMember member, EmailSummary email) {
    final moved = member.seenAs(email);
    if (moved.key == member.key && moved.ref.emailId == member.ref.emailId) return this;
    final duplicate = moved.key != member.key && memberOf(moved.key) != null;
    return _copy(
      members: [
        for (final m in members)
          if (m.key != member.key) m else if (!duplicate) moved,
      ],
    );
  }

  /// With [other]'s conversations too: what [other] had and this didn't
  /// comes after this one's own. A conversation either one has wins over the
  /// other's exclusion of it. [other] is deleted by the caller.
  Matter merging(Matter other, {required DateTime at}) {
    final mine = conversations;
    final added = [
      for (final m in other.members)
        if (!mine.contains(m.key)) m,
    ];
    final all = {...mine, for (final m in added) m.key};
    final excluded = <ConversationKey, MatterExclusion>{
      for (final x in [...exclusions, ...other.exclusions])
        if (!all.contains(x.key)) x.key: x,
    };
    return _copy(
      updatedAt: at,
      members: [...members, ...added],
      exclusions: excluded.values.toList(),
      history: [
        ...history,
        MatterEvent(MatterEventKind.merged, at, text: other.name, count: added.length),
      ],
    );
  }

  /// Moves [moving] to a new matter [name] (id [id]). Returns this matter
  /// without them, where they are now remembered as removed (so they aren't
  /// suggested back), and the new matter.
  ({Matter rest, Matter split}) splitting(
    Set<ConversationKey> moving, {
    required String id,
    required String name,
    required DateTime at,
  }) {
    final leaving = [
      for (final m in members)
        if (moving.contains(m.key)) m,
    ];
    final rest = _copy(
      updatedAt: at,
      members: [
        for (final m in members)
          if (!moving.contains(m.key)) m,
      ],
      exclusions: [
        for (final x in exclusions)
          if (!moving.contains(x.key)) x,
        for (final m in leaving)
          MatterExclusion(accountId: m.accountId, threadId: m.threadId, at: at, ref: m.ref, removed: true),
      ],
      history: [
        ...history,
        MatterEvent(MatterEventKind.splitOff, at, text: name.trim(), count: leaving.length),
      ],
    );
    final split = Matter(
      id: id,
      name: name.trim(),
      createdAt: at,
      updatedAt: at,
      members: leaving,
      history: [
        MatterEvent(MatterEventKind.created, at),
        MatterEvent(MatterEventKind.splitFrom, at, text: this.name, count: leaving.length),
      ],
    );
    return (rest: rest, split: split);
  }
}

/// Matters, kept on this device only and apart from the mail: filing or
/// moving a message doesn't take it out of its matter, and deleting a matter
/// leaves the mail alone. Removing an account takes its conversations (and
/// the history entries naming them) out of every matter. Implemented by
/// repositories that can (`repository is MatterRecords`). All `watch*`
/// streams emit the current value at once and again whenever it changes.
///
/// The repository stores records; what an edit means (a removal remembered
/// as a correction, merging, splitting) is [Matter]'s.
abstract interface class MatterRecords {
  /// Every matter, the oldest first.
  Stream<List<Matter>> watchMatters();

  /// Saves [save] (replacing the matters with their ids) and deletes the
  /// matters [delete], in one go. Members and history entries of accounts
  /// that no longer exist are dropped.
  Future<void> writeMatters({List<Matter> save = const [], List<String> delete = const []});

  /// Every stored message of matter [matterId]'s conversations, oldest
  /// first: one copy of each (the Inbox's, else another folder's), none in
  /// Trash or Junk.
  Stream<List<EmailSummary>> watchMatterMessages(String matterId);

  /// When the newest message of each matter's conversations arrived (outside
  /// Trash and Junk), by matter id. Matters without one are left out.
  Stream<Map<String, DateTime>> watchMatterActivity();

  /// The message [ref] refers to, wherever it is now (see
  /// [MessageRef.matches]; a copy outside Trash and Junk first), or null
  /// when it isn't stored.
  Future<EmailSummary?> locateMessage(MessageRef ref);
}
