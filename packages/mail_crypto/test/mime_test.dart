import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:test/test.dart';

import 'support.dart';

Uint8List crlf(String s) => bytes(s.replaceAll('\r\n', '\n').replaceAll('\n', '\r\n'));

void main() {
  group('MimeEntity', () {
    test('splits a multipart and keeps each part’s exact bytes', () {
      final raw = crlf('''
Content-Type: multipart/mixed; boundary="b1"
Subject: =?UTF-8?B?R3LDvMOfZQ==?=

preamble
--b1
Content-Type: text/plain; charset=utf-8

Hello
--b1
Content-Type: application/pdf; name="a.pdf"
Content-Disposition: attachment; filename*=UTF-8''r%C3%A9sum%C3%A9.pdf
Content-Transfer-Encoding: base64

JVBERi0x
--b1--
epilogue
''');
      final m = MimeEntity.parse(raw);
      expect(m.isMultipart, isTrue);
      expect(m.header('subject'), 'Grüße');
      expect(m.parts, hasLength(2));
      expect(utf8.decode(m.parts[0].raw), 'Content-Type: text/plain; charset=utf-8\r\n\r\nHello');
      expect(m.parts[0].text, 'Hello');
      expect(m.parts[1].filename, 'résumé.pdf');
      expect(utf8.decode(m.parts[1].decodedBody), '%PDF-1');
      expect(m.find('2')!.mimeType, 'application/pdf');
      expect(m.find('3'), isNull);
    });

    test('LF-only messages, folded headers and quoted-printable', () {
      final m = MimeEntity.parse(
        bytes(
          'Content-Type: text/plain;\n charset="iso-8859-1"\nContent-Transfer-Encoding: quoted-printable\n\nCaf=E9 =\nau lait',
        ),
      );
      expect(m.charset, 'iso-8859-1');
      expect(m.text, 'Café au lait');
    });

    test('a missing closing boundary keeps the last part', () {
      final m = MimeEntity.parse(crlf('Content-Type: multipart/mixed; boundary=x\n\n--x\n\nonly'));
      expect(m.parts.single.text, 'only');
    });

    test('deep nesting stops instead of recursing forever', () {
      final b = StringBuffer();
      for (var i = 0; i < 40; i++) {
        b.write('Content-Type: multipart/mixed; boundary=b$i\r\n\r\n--b$i\r\n');
      }
      b.write('Content-Type: text/plain\r\n\r\ndeep\r\n');
      final m = MimeEntity.parse(bytes(b.toString()));
      var depth = 0;
      var e = m;
      while (e.parts.isNotEmpty) {
        e = e.parts.first;
        depth++;
      }
      expect(depth, lessThanOrEqualTo(MimeEntity.maxDepth));
    });
  });

  group('contentFromEntity', () {
    test('alternative with related images, and attachments', () {
      final raw = crlf('''
Content-Type: multipart/mixed; boundary=m

--m
Content-Type: multipart/alternative; boundary=a

--a
Content-Type: text/plain; charset=utf-8; format=flowed

Plain body
--a
Content-Type: multipart/related; boundary=r

--r
Content-Type: text/html; charset=utf-8

<p>HTML body <img src="cid:logo@x"></p>
--r
Content-Type: image/png
Content-ID: <logo@x>
Content-Transfer-Encoding: base64

iVBORw0K
--r--
--a--
--m
Content-Type: text/csv; name=data.csv
Content-Disposition: attachment; filename=data.csv

a,b
--m--
''');
      final c = contentFromEntity(MimeEntity.parse(raw), emailId: 'e1');
      expect(c.text, 'Plain body');
      expect(c.isFlowed, isTrue);
      expect(c.html, contains('HTML body'));
      expect(c.inlineData.keys, ['logo@x']);
      expect(c.attachments.map((a) => (a.partId, a.mimeType, a.isInline)), [
        ('pgp:1.2.2', 'image/png', true),
        ('pgp:2', 'text/csv', false),
      ]);
      expect(c.visibleAttachments.single.filename, 'data.csv');
      final part = partOf(MimeEntity.parse(raw), 'pgp:2');
      expect(utf8.decode(part!.decodedBody), 'a,b');
    });

    test('a single text part is section 1; legacy display parts are hidden', () {
      final raw = crlf('''
Content-Type: multipart/mixed; boundary=m; protected-headers="v1"
Subject: Secret

--m
Content-Type: text/rfc822-headers; protected-headers="v1"
Content-Disposition: inline

Subject: Secret
--m
Content-Type: text/plain

Body
--m--
''');
      final c = contentFromEntity(MimeEntity.parse(raw), emailId: 'e');
      expect(c.text, 'Body');
      expect(c.attachments, isEmpty);
      final leaf = contentFromEntity(MimeEntity.parse(crlf('Content-Type: text/plain\n\nHi')), emailId: 'e');
      expect(leaf.text, 'Hi');
    });
  });

  group('codecs', () {
    test('encoded words, RFC 2231 continuations, charsets', () {
      expect(decodeEncodedWords('=?ISO-8859-1?Q?Andr=E9?= =?UTF-8?B?IFLDqQ==?='), 'André Ré');
      final v = HeaderValue.parse("attachment; filename*0*=UTF-8''long%20na; filename*1*=me.txt");
      expect(v.value, 'attachment');
      expect(v['filename'], 'long name.txt');
      expect(decodeCharset([0x80], 'windows-1252'), '€');
      expect(canonicalLineEnds(bytes('a\nb\r\nc')), bytes('a\r\nb\r\nc'));
    });
  });
}
