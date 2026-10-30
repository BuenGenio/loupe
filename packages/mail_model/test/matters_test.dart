import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  final t0 = DateTime.utc(2026, 10, 20, 9);
  DateTime later(int minutes) => t0.add(Duration(minutes: minutes));

  EmailSummary email(String id, String thread, {String account = 'personal', String? messageId, String subject = ''}) =>
      EmailSummary(
        id: id,
        accountId: account,
        mailboxId: 'm',
        receivedAt: t0,
        threadId: thread,
        messageIdHeader: messageId ?? '$id@example.org',
        subject: subject,
      );

  final adviser = email('personal/INBOX/1', 'harbour', subject: 'Your mortgage application');
  final solicitor = email('personal/INBOX/2', 'quay', subject: '14 Quay Street: client care letter');
  final removals = email('personal/INBOX/3', 'removals', subject: 'Invoice INV-2207');

  Matter house() => Matter.create(id: 'm1', name: 'Buying 14 Quay Street', at: t0)
      .adding(MatterMember.of(adviser, at: later(1)), subject: adviser.subject)
      .adding(MatterMember.of(solicitor, at: later(2)), subject: solicitor.subject);

  test('a new matter has a history from the start; adding records who and how', () {
    final m = house();
    expect(m.members.map((x) => x.threadId), ['harbour', 'quay']);
    expect(m.history.map((e) => e.kind), [MatterEventKind.created, MatterEventKind.added, MatterEventKind.added]);
    expect(m.history.last.text, '14 Quay Street: client care letter');
    expect(m.history.last.accountId, 'personal');
    expect(m.updatedAt, later(2));
    expect(identical(m.adding(MatterMember.of(solicitor, at: later(3))), m), isTrue, reason: 'already in it');

    const reason = MatterReason(MatterReasonKind.mentions, '14 Quay Street');
    final suggested = m.adding(MatterMember.of(removals, at: later(4), reason: reason));
    expect(suggested.members.last.source, MatterSource.suggested);
    expect(suggested.members.last.reason, reason);
    expect(suggested.history.last.source, MatterSource.suggested);
    expect(MatterReason.fromJson(reason.toJson()), reason);
    expect(const MatterReason(MatterReasonKind.sameDomain, 'harbour.example').isWeak, isTrue);
    expect(reason.isWeak, isFalse);
  });

  test('a conversation follows its message when the thread id changes', () {
    final m = house();
    final member = m.memberOf(conversationOf(adviser))!;
    final rethreaded = email(
      'personal/Archive/9',
      'merged-thread',
      messageId: adviser.messageIdHeader,
      subject: adviser.subject,
    );
    expect(member.includes(rethreaded), isTrue, reason: 'the reference finds the moved message');
    final moved = m.relocating(member, rethreaded);
    expect(moved.members.first.threadId, 'merged-thread');
    expect(moved.members.first.ref.emailId, 'personal/Archive/9');
    expect(moved.history, hasLength(m.history.length), reason: 'not an edit');
    expect(moved.updatedAt, m.updatedAt);
    // Joined to another member's thread: one conversation, not two.
    final joined = m.relocating(
      member,
      email('personal/INBOX/8', 'quay', messageId: adviser.messageIdHeader, subject: adviser.subject),
    );
    expect(joined.members.map((x) => x.threadId), ['quay']);
  });

  test('removing is remembered as a correction; adding by hand lifts it', () {
    final m = house().removing(conversationOf(adviser), at: later(10), subject: adviser.subject);
    expect(m.members.map((x) => x.threadId), ['quay']);
    expect(m.excludes(adviser), isTrue);
    expect(m.exclusions.single.removed, isTrue);
    expect(m.history.last.kind, MatterEventKind.removed);
    final back = m.adding(MatterMember.of(adviser, at: later(11)));
    expect(back.excludes(adviser), isFalse);
    expect(back.exclusions, isEmpty);

    final declined = house().declining(
      MatterExclusion(accountId: 'personal', threadId: 'removals', at: later(12), ref: MessageRef.of(removals)),
    );
    expect(declined.excludes(removals), isTrue);
    expect(declined.exclusions.single.removed, isFalse);
    expect(declined.history, hasLength(house().history.length), reason: 'a declined suggestion is not an edit');
  });

  test('renaming keeps the identity and trims; an unchanged or empty name changes nothing', () {
    final m = house();
    final renamed = m.renamed('  14 Quay Street  ', at: later(5));
    expect((renamed.id, renamed.name), ('m1', '14 Quay Street'));
    expect(renamed.history.last.text, '14 Quay Street');
    expect(identical(renamed.renamed('14 Quay Street', at: later(6)), renamed), isTrue);
    expect(identical(m.renamed(' ', at: later(6)), m), isTrue);
  });

  test('merging brings the other matter’s conversations; a member wins over an exclusion', () {
    final removalsMatter = Matter.create(id: 'm2', name: 'The move', at: t0)
        .adding(MatterMember.of(removals, at: later(1)))
        .adding(MatterMember.of(solicitor, at: later(2)))
        .declining(MatterExclusion(accountId: 'personal', threadId: 'harbour', at: later(3)));
    final merged = house().merging(removalsMatter, at: later(20));
    expect(merged.id, 'm1');
    expect(merged.members.map((x) => x.threadId), ['harbour', 'quay', 'removals']);
    expect(merged.exclusions, isEmpty);
    expect(merged.history.last.kind, MatterEventKind.merged);
    expect((merged.history.last.text, merged.history.last.count), ('The move', 1));
  });

  test('splitting moves the chosen conversations to a new matter, not to be suggested back', () {
    final m = house().adding(MatterMember.of(removals, at: later(3)));
    final (:rest, :split) = m.splitting({conversationOf(removals)}, id: 'm3', name: 'Removals', at: later(30));
    expect(rest.members.map((x) => x.threadId), ['harbour', 'quay']);
    expect(rest.excludes(removals), isTrue);
    expect(rest.history.last.kind, MatterEventKind.splitOff);
    expect((rest.history.last.text, rest.history.last.count), ('Removals', 1));
    expect((split.id, split.name), ('m3', 'Removals'));
    expect(split.members.single.threadId, 'removals');
    expect(split.history.map((e) => e.kind), [MatterEventKind.created, MatterEventKind.splitFrom]);
    expect(split.history.last.text, 'Buying 14 Quay Street');
  });

  test('another account’s message with the same thread id is another conversation', () {
    final m = house();
    expect(m.includes(email('work/INBOX/1', 'harbour', account: 'work', messageId: 'other@x')), isFalse);
    expect(m.includes(email('personal/Sent/5', 'harbour', messageId: 'reply@x')), isTrue);
  });
}
