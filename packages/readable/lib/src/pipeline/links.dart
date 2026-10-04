// Links: which hrefs are allowed, link-text/href mismatch detection, and
// linkifying plain text.

/// Normalises an href to an openable URL, or null for anything that isn't
/// http(s), mailto or tel (javascript:, data:, file:, relative paths, …).
String? safeHref(String? href) {
  if (href == null) return null;
  var h = href.trim().replaceAll(RegExp(r'[\u0000-\u001f]'), '');
  if (h.isEmpty || h.startsWith('#')) return null;
  if (RegExp(r'^www\.', caseSensitive: false).hasMatch(h)) h = 'https://$h';
  h = h.replaceAll(' ', '%20');
  final uri = Uri.tryParse(h);
  if (uri == null) return null;
  switch (uri.scheme.toLowerCase()) {
    case 'http' || 'https':
      return uri.host.isEmpty ? null : h;
    case 'mailto' || 'tel':
      return uri.path.isEmpty && uri.query.isEmpty ? null : h;
  }
  return null;
}

/// Common file extensions that look like TLDs in link text ("report.pdf").
const _fileExtensions = {
  'pdf',
  'doc',
  'docx',
  'xls',
  'xlsx',
  'ppt',
  'pptx',
  'jpg',
  'jpeg',
  'png',
  'gif',
  'zip',
  'txt',
  'html',
  'htm',
  'php',
  'exe',
  'csv',
  'mp3',
  'mp4',
  'mov',
  'ics',
  'eml',
  'msg',
  'json',
  'xml',
  'svg',
  'webp',
  'heic',
  'js',
};

final _domainInText = RegExp(
  r'(?<![@\w.-])(?:https?://)?((?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+([a-z]{2,24}))(?=$|[/:?#\s,;)\]>"]|\.(?:\s|$))',
  caseSensitive: false,
);

/// The domain that link text names ("www.paypal.com", "https://bank.example/login"),
/// or null if it doesn't look like it names one.
String? domainNamedIn(String text) {
  for (final m in _domainInText.allMatches(text.trim())) {
    final tld = m[2]!.toLowerCase();
    if (_fileExtensions.contains(tld)) continue;
    return m[1]!.toLowerCase();
  }
  return null;
}

/// Second-level labels used under country TLDs ("co.uk", "com.au").
const _secondLevel = {'co', 'com', 'net', 'org', 'gov', 'edu', 'ac', 'or', 'ne', 'go', 'gob', 'mil', 'nic', 'ltd'};

/// Approximate registrable domain ("eTLD+1") without a public-suffix list.
String registrableDomain(String host) {
  final labels = host.toLowerCase().replaceFirst(RegExp(r'\.$'), '').split('.');
  if (labels.length <= 2) return labels.join('.');
  final tld = labels.last;
  final sld = labels[labels.length - 2];
  final take = tld.length == 2 && _secondLevel.contains(sld) ? 3 : 2;
  return labels.sublist(labels.length - take).join('.');
}

/// If [text] names a domain other than the one [url] opens, returns that
/// named domain (for the warning); otherwise null.
String? linkMismatch(String text, String url) {
  final named = domainNamedIn(text);
  if (named == null) return null;
  final uri = Uri.tryParse(url);
  if (uri == null) return null;
  final scheme = uri.scheme.toLowerCase();
  if (scheme != 'http' && scheme != 'https') return null;
  if (uri.host.isEmpty) return null;
  return registrableDomain(named) == registrableDomain(uri.host) ? null : named;
}

/// A URL or email address found in plain text.
typedef LinkMatch = ({int start, int end, String url});

final _urlOrEmail = RegExp(
  r'''(?:\b(?:https?://|www\.)[^\s<>"'\u00a0]+)|(?:\b[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+(?:\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}\b)''',
  caseSensitive: false,
);

/// Finds URLs (`https://…`, `www.…`) and email addresses in [text].
List<LinkMatch> findLinks(String text) {
  final out = <LinkMatch>[];
  for (final m in _urlOrEmail.allMatches(text)) {
    var s = m[0]!;
    if (s.contains('@') && !s.contains('/') && !s.toLowerCase().startsWith('www.')) {
      out.add((start: m.start, end: m.end, url: 'mailto:$s'));
      continue;
    }
    s = _trimTrailing(s);
    if (s.length < 5) continue;
    final url = safeHref(s);
    if (url != null) out.add((start: m.start, end: m.start + s.length, url: url));
  }
  return out;
}

/// Drops trailing punctuation that is almost never part of a URL, keeping
/// balanced parentheses ("(see https://x.org/a_(b))").
String _trimTrailing(String s) {
  while (s.isNotEmpty) {
    final c = s[s.length - 1];
    if ('.,;:!?\'"*'.contains(c)) {
      s = s.substring(0, s.length - 1);
    } else if (c == ')' || c == ']' || c == '}') {
      final open = c == ')' ? '(' : (c == ']' ? '[' : '{');
      if (open.allMatches(s).length < c.allMatches(s).length) {
        s = s.substring(0, s.length - 1);
      } else {
        break;
      }
    } else if (c == '>') {
      s = s.substring(0, s.length - 1);
    } else {
      break;
    }
  }
  return s;
}
