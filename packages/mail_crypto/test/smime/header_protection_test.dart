import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'smime_support.dart';
import 'writer_test.dart' show Keys, aliceId, aliceState, readAs, sign, signEncrypt, toBob;

/// Encrypted with the Subject hidden outside (S/MIME's default keeps it readable).
const hiding = OutgoingSecurity(sign: true, encrypt: true, technology: SecurityTechnology.smime, hideSubject: true);

/// Header protection (RFC 9788) of S/MIME mail Loupe sends, and reading it.
void main() {
  Uint8List write(
    OutgoingSecurity security, {
    String subject = 'Quarterly numbers',
    String text = 'Hi Bob,\n\nThe numbers are in.\n\nAlice',
    String? html,
    List<OutgoingAttachment> attachments = const [],
  }) =>
      SmimeMessageComposer(
        MimeMessageComposer(),
        Keys(aliceState(), {alice.certificate.fingerprint: alice.key}),
        backend: smime,
        clock: () => today,
      ).compose(
        OutgoingMessage(
          accountId: 'a',
          identityId: 'a',
          to: toBob,
          subject: subject,
          text: text,
          html: html,
          attachments: attachments,
          security: security,
        ),
        aliceId,
        messageId: 'hp@example.org',
        date: today,
      );

  group('encrypted', () {
    test('the Subject is "..." outside and the real one inside, with HP-Outer', () {
      final raw = write(hiding);
      final root = MimeEntity.parse(raw);
      expect(root.header('subject'), '...');
      expect(latin1.decode(raw), isNot(contains('Quarterly')));
      expect(root.header('from'), 'Alice Example <alice@example.org>');

      final r = readAs(raw, bob);
      expect(r.status.signature?.good, isTrue);
      expect(r.status.protectedSubject, 'Quarterly numbers');
      final payload = r.entity!;
      expect(payload.contentType['hp'], 'cipher');
      expect(payload.contentType['protected-headers'], 'v1');
      expect(payload.header('subject'), 'Quarterly numbers');
      expect(payload.header('message-id'), '<hp@example.org>');
      expect(payload.rawHeaders('hp-outer'), contains('Subject: ...'));
      expect(payload.rawHeaders('hp-outer'), contains('To: Bob Example <bob@example.net>'));
    });

    test('the legacy display leads the text for other clients; Loupe hides it', () {
      final r = readAs(write(hiding), bob);
      final legacy = contentFromEntity(r.entity!, emailId: 'x').text!;
      expect(legacy, startsWith('Subject: Quarterly numbers\r\n\r\nHi Bob,'));
      final shown = contentFromEntity(r.entity!, emailId: 'x', hideLegacyDisplay: true).text!;
      expect(shown, startsWith('Hi Bob,'));
      expect(shown, contains('The numbers are in.'));
    });

    test('HTML: a header-protection-legacy-display element after <body>, hidden when read', () {
      final r = readAs(write(hiding, html: '<html><body><p>The <b>numbers</b> are in.</p></body></html>'), bob);
      final html = contentFromEntity(r.entity!, emailId: 'x').html!;
      expect(html, contains('<body>\r\n<div class="header-protection-legacy-display"><pre>Subject: Quarterly numbers'));
      final shown = contentFromEntity(r.entity!, emailId: 'x', hideLegacyDisplay: true);
      expect(shown.html, isNot(contains('legacy-display')));
      expect(shown.html, contains('<p>The <b>numbers</b> are in.</p>'));
      expect(shown.text, startsWith('Hi Bob,'), reason: 'the text alternative too');
    });

    test('attachments are left alone: only main body parts get the display', () {
      final r = readAs(
        write(
          hiding,
          attachments: [
            OutgoingAttachment(
              filename: 'notes.txt',
              mimeType: 'text/plain',
              data: Uint8List.fromList(utf8.encode('A note')),
            ),
          ],
        ),
        bob,
      );
      final note = r.entity!.parts.last;
      expect(note.filename, 'notes.txt');
      expect(note.contentType['hp-legacy-display'], isNull);
      expect(note.text, 'A note');
    });

    test('a non-ASCII subject: encoded outside the payload, decoded when read', () {
      final r = readAs(write(hiding, subject: 'Grüße zum Quartal'), bob);
      expect(r.status.protectedSubject, 'Grüße zum Quartal');
      expect(contentFromEntity(r.entity!, emailId: 'x').text, startsWith('Subject: Grüße zum Quartal\r\n'));
    });

    test('by default S/MIME keeps the Subject readable outside, protected inside, with no legacy display', () {
      final raw = write(signEncrypt);
      final root = MimeEntity.parse(raw);
      expect(root.header('subject'), 'Quarterly numbers');
      final r = readAs(raw, bob);
      expect(r.status.signature?.good, isTrue);
      final payload = r.entity!;
      expect(payload.contentType['hp'], 'cipher');
      expect(payload.header('subject'), 'Quarterly numbers');
      expect(payload.rawHeaders('hp-outer'), contains('Subject: Quarterly numbers'));
      // No legacy display: other clients already show the real Subject.
      expect(contentFromEntity(payload, emailId: 'x').text!, startsWith('Hi Bob,'));
    });

    test('an encrypted draft hides its subject too', () {
      final raw = write(hiding.forDraft());
      expect(MimeEntity.parse(raw).header('subject'), '...');
      expect(readAs(raw, alice).status.protectedSubject, 'Quarterly numbers');
    });
  });

  group('signed only', () {
    test('the header fields go inside too (hp="clear"), covered by the signature; nothing hidden', () {
      final raw = write(sign);
      final root = MimeEntity.parse(raw);
      expect(root.header('subject'), 'Quarterly numbers');
      final r = readAs(raw, bob);
      expect(r.status.signature?.good, isTrue);
      expect(r.entity!.contentType['hp'], 'clear');
      expect(r.entity!.rawHeaders('hp-outer'), isEmpty);
      expect(r.status.protectedSubject, 'Quarterly numbers');
      expect(contentFromEntity(r.entity!, emailId: 'x', hideLegacyDisplay: true).text, startsWith('Hi Bob,'));
    });
  });

  test('messages without protected headers have none (OpenSSL, Thunderbird)', () {
    expect(readAs(smimeMail('signed-enveloped.eml'), bob).status.protectedHeaders, isEmpty);
    expect(readAs(smimeMail('signed-detached.eml'), bob).status.protectedHeaders, isEmpty);
  });

  group('withoutLegacyDisplay', () {
    test('text: the lines through the first blank one', () {
      expect(withoutLegacyDisplay('Subject: x\r\nCc: y\r\n\r\nBody\r\n\r\nmore', html: false), 'Body\r\n\r\nmore');
      expect(withoutLegacyDisplay('Subject: x\n\nBody', html: false), 'Body');
      expect(withoutLegacyDisplay('no blank line', html: false), 'no blank line');
    });

    test('HTML: the marked div with what is nested in it', () {
      const html =
          '<body><div class="header-protection-legacy-display"><div><pre>Subject: x</pre></div></div>'
          '<div>kept</div></body>';
      expect(withoutLegacyDisplay(html, html: true), '<body><div>kept</div></body>');
      expect(withoutLegacyDisplay('<body><div>kept</div></body>', html: true), '<body><div>kept</div></body>');
      expect(withoutLegacyDisplay('<div class="header-protection-legacy-display">open', html: true), isNotEmpty);
    });
  });
}
