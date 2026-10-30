import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  final received = DateTime.utc(2026, 10, 24, 15, 10);
  EmailSummary email(
    String id, {
    String account = 'personal',
    String? messageId = 'a1@harbour.example',
    String subject = 'Your application',
    DateTime? at,
  }) => EmailSummary(
    id: id,
    accountId: account,
    mailboxId: 'm',
    receivedAt: at ?? received,
    messageIdHeader: messageId,
    subject: subject,
    threadId: 't',
  );

  test('finds a moved message by its Message-ID, guarded by subject and date', () {
    final ref = MessageRef.of(email('personal/INBOX/1'));
    expect(ref.matches(email('personal/Archive/7')), isTrue);
    expect(ref.matches(email('work/INBOX/1', account: 'work')), isFalse);
    expect(ref.matches(email('personal/Archive/8', subject: 'Something else')), isFalse);
    expect(ref.matches(email('personal/Archive/9', at: received.add(const Duration(days: 30)))), isFalse);
    expect(ref.seenAs(email('personal/Archive/7')).emailId, 'personal/Archive/7');
  });

  test('without a Message-ID only the local id matches', () {
    final ref = MessageRef.of(email('personal/INBOX/1', messageId: null));
    expect(ref.matches(email('personal/INBOX/1', messageId: null)), isTrue);
    expect(ref.matches(email('personal/Archive/7', messageId: null)), isFalse);
  });

  test('round-trips through JSON', () {
    final ref = MessageRef.of(email('personal/INBOX/1'));
    final back = MessageRef.fromJson(ref.toJson());
    expect(back, ref);
    expect(back.subject, 'Your application');
    expect(back.receivedAt, received);
    expect(back.threadId, 't');
  });
}
