import 'package:flutter_test/flutter_test.dart';
import 'package:readable/src/model/document.dart';
import 'package:readable/src/pipeline/pipeline.dart';

ReaderDocument readable(String html, {Set<String> cids = const {}}) =>
    runPipeline(PipelineInput(mode: PipelineMode.readable, html: html, contentIds: cids)).document;

/// Blocks as compact JSON-ish maps for terse expectations.
List<Map<String, Object?>> blocks(String html) => [for (final b in readable(html).blocks) b.toJson()];

String text(Block b) => switch (b) {
  ParagraphBlock(:final inlines) || HeadingBlock(:final inlines) || PreBlock(:final inlines) => inlineText(inlines),
  ButtonBlock(text: final t) => t,
  _ => '',
};

void main() {
  group('whitespace and paragraphs', () {
    test('collapses whitespace and trims lines', () {
      final doc = readable('<p>  Hello \n   <b> big </b>  world  <br>  next   line </p>');
      expect(text(doc.blocks.single), 'Hello big world\nnext line');
    });

    test('a lone nbsp binds, runs of nbsp collapse, empty paragraphs vanish', () {
      final doc = readable('<p>10&nbsp;kg&nbsp;&nbsp;&nbsp;more</p><p>&nbsp;</p><p> </p>');
      expect(doc.blocks, hasLength(1));
      expect(text(doc.blocks.single), '10\u00a0kg more');
    });

    test('Gmail-style div lines are tight; a blank div starts a new paragraph', () {
      final doc = readable('<div>a</div><div>b</div><div><br></div><div>c</div>');
      final tight = [for (final b in doc.blocks) (b as ParagraphBlock).tight];
      expect(tight, [false, true, false]);
    });

    test('divs in different table cells are not tight', () {
      final doc = readable('<table><tr><td><div>a</div></td></tr><tr><td><div>b</div></td></tr></table>');
      expect([for (final b in doc.blocks) (b as ParagraphBlock).tight], [false, false]);
    });

    test('Outlook MsoNormal paragraphs are lines', () {
      final doc = readable('<p class=MsoNormal>one<o:p></o:p></p><p class=MsoNormal>two<o:p></o:p></p>');
      expect((doc.blocks[1] as ParagraphBlock).tight, isTrue);
    });

    test('at most one blank line inside a paragraph', () {
      expect(text(readable('<p>a<br><br><br><br>b<br></p>').blocks.single), 'a\n\nb');
    });
  });

  group('allowlisted styles', () {
    test('bold, italic, underline, strike, code', () {
      final runs = (readable('<p><b>b</b><i>i</i><u>u</u><s>s</s><code>c</code></p>').blocks.single as ParagraphBlock)
          .inlines
          .cast<TextRun>();
      expect(
        [for (final r in runs) r.style.toJson()],
        [
          {'b': true},
          {'i': true},
          {'u': true},
          {'s': true},
          {'mono': true},
        ],
      );
    });

    test('colour and highlight on text; block backgrounds dropped', () {
      final p =
          readable('<div style="background:#000;color:#fff">w <span style="background-color:yellow">h</span></div>')
                  .blocks
                  .single
              as ParagraphBlock;
      final runs = p.inlines.cast<TextRun>().toList();
      expect(runs.first.style.color, 0xFFFFFFFF);
      expect(runs.first.style.background, isNull);
      expect(runs.last.style.background, 0xFFFFFF00);
    });

    test('font-weight and font-style values', () {
      final runs =
          (readable(
                    '<p><span style="font-weight:700">a</span><b style="font-weight:normal">b</b>'
                    '<span style="font-style:italic">c</span></p>',
                  ).blocks.single
                  as ParagraphBlock)
              .inlines
              .cast<TextRun>()
              .toList();
      expect(runs.map((r) => r.style.bold), [true, false, false]);
      expect(runs.last.style.italic, isTrue);
    });

    test('monospace font families become code style', () {
      final r = (readable('<p><font face="Courier New">x</font></p>').blocks.single as ParagraphBlock).inlines.single;
      expect((r as TextRun).style.mono, isTrue);
    });

    test('font sizes map to relative steps; small text is fine print', () {
      final runs =
          (readable(
                    '<p><span style="font-size:8px">a</span> <span style="font-size:18px">b</span> '
                    '<span style="font-size:11pt">c</span></p>',
                  ).blocks.single
                  as ParagraphBlock)
              .inlines
              .cast<TextRun>()
              .where((r) => r.text.trim().isNotEmpty)
              .map((r) => r.style.scale);
      expect(runs, [0.8, 1.15, 1.0]);
    });

    test('big text becomes a heading', () {
      final b = readable('<td><span style="font-size:30px">Summer sale</span></td>').blocks.single;
      expect(b, isA<HeadingBlock>().having((h) => h.level, 'level', 1));
    });

    test('centre alignment only for short blocks', () {
      final short = readable('<p align="center">Short</p>').blocks.single as ParagraphBlock;
      final long = readable('<p style="text-align:center">${'word ' * 60}</p>').blocks.single as ParagraphBlock;
      expect(short.align, BlockAlign.center);
      expect(long.align, BlockAlign.start);
    });

    test('dir=rtl is kept', () {
      expect((readable('<p dir="rtl">שלום</p>').blocks.single as ParagraphBlock).dir, TextDir.rtl);
    });

    test('widths, margins, positions and font families are dropped', () {
      final json = blocks('<div style="width:900px;margin:40px;position:absolute;font-family:Georgia">x</div>');
      expect(json.single, {
        'type': 'p',
        'inlines': [
          {'text': 'x'},
        ],
      });
    });
  });

  group('fine print', () {
    const body = '<p>The body of the message, at the size the sender chose for it, long enough to count as body.</p>';

    /// Scales of the runs of the last paragraph of [html].
    List<double> lastScales(String html) =>
        (readable(html).blocks.last as ParagraphBlock).inlines.whereType<TextRun>().map((r) => r.style.scale).toList();

    test('every way of setting text smaller', () {
      for (final small in [
        '<p style="font-size:7.5pt">x</p>',
        '<p style="font-size:8.0pt">x</p>',
        '<p style="font-size:11px">x</p>',
        '<p style="font-size:0.75em">x</p>',
        '<p style="font-size:80%">x</p>',
        '<p style="font-size:x-small">x</p>',
        '<p style="font-size:small">x</p>',
        '<p style="font-size:smaller">x</p>',
        '<p style="font:italic 9pt/1.2 Arial">x</p>',
        '<p><font size="1">x</font></p>',
        '<p><font size="2">x</font></p>',
        '<p><small>x</small></p>',
        '<style>p.disclaimer{font-size:8pt}</style><p class="disclaimer">x</p>',
        '<style>.footer{font-size:11px}</style><div class="footer"><p>x</p></div>',
      ]) {
        expect(lastScales('$body$small'), [0.8], reason: small);
      }
    });

    test('slightly smaller text is not fine print', () {
      for (final html in ['<p style="font-size:14px">x</p>', '<p style="font-size:10.5pt">x</p>']) {
        expect(lastScales('$body$html'), [1.0], reason: html);
      }
    });

    test('sizes compare with the body size the message sets', () {
      // A newsletter set entirely in 13 px: body size, with an 11 px footer.
      final doc = readable(
        '<body style="font-size:13px"><p>First paragraph of the newsletter, set in thirteen pixels.</p>'
        '<p>Second paragraph, also in thirteen pixels, and the bulk of the text.</p>'
        '<p>Third paragraph, the same again, so that the body is clearly thirteen.</p>'
        '<p style="font-size:11px">Sent by the newsletter. Unsubscribe.</p></body>',
      );
      final scales = [for (final b in doc.blocks) (b as ParagraphBlock).inlines.cast<TextRun>().single.style.scale];
      expect(scales, [1.0, 1.0, 1.0, 0.8]);
      // The same with the size on each paragraph instead of the body.
      final inline = readable(
        '${'<p style="font-size:13px">A paragraph of the newsletter in thirteen pixels.</p>' * 3}'
        '<p style="font-size:13px">The closing paragraph, also thirteen.</p>',
      );
      expect(inline.blocks.cast<ParagraphBlock>().every((p) => !(p.inlines.single as TextRun).style.fine), isTrue);
      // Outlook: an 11 pt body with a 9 pt signature line and a 10 pt note.
      expect(
        lastScales(
          '<style>p.MsoNormal{font-size:11.0pt}</style><p class=MsoNormal>Hi Sam, the draft looks good to me.</p>'
          '<p class=MsoNormal>Please send it on to the client today.</p><p class=MsoNormal>Thanks</p>'
          '<p class=MsoNormal><span style="font-size:10.0pt">Sent from the office</span> '
          '<span style="font-size:9.0pt">Partner</span></p>',
        ),
        [1.0, 0.8],
      );
    });

    test('a long disclaimer does not set the body size', () {
      final doc = readable(
        '<p>Please find the draft attached.</p><p>Regards,<br>Alex</p><p>Example LLP</p>'
        '<p style="font-size:9px">${'This message is confidential. ' * 30}</p>',
      );
      expect((doc.blocks.last as ParagraphBlock).inlines.cast<TextRun>().single.style.fine, isTrue);
      expect((doc.blocks.first as ParagraphBlock).inlines.cast<TextRun>().single.style.fine, isFalse);
    });

    test('grey fine print takes the secondary colour; links and brand colours keep theirs', () {
      final runs =
          (readable(
                    '$body<p style="font-size:10px;color:#777777">Grey <span style="color:#000000">black</span> '
                    '<span style="color:#c5221f">red</span> <a href="https://x.example/u" style="color:#999999">link</a> '
                    '<span style="background:#ffff00;color:#333333">marked</span></p>',
                  ).blocks.last
                  as ParagraphBlock)
              .inlines
              .cast<TextRun>()
              .where((r) => r.text.trim().isNotEmpty)
              .toList();
      expect(runs.every((r) => r.style.fine), isTrue);
      // Grey and black merge into one run once their colours are dropped.
      expect(runs.first.text, 'Grey black ');
      expect(runs.map((r) => r.style.color), [null, 0xFFC5221F, 0xFF999999, 0xFF333333]);
    });

    test('code is never fine print', () {
      final doc = readable('$body<pre style="font-size:11px">x = 1</pre><p><code style="font-size:11px">y</code></p>');
      final pre = doc.blocks[1] as PreBlock;
      expect((pre.inlines.single as TextRun).style.scale, 1.0);
      expect(lastScales('$body<p><code style="font-size:11px">y</code></p>'), [1.0]);
    });
  });

  group('structure', () {
    test('headings, quotes, lists, pre, hr', () {
      final doc = readable(
        '<h2>T</h2><blockquote><p>q</p></blockquote><ol start="3"><li>a</li><li>b<ul><li>c</li></ul></li></ol>'
        '<pre>  x\n    y</pre><hr><p>end</p>',
      );
      expect(doc.blocks.map((b) => b.toJson()['type']), ['h2', 'quote', 'list', 'pre', 'hr', 'p']);
      final list = doc.blocks[2] as ListBlock;
      expect(list.start, 3);
      expect(list.items[1].last, isA<ListBlock>());
      expect(text(doc.blocks[3]), '  x\n    y');
    });

    test('nested layout tables are linearised in reading order', () {
      final doc = readable(
        '<table role="presentation"><tr><td><table><tr><td>Left col</td><td>Right col text that is long enough '
        'to not be inline at all, really quite long</td></tr></table></td></tr><tr><td><p>Footer</p></td></tr></table>',
      );
      expect(doc.blocks.map(text), ['Left col', startsWith('Right col'), 'Footer']);
    });

    test('a row of short inline cells becomes one line', () {
      final doc = readable(
        '<table><tr><td><a href="https://x.example/u">Unsubscribe</a></td><td>|</td>'
        '<td><a href="https://x.example/p">Preferences</a></td></tr></table>',
      );
      expect(text(doc.blocks.single), 'Unsubscribe | Preferences');
    });

    test('data tables stay tables, with colspans', () {
      final doc = readable(
        '<table><tr><th>Item</th><th>Qty</th></tr><tr><td>Tea</td><td>1</td></tr>'
        '<tr><td colspan="2">Total 1</td></tr></table>',
      );
      final t = doc.blocks.single as TableBlock;
      expect(t.columns, 2);
      expect(t.rows.last.single.colspan, 2);
      expect(t.rows.first.first.header, isTrue);
    });

    test('a regular grid of short cells without th is a data table', () {
      final doc = readable(
        '<table><tr><td>Mon</td><td>9:00</td></tr><tr><td>Tue</td><td>10:00</td></tr><tr><td>Wed</td><td>8:30</td></tr></table>',
      );
      expect(doc.blocks.single, isA<TableBlock>());
    });

    test('role=presentation grids are layout', () {
      final doc = readable(
        '<table role="presentation"><tr><td>Mon</td><td>9:00</td></tr><tr><td>Tue</td><td>10:00</td></tr></table>',
      );
      expect(doc.blocks.whereType<TableBlock>(), isEmpty);
    });
  });

  group('links', () {
    test('only safe schemes become links', () {
      final doc = readable(
        '<p><a href="javascript:alert(1)">js</a> <a href="https://ok.example">ok</a> '
        '<a href="mailto:a@b.example">mail</a> <a href="/relative">rel</a></p>',
      );
      expect(doc.links.map((l) => l.url), ['https://ok.example', 'mailto:a@b.example']);
    });

    test('bare URLs and addresses in text become links', () {
      final doc = readable('<p>Paste https://x.example/reset?t=1 into your browser or write to help@x.example.</p>');
      expect(doc.links.map((l) => l.url), ['https://x.example/reset?t=1', 'mailto:help@x.example']);
      expect(doc.links.every((l) => !l.isMismatch), isTrue);
    });

    test('link text naming another domain is flagged', () {
      final doc = readable('<a href="https://login.evil.example/x">https://www.mybank.example/login</a>');
      expect(doc.links.single.namedDomain, 'www.mybank.example');
    });

    test('same registrable domain is fine', () {
      final doc = readable('<a href="https://click.shop.example/t?u=1">shop.example</a>');
      expect(doc.links.single.isMismatch, isFalse);
    });

    test('anchors with a background colour are buttons', () {
      final doc = readable(
        '<a href="https://x.example/go" style="background-color:#e85c41;color:#fff;padding:12px">Shop now</a>',
      );
      expect(doc.blocks.single, isA<ButtonBlock>().having((b) => b.background, 'bg', 0xFFE85C41));
    });

    test('bulletproof buttons (coloured cell around one link)', () {
      final doc = readable(
        '<table><tr><td bgcolor="#348eda"><a href="https://x.example/c" style="color:#ffffff">Confirm</a></td></tr></table>',
      );
      expect(doc.blocks.single, isA<ButtonBlock>().having((b) => b.text, 'text', 'Confirm'));
    });

    test('a link inside a sentence is not a button', () {
      final doc = readable('<p>Read <a href="https://x.example" style="background:#ff0">this</a> now.</p>');
      expect(doc.blocks.single, isA<ParagraphBlock>());
    });
  });

  group('images', () {
    test('cid images resolve through known Content-IDs (case-insensitive), unknown ones are dropped', () {
      final doc = readable(
        '<img src="cid:Logo@X" width="200" height="50"><img src="cid:missing@x" width="200">',
        cids: {'logo@x'},
      );
      expect(doc.images.single.source, isA<CidImageSource>().having((s) => s.contentId, 'cid', 'logo@x'));
    });

    test('data URIs are decoded; SVG is refused', () {
      final doc = readable(
        '<img src="data:image/png;base64,iVBORw0KGgo=" width="100" height="100">'
        '<img src="data:image/svg+xml;base64,PHN2Zz4=" width="100">',
      );
      final src = doc.images.single.source as DataImageSource;
      expect(src.mimeType, 'image/png');
      expect(src.bytes.length, 8);
    });

    test('http images are upgraded to https', () {
      final doc = readable('<img src="http://cdn.x.example/a.jpg" width="300" height="200">');
      expect((doc.images.single.source as RemoteImageSource).url, 'https://cdn.x.example/a.jpg');
    });

    test('small images stay inline as icons', () {
      final doc = readable('<p>Follow <img src="https://x.example/fb.png" width="24" height="24"> us</p>');
      expect((doc.blocks.single as ParagraphBlock).inlines.whereType<InlineImage>(), hasLength(1));
      expect(doc.images.single.icon, isTrue);
    });

    test('consecutive images become a carousel', () {
      final doc = readable(
        '<p><img src="cid:a" width="400" height="300"><br><img src="cid:b" width="400" height="300"></p><p>after</p>',
        cids: {'a', 'b'},
      );
      expect(doc.blocks.first, isA<CarouselBlock>().having((c) => c.images, 'images', [0, 1]));
    });

    test('stacked full-width remote slices are not a carousel', () {
      final doc = readable(
        '<img src="https://x.example/1.jpg" width="600" height="300"><img src="https://x.example/2.jpg" width="600" height="200">',
      );
      expect(doc.blocks.whereType<CarouselBlock>(), isEmpty);
    });

    test('images inside links carry the link', () {
      final doc = readable(
        '<a href="https://x.example"><img src="https://x.example/b.jpg" width="300" height="100"></a>',
      );
      expect(doc.images.single.link, 0);
    });
  });

  group('suggest Original', () {
    test('image-only promo', () {
      final doc = readable(
        '<a href="https://s.example/1"><img src="https://s.example/1.jpg" width="600" height="400"></a>'
        '<a href="https://s.example/2"><img src="https://s.example/2.jpg" width="600" height="400"></a>'
        '<p>Unsubscribe</p>',
      );
      expect(doc.stats.suggestOriginal, isTrue);
    });

    test('mostly hidden content', () {
      final doc = readable('<p>Hi</p><div style="display:none">${'hidden words ' * 40}</div>');
      expect(doc.stats.suggestOriginal, isTrue);
    });

    test('an ordinary message', () {
      final doc = readable('<p>${'Some normal words here. ' * 20}</p><img src="https://x.example/a.jpg" width="300">');
      expect(doc.stats.suggestOriginal, isFalse);
    });
  });

  test('broken markup is recovered', () {
    final doc = readable('<p>one<p>two<b>bold<i>both</b> after</i><div>three<table><tr><td>four');
    expect(doc.blocks.map(text).join('|'), 'one|twoboldboth after|three|four');
  });
}
