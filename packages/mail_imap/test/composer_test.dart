import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:enough_mail/enough_mail.dart' as em;
import 'package:mail_imap/mail_imap.dart';
import 'package:mail_imap/src/compose/mime_composer.dart';
import 'package:mail_imap/src/mime/headers.dart';
import 'package:mail_imap/src/mime/transfer_encoding.dart';
import 'package:mail_imap/src/smtp/smtp_client.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

const identity = Identity(id: 'i1', email: 'jo@example.org', name: 'Jö Schmidt, Jr.', replyTo: 'team@example.org');

Uint8List compose(OutgoingMessage m) =>
    MimeMessageComposer(random: Random(1))
        .compose(m, identity, messageId: '<abc@example.org>', date: DateTime.utc(2025, 10, 6, 8, 30));

em.MimeMessage parseBack(Uint8List bytes) => em.MimeMessage.parseFromData(bytes);

void main() {
  test('plain text message with encoded headers and no Bcc', () {
    final bytes = compose(
      const OutgoingMessage(
        accountId: 'a',
        identityId: 'i1',
        to: [EmailAddress('ann@example.com', 'Ann Ö'), EmailAddress('bob@example.com')],
        cc: [EmailAddress('cy@example.com', 'Cy "The Guy"')],
        bcc: [EmailAddress('secret@example.com', 'Secret')],
        subject: 'Grüße aus Berlin – ein ziemlich langer Betreff, der über mehrere Zeilen gefaltet werden muss',
        text: 'Hallo Ann,\nschöne Grüße.\n.\nFrom here on = fine \n-- \nJo',
        inReplyTo: 'parent@example.com',
        references: ['root@example.com', '<parent@example.com>'],
      ),
    );
    final raw = ascii.decode(bytes);
    expect(raw.split('\r\n').every((l) => l.length <= 998), isTrue);
    expect(raw.contains(RegExp(r'[^\x00-\x7f]')), isFalse);
    expect(raw.toLowerCase(), isNot(contains('bcc')));
    expect(raw, isNot(contains('secret@example.com')));

    final headers = parseHeaderBlock(bytes);
    expect(headerValue(headers, 'Date'), 'Mon, 06 Oct 2025 08:30:00 +0000');
    expect(headerValue(headers, 'Message-ID'), '<abc@example.org>');
    expect(headerValue(headers, 'In-Reply-To'), '<parent@example.com>');
    expect(parseMessageIds(headerValue(headers, 'References')), ['root@example.com', 'parent@example.com']);
    expect(headerValue(headers, 'MIME-Version'), '1.0');
    expect(headerValue(headers, 'User-Agent'), 'Loupe/0.1');
    expect(headerValue(headers, 'Subject'), startsWith('Grüße aus Berlin – ein ziemlich'));
    expect(headerValue(headers, 'Content-Type'), 'text/plain; charset=utf-8');

    final m = parseBack(bytes);
    expect(
      m.decodeSubject(),
      'Grüße aus Berlin – ein ziemlich langer Betreff, der über mehrere Zeilen gefaltet werden muss',
    );
    expect(m.from!.single.personalName, 'Jö Schmidt, Jr.');
    expect(m.from!.single.email, 'jo@example.org');
    expect(m.to!.map((a) => a.email), ['ann@example.com', 'bob@example.com']);
    expect(m.to!.first.personalName, 'Ann Ö');
    expect(m.cc!.single.personalName, 'Cy "The Guy"');
    expect(m.replyTo!.single.email, 'team@example.org');
    expect(m.decodeTextPlainPart(), 'Hallo Ann,\r\nschöne Grüße.\r\n.\r\nFrom here on = fine \r\n-- \r\nJo');
  });

  test('refuses a message that asks for encryption or a signature, never sending it in the clear', () {
    for (final security in const [OutgoingSecurity(encrypt: true), OutgoingSecurity(sign: true)]) {
      expect(
        () => compose(OutgoingMessage(accountId: 'a', identityId: 'i1', subject: 'x', security: security)),
        throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.unsupported)),
      );
    }
    expect(compose(const OutgoingMessage(accountId: 'a', identityId: 'i1', subject: 'x')), isNotEmpty);
  });

  test('HTML alternative and attachments', () {
    final pdf = Uint8List.fromList(List.generate(1000, (i) => i % 256));
    final bytes = compose(
      OutgoingMessage(
        accountId: 'a',
        identityId: 'i1',
        to: const [EmailAddress('ann@example.com')],
        subject: 'Report',
        text: 'See attached.',
        html: '<p>See <b>attached</b>.</p>',
        attachments: [
          OutgoingAttachment(
            filename: 'Bericht März 2025 – endgültige Fassung.pdf',
            mimeType: 'application/pdf',
            data: pdf,
          ),
          OutgoingAttachment(filename: 'notes.txt', mimeType: 'not a mime type', data: Uint8List.fromList([65, 66])),
        ],
      ),
    );
    final m = parseBack(bytes);
    expect(m.mediaType.sub, em.MediaSubtype.multipartMixed);
    expect(m.parts![0].mediaType.sub, em.MediaSubtype.multipartAlternative);
    // enough_mail keeps the CRLF that RFC 2046 assigns to the next boundary.
    expect(m.decodeTextPlainPart()?.trimRight(), 'See attached.');
    expect(m.decodeTextHtmlPart()?.trimRight(), '<p>See <b>attached</b>.</p>');
    final attachments = m.findContentInfo(disposition: em.ContentDisposition.attachment);
    expect(attachments, hasLength(2));
    expect(attachments[0].fileName, 'Bericht März 2025 – endgültige Fassung.pdf');
    expect(m.getPart(attachments[0].fetchId)!.decodeContentBinary(), pdf);
    expect(attachments[1].fileName, 'notes.txt');
    expect(attachments[1].mediaType?.text, 'application/octet-stream');
  });

  group('an invitation reply (iMIP)', () {
    const ics =
        'BEGIN:VCALENDAR\r\nPRODID:-//Loupe//Loupe Mail//EN\r\nVERSION:2.0\r\nMETHOD:REPLY\r\nBEGIN:VEVENT\r\n'
        'ATTENDEE;PARTSTAT=ACCEPTED:mailto:jo@example.org\r\nORGANIZER:mailto:ann@example.com\r\n'
        'UID:abc@example.com\r\nSEQUENCE:0\r\nDTSTAMP:20251006T083000Z\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n';

    test('multipart/alternative: the text, then text/calendar with its method', () {
      final bytes = compose(
        const OutgoingMessage(
          accountId: 'a',
          identityId: 'i1',
          to: [EmailAddress('ann@example.com')],
          subject: 'Accepted: Planning',
          text: 'Jö Schmidt has accepted: Planning, Mon 6 Oct 10:00',
          calendar: OutgoingCalendar(method: 'REPLY', data: ics),
        ),
      );
      final raw = ascii.decode(bytes);
      expect(raw, contains('Content-Type: text/calendar; method=REPLY; charset=UTF-8\r\n'));
      expect(raw, contains('Content-Transfer-Encoding: 7bit\r\n'));
      expect(raw, contains('\r\nMETHOD:REPLY\r\n'));
      final m = parseBack(bytes);
      expect(m.mediaType.sub, em.MediaSubtype.multipartAlternative);
      expect(m.parts!.map((p) => p.mediaType.text), ['text/plain', 'text/calendar']);
      expect(m.parts![1].getHeaderContentType()!.parameters['method'], 'REPLY');
      expect(m.parts![1].decodeContentText(), ics);
      expect(m.decodeTextPlainPart()?.trimRight(), 'Jö Schmidt has accepted: Planning, Mon 6 Oct 10:00');
      expect(m.findContentInfo(disposition: em.ContentDisposition.attachment), isEmpty);
    });

    test('non-ASCII calendars go as base64; with HTML and attachments the calendar stays an alternative', () {
      final unicode = ics.replaceFirst('ATTENDEE;', 'ATTENDEE;CN=Jö Schmidt;');
      final bytes = compose(
        OutgoingMessage(
          accountId: 'a',
          identityId: 'i1',
          to: const [EmailAddress('ann@example.com')],
          subject: 'Accepted',
          text: 'Accepted',
          html: '<p>Accepted</p>',
          attachments: [OutgoingAttachment(filename: 'a.txt', mimeType: 'text/plain', data: Uint8List(3))],
          calendar: OutgoingCalendar(method: 'reply', data: unicode.replaceAll('\r\n', '\n')),
        ),
      );
      final m = parseBack(bytes);
      expect(m.mediaType.sub, em.MediaSubtype.multipartMixed);
      final alternative = m.parts![0];
      expect(alternative.parts!.map((p) => p.mediaType.text), ['text/plain', 'text/html', 'text/calendar']);
      final calendar = alternative.parts![2];
      expect(calendar.getHeaderValue('Content-Transfer-Encoding'), 'base64');
      expect(calendar.getHeaderContentType()!.parameters['method'], 'REPLY');
      expect(utf8.decode(calendar.decodeContentBinary()!), unicode);
    });
  });

  test('quoted-printable keeps lines short and round-trips', () {
    final text = '${'x' * 200} trailing \r\n.dot\r\nFrom me\r\n€uro = sign\t';
    final encoded = encodeQuotedPrintable(utf8.encode(text));
    expect(encoded.split('\r\n').every((l) => l.length <= 76), isTrue);
    expect(encoded, contains('=2Edot'));
    expect(encoded, contains('=46rom me'));
    expect(utf8.decode(decodeQuotedPrintable(ascii.encode(encoded))), text);
  });

  test('encoded words never split characters and stay short', () {
    final words = encodeWords('🎉' * 30);
    expect(words.every((w) => w.length <= 75), isTrue);
    for (final w in words) {
      final b64 = w.substring('=?UTF-8?B?'.length, w.length - 2);
      expect(() => utf8.decode(base64.decode(b64)), returnsNormally);
    }
  });

  test('long RFC 2231 file names use continuations', () {
    final parts = rfc2231Parameter('filename', 'ä' * 40);
    expect(parts.length, greaterThan(1));
    expect(parts.first, startsWith("filename*0*=UTF-8''"));
    expect(parts.every((p) => p.length < 78), isTrue);
  });

  test('SMTP dot-stuffing escapes every leading dot and fixes line ends', () {
    String stuff(String s) => latin1.decode(dotStuff(Uint8List.fromList(latin1.encode(s))));
    expect(stuff('.a\r\nb\r\n..c\r\n.\r\n'), '..a\r\nb\r\n...c\r\n..\r\n');
    expect(stuff('a\nb'), 'a\r\nb\r\n');
    expect(stuff('x\r\n'), 'x\r\n');
  });

  test('factory wires the composer and refuses non-IMAP accounts', () {
    final factory = ImapTransportFactory();
    expect(factory.composer, isA<MimeMessageComposer>());
    const account = MailAccount(
      id: 'j',
      email: 'a@b.c',
      displayName: 'J',
      provider: ProviderKind.fastmail,
      authKind: AuthKind.password,
      incoming: ServerConfig(protocol: ServerProtocol.jmap, host: 'api.fastmail.com', port: 443),
    );
    expect(
      () => factory.createTransport(account, ({forceRefresh = false}) async => const PasswordCredentials('x')),
      throwsA(isA<MailException>().having((e) => e.kind, 'kind', MailErrorKind.unsupported)),
    );
  });
}
