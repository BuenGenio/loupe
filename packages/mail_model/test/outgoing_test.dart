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

  test('OutgoingSecurity: OpenPGP unless S/MIME is asked for, kept through JSON and drafts', () {
    expect(OutgoingSecurity.none.technology, SecurityTechnology.openPgp);
    const s = OutgoingSecurity(sign: true, technology: SecurityTechnology.smime);
    expect(s.isSmime, isTrue);
    expect(s.toJson(), {'sign': true, 'technology': 'smime'});
    expect(OutgoingSecurity.fromJson(s.toJson()), s);
    expect(s.forDraft().technology, SecurityTechnology.smime);
    expect(s == const OutgoingSecurity(sign: true), isFalse);
    // Unknown technologies (from a newer version) read as OpenPGP.
    expect(OutgoingSecurity.fromJson({'sign': true, 'technology': 'x'}).technology, SecurityTechnology.openPgp);
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
