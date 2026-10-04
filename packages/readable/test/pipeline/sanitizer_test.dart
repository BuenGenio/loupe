import 'package:flutter_test/flutter_test.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:readable/src/pipeline/limits.dart';
import 'package:readable/src/pipeline/sanitizer.dart';

/// Sanitises [html] and returns the body's inner HTML.
String clean(String html, {PipelineLimits limits = const PipelineLimits()}) =>
    sanitize(html_parser.parse(html), Budget(limits)).body.innerHtml;

SanitizeResult result(String html) => sanitize(html_parser.parse(html), Budget(const PipelineLimits()));

void main() {
  group('removes active and foreign content', () {
    test('script, style, iframe, object, embed, svg, comments', () {
      final out = clean(
        '<p>a</p><script>alert(1)</script><style>p{}</style><iframe src="x"></iframe><object>o</object>'
        '<embed src="y"><svg><text>s</text></svg><!-- note --><p>b</p>',
      );
      expect(out, '<p>a</p><p>b</p>');
    });

    test('Outlook conditional comments and their VML', () {
      final out = clean('<p>x</p><!--[if mso]><v:roundrect><center>VML</center></v:roundrect><![endif]--><p>y</p>');
      expect(out, '<p>x</p><p>y</p>');
    });

    test('form controls keep their text', () {
      final out = clean(
        '<form action="https://x"><label>Name</label><input type="text" value="secret">'
        '<input type="submit" value="Send"><button>Click</button><select><option>A</option>'
        '<option selected>B</option></select><textarea>Notes</textarea></form>',
      );
      expect(out, 'NameSendClickB<div>Notes</div>');
    });
  });

  group('removes hidden content', () {
    for (final style in [
      'display:none',
      'display: none !important',
      'visibility:hidden',
      'opacity:0',
      'opacity: 0.0',
      'font-size:0',
      'font-size:0px',
      'max-height:0',
      'max-height:0px;overflow:hidden',
      'height:0;overflow:hidden',
      'mso-hide:all;overflow:hidden',
    ]) {
      test(style, () {
        final r = result('<p>keep</p><div style="$style">hidden text</div>');
        expect(r.body.innerHtml, '<p>keep</p>');
        expect(r.hiddenElements, 1);
        expect(r.hiddenTextLength, 'hiddentext'.length);
      });
    }

    test('mso-hide:all alone (Outlook-only hiding) is kept', () {
      expect(clean('<a href="https://x" style="mso-hide:all">Button</a>'), contains('Button'));
    });

    test('font-size:0 parent with a font-size reset inside is kept', () {
      final out = clean('<td style="font-size:0"><div style="display:inline-block;font-size:14px">Col</div></td>');
      expect(out, contains('Col'));
    });

    test('hidden attribute and preheader class', () {
      expect(clean('<span hidden>x</span><span class="preheader">y</span><p>z</p>'), '<p>z</p>');
    });

    test('classes hidden by a top-level style rule, but not by @media rules', () {
      final out = clean(
        '<style>.mobile-only{display:none} @media (max-width:600px){.desktop{display:none}}</style>'
        '<div class="mobile-only">m</div><div class="desktop">d</div>',
      );
      expect(out, '<div class="desktop">d</div>');
    });
  });

  group('removes tracking pixels', () {
    test('1×1 and 2px images', () {
      final r = result(
        '<img src="https://t.example/o.gif" width="1" height="1"><img src="https://t.example/p.png" style="width:2px">'
        '<img src="https://cdn.example/photo.jpg" width="600" height="400">',
      );
      expect(r.body.querySelectorAll('img').map((e) => e.attributes['src']), ['https://cdn.example/photo.jpg']);
      expect(r.trackers, 2);
    });

    test('known tracker hosts and open-tracking paths', () {
      final r = result(
        '<img src="https://www.google-analytics.com/collect?v=1" width="100">'
        '<img src="https://u123.list-manage.com/track/open.php?u=1">'
        '<img src="https://mail.example.com/wf/open?upn=abc">'
        '<img src="https://cdn.example/logo.png">',
      );
      expect(r.body.querySelectorAll('img').map((e) => e.attributes['src']), ['https://cdn.example/logo.png']);
      expect(r.trackers, 3);
    });

    test('spacer gifs without alt text', () {
      expect(clean('<img src="https://x.example/images/spacer.gif" width="20"><p>t</p>'), '<p>t</p>');
    });

    test('images without src', () {
      expect(clean('<img alt="nothing"><p>t</p>'), '<p>t</p>');
    });
  });

  group('limits', () {
    test('deep nesting is flattened to text', () {
      final html = '${'<div>' * 300}deep text${'</div>' * 300}';
      final r = sanitize(html_parser.parse(html), Budget(const PipelineLimits(maxDepth: 50)));
      expect(r.body.text, contains('deep text'));
      expect(r.truncated, isTrue);
    });

    test('node budget stops the walk', () {
      final html = List.generate(500, (i) => '<p>p$i</p>').join();
      final r = sanitize(html_parser.parse(html), Budget(const PipelineLimits(maxNodes: 100)));
      expect(r.body.children.length, lessThan(101));
      expect(r.truncated, isTrue);
    });
  });

  test('visibleTextLength ignores whitespace', () {
    expect(visibleTextLength(html_parser.parse('<p> a b\n c&nbsp;d </p>').body!), 4);
  });
}
