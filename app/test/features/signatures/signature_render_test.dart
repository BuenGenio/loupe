import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/signatures/signature_render.dart';
import 'package:mail_model/mail_model.dart';

RenderedSignature render(List<Map<String, Object?>> ops, {String? name = 'Sam Rivera'}) => RenderedSignature.of(
  Signature(id: 's', content: jsonEncode(ops)),
  SignatureFields(name: name, email: 'sam@rivera.example'),
);

void main() {
  test('formatting becomes inline HTML; text is escaped', () {
    final r = render([
      {
        'insert': '<Sam> & co',
        'attributes': {'bold': true, 'italic': true, 'color': '#FF3B4FC9', 'size': 'large', 'font': 'serif'},
      },
      {
        'insert': '\n',
        'attributes': {'align': 'center'},
      },
    ]);
    expect(r.isRich, isTrue);
    expect(r.plain, '<Sam> & co');
    final html = r.toHtml().html;
    expect(html, startsWith('<div style="text-align:center">'));
    expect(html, contains('&lt;Sam&gt; &amp; co'));
    expect(html, contains('color:#3b4fc9'));
    expect(html, contains('font-size:1.3em'));
    expect(html, contains('font-family:Georgia'));
    expect(html, contains('<i><b>'));
  });

  test('a link spanning runs gets its address once in plain text; unsafe links are dropped', () {
    final r = render([
      {
        'insert': 'Book ',
        'attributes': {'link': 'https://cal.example/sam'},
      },
      {
        'insert': 'a call',
        'attributes': {'link': 'https://cal.example/sam', 'bold': true},
      },
      {'insert': ' · '},
      {
        'insert': 'click',
        'attributes': {'link': 'javascript:alert(1)'},
      },
      {'insert': '\n'},
    ]);
    expect(r.plain, 'Book a call <https://cal.example/sam> · click');
    expect(r.display, 'Book a call · click');
    expect(r.toHtml().html, isNot(contains('javascript')));
  });

  test('fields fill in; plain text without formatting needs no HTML', () {
    final r = render([
      {
        'insert': {'loupe-field': 'name'},
      },
      {'insert': '\n'},
      {
        'insert': {'loupe-field': 'email'},
      },
      {'insert': '\n\n\n'},
    ]);
    expect(r.display, 'Sam Rivera\nsam@rivera.example');
    expect(r.isRich, isFalse);
  });

  test('plainToHtml quotes as nested blockquotes', () {
    final html = plainToHtml('Hi\n> one\n> > two\nback');
    expect(
      html,
      'Hi<br><blockquote type="cite" style="margin:0 0 0 .8ex;border-left:2px solid #ccc;padding-left:1ex">'
      'one<br><blockquote type="cite" style="margin:0 0 0 .8ex;border-left:2px solid #ccc;padding-left:1ex">two<br>'
      '</blockquote></blockquote>back<br>',
    );
  });

  test('the shown text ends where the compose block does, styles included', () {
    final r = render([
      {
        'insert': 'Sam  ',
        'attributes': {'bold': true},
      },
      {'insert': '\n'},
    ]);
    expect(r.display, 'Sam');
    expect(r.runs.single.end, 3);
  });

  test('damaged content falls back to its text', () {
    final r = RenderedSignature.of(
      const Signature(id: 's', content: 'not json'),
      const SignatureFields(email: 'a@b.example'),
    );
    expect(r.display, '');
    expect(r.isEmpty, isTrue);
  });
}
