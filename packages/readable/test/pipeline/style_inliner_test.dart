import 'package:flutter_test/flutter_test.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:readable/src/pipeline/css.dart';
import 'package:readable/src/pipeline/limits.dart';
import 'package:readable/src/pipeline/style_inliner.dart';

/// Inlines the sheets of [html] and returns the parsed style of the element
/// with id `t`.
Map<String, String> styleOf(String html, {String id = 't'}) {
  final doc = html_parser.parse(html);
  inlineStyleSheets(doc, Budget(const PipelineLimits()));
  return parseStyle(doc.getElementById(id)!.attributes['style']);
}

void main() {
  test('tag, class, tag.class, #id and comma lists', () {
    const sheet =
        '<style>td{color:#111111} .small{font-size:8pt} p.note{font-style:italic} '
        '#legal{text-align:center} h2, .lead{font-weight:bold}</style>';
    expect(styleOf('$sheet<table><tr><td id="t">x</td></tr></table>'), {'color': '#111111'});
    expect(styleOf('$sheet<span id="t" class="Small">x</span>'), {'font-size': '8pt'});
    expect(styleOf('$sheet<p id="t" class="note">x</p>'), {'font-style': 'italic'});
    expect(styleOf('$sheet<div class="note" id="t">x</div>'), isEmpty);
    expect(styleOf('$sheet<p id="legal"></p>', id: 'legal'), {'text-align': 'center'});
    expect(styleOf('$sheet<div id="t" class="lead">x</div>'), {'font-weight': 'bold'});
  });

  test('only the allowed text properties are taken', () {
    final style = styleOf(
      '<style>.x{font-size:8pt;color:red;background-color:#eee;font-weight:700;font-style:italic;'
      'text-decoration:none;text-align:right;width:600px;padding:20px;font-family:Arial;line-height:2;'
      'position:absolute}</style><p id="t" class="x">x</p>',
    );
    expect(style.keys.toSet(), {
      'font-size',
      'color',
      'background-color',
      'font-weight',
      'font-style',
      'text-decoration',
      'text-align',
    });
  });

  test('display:none hides; other display values and the background shorthand colour', () {
    expect(styleOf('<style>.h{display:none !important}</style><div id="t" class="h">x</div>'), {'display': 'none'});
    expect(styleOf('<style>.b{display:block}</style><span id="t" class="b">x</span>'), isEmpty);
    expect(
      styleOf(
        '<style>.btn{background:#F97316 url(x.png)}</style><table><tr><td id="t" class="btn">x</td></tr></table>',
      ),
      {'background-color': '#f97316'},
    );
    expect(styleOf('<style>.f{font:bold 7.5pt/1.2 Arial}</style><p id="t" class="f">x</p>'), {'font-size': '7.5pt'});
  });

  test('specificity: id over class over tag, later rules win ties, inline wins over all', () {
    const sheet =
        '<style>#t{color:#000001} p.a{color:#000002} .a{color:#000003} p{color:#000004;font-size:12px} '
        '.b{font-size:10px} .c{font-size:9px}</style>';
    expect(styleOf('$sheet<p id="t" class="a">x</p>')['color'], '#000001');
    expect(styleOf('$sheet<p id="u" class="a">x</p>', id: 'u')['color'], '#000002');
    expect(styleOf('$sheet<div id="u" class="a">x</div>', id: 'u')['color'], '#000003');
    expect(styleOf('$sheet<p id="u">x</p>', id: 'u')['color'], '#000004');
    expect(styleOf('$sheet<p id="u" class="c b">x</p>', id: 'u')['font-size'], '9px');
    expect(styleOf('$sheet<p id="u" class="b" style="font-size:20px">x</p>', id: 'u')['font-size'], '20px');
  });

  test('at-rules, complex selectors, comments and HTML comment wrappers are ignored', () {
    const sheet =
        '<style><!-- /* .x{color:red} */ @import url(a.css); @font-face{font-family:X} '
        '@media (max-width:600px){ .m{display:none} .inner{color:red} } '
        'td p{color:#000001} a:link{color:#000002} [x-apple]{color:#000003} div > p{color:#000004} '
        '* {color:#000005} .ok{color:#000006} --></style>';
    expect(styleOf('$sheet<div class="m"><p id="t" class="x inner">x</p></div>'), isEmpty);
    expect(styleOf('$sheet<a id="t" href="#" class="ok">x</a>'), {'color': '#000006'});
  });

  test('Outlook sheets: class sizes reach MsoNormal paragraphs', () {
    final style = styleOf(
      '<style><!--\n@font-face {font-family:"Cambria Math";}\n'
      'p.MsoNormal, li.MsoNormal, div.MsoNormal {margin:0cm; font-size:11.0pt; font-family:"Calibri",sans-serif;}\n'
      'p.Disclaimer {font-size:7.5pt; color:#7F7F7F}\n'
      '@page WordSection1 {size:612.0pt 792.0pt;}\n--></style>'
      '<p id="t" class="MsoNormal Disclaimer">Notice</p>',
    );
    expect(style, {'font-size': '7.5pt', 'color': '#7F7F7F'});
  });

  test('the work is bounded', () {
    final rules = List.generate(maxStyleRules + 500, (i) => '.c$i{color:#123456}').join(' ');
    final doc = html_parser.parse('<style>$rules</style><p class="c${maxStyleRules + 100}" id="t">x</p>');
    inlineStyleSheets(doc, Budget(const PipelineLimits()));
    expect(doc.getElementById('t')!.attributes['style'], isNull);

    final many = List.generate(500, (i) => '<p class="a">$i</p>').join();
    final capped = html_parser.parse('<style>.a{color:red}</style>$many');
    expect(inlineStyleSheets(capped, Budget(const PipelineLimits(maxNodes: 100))), lessThan(100));

    // Many rules for one class on many elements: the rule checks are capped.
    final sheet = List.generate(maxStyleRules, (i) => '.a{color:#${(i % 9) * 111111}}').join(' ');
    final paragraphs = List.generate(3000, (i) => '<p class="a">$i</p>').join();
    final heavy = html_parser.parse('<style>$sheet</style>$paragraphs');
    final styled = inlineStyleSheets(heavy, Budget(const PipelineLimits()));
    expect(styled, lessThanOrEqualTo(maxStyleMatches ~/ maxStyleRules));
  });
}
