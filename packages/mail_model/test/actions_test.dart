import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  final at = DateTime.utc(2026, 10, 24, 15, 10);
  final later = at.add(const Duration(hours: 2));
  const source = MessageRef(
    accountId: 'personal',
    emailId: 'personal/INBOX/1',
    messageIdHeader: 'a1@harbour.example',
    threadId: 't',
    subject: 'Your mortgage application',
  );
  const statement = ActionSuggestion(
    owner: ActionOwner.me,
    kind: ActionKind.document,
    text: 'A full month’s bank statement',
    quote: 'A full month’s bank statement showing your day-to-day spending.',
    channel: 'by email',
  );
  ActionRecord record() => ActionRecord.suggested(
    id: 'a1',
    source: source,
    suggestion: statement,
    origin: const ActionOrigin.suggested(providerId: 'demo', model: 'demo', runHash: 'h1'),
    at: at,
  );

  test('the folder follows owner and state', () {
    expect(ActionRecord.folderOf(ActionOwner.me, ActionState.needsAction), VirtualMailbox.needsMyAction);
    expect(ActionRecord.folderOf(ActionOwner.me, ActionState.inProgress), VirtualMailbox.needsMyAction);
    expect(ActionRecord.folderOf(ActionOwner.them, ActionState.needsAction), VirtualMailbox.waitingOnOthers);
    expect(
      ActionRecord.folderOf(ActionOwner.me, ActionState.waitingForAcknowledgement),
      VirtualMailbox.waitingOnOthers,
    );
    for (final settled in [
      ActionState.sent,
      ActionState.acknowledged,
      ActionState.done,
      ActionState.dismissed,
      ActionState.superseded,
    ]) {
      expect(ActionRecord.folderOf(ActionOwner.me, settled), isNull, reason: settled.name);
      expect(ActionRecord.folderOf(ActionOwner.them, settled), isNull, reason: settled.name);
    }
    expect(record().withDeleted(true, later).folder, isNull);
  });

  test('a state change is the user’s, with its history', () {
    final sent = record().withState(ActionState.sent, later);
    expect(sent.state, ActionState.sent);
    expect(sent.overridden, {ActionField.state});
    expect(sent.history.map((e) => e.change), [ActionChange.created, ActionChange.state]);
    expect(sent.history.last.state, ActionState.sent);
    expect(sent.updatedAt, later);
    expect(identical(sent.withState(ActionState.sent, later), sent), isTrue);
  });

  test('a new suggestion for the same passage keeps the user’s corrections and never reopens', () {
    final edited = record().withText('September bank statement', later).withState(ActionState.done, later);
    const next = ActionSuggestion(
      owner: ActionOwner.me,
      kind: ActionKind.document,
      text: 'One month of bank statements',
      quote: 'A full month’s bank statement showing your day-to-day spending.',
      channel: 'by email or upload',
    );
    expect(edited.wouldRevise(next), isTrue);
    final revised = edited.revisedBy(
      next,
      const ActionOrigin.suggested(providerId: 'cloud', model: 'm2', runHash: 'h2'),
      later,
    );
    expect(revised.currentRequest, 'September bank statement');
    expect(revised.originalRequest, 'A full month’s bank statement');
    expect(revised.state, ActionState.done);
    expect(revised.channel, 'by email or upload');
    expect(revised.suggestion, next);
    expect(revised.history.last.change, ActionChange.revised);

    // The same suggestion again changes nothing.
    final fresh = record();
    expect(fresh.wouldRevise(statement), isFalse);
    expect(identical(fresh.revisedBy(statement, fresh.origin, later), fresh), isTrue);
  });

  test('passages compare without case, spacing or the kind of quotation marks', () {
    final r = record();
    expect(r.comesFrom(source, 'a full month\'s  bank statement showing your day-to-day spending.'), isTrue);
    expect(r.comesFrom(source, 'Your SA302 tax calculation for 2024/25.'), isFalse);
    const moved = MessageRef(
      accountId: 'personal',
      emailId: 'personal/Archive/9',
      messageIdHeader: 'a1@harbour.example',
    );
    expect(r.comesFrom(moved, statement.quote), isTrue);
    expect(r.comesFrom(source, ''), isFalse);
  });

  test('round-trips through JSON', () {
    final r = record()
        .withText('September bank statement', later)
        .withReminder(DateTime.utc(2026, 10, 27, 8), later)
        .withDue(ActionDue(kind: ActionDueKind.explicit, text: 'by 5 November', date: DateTime(2026, 11, 5)), later);
    final back = ActionRecord.fromJson(r.toJson());
    expect(back, r);
    expect(back.toJson(), r.toJson());
    expect(back.due.date, DateTime(2026, 11, 5));
    expect(back.origin.model, 'demo');
    expect(back.overridden, {ActionField.text, ActionField.reminder, ActionField.due});

    final manual = ActionRecord(
      id: 'm1',
      owner: ActionOwner.them,
      kind: ActionKind.followUp,
      source: source,
      originalRequest: 'Reply about the overview',
      currentRequest: 'Reply about the overview',
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );
    expect(ActionRecord.fromJson(manual.toJson()), manual);
    expect(ActionRecord.fromJson(manual.toJson()).origin.isSuggested, isFalse);
  });
}
