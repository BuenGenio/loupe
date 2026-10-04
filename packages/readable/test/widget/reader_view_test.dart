import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readable/readable.dart';
import 'package:readable/src/cache.dart';
import 'package:readable/src/render/banner.dart';
import 'package:readable/src/render/blocks.dart';
import 'package:readable/src/render/gallery.dart';
import 'package:readable/src/render/icons.dart';
import 'package:readable/src/render/images.dart';
import 'package:readable/src/render/link_actions.dart';
import 'package:readable/src/render/reader_view.dart';

import 'helpers.dart';

void main() {
  setUp(PipelineCache.instance.clear);

  testWidgets('renders a readable message natively', (tester) async {
    await pumpReader(
      tester,
      email(
        html:
            '<html><head><style>p{color:red}</style></head><body>'
            '<table role="presentation" width="640"><tr><td><h1>Weekly digest</h1>'
            '<p>Hello <b>reader</b>, here is <span style="background:yellow">news</span>.</p>'
            '<ul><li>First</li><li>Second</li></ul></td></tr></table>'
            '<div style="display:none">secret preheader</div><script>alert(1)</script></body></html>',
      ),
    );
    expect(richText('Weekly digest'), findsOneWidget);
    expect(richText('Hello reader, here is news.'), findsOneWidget);
    expect(richText('First'), findsOneWidget);
    expect(richText('secret preheader'), findsNothing);
    expect(richText('alert'), findsNothing);
    expect(find.byType(SelectionArea), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a text-only message renders as text with linkified URLs', (tester) async {
    Uri? opened;
    await pumpReader(tester, email(text: 'See https://example.org/page for details.'), onOpen: (u) => opened = u);
    expect(richText('See https://example.org/page for details.'), findsOneWidget);
    await tester.tapOnText(find.textRange.ofSubstring('https://example.org/page'));
    await tester.pumpAndSettle();
    expect(opened, Uri.parse('https://example.org/page'));
  });

  group('images', () {
    testWidgets('consecutive images become a carousel', (tester) async {
      await pumpReader(
        tester,
        email(
          html:
              '<p>Photos:</p><p><img src="$pngDataUri" width="400" height="300" alt="Beach">'
              '<img src="$pngDataUri" width="400" height="300" alt="Hills"></p>',
        ),
      );
      expect(find.byType(ImageCarousel), findsOneWidget);
      expect(find.byKey(const ValueKey('readable-carousel')), findsOneWidget);
    });

    testWidgets('tapping an image opens the gallery over all images', (tester) async {
      await pumpReader(
        tester,
        email(
          html:
              '<p><img src="$pngDataUri" width="400" height="300" alt="Beach"></p><p>text between</p>'
              '<p><img src="cid:logo@x" width="300" height="100"></p>',
          inline: {'logo@x': pngBytes},
        ),
      );
      expect(find.byType(BlockImage), findsNWidgets(2));
      await tester.tap(find.byType(BlockImage).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byKey(const ValueKey('readable-gallery')), findsOneWidget);
      expect(find.text('1 / 2'), findsOneWidget);
      expect(find.text('Beach'), findsWidgets);
      await tester.tap(find.byIcon(ReadableIcons.close));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(ImageGalleryPage), findsNothing);
    });

    testWidgets('showImageGallery shows a counter and swipes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => showImageGallery(
                context,
                images: [
                  GalleryImage(image: MemoryImage(pngBytes), caption: 'one'),
                  GalleryImage(image: MemoryImage(pngBytes), caption: 'two'),
                ],
                initialIndex: 1,
              ),
              child: const Text('open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('2 / 2'), findsOneWidget);
      await tester.fling(find.byKey(const ValueKey('readable-gallery')), const Offset(400, 0), 1000);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('1 / 2'), findsOneWidget);
      expect(find.byType(InteractiveViewer), findsWidgets);
    });

    testWidgets('remote images are blocked behind a banner', (tester) async {
      final calls = <bool>[];
      await pumpReader(
        tester,
        email(html: '<p>Sale</p><img src="https://cdn.shop.example/hero.jpg" width="600" height="300" alt="Hero">'),
        onAllow: ({required always}) => calls.add(always),
      );
      expect(find.byType(RemoteContentBanner), findsOneWidget);
      expect(find.text('Images from shop.example are blocked to protect your privacy'), findsOneWidget);
      expect(find.byType(ImagePlaceholder), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is Image && w.image is NetworkImage), findsNothing);

      await tester.tap(find.text('Load images'));
      await tester.pump();
      expect(calls, [false]);
      expect(find.byType(RemoteContentBanner), findsNothing);
      expect(
        find.byWidgetPredicate(
          (w) => w is Image && w.image is ResizeImage && (w.image as ResizeImage).imageProvider is NetworkImage,
        ),
        findsOneWidget,
      );
    });

    testWidgets('"Always for this sender" reports always: true', (tester) async {
      final calls = <bool>[];
      await pumpReader(
        tester,
        email(html: '<img src="https://cdn.shop.example/a.jpg" width="600" height="300"><p>${'words ' * 50}</p>'),
        onAllow: ({required always}) => calls.add(always),
      );
      await tester.tap(find.text('Always for this sender'));
      await tester.pump();
      expect(calls, [true]);
    });

    testWidgets('no banner when remote content is allowed or there are no remote images', (tester) async {
      await pumpReader(
        tester,
        email(html: '<img src="https://cdn.shop.example/a.jpg" width="600" height="300">'),
        remote: RemoteContentPolicy.allow,
      );
      expect(find.byType(RemoteContentBanner), findsNothing);
      await pumpReader(tester, email(html: '<p>Just text</p><img src="$pngDataUri" width="100" height="100">'));
      expect(find.byType(RemoteContentBanner), findsNothing);
    });

    testWidgets('tracking pixels never render', (tester) async {
      await pumpReader(
        tester,
        email(html: '<p>Hi</p><img src="https://t.example/open.gif" width="1" height="1">'),
        remote: RemoteContentPolicy.allow,
      );
      expect(find.byType(Image), findsNothing);
    });
  });

  group('links', () {
    testWidgets('a link whose text names another domain warns first', (tester) async {
      Uri? opened;
      await pumpReader(
        tester,
        email(html: '<p>Log in at <a href="https://evil.example/login">www.mybank.example</a></p>'),
        onOpen: (u) => opened = u,
      );
      await tester.tapOnText(find.textRange.ofSubstring('www.mybank.example'));
      await tester.pumpAndSettle();
      expect(find.byType(LinkMismatchDialog), findsOneWidget);
      expect(find.text('Check this link'), findsOneWidget);
      expect(opened, isNull);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(opened, isNull);

      await tester.tapOnText(find.textRange.ofSubstring('www.mybank.example'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Open anyway'));
      await tester.pumpAndSettle();
      expect(opened, Uri.parse('https://evil.example/login'));
    });

    testWidgets('a matching link opens directly', (tester) async {
      Uri? opened;
      await pumpReader(
        tester,
        email(html: '<p><a href="https://shop.example/deals">See the deals</a></p>'),
        onOpen: (u) => opened = u,
      );
      await tester.tapOnText(find.textRange.ofSubstring('See the deals'));
      await tester.pumpAndSettle();
      expect(find.byType(LinkMismatchDialog), findsNothing);
      expect(opened, Uri.parse('https://shop.example/deals'));
    });

    testWidgets('long-press shows the real URL with Copy and Open', (tester) async {
      await pumpReader(
        tester,
        email(html: '<p><a href="https://shop.example/deals?id=42">See the deals</a></p>'),
        onOpen: (_) {},
      );
      final gesture = await tester.startGesture(textCenter('See the deals'));
      await tester.pump(const Duration(milliseconds: 600));
      await gesture.up();
      await tester.pumpAndSettle();
      expect(find.text('Copy'), findsOneWidget);
      expect(
        find.byWidgetPredicate((w) => w is SelectableText && w.data == 'https://shop.example/deals?id=42'),
        findsOneWidget,
      );
      expect(find.text('Open'), findsOneWidget);
    });

    testWidgets('button links render as chips', (tester) async {
      Uri? opened;
      await pumpReader(
        tester,
        email(
          html:
              '<table><tr><td bgcolor="#e85c41" style="border-radius:4px">'
              '<a href="https://shop.example/buy" style="color:#ffffff">Buy now</a></td></tr></table>',
        ),
        onOpen: (u) => opened = u,
      );
      final chip = find.ancestor(of: find.text('Buy now'), matching: find.byType(Material)).first;
      expect(tester.widget<Material>(chip).color, const Color(0xFFE85C41));
      await tester.tap(find.text('Buy now'));
      await tester.pumpAndSettle();
      expect(opened, Uri.parse('https://shop.example/buy'));
    });
  });

  group('button chips', () {
    const labels = ['View my work', 'Approve', 'Register now', 'Confirm your attendance at the annual general meeting'];
    const html =
        // A pill: an anchor with a background colour and padding.
        '<p><a href="https://x.example/work" style="background-color:#2e7d32;color:#fff;padding:12px 28px;'
        'border-radius:24px;display:inline-block">View my work</a></p>'
        // Bulletproof: a coloured cell around a link.
        '<table><tr><td bgcolor="#348eda" style="padding:12px 24px"><a href="https://x.example/c" '
        'style="color:#ffffff">Approve</a></td></tr></table>'
        // VML-backed, with the HTML fallback for everyone else.
        '<div><!--[if mso]><v:roundrect href="https://x.example/r" style="height:40px;width:200px" '
        'fillcolor="#556270"><center>Register now</center></v:roundrect><![endif]-->'
        '<a href="https://x.example/r" style="background-color:#556270;color:#ffffff;display:inline-block;'
        'line-height:40px;width:200px;mso-hide:all">Register now</a></div>'
        // A label that wraps.
        '<p><a href="https://x.example/agm" style="background:#7b1fa2;color:#fff;padding:10px">'
        'Confirm your attendance at the annual general meeting</a></p>';

    /// The union of the glyph boxes of [label], globally.
    Rect labelRect(String label) {
      final range = find.textRange.ofSubstring(label).evaluate().single;
      final boxes = range.renderObject.getBoxesForSelection(
        TextSelection(baseOffset: range.textRange.start, extentOffset: range.textRange.end),
      );
      final local = boxes.map((b) => b.toRect()).reduce((a, b) => a.expandToInclude(b));
      return local.shift(range.renderObject.localToGlobal(Offset.zero));
    }

    for (final scale in [0.8, 1.0, 1.4]) {
      testWidgets('labels are centred in their chips at text scale $scale', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 3;
        addTearDown(tester.view.reset);
        await pumpReader(
          tester,
          email(html: html),
          settings: ReaderSettings(textScale: scale),
        );
        expect(tester.takeException(), isNull);
        for (final label in labels) {
          final chip = tester.getRect(find.ancestor(of: find.text(label), matching: find.byType(Material)).first);
          final text = labelRect(label);
          expect(chip.height, greaterThanOrEqualTo(44), reason: label);
          expect(text.center.dy, closeTo(chip.center.dy, 0.5), reason: '$label at $scale');
          // (A wrapped label's line boxes include the space at each break.)
          if (label != labels.last) expect(text.center.dx, closeTo(chip.center.dx, 0.5), reason: '$label at $scale');
          expect(text.top - chip.top, closeTo(chip.bottom - text.bottom, 1), reason: label);
        }
        // The long label wraps inside its chip.
        final long = labelRect(labels.last);
        expect(long.height, greaterThan(tester.getSize(find.text('Approve')).height * 1.5));
      });
    }

    testWidgets('chips in a row share a centre line', (tester) async {
      await pumpReader(
        tester,
        email(
          html:
              '<p><a href="https://x.example/y" style="background:#1a73e8;color:#fff">Yes</a> '
              '<a href="https://x.example/m" style="background:#e8eaed;color:#3c4043">Maybe</a></p>',
        ),
      );
      final yes = tester.getRect(find.ancestor(of: find.text('Yes'), matching: find.byType(Material)).first);
      final maybe = tester.getRect(find.ancestor(of: find.text('Maybe'), matching: find.byType(Material)).first);
      expect(yes.center.dy, closeTo(maybe.center.dy, 0.5));
      expect(labelRect('Maybe').center.dy, closeTo(maybe.center.dy, 0.5));
    });
  });

  group('plain mode', () {
    const quoted = 'Sounds good.\n\nOn Monday, Alex wrote:\n> Shall we meet?\n> > Earlier text\n\n-- \nSam';

    testWidgets('quote levels as coloured bars, signature dimmed (Sans)', (tester) async {
      await pumpReader(
        tester,
        email(text: quoted),
        settings: const ReaderSettings(mode: ReaderMode.plain),
      );
      final bars = tester
          .widgetList<Container>(find.byType(Container))
          .map((c) => c.decoration)
          .whereType<BoxDecoration>()
          .map((d) => d.border)
          .whereType<BorderDirectional>()
          .map((b) => b.start.color)
          .toList();
      expect(bars, hasLength(2));
      expect(bars[0], isNot(bars[1]));
      final sig = tester.widget<Text>(find.ancestor(of: richText('Sam'), matching: find.byType(Text)).first);
      final sans = tester.widget<Text>(find.ancestor(of: richText('Sounds good.'), matching: find.byType(Text)).first);
      expect(sig.textSpan!.style!.color, isNot(sans.textSpan!.style!.color));
      expect(sans.textSpan!.style!.fontFamily, isNot('monospace'));
    });

    testWidgets('Mono uses a monospace font', (tester) async {
      await pumpReader(
        tester,
        email(text: '+-----+-----+\n| a   | b   |\n+-----+-----+'),
        settings: const ReaderSettings(mode: ReaderMode.plain, plainFont: PlainTextFont.mono),
      );
      final text = tester.widget<Text>(find.ancestor(of: richText('| a   | b   |'), matching: find.byType(Text)).first);
      expect(text.textSpan!.style!.fontFamily, 'monospace');
    });

    testWidgets('plain mode of an HTML-only message has link footnotes', (tester) async {
      await pumpReader(
        tester,
        email(html: '<p>Read <a href="https://blog.example/post">the post</a>.</p>'),
        settings: const ReaderSettings(mode: ReaderMode.plain),
      );
      expect(richText('Read the post [1].'), findsOneWidget);
      expect(richText('[1] https://blog.example/post'), findsOneWidget);
    });
  });

  testWidgets('suggests Original for an image-only promo, once', (tester) async {
    var suggested = 0;
    final content = email(
      html:
          '<a href="https://s.example/1"><img src="https://s.example/1.jpg" width="600" height="800"></a>'
          '<a href="https://s.example/2"><img src="https://s.example/2.jpg" width="600" height="800"></a>',
    );
    await pumpReader(tester, content, onSuggest: () => suggested++);
    await tester.pump();
    expect(suggested, 1);
    await pumpReader(tester, content, onSuggest: () => suggested++);
    await tester.pump();
    expect(suggested, 1);
  });

  testWidgets('large messages are processed in a background isolate', (tester) async {
    final html = List.generate(900, (i) => '<p>Isolate paragraph $i, padded with some words.</p>').join();
    expect(html.length, greaterThan(24 * 1024));
    await pumpReader(tester, email(html: html));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    for (var i = 0; i < 100 && richText('Isolate paragraph 0,').evaluate().isEmpty; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
    }
    expect(richText('Isolate paragraph 0,'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('long messages build in chunks, each a repaint boundary', (tester) async {
    ReaderView.debugSynchronous = true;
    addTearDown(() => ReaderView.debugSynchronous = false);
    final html = List.generate(400, (i) => '<p>Paragraph number $i of a very long newsletter.</p>').join();
    await pumpReader(tester, email(html: html));
    expect(richText('Paragraph number 0 of'), findsOneWidget);
    expect(richText('Paragraph number 399 of'), findsNothing);
    await tester.pumpAndSettle();
    expect(richText('Paragraph number 399 of'), findsOneWidget);
    expect(
      find.descendant(of: find.byType(DocumentBlocks), matching: find.byType(RepaintBoundary)),
      findsAtLeastNWidgets(10),
    );
  });

  testWidgets('hostile nesting depth keeps a readable width', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final html =
        '${'<blockquote>' * 60}deep quote text${'</blockquote>' * 60}'
        '${'<ul><li>' * 40}deep list text${'</li></ul>' * 40}';
    await pumpReader(tester, email(html: html));
    final text = '> ' * 80;
    await pumpReader(
      tester,
      email(text: '${text}deep plain quote'),
      settings: const ReaderSettings(mode: ReaderMode.plain),
    );
    expect(tester.takeException(), isNull);
    expect(tester.getSize(richText('deep plain quote')).width, greaterThan(150));
    await pumpReader(tester, email(html: html));
    expect(tester.getSize(richText('deep quote text')).width, greaterThan(150));
    expect(tester.getSize(richText('deep list text')).width, greaterThan(150));
  });

  testWidgets('settings.textScale multiplies the platform text scale', (tester) async {
    await pumpReader(tester, email(text: 'Scaled'), settings: const ReaderSettings(textScale: 1.5));
    final context = tester.element(richText('Scaled'));
    expect(MediaQuery.textScalerOf(context).scale(10), closeTo(15, 0.001));
  });

  testWidgets('fine print is smaller and in the secondary text colour', (tester) async {
    await pumpReader(
      tester,
      email(
        html:
            '<p>The body of the message, long enough to be the body.</p>'
            '<p style="font-size:7.5pt;color:#000000">Legal notice and <a href="https://x.example/privacy">privacy</a></p>',
      ),
    );
    List<TextSpan> spansOf(String text) =>
        (tester.widget<Text>(find.ancestor(of: richText(text), matching: find.byType(Text)).first).textSpan!
                as TextSpan)
            .children!
            .whereType<TextSpan>()
            .toList();
    final body = spansOf('The body').single.style!;
    final fine = spansOf('Legal notice');
    final scheme = Theme.of(tester.element(richText('Legal notice'))).colorScheme;
    expect(fine.first.style!.fontSize, closeTo(body.fontSize! * 0.8, 0.01));
    expect(fine.first.style!.color, scheme.onSurfaceVariant);
    // Links in fine print stay links.
    expect(fine.last.style!.color, scheme.primary);
    expect(fine.last.style!.fontSize, closeTo(body.fontSize! * 0.8, 0.01));
  });

  testWidgets('dark mode adapts dark text colours; keepOriginalColors does not', (tester) async {
    final content = email(html: '<p><span style="color:#111111">Dark ink</span></p>');
    await pumpReader(tester, content, theme: ThemeData(brightness: Brightness.dark));
    Color? colorOf() {
      final text = tester.widget<Text>(find.ancestor(of: richText('Dark ink'), matching: find.byType(Text)).first);
      return (text.textSpan! as TextSpan).children!.whereType<TextSpan>().first.style!.color;
    }

    final adapted = colorOf()!;
    expect(adapted.computeLuminance(), greaterThan(0.4));
    await pumpReader(
      tester,
      content,
      theme: ThemeData(brightness: Brightness.dark),
      settings: const ReaderSettings(keepOriginalColors: true),
    );
    expect(colorOf(), const Color(0xFF111111));
  });
}
