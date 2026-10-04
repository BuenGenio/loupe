import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/attachments/eml.dart';

Uint8List _bytes(String s) => Uint8List.fromList(utf8.encode(s.replaceAll('\n', '\r\n')));

void main() {
  test('parses headers, both bodies, inline images and attachment names', () {
    final m = parseEml(
      _bytes('''From: =?UTF-8?Q?Ana_Mar=C3=ADa?= <ana@example.com>
To: sam@example.com, Leo <leo@example.com>
Subject: Photos
Date: Sat, 03 Oct 2026 10:00:00 +0000
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mix"

--mix
Content-Type: multipart/related; boundary="rel"

--rel
Content-Type: multipart/alternative; boundary="alt"

--alt
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Voil=E0 the photo.
--alt
Content-Type: text/html; charset=utf-8

<p>Voilà the <img src="cid:pic@x"> photo.</p>
--alt--
--rel
Content-Type: image/png
Content-ID: <pic@x>
Content-Disposition: inline
Content-Transfer-Encoding: base64

iVBORw0KGgo=
--rel--
--mix
Content-Type: application/pdf; name="plan.pdf"
Content-Disposition: attachment; filename="plan.pdf"
Content-Transfer-Encoding: base64

JVBERi0=
--mix--
'''),
    );
    expect(m.from, 'Ana María <ana@example.com>');
    expect(m.to, 'sam@example.com, Leo <leo@example.com>');
    expect(m.subject, 'Photos');
    expect(m.date!.isAtSameMomentAs(DateTime.utc(2026, 10, 3, 10)), isTrue);
    expect(m.text?.trim(), 'Voilà the photo.');
    expect(m.html, contains('cid:pic@x'));
    expect(m.inlineImages.keys, ['pic@x']);
    expect(m.attachmentNames, ['plan.pdf']);
    expect(m.hasBody, isTrue);
    final content = m.toContent('eml-1');
    expect(content.emailId, 'eml-1');
    expect(content.inlineData.keys, ['pic@x']);
    expect(content.headers.first, ('From', 'Ana María <ana@example.com>'));
  });

  test('rejects bytes that are not a message', () {
    expect(() => parseEml(_bytes('just some words\nand more')), throwsFormatException);
  });
}
