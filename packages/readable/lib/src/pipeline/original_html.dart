// Original view: the sender's HTML for a locked-down WebView. JavaScript is
// off in the WebView; on top of that, active content is stripped here and a
// Content-Security-Policy blocks every load except inline images (and remote
// images once the user allows them).

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

import 'limits.dart';
import 'sanitizer.dart' show flatText;

/// The sender's HTML, stripped of active content, ready to wrap in a page.
final class OriginalHtml {
  const OriginalHtml({
    required this.head,
    required this.body,
    this.remoteImages = 0,
    this.contentIds = const {},
    this.truncated = false,
  });

  /// Inner HTML of `<head>` (the sender's `<style>` blocks only).
  final String head;

  /// The `<body>` element, serialised.
  final String body;

  /// Remote images (`<img>`, `background=`, CSS `url()`), blocked by default.
  final int remoteImages;

  /// Content-IDs referenced by `cid:` URLs; the host supplies their bytes.
  final Set<String> contentIds;
  final bool truncated;
}

const _strip = {
  'script',
  'noscript',
  'meta',
  'base',
  'link',
  'iframe',
  'frame',
  'frameset',
  'object',
  'embed',
  'applet',
  'portal',
  'template',
  'title',
};

/// Prepares [html] for the WebView.
OriginalHtml prepareOriginalHtml(String html, {PipelineLimits limits = const PipelineLimits()}) {
  var input = html;
  var truncated = false;
  if (input.length > limits.maxInputChars) {
    input = input.substring(0, limits.maxInputChars);
    truncated = true;
  }
  final doc = html_parser.parse(input);
  final budget = Budget(limits);
  var remote = 0;
  final cids = <String>{};

  // Event handlers and javascript: URLs can't run (JavaScript is off), but
  // there is no reason to keep them.
  void stripAttributes(Element n) => n.attributes.removeWhere((k, v) {
    final name = k.toString().toLowerCase();
    if (name.startsWith('on')) return true;
    final value = v.trim().toLowerCase();
    return (name == 'href' || name == 'src' || name == 'action' || name == 'formaction') &&
        (value.startsWith('javascript:') || value.startsWith('vbscript:'));
  });

  void clean(Element el, int depth) {
    final kids = List<Node>.of(el.nodes);
    el.nodes.clear();
    for (final n in kids) {
      if (n is Comment) continue;
      if (n is! Element) {
        el.nodes.add(n);
        continue;
      }
      final tag = n.localName ?? '';
      if (_strip.contains(tag)) continue;
      if (!budget.tick()) {
        truncated = true;
        continue;
      }
      if (depth > limits.maxDepth) {
        truncated = true;
        el.nodes.add(Text(flatText(n, limits.maxFlattenedChars)));
        continue;
      }
      stripAttributes(n);
      if (tag == 'form') {
        // No submissions: a form becomes a plain container.
        final div = Element.tag('div')..attributes.addAll(n.attributes..remove('action'));
        clean(n, depth + 1);
        div.nodes.addAll(List<Node>.of(n.nodes));
        el.nodes.add(div);
        continue;
      }
      if (_isRemote(n.attributes['src']) || _isRemote(n.attributes['background'])) remote++;
      for (final attr in const ['src', 'background']) {
        final v = n.attributes[attr]?.trim();
        if (v != null && v.toLowerCase().startsWith('cid:')) cids.add(_decodeCid(v.substring(4)));
      }
      final style = n.attributes['style'];
      if (style != null && style.contains(_remoteUrl)) remote++;
      if (tag == 'style') {
        remote += _remoteUrl.allMatches(n.text).length;
        el.nodes.add(n);
        continue;
      }
      clean(n, depth + 1);
      el.nodes.add(n);
    }
  }

  final head = doc.head ?? Element.tag('head');
  final body = doc.body ?? Element.tag('body');
  stripAttributes(body);
  clean(head, 0);
  clean(body, 0);
  final styles = head.children.where((e) => e.localName == 'style').map((e) => e.outerHtml).join('\n');
  return OriginalHtml(head: styles, body: body.outerHtml, remoteImages: remote, contentIds: cids, truncated: truncated);
}

String _decodeCid(String id) {
  var out = id;
  try {
    out = Uri.decodeComponent(id);
  } on ArgumentError {
    // Keep it as written.
  }
  return out.replaceAll(RegExp(r'^<|>$'), '');
}

final _remoteUrl = RegExp(r'''url\(\s*['"]?\s*(https?:)?//''', caseSensitive: false);

bool _isRemote(String? url) {
  if (url == null) return false;
  final u = url.trim().toLowerCase();
  return u.startsWith('http://') || u.startsWith('https://') || u.startsWith('//');
}

/// The Content-Security-Policy of the Original view.
String originalCsp({required bool allowRemote}) =>
    "default-src 'none'; img-src cid: data:${allowRemote ? ' https:' : ''}; style-src 'unsafe-inline'";

/// Wraps [original] in a page with the CSP, a viewport and image scaling.
/// [cidDataUris] maps Content-IDs to `data:` URIs: a WebView can't resolve
/// `cid:` itself.
String buildOriginalPage(
  OriginalHtml original, {
  required bool allowRemote,
  Map<String, String> cidDataUris = const {},
  String extraCss = '',
}) {
  var body = original.body;
  var head = original.head;
  if (cidDataUris.isNotEmpty) {
    String resolve(String s) => s.replaceAllMapped(
      RegExp(r'cid:([^"\x27\s)>]+)', caseSensitive: false),
      (m) => cidDataUris[_decodeCid(m[1]!)] ?? m[0]!,
    );
    body = resolve(body);
    head = resolve(head);
  }
  final csp = originalCsp(allowRemote: allowRemote);
  return '<!DOCTYPE html><html><head>'
      '<meta http-equiv="Content-Security-Policy" content="$csp">'
      '<meta charset="utf-8">'
      '<meta name="viewport" content="width=device-width, initial-scale=1">'
      '<meta name="color-scheme" content="light">'
      '<style>html,body{margin:0;padding:0}body{padding:8px;overflow-wrap:break-word}'
      'img{max-width:100% !important;height:auto !important}$extraCss</style>'
      '$head</head>$body</html>';
}
