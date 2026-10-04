import 'dart:convert';

import 'package:mail_imap/src/mime/charsets.dart';
import 'package:mail_imap/src/mime/dates.dart';
import 'package:mail_imap/src/mime/encoded_words.dart';
import 'package:mail_imap/src/mime/headers.dart';
import 'package:mail_imap/src/mime/plain_text.dart';
import 'package:mail_imap/src/mime/transfer_encoding.dart';
import 'package:mail_imap/src/util/modified_utf7.dart';
import 'package:mail_imap/src/util/uid_set.dart';
import 'package:test/test.dart';

void main() {
  group('sequence sets', () {
    test('parse ranges, stars and reversed ranges in order', () {
      expect(parseSequenceSet('1:3,7,9:10'), [1, 2, 3, 7, 9, 10]);
      expect(parseSequenceSet('5:3'), [5, 4, 3]);
      expect(parseSequenceSet('4:*', star: 6), [4, 5, 6]);
      expect(parseSequenceSet('*'), isEmpty);
      expect(() => parseSequenceSet('1:x'), throwsFormatException);
    });

    test('format compactly', () {
      expect(formatSequenceSet([7, 1, 2, 3, 9, 10, 3]), '1:3,7,9:10');
      expect(formatSequenceSet([]), '');
      expect(formatSequenceSet([42]), '42');
    });

    test('chunk', () {
      expect(chunked([1, 2, 3, 4, 5], 2).toList(), [
        [1, 2],
        [3, 4],
        [5],
      ]);
    });
  });

  group('modified UTF-7', () {
    test('round-trips names', () {
      for (final name in ['INBOX', 'Entwürfe', 'Gelöschte Elemente', '台北', 'A&B', '~peter/mail/日本語']) {
        expect(decodeModifiedUtf7(encodeModifiedUtf7(name)), name);
      }
    });

    test('matches RFC 3501 examples', () {
      expect(encodeModifiedUtf7('~peter/mail/台北/日本語'), '~peter/mail/&U,BTFw-/&ZeVnLIqe-');
      expect(decodeModifiedUtf7('Entw&APw-rfe'), 'Entwürfe');
      expect(decodeModifiedUtf7('A&-B'), 'A&B');
    });
  });

  group('charsets and transfer encodings', () {
    test('decode common charsets', () {
      expect(decodeCharset([0x47, 0x72, 0xfc, 0xdf, 0x65], 'ISO-8859-1'), 'Grüße');
      expect(decodeCharset(utf8.encode('Grüße'), 'utf-8'), 'Grüße');
      expect(decodeCharset([0x80], 'windows-1252'), '€');
      expect(decodeCharset([0xc1, 0xc2], 'koi8-r'), 'аб');
      expect(decodeCharset(utf8.encode('ok ü'), null), 'ok ü');
      expect(decodeCharset([0xfc], 'unknown-charset'), 'ü');
      expect(decodeCharset([0xff, 0xfe, 0x41, 0x00], 'utf-16'), 'A');
    });

    test('base64 tolerates junk and truncation', () {
      expect(utf8.decode(decodeBase64Lenient(ascii.encode('SGVs\r\nbG8='))), 'Hello');
      expect(utf8.decode(decodeBase64Lenient(ascii.encode('SGVsbG8gV29y'))), 'Hello Wor');
      expect(utf8.decode(decodeBase64Lenient(ascii.encode('SGVsbG8gV2'))), 'Hello W');
    });

    test('quoted-printable with soft breaks and truncation', () {
      expect(utf8.decode(decodeQuotedPrintable(ascii.encode('Gr=C3=BC=C3=9Fe =\r\nWelt=\n!'))), 'Grüße Welt!');
      expect(ascii.decode(decodeQuotedPrintable(ascii.encode('a=ZZb'))), 'a=ZZb');
      expect(ascii.decode(decodeQuotedPrintable(ascii.encode('abc=4'))), 'abc');
      expect(ascii.decode(decodeTransferEncoding(ascii.encode('x'), '7bit')), 'x');
    });
  });

  group('encoded words', () {
    test('decode RFC 2047 words and drop whitespace between them', () {
      expect(decodeEncodedWords('=?UTF-8?B?R3LDvMOfZQ==?= =?UTF-8?Q?_Welt?='), 'Grüße Welt');
      expect(decodeEncodedWords('Re: =?iso-8859-1?q?Gr=FC=DFe?= aus Berlin'), 'Re: Grüße aus Berlin');
      expect(decodeEncodedWords('plain text'), 'plain text');
    });

    test('decode multi-byte characters split across words', () {
      // "€" is E2 82 AC; split over two B-words.
      expect(decodeEncodedWords('=?utf-8?B?4oI=?= =?utf-8?B?rA==?='), '€');
    });

    test('RFC 2231 parameters and continuations', () {
      expect(normalizeParameters({'filename*': "utf-8''%E2%82%AC%20rates.pdf"}), {'filename': '€ rates.pdf'});
      expect(normalizeParameters({'name*0*': "utf-8''Gr%C3%BC", 'name*1': 'sse.txt'}), {'name': 'Grüsse.txt'});
      expect(normalizeParameters({'NAME': '=?UTF-8?B?w6Q=?=.txt'}), {'name': 'ä.txt'});
    });
  });

  group('headers', () {
    test('parse in order, unfolded and decoded', () {
      final headers = parseHeaderBlock(
        utf8.encode(
          'Subject: =?UTF-8?Q?Gr=C3=BC=C3=9Fe?=\r\nReceived: from a\r\n\tby b\r\nX-Empty:\r\nReceived: second\r\n\r\nbody',
        ),
      );
      expect(headers, [('Subject', 'Grüße'), ('Received', 'from a by b'), ('X-Empty', ''), ('Received', 'second')]);
      expect(headerValue(headers, 'subject'), 'Grüße');
    });

    test('message ids', () {
      expect(parseMessageIds('<a@b> <c@d>\r\n <e@f>'), ['a@b', 'c@d', 'e@f']);
      expect(parseMessageIds('a@b'), ['a@b']);
      expect(parseMessageIds(null), isEmpty);
      expect(stripMessageId('<x@y>'), 'x@y');
    });

    test('dates', () {
      expect(parseMailDate('Tue, 1 Jul 2003 10:52:37 +0200')!.toUtc(), DateTime.utc(2003, 7, 1, 8, 52, 37));
      expect(parseMailDate('17-Jul-1996 02:44:25 -0700')!.toUtc(), DateTime.utc(1996, 7, 17, 9, 44, 25));
      expect(parseMailDate('1 Jan 99 00:00 GMT')!.toUtc(), DateTime.utc(1999));
      expect(parseMailDate('Mon, 3 Feb 2025 12:00:00 +0000 (UTC)')!.toUtc(), DateTime.utc(2025, 2, 3, 12));
      expect(parseMailDate('garbage'), isNull);
    });
  });

  group('previews', () {
    test('strip HTML, quotes and signatures', () {
      final text = htmlToPreviewText(
        '<html><head><style>p{color:red}</style><title>T</title></head>'
        '<body><p>Hello&nbsp;<b>there</b> &amp; welcome&#33;</p><!-- hidden --><div>Line 2</div></body></html>',
      );
      expect(makePreview(text), 'Hello there & welcome! Line 2');
      expect(makePreview('Hi!\n> quoted\nThanks\n-- \nSignature'), 'Hi! Thanks');
    });

    test('cut at a word boundary', () {
      final p = makePreview(List.filled(100, 'word').join(' '), maxLength: 50);
      expect(p.length, lessThanOrEqualTo(51));
      expect(p, endsWith('word…'));
    });
  });
}
