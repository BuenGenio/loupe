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

  test('OutgoingMessage keeps its calendar part through copyWith, withoutDraft and deliveries', () {
    const calendar = OutgoingCalendar(method: 'REPLY', data: 'BEGIN:VCALENDAR\r\nEND:VCALENDAR\r\n');
    const m = OutgoingMessage(
      accountId: 'a',
      identityId: 'a/me',
      draftId: 'd',
      to: [EmailAddress('organizer@example.com')],
      bcc: [EmailAddress('me@example.com')],
      calendar: calendar,
      security: OutgoingSecurity(encrypt: true, sign: true),
    );
    expect(m.copyWith(security: OutgoingSecurity.none).calendar, calendar);
    expect(m.withoutDraft().calendar, calendar);
    expect(m.deliveries(sender: 'me@example.com').map((d) => d.message.calendar), everyElement(calendar));
    expect(OutgoingCalendar.fromJson(calendar.toJson()), calendar);
    expect(OutgoingCalendar.fromJson({'method': 'REPLY'}), isNull);
    expect(OutgoingCalendar.fromJson(null), isNull);
    expect(const OutgoingMessage(accountId: 'a', identityId: 'a/me').calendar, isNull);
  });

  group('deliveries', () {
    const me = 'me@example.org';
    const to = EmailAddress('to@example.org');
    const cc = EmailAddress('cc@example.org');
    const bcc1 = EmailAddress('Bcc1@example.org', 'One');
    const bcc2 = EmailAddress('bcc2@example.org');
    OutgoingMessage message(OutgoingSecurity security, {List<EmailAddress> bcc = const [bcc1, bcc2]}) =>
        OutgoingMessage(
          accountId: 'a',
          identityId: 'a/me',
          to: const [to],
          cc: const [cc],
          bcc: bcc,
          security: security,
        );

    /// Each delivery as "envelope | encrypted to | main or Bcc copy | filed".
    List<String> describe(List<OutgoingDelivery> list) => [
      for (final d in list)
        '${d.recipients.join(',')} | ${d.message.encryptionRecipients.map((a) => a.email).join(',')} | '
            '${d.message.bccCopy ? 'copy' : 'main'} | ${d.filed ? 'filed' : '-'}',
    ];

    test('plain, signed or a draft: one message to everyone, filed', () {
      for (final security in [
        OutgoingSecurity.none,
        const OutgoingSecurity(sign: true),
        const OutgoingSecurity(encrypt: true, sign: true).forDraft(),
      ]) {
        final list = message(security).deliveries(sender: me);
        expect(list, hasLength(1));
        expect(list.single.recipients, [to.email, cc.email, bcc1.email, bcc2.email]);
        expect(list.single.filed, isTrue);
        expect((list.single.message.bcc, list.single.message.bccCopy), (const [bcc1, bcc2], false));
      }
    });

    test('encrypted with Bcc: To and Cc get one copy; each Bcc recipient their own, encrypted to them alone', () {
      const security = OutgoingSecurity(encrypt: true, sign: true);
      final list = message(security).deliveries(sender: me);
      expect(describe(list), [
        'to@example.org,cc@example.org | to@example.org,cc@example.org | main | filed',
        'Bcc1@example.org | Bcc1@example.org | copy | -',
        'bcc2@example.org | bcc2@example.org | copy | -',
      ]);
      for (final d in list) {
        expect((d.message.to, d.message.cc), (const [to], const [cc]), reason: 'every copy shows To and Cc');
        expect(d.message.security, security);
      }
      expect(list.first.message.bcc, isEmpty);
    });

    test('a Bcc recipient also in To or Cc, or the sender, goes with the To and Cc copy', () {
      final list = message(
        const OutgoingSecurity(encrypt: true),
        bcc: const [EmailAddress('CC@example.org'), EmailAddress('ME@example.org'), bcc1, bcc1],
      ).deliveries(sender: me);
      expect(describe(list), [
        'to@example.org,cc@example.org,ME@example.org | to@example.org,cc@example.org | main | filed',
        'Bcc1@example.org | Bcc1@example.org | copy | -',
      ]);
    });

    test('only Bcc recipients: the first copy is only filed', () {
      const m = OutgoingMessage(
        accountId: 'a',
        identityId: 'a/me',
        bcc: [bcc1],
        security: OutgoingSecurity(encrypt: true),
      );
      expect(describe(m.deliveries(sender: me)), [
        ' |  | main | filed',
        'Bcc1@example.org | Bcc1@example.org | copy | -',
      ]);
    });

    test('a Bcc copy stays one through copyWith and withoutDraft', () {
      final copy = message(const OutgoingSecurity(encrypt: true)).copyWith(bcc: const [bcc1], bccCopy: true);
      expect(copy.copyWith(subject: 'x').bccCopy, isTrue);
      expect(copy.withoutDraft().bccCopy, isTrue);
      expect(copy.encryptionRecipients, const [bcc1]);
    });
  });
}
