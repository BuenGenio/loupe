import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  test('OutgoingSecurity: JSON, drafts, equality', () {
    const s = OutgoingSecurity(encrypt: true, sign: true);
    expect(OutgoingSecurity.fromJson(s.toJson()), s);
    expect(OutgoingSecurity.fromJson(null), OutgoingSecurity.none);
    expect(OutgoingSecurity.none.isPlain, isTrue);
    expect(OutgoingSecurity.none.toJson(), isEmpty);
    final draft = s.forDraft();
    expect((draft.encrypt, draft.sign, draft.draft), (true, true, true));
    expect(OutgoingSecurity.fromJson(draft.toJson()), draft);
  });

  test('OutgoingMessage keeps its security through copyWith and withoutDraft', () {
    const m = OutgoingMessage(
      accountId: 'a',
      identityId: 'a/me',
      draftId: 'd',
      security: OutgoingSecurity(encrypt: true),
    );
    expect(m.copyWith(subject: 'x').security.encrypt, isTrue);
    expect(m.withoutDraft().security.encrypt, isTrue);
    expect(m.copyWith(security: OutgoingSecurity.none).security.isPlain, isTrue);
    expect(const OutgoingMessage(accountId: 'a', identityId: 'a/me').security, OutgoingSecurity.none);
  });
}
