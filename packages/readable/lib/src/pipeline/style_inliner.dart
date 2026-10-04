// Step 3, first part: apply the simple rules of the message's `<style>`
// sheets as inline styles before sanitising, so class-based sizes, colours,
// emphasis and hiding survive the removal of the sheets (Outlook's
// `p.MsoNormal`, Mimecast's `p.disclaimer`, newsletter `.footer` classes).
//
// Only simple selectors (`tag`, `.class`, `tag.class`, `#id`, comma lists of
// them) and a few text properties are taken; @media and other at-rules,
// combinators, pseudo-classes and attribute selectors are ignored. Inline
// declarations always win over the sheet.

import 'package:html/dom.dart';

import 'css.dart';
import 'limits.dart';

/// Properties taken from style sheets.
const _inlinedProperties = {
  'font-size',
  'color',
  'background-color',
  'font-weight',
  'font-style',
  'text-decoration',
  'text-align',
};

/// Style sheet text read, in characters; the rest is ignored.
const maxStyleSheetChars = 200000;

/// Rules kept from all sheets.
const maxStyleRules = 2000;

/// Rule checks against elements, in all; inlining stops after that.
const maxStyleMatches = 2000000;

final _simpleSelector = RegExp(r'^([a-z][a-z0-9]*)?((?:\.[a-z0-9_-]+)+|#[a-z0-9_-]+)?$', caseSensitive: false);
final _comments = RegExp(r'/\*.*?\*/', dotAll: true);
final _whitespace = RegExp(r'\s+');

final class _Rule {
  _Rule({this.tag, this.classes = const [], this.id, required this.order, required this.declarations})
    : specificity = (id != null ? 100 : 0) + classes.length * 10 + (tag != null ? 1 : 0);

  final String? tag;
  final List<String> classes;
  final String? id;
  final int order;
  final int specificity;
  final Map<String, String> declarations;

  bool matches(String tag, Set<String> classes, String? id) =>
      (this.tag == null || this.tag == tag) &&
      (this.id == null || this.id == id) &&
      this.classes.every(classes.contains);
}

/// Applies the simple rules of [document]'s style sheets to its elements'
/// `style` attributes. Returns the number of elements that got styles.
int inlineStyleSheets(Document document, Budget budget) {
  final rules = _parseSheets(document);
  if (rules.isEmpty) return 0;

  // Index each rule once: by id, else its first class, else its tag.
  final byId = <String, List<_Rule>>{};
  final byClass = <String, List<_Rule>>{};
  final byTag = <String, List<_Rule>>{};
  for (final r in rules) {
    if (r.id != null) {
      (byId[r.id!] ??= []).add(r);
    } else if (r.classes.isNotEmpty) {
      (byClass[r.classes.first] ??= []).add(r);
    } else {
      (byTag[r.tag!] ??= []).add(r);
    }
  }

  final root = document.documentElement;
  if (root == null) return 0;
  var styled = 0;
  var seen = 0;
  var checks = 0;
  final stack = <Element>[root];
  while (stack.isNotEmpty) {
    if (++seen > budget.limits.maxNodes || ((seen & 255) == 0 && budget.timeUp)) break;
    final e = stack.removeLast();
    stack.addAll(e.children);
    final tag = e.localName ?? '';
    final cls = e.attributes['class'];
    final classes = cls == null || cls.isEmpty
        ? const <String>{}
        : {for (final c in cls.trim().split(_whitespace)) c.toLowerCase()};
    final rawId = e.attributes['id']?.trim().toLowerCase();
    final id = rawId == null || rawId.isEmpty ? null : rawId;

    final candidates = <_Rule>[...?byTag[tag], for (final c in classes) ...?byClass[c], if (id != null) ...?byId[id]];
    checks += candidates.length;
    if (checks > maxStyleMatches) break;
    final matched = candidates.where((r) => r.matches(tag, classes, id)).toList();
    if (matched.isEmpty) continue;
    matched.sort((a, b) {
      final s = a.specificity.compareTo(b.specificity);
      return s != 0 ? s : a.order.compareTo(b.order);
    });
    final merged = <String, String>{};
    for (final r in matched) {
      merged.addAll(r.declarations);
    }
    // Sheet declarations first: the element's own come later and win.
    final sheet = merged.entries.map((d) => '${d.key}:${d.value}').join(';');
    final own = e.attributes['style'];
    e.attributes['style'] = own == null || own.trim().isEmpty ? sheet : '$sheet;$own';
    styled++;
  }
  return styled;
}

List<_Rule> _parseSheets(Document document) {
  final rules = <_Rule>[];
  var budget = maxStyleSheetChars;
  for (final style in document.getElementsByTagName('style')) {
    if (budget <= 0 || rules.length >= maxStyleRules) break;
    var css = style.text;
    if (css.length > budget) css = css.substring(0, budget);
    budget -= css.length;
    css = css.replaceAll(_comments, ' ').replaceAll('<!--', ' ').replaceAll('-->', ' ');
    for (final (selectors, body) in _ruleTexts(css)) {
      final declarations = _allowedDeclarations(body);
      if (declarations.isEmpty) continue;
      for (final selector in selectors.split(',')) {
        final rule = _rule(selector.trim(), rules.length, declarations);
        if (rule != null) rules.add(rule);
        if (rules.length >= maxStyleRules) return rules;
      }
    }
  }
  return rules;
}

/// Top-level `selectors { declarations }` pairs; at-rules (with or without a
/// block) are skipped whole.
Iterable<(String, String)> _ruleTexts(String css) sync* {
  var i = 0;
  while (i < css.length) {
    final c = css.codeUnitAt(i);
    // Whitespace and stray `}` / `;` between rules.
    if (c <= 0x20 || c == 0x7D || c == 0x3B) {
      i++;
      continue;
    }
    final open = css.indexOf('{', i);
    if (c == 0x40) {
      // @import …; or @media … { … }
      final semi = css.indexOf(';', i);
      if (open < 0 && semi < 0) return;
      i = open < 0 || (semi >= 0 && semi < open) ? semi + 1 : _skipBlock(css, open);
      continue;
    }
    if (open < 0) return;
    final close = css.indexOf('}', open);
    if (close < 0) return;
    final selectors = css.substring(i, open);
    if (selectors.contains('@')) {
      i = _skipBlock(css, open);
      continue;
    }
    yield (selectors, css.substring(open + 1, close));
    i = close + 1;
  }
}

int _skipBlock(String css, int open) {
  var depth = 0;
  for (var j = open; j < css.length; j++) {
    final c = css.codeUnitAt(j);
    if (c == 0x7B) depth++;
    if (c == 0x7D && --depth == 0) return j + 1;
  }
  return css.length;
}

Map<String, String> _allowedDeclarations(String body) {
  final out = <String, String>{};
  for (final MapEntry(:key, :value) in parseStyle(body).entries) {
    if (_inlinedProperties.contains(key)) {
      out[key] = value;
    } else if (key == 'display' && value.toLowerCase().startsWith('none')) {
      out['display'] = 'none';
    } else if (key == 'background' && !out.containsKey('background-color')) {
      // Only the colour of the shorthand.
      final color = parseColor(value);
      if (color != null) out['background-color'] = '#${(color & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
    } else if (key == 'font' && !out.containsKey('font-size')) {
      final size = fontShorthandSize(value);
      if (size != null) out['font-size'] = size;
    }
  }
  return out;
}

_Rule? _rule(String selector, int order, Map<String, String> declarations) {
  final m = _simpleSelector.firstMatch(selector);
  if (m == null) return null;
  final tag = m[1]?.toLowerCase();
  final rest = m[2];
  if (tag == null && rest == null) return null;
  if (rest != null && rest.startsWith('#')) {
    return _Rule(tag: tag, id: rest.substring(1).toLowerCase(), order: order, declarations: declarations);
  }
  final classes = rest == null
      ? const <String>[]
      : [
          for (final c in rest.split('.'))
            if (c.isNotEmpty) c.toLowerCase(),
        ];
  return _Rule(tag: tag, classes: classes, order: order, declarations: declarations);
}
