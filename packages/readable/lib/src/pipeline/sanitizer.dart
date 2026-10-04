// Step 3 of the pipeline: strip everything that must never render (active
// content, hidden text, tracking pixels) from the parsed DOM, in place.

import 'package:html/dom.dart';

import 'css.dart';
import 'limits.dart';

/// Elements removed together with their content.
const _dropWithContent = {
  'script',
  'style',
  'head',
  'title',
  'meta',
  'link',
  'base',
  'iframe',
  'frame',
  'frameset',
  'object',
  'embed',
  'applet',
  'param',
  'svg',
  'math',
  'canvas',
  'audio',
  'video',
  'source',
  'track',
  'map',
  'area',
  'noscript',
  'template',
  'xml',
  'datalist',
  'dialog',
  'portal',
  'o:officedocumentsettings',
  'w:worddocument',
};

/// Containers removed but whose content is kept.
const _unwrap = {'form', 'fieldset', 'legend', 'label', 'button', 'optgroup', 'output'};

/// Known open-tracking hosts. Small on purpose: the size rule catches most
/// pixels; this list catches the ones that declare a "normal" size.
const trackerHosts = {
  'google-analytics.com',
  'www.google-analytics.com',
  'stats.g.doubleclick.net',
  'pixel.wp.com',
  'mailtrack.io',
  'mltrk.io',
  'open.convertkit-mail.com',
  'track.hubspot.com',
  'pixel.mathtag.com',
  'trk.klclick.com',
  'email.mg.mailgun.net',
  'pixel.app.returnpath.net',
  'tracking.getbase.com',
  'mandrillapp.com',
  'sendgrid.net',
  'list-manage.com',
  'ct.sendgrid.net',
  'bat.bing.com',
  'mailstat.us',
  'tr.cloudmagic.com',
  'app.yesware.com',
  'bananatag.com',
  'mailfoogae.appspot.com',
  'sidekickopen.com',
  'r.superhuman.com',
};

/// Path fragments typical of open-tracking endpoints.
final _trackerPath = RegExp(
  r'/(track|wf)/open|/open\.(php|aspx|gif|png)|/o\.gif|/(e|t)/o/|/beacon|/pixel(\.gif|\.png|/|$)|/imp\?|'
  r'/trackopen|/openrate|/mo/|/tracking/open',
  caseSensitive: false,
);

final _spacerName = RegExp(r'(spacer|blank|clear|transparent|pixel|shim|1x1)\.(gif|png)', caseSensitive: false);

final class SanitizeResult {
  SanitizeResult(this.body);
  final Element body;
  int hiddenElements = 0;
  int hiddenTextLength = 0;
  int trackers = 0;
  bool truncated = false;
}

/// Cleans [document] in place and returns its body.
SanitizeResult sanitize(Document document, Budget budget) {
  final body = document.body ?? document.documentElement ?? Element.tag('body');
  final s = _Sanitizer(budget, _hiddenClasses(document));
  final result = SanitizeResult(body);
  s.result = result;
  s.cleanChildren(body, 0);
  result.truncated = budget.exhausted;
  return result;
}

final class _Sanitizer {
  _Sanitizer(this.budget, this.hiddenClasses);

  final Budget budget;
  final Set<String> hiddenClasses;
  late final SanitizeResult result;

  void cleanChildren(Element el, int depth) {
    if (el.nodes.isEmpty) return;
    final kids = List<Node>.of(el.nodes);
    el.nodes.clear();
    for (final k in kids) {
      final replacement = clean(k, depth + 1);
      for (final n in replacement) {
        el.nodes.add(n);
      }
    }
  }

  /// Returns what replaces [node]: nothing, itself, or its children.
  List<Node> clean(Node node, int depth) {
    if (node is Text) return [node];
    if (node is! Element) return const []; // Comments (incl. Outlook conditionals), doctype.
    if (!budget.tick()) return const [];
    if (depth > budget.limits.maxDepth) {
      // Flatten instead of recursing further: keeps the text, bounds the stack.
      budget.markTruncated();
      return [Text(flatText(node, budget.limits.maxFlattenedChars))];
    }
    final tag = node.localName ?? '';
    if (_dropWithContent.contains(tag)) return const [];

    final style = parseStyle(node.attributes['style']);
    if (_isHidden(node, style)) {
      result.hiddenElements++;
      result.hiddenTextLength += visibleTextLength(node);
      return const [];
    }

    switch (tag) {
      case 'img':
        if (_isTrackerOrSpacer(node, style)) return const [];
        node.nodes.clear();
        return [node];
      case 'input':
        final type = (node.attributes['type'] ?? 'text').toLowerCase();
        final value = node.attributes['value']?.trim() ?? '';
        return (type == 'submit' || type == 'button' || type == 'reset') && value.isNotEmpty ? [Text(value)] : const [];
      case 'textarea':
        final text = flatText(node, budget.limits.maxFlattenedChars).trim();
        return text.isEmpty ? const [] : [Element.tag('div')..append(Text(text))];
      case 'select':
        final options = node.querySelectorAll('option');
        final chosen = options.where((o) => o.attributes.containsKey('selected')).firstOrNull ?? options.firstOrNull;
        final text = chosen?.text.trim() ?? '';
        return text.isEmpty ? const [] : [Text(text)];
      case 'option':
        return const [];
    }

    cleanChildren(node, depth);
    if (_unwrap.contains(tag)) {
      final kids = List<Node>.of(node.nodes);
      node.nodes.clear();
      return kids;
    }
    return [node];
  }

  bool _isHidden(Element e, Map<String, String> style) {
    if (e.attributes.containsKey('hidden')) return true;
    final display = style['display'];
    if (display != null && display.toLowerCase().startsWith('none')) return true;
    final visibility = style['visibility']?.toLowerCase();
    if (visibility == 'hidden' || visibility == 'collapse') return true;
    final opacity = style['opacity'];
    if (opacity != null) {
      final o = opacity.endsWith('%')
          ? (double.tryParse(opacity.substring(0, opacity.length - 1)) ?? 100) / 100
          : double.tryParse(opacity);
      if (o != null && o <= 0.01) return true;
    }
    if (isZeroLength(style['max-height'])) return true;
    final overflowHidden = (style['overflow'] ?? style['overflow-y'] ?? '').toLowerCase() == 'hidden';
    if (overflowHidden && (isZeroLength(style['height']) || isZeroLength(style['width']))) return true;
    // mso-hide:all only hides from Outlook; on its own it marks content meant
    // for everyone else (bulletproof buttons, non-VML fallbacks). Treat it as
    // hidden only together with another hiding hint.
    if ((style['mso-hide'] ?? '').toLowerCase() == 'all' &&
        (overflowHidden || isZeroLength(style['line-height']) || isZeroLength(style['font-size']))) {
      return true;
    }
    // font-size:0 is also the inline-block whitespace trick: hidden only if
    // nothing inside sets a real size again.
    final fontSize = style['font-size'];
    if (fontSize != null && isZeroLength(fontSize) && !_hasFontSizeReset(e)) return true;
    if (e.localName == 'font' && e.attributes['size']?.trim() == '0') return true;
    final cls = e.attributes['class'];
    if (cls != null && cls.isNotEmpty) {
      for (final c in cls.split(RegExp(r'\s+'))) {
        final lc = c.toLowerCase();
        if (hiddenClasses.contains(lc) || lc.contains('preheader')) return true;
      }
    }
    return false;
  }

  bool _hasFontSizeReset(Element root) {
    final stack = <Element>[...root.children];
    var seen = 0;
    while (stack.isNotEmpty && seen++ < 5000) {
      final e = stack.removeLast();
      final fs = parseStyle(e.attributes['style'])['font-size'];
      if (fs != null && !isZeroLength(fs)) return true;
      if (e.localName == 'font' && (e.attributes['size']?.trim() ?? '0') != '0') return true;
      stack.addAll(e.children);
    }
    return false;
  }

  bool _isTrackerOrSpacer(Element img, Map<String, String> style) {
    final src = (img.attributes['src'] ?? '').trim();
    if (src.isEmpty) return true;
    final w = imageDimension(img, 'width', style);
    final h = imageDimension(img, 'height', style);
    if ((w != null && w <= 2) || (h != null && h <= 2)) {
      if (src.startsWith('http')) result.trackers++;
      return true;
    }
    final uri = Uri.tryParse(src);
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      if (isTrackerHost(uri.host) || _trackerPath.hasMatch(uri.path)) {
        result.trackers++;
        return true;
      }
      if (_spacerName.hasMatch(uri.path) && (img.attributes['alt'] ?? '').trim().isEmpty) return true;
    }
    return false;
  }
}

bool isTrackerHost(String host) {
  final h = host.toLowerCase();
  for (final t in trackerHosts) {
    if (h == t || h.endsWith('.$t')) return true;
  }
  return false;
}

/// A declared image dimension in CSS px from the attribute or inline style;
/// percentages and `auto` give null.
double? imageDimension(Element img, String name, Map<String, String> style) {
  final fromStyle = parseLength(style[name]);
  if (fromStyle != null) return fromStyle;
  final attr = img.attributes[name]?.trim();
  if (attr == null || attr.isEmpty || attr.endsWith('%')) return null;
  return double.tryParse(attr.replaceFirst(RegExp(r'px$', caseSensitive: false), ''));
}

/// Classes hidden by simple top-level `<style>` rules (`.x { display:none }`).
/// Rules inside `@media` are ignored: those are the responsive variants.
Set<String> _hiddenClasses(Document document) {
  final out = <String>{};
  for (final style in document.getElementsByTagName('style')) {
    final css = style.text.replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '');
    var i = 0;
    while (i < css.length) {
      final open = css.indexOf('{', i);
      if (open < 0) break;
      final selectors = css.substring(i, open).trim();
      if (selectors.contains('@')) {
        i = _skipBlock(css, open);
        continue;
      }
      final close = css.indexOf('}', open);
      if (close < 0) break;
      final decls = parseStyle(css.substring(open + 1, close));
      if ((decls['display'] ?? '').toLowerCase().startsWith('none')) {
        for (final sel in selectors.split(',')) {
          final m = RegExp(r'^[a-zA-Z0-9]*\.([A-Za-z0-9_-]+)$').firstMatch(sel.trim());
          if (m != null) out.add(m[1]!.toLowerCase());
        }
      }
      i = close + 1;
    }
  }
  return out;
}

int _skipBlock(String css, int open) {
  var depth = 0;
  for (var j = open; j < css.length; j++) {
    if (css[j] == '{') depth++;
    if (css[j] == '}' && --depth == 0) return j + 1;
  }
  return css.length;
}

/// Number of non-whitespace characters in the text under [root]; iterative so
/// hostile nesting can't overflow the stack.
int visibleTextLength(Node root) {
  var n = 0;
  final stack = <Node>[root];
  while (stack.isNotEmpty) {
    final node = stack.removeLast();
    if (node is Text) {
      n += node.data.replaceAll(_whitespace, '').length;
    } else if (node is Element) {
      final tag = node.localName;
      if (tag == 'script' || tag == 'style' || tag == 'title') continue;
      stack.addAll(node.nodes);
    }
  }
  return n;
}

final _whitespace = RegExp(r'[\s\u00a0]+');

/// Concatenated text under [root], at most [max] characters, iteratively.
String flatText(Node root, int max) {
  final sb = StringBuffer();
  final stack = <Node>[root];
  while (stack.isNotEmpty && sb.length < max) {
    final node = stack.removeLast();
    if (node is Text) {
      sb.write(node.data);
    } else if (node is Element) {
      final tag = node.localName;
      if (_dropWithContent.contains(tag)) continue;
      if (tag == 'br') sb.write('\n');
      for (var i = node.nodes.length - 1; i >= 0; i--) {
        stack.add(node.nodes[i]);
      }
    }
  }
  final s = sb.toString();
  return s.length > max ? s.substring(0, max) : s;
}
