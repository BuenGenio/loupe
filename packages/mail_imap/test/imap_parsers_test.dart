import 'dart:convert';

import 'package:mail_imap/src/imap/body_structure.dart';
import 'package:mail_imap/src/imap/keyword_mapping.dart';
import 'package:mail_imap/src/imap/parsers.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/imap_fixtures.dart';

/// Parses one FETCH response line with the given items.
FetchedMessage fetchOne(String items) => runParser(FetchParser(), crlf('* 1 FETCH ($items)\n')).messages.single;

BodyNode structure(String bodystructure) => fetchOne('UID 1 BODYSTRUCTURE $bodystructure').structure!;

const _plain = '("TEXT" "PLAIN" ("CHARSET" "utf-8" "FORMAT" "flowed") NIL NIL "QUOTED-PRINTABLE" 1200 30 NIL NIL NIL)';
const _html = '("TEXT" "HTML" ("CHARSET" "utf-8") NIL NIL "BASE64" 5000 70 NIL NIL NIL)';
const _image =
    '("IMAGE" "PNG" ("NAME" "logo.png") "<logo@x>" NIL "BASE64" 4000 NIL ("INLINE" ("FILENAME" "logo.png")) NIL)';
const _pdf =
    '("APPLICATION" "PDF" ("NAME" "=?UTF-8?Q?Rechnung_M=C3=A4rz.pdf?=") NIL NIL "BASE64" 80000 NIL ("ATTACHMENT" ("FILENAME*" "utf-8\'\'Rechnung%20M%C3%A4rz.pdf")) NIL)';
const _sig =
    '("APPLICATION" "PGP-SIGNATURE" ("NAME" "signature.asc") NIL NIL "7BIT" 500 NIL ("ATTACHMENT" ("FILENAME" "signature.asc")) NIL)';

void main() {
  group('BODYSTRUCTURE', () {
    test('single part is section 1', () {
      final root = structure(_plain);
      expect(root.section, '1');
      expect(root.mimeType, 'text/plain');
      expect(root.charset, 'utf-8');
      expect(root.isFlowed, isTrue);
      expect(root.encoding, 'quoted-printable');
      expect(selectPreviewPart(root), same(root));
      expect(listAttachments(root), isEmpty);
      expect(hasVisibleAttachment(root), isFalse);
    });

    test('mixed(alternative(plain, related(html, image)), pdf)', () {
      final root = structure(
        '(($_plain($_html$_image "RELATED" ("TYPE" "text/html") NIL NIL) "ALTERNATIVE") $_pdf "MIXED")',
      );
      expect(root.section, '');
      expect(root.find('1.2.2')!.contentId, 'logo@x');
      final display = selectDisplayParts(root);
      expect(display.html.map((n) => n.section), ['1.2.1']);
      expect(display.text.map((n) => n.section), ['1.1']);
      expect(selectPreviewPart(root)!.section, '1.1');
      final attachments = listAttachments(root);
      expect(attachments.map((a) => a.partId), ['1.2.2', '2']);
      expect(attachments.first.isInline, isTrue);
      expect(attachments.first.contentId, 'logo@x');
      expect(attachments.last.filename, 'Rechnung März.pdf');
      expect(attachments.last.size, 60000);
      expect(hasVisibleAttachment(root), isTrue);
    });

    test('HTML-only message previews the HTML part', () {
      final root = structure('($_html$_image "RELATED" NIL NIL NIL)');
      expect(selectPreviewPart(root)!.section, '1');
      expect(hasVisibleAttachment(root), isFalse);
    });

    test('signed message ignores the signature part', () {
      final root = structure('($_plain$_sig "SIGNED" ("PROTOCOL" "application/pgp-signature") NIL NIL)');
      expect(selectDisplayParts(root).text.single.section, '1');
      expect(listAttachments(root), isEmpty);
    });

    test('encrypted: PGP/MIME and S/MIME enveloped data, not signed mail', () {
      const pgpVersion =
          '("APPLICATION" "PGP-ENCRYPTED" NIL NIL "PGP/MIME version identification" "7BIT" 12 NIL NIL NIL)';
      const pgpData =
          '("APPLICATION" "OCTET-STREAM" ("NAME" "encrypted.asc") NIL "OpenPGP encrypted message" "7BIT" 3000 NIL '
          '("INLINE" ("FILENAME" "encrypted.asc")) NIL)';
      expect(
        isEncryptedStructure(
          structure('($pgpVersion$pgpData "ENCRYPTED" ("PROTOCOL" "application/pgp-encrypted") NIL NIL)'),
        ),
        isTrue,
      );
      for (final (type, params, encrypted) in [
        ('"PKCS7-MIME"', '("SMIME-TYPE" "enveloped-data" "NAME" "smime.p7m")', true),
        ('"PKCS7-MIME"', '("SMIME-TYPE" "authEnveloped-data")', true),
        ('"X-PKCS7-MIME"', '("NAME" "smime.p7m")', true),
        ('"PKCS7-MIME"', '("SMIME-TYPE" "signed-data")', false),
        ('"OCTET-STREAM"', '("NAME" "smime.p7m")', true),
        ('"OCTET-STREAM"', '("NAME" "report.pdf")', false),
      ]) {
        final root = structure('("APPLICATION" $type $params NIL NIL "BASE64" 4000 NIL NIL NIL)');
        expect(isEncryptedStructure(root), encrypted, reason: '$type $params');
      }
      expect(isEncryptedStructure(structure(_plain)), isFalse);
      expect(
        isEncryptedStructure(structure('($_plain$_sig "SIGNED" ("PROTOCOL" "application/pgp-signature") NIL NIL)')),
        isFalse,
      );
    });

    test('forwarded message is one attachment and its parts are numbered below it', () {
      const forwarded =
          '("MESSAGE" "RFC822" NIL NIL NIL "7BIT" 3000 ("Mon, 1 Jan 2024 10:00:00 +0000" "Inner" NIL NIL NIL NIL NIL NIL NIL NIL) ($_plain$_html "ALTERNATIVE") 60 NIL ("ATTACHMENT" NIL) NIL)';
      final root = structure('($_plain $forwarded "MIXED")');
      final attachments = listAttachments(root);
      expect(attachments.single.partId, '2');
      expect(attachments.single.mimeType, 'message/rfc822');
      expect(attachments.single.filename, 'message.eml');
      expect(root.find('2.2')!.mimeType, 'text/html');
      expect(selectDisplayParts(root).text.map((n) => n.section), ['1']);
    });

    test('mixed with footer appends inline text parts', () {
      final root = structure(
        '($_plain("TEXT" "PLAIN" ("CHARSET" "us-ascii") NIL NIL "7BIT" 100 3 NIL ("INLINE" NIL) NIL) "MIXED")',
      );
      expect(selectDisplayParts(root).text.map((n) => n.section), ['1', '2']);
      expect(listAttachments(root), isEmpty);
    });
  });

  group('FETCH', () {
    test('summary items, literal subject, header fields and Gmail thread id', () {
      final header = crlf('References: <a@x>\n <b@x>\nIn-Reply-To: <b@x>\nList-Id: <list.x>\n\n');
      final raw = crlf(
        '* 12 FETCH (UID 4711 FLAGS (\\Seen \$Forwarded Junk) INTERNALDATE "17-Jul-1996 02:44:25 -0700" '
        'RFC822.SIZE 4286 X-GM-THRID 1278455344230334865 MODSEQ (12121231000) '
        'ENVELOPE ("Wed, 17 Jul 1996 02:23:25 -0700 (PDT)" ${literal('Grüße "aus" Berlin')} '
        '(("=?ISO-8859-1?Q?Andr=E9?=" NIL "andre" "example.com")) NIL NIL '
        '((NIL NIL "bob" "example.org")("Team" NIL NIL NIL)("Carol" NIL "carol" "example.org")(NIL NIL NIL NIL)) '
        'NIL NIL "<b@x>" "<id@x>") '
        'BODYSTRUCTURE $_plain '
        'BODY[HEADER.FIELDS (REFERENCES IN-REPLY-TO LIST-ID)] ${literal(header)})\n',
      );
      final m = runParser(FetchParser(), raw).messages.single;
      expect(m.seq, 12);
      expect(m.uid, 4711);
      expect(keywordsFromFlags(m.flags!), {Keywords.seen, Keywords.forwarded, Keywords.junk});
      expect(m.size, 4286);
      expect(m.modSeq, 12121231000);
      expect(m.gmailThreadId, '1278455344230334865');
      expect(m.internalDate!.toUtc(), DateTime.utc(1996, 7, 17, 9, 44, 25));
      final env = m.envelope!;
      expect(env.subject, 'Grüße "aus" Berlin');
      expect(env.from.single, const EmailAddress('andre@example.com', 'André'));
      expect(env.to.map((a) => a.email), ['bob@example.org', 'carol@example.org']);
      expect(env.inReplyTo, 'b@x');
      expect(env.messageId, 'id@x');
      expect(utf8.decode(m.sections['HEADER.FIELDS']!), contains('List-Id'));
      expect(m.structure!.mimeType, 'text/plain');
    });

    test('partial body sections and VANISHED', () {
      final raw = crlf(
        '* VANISHED (EARLIER) 3:5,9\n'
        '* 1 FETCH (UID 7 BODY[1.1]<0> ${literal('Hello')})\n'
        '* 2 FETCH (UID 8 BODY[2] NIL)\n'
        '* 2 FETCH (FLAGS (\\Flagged))\n',
      );
      final result = runParser(FetchParser(), raw);
      expect(result.vanished, [3, 4, 5, 9]);
      expect(utf8.decode(result.messages.first.sections['1.1']!), 'Hello');
      expect(result.messages.last.uid, 8);
      expect(result.messages.last.flags, [r'\Flagged']);
      expect(result.messages.last.sections['2'], isEmpty);
    });
  });

  test('LIST with special-use, subscription, NIL delimiter and literal names', () {
    final raw = crlf(
      '* LIST (\\HasNoChildren) "/" INBOX\n'
      '* LIST (\\HasNoChildren \\Sent \\Subscribed) "/" "Sent Items"\n'
      '* LIST (\\Noselect \\HasChildren) "/" "[Gmail]"\n'
      '* LIST (\\HasNoChildren) "/" ${literal('Odd"Name')}\n'
      '* LIST () NIL Flat\n'
      '* LIST (\\HasNoChildren) "." "INBOX.Entw&APw-rfe"\n',
    );
    final entries = runParser(ListParser(), raw);
    expect(entries.map((e) => e.rawName), ['INBOX', 'Sent Items', '[Gmail]', 'Odd"Name', 'Flat', 'INBOX.Entw&APw-rfe']);
    expect(entries[1].flags, {r'\hasnochildren', r'\sent', r'\subscribed'});
    expect(entries[2].flags, contains(r'\noselect'));
    expect(entries[4].delimiter, isNull);
    expect(entries[5].delimiter, '.');
  });

  test('SEARCH and ESEARCH', () {
    expect(runParser(SearchParser(), crlf('* SEARCH 2 84 882\n')).ids, [2, 84, 882]);
    expect(runParser(SearchParser(), crlf('* SEARCH\n')).ids, isEmpty);
    expect(runParser(SearchParser(), crlf('* SEARCH 5 6 (MODSEQ 917162500)\n')).ids, [5, 6]);
    final e = runParser(SearchParser(), crlf('* ESEARCH (TAG "a5") UID COUNT 4 ALL 1:3,7 MIN 1 MAX 7\n'));
    expect(e.ids, [1, 2, 3, 7]);
    expect(e.count, 4);
    expect(e.max, 7);
  });

  test('SELECT and STATUS', () {
    final select = runParser(
      SelectParser(),
      crlf(
        '* FLAGS (\\Answered \\Flagged \\Deleted \\Seen \\Draft)\n'
        '* OK [PERMANENTFLAGS (\\Deleted \\Seen \\*)] Limited\n'
        '* 172 EXISTS\n* 1 RECENT\n'
        '* OK [UIDVALIDITY 3857529045] UIDs valid\n* OK [UIDNEXT 4392] Predicted next UID\n'
        '* OK [HIGHESTMODSEQ 715194045007]\n',
      ),
      tagged: 'OK [READ-WRITE] SELECT completed',
    );
    expect(select.exists, 172);
    expect(select.uidValidity, 3857529045);
    expect(select.uidNext, 4392);
    expect(select.highestModSeq, 715194045007);
    expect(select.permanentFlags, contains(r'\*'));
    expect(select.canStoreKeywords, isTrue);
    expect(select.readOnly, isFalse);

    final status = runParser(StatusParser(), crlf('* STATUS "Sent Items" (MESSAGES 231 UIDNEXT 44292 UNSEEN 3)\n'));
    expect(status, {'MESSAGES': 231, 'UIDNEXT': 44292, 'UNSEEN': 3});
  });

  test('PERMANENTFLAGS decides whether keywords can be stored', () {
    SelectData select(String lines) => runParser(SelectParser(), crlf(lines), tagged: 'OK SELECT completed');
    // Outlook.com and Exchange: no \*, so snooze times can't live on the server.
    expect(
      select('* OK [PERMANENTFLAGS (\\Seen \\Answered \\Flagged \\Deleted \\Draft \$MDNSent)] Permanent flags\n')
          .canStoreKeywords,
      isFalse,
    );
    expect(select('* OK [PERMANENTFLAGS ()] No permanent flags permitted\n').canStoreKeywords, isFalse);
    expect(select('* OK [PERMANENTFLAGS (\\Seen \\*)] Ok\n').canStoreKeywords, isTrue);
    // Not sent at all: RFC 9051 says every flag is permanent.
    expect(select('* 3 EXISTS\n').canStoreKeywords, isNull);
  });

  test('capabilities and response codes', () {
    expect(runParser(CapabilityParser(), '', tagged: 'OK [CAPABILITY IMAP4rev1 IDLE MOVE] Logged in'), {
      'IMAP4REV1',
      'IDLE',
      'MOVE',
    });
    expect(runParser(CapabilityParser(), crlf('* CAPABILITY IMAP4rev1 AUTH=PLAIN\n')), {'IMAP4REV1', 'AUTH=PLAIN'});
    final move = runParser(GenericParser(), crlf('* OK [COPYUID 432432 42:43 6:7]\n* 3 EXPUNGE\n'), tagged: 'OK Done');
    final (validity, source, target) = parseUidPlusCode(move.code('COPYUID'))!;
    expect(validity, 432432);
    expect(source, [42, 43]);
    expect(target, [6, 7]);
    final append = runParser(GenericParser(), '', tagged: 'OK [APPENDUID 38505 3955] APPEND completed');
    final (appendValidity, _, uids) = parseUidPlusCode(append.code('APPENDUID'))!;
    expect(appendValidity, 38505);
    expect(uids, [3955]);
  });

  group('keywords', () {
    test('flags to keywords', () {
      expect(keywordsFromFlags([r'\Seen', r'\Answered', r'\Recent', r'\Deleted', r'$Label1', 'NonJunk']), {
        Keywords.seen,
        Keywords.answered,
        deletedKeyword,
        Keywords.label1,
        Keywords.notJunk,
      });
    });

    test('keywords to flags', () {
      expect(flagsForKeywords([Keywords.seen, Keywords.flagged, Keywords.draft, deletedKeyword, Keywords.answered]), [
        r'\Seen',
        r'\Flagged',
        r'\Draft',
        r'\Deleted',
        r'\Answered',
      ]);
      expect(flagsForKeywords([Keywords.forwarded, Keywords.junk, r'$label2', 'bad word', 'x"y']), [
        r'$Forwarded',
        r'$Junk',
        r'$label2',
      ]);
    });
  });
}
