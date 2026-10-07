import 'dart:convert';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'smime_support.dart';
import 'writer_test.dart' show Keys, aliceId, aliceState, readAs, sign, signEncrypt, toBob;

const _ics =
    'BEGIN:VCALENDAR\r\nVERSION:2.0\r\nMETHOD:REPLY\r\nBEGIN:VEVENT\r\n'
    'ATTENDEE;PARTSTAT=DECLINED:mailto:alice@example.org\r\nORGANIZER:mailto:bob@example.net\r\n'
    'UID:numbers@example.net\r\nSEQUENCE:1\r\nDTSTAMP:20261004T120000Z\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n';

void main() {
  test('an invitation reply keeps its text/calendar alternative when S/MIME signs or encrypts it', () {
    final composer = SmimeMessageComposer(
      MimeMessageComposer(),
      Keys(aliceState(), {alice.certificate.fingerprint: alice.key}),
      backend: smime,
      clock: () => today,
    );
    for (final security in [sign, signEncrypt]) {
      final raw = composer.compose(
        const OutgoingMessage(
          accountId: 'a',
          identityId: 'a',
          to: toBob,
          subject: 'Declined: Quarterly numbers',
          text: 'Alice Example has declined: Quarterly numbers',
          calendar: OutgoingCalendar(method: 'REPLY', data: _ics),
        ).copyWith(security: security),
        aliceId,
        messageId: 'smime-calendar@example.org',
        date: today,
      );
      final r = readAs(raw, bob);
      expect(r.status.signature?.good, isTrue, reason: '$security');
      expect(r.entity!.mimeType, 'multipart/alternative');
      expect(r.entity!.parts.last.contentType['method'], 'REPLY');
      final content = contentFromEntity(r.entity!, emailId: 'x');
      expect(content.text, contains('has declined'));
      final calendar = content.attachments.single;
      expect(calendar.mimeType, 'text/calendar');
      expect(utf8.decode(partOf(r.entity!, calendar.partId)!.decodedBody).trimRight(), _ics.trimRight());
    }
  });
}
