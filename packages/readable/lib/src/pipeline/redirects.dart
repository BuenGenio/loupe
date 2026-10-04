// Click-tracking redirects and link-protection wrappers: recognise them and
// recover the real destination. Purely syntactic: nothing is ever fetched.

import 'dart:convert';

/// A link that goes through one or more redirects before its destination.
final class Redirect {
  const Redirect({required this.services, this.target, this.hidden = false, this.hostHint, this.known = true});

  /// Who redirects, outermost first ("Outlook Safe Links", "Google"). A
  /// generic `?url=` wrapper is named by its host.
  final List<String> services;

  /// The innermost URL recovered (absolute http or https), or null when the
  /// outermost wrapper doesn't carry it. When [hidden], this is the link of
  /// the tracker that hides the destination.
  final String? target;

  /// The real destination is hidden behind an opaque click tracker
  /// (Mailchimp, HubSpot…): only the tracker's server knows it.
  final bool hidden;

  /// The destination's host when a wrapper names it without the full URL
  /// (Mimecast's `domain=`).
  final String? hostHint;

  /// Every wrapper is a recognised service; false when one is only a generic
  /// `?url=` parameter, which is probably, not certainly, a redirect.
  final bool known;

  /// The outermost service.
  String get service => services.first;

  /// Some wrapper in the chain records clicks for the sender (as opposed to
  /// the recipient's own link protection, like Safe Links).
  bool get tracking => services.any(_trackingServices.contains) || !known;

  /// The wrappers that record clicks for the sender: every service but the
  /// recipient's link protection.
  List<String> get trackingServices => [
    for (final s in services)
      if (!_protectionServices.contains(s)) s,
  ];

  /// Some wrapper is the recipient's link protection (Safe Links,
  /// Proofpoint, Mimecast…), which checks the destination when clicked.
  bool get protection => services.any(_protectionServices.contains);

  /// The destination is known: [target] is where the link ends up.
  bool get resolved => target != null && !hidden;

  /// Opening [direct] instead of the link is safe to do without asking: a
  /// known click tracker with a known destination, and no link protection
  /// of the recipient's (Safe Links…) to bypass.
  bool get skippable => known && resolved && tracking && !protection;

  /// [target] without tracking parameters, for opening the destination
  /// directly. Null unless [resolved].
  String? get direct => resolved ? stripTrackingParameters(target!) : null;

  /// The host the link ends up on, if known.
  String? get destinationHost {
    if (resolved) return Uri.tryParse(target!)?.host;
    return hostHint;
  }

  @override
  String toString() =>
      'Redirect(${services.join(' > ')}${target == null ? '' : ' -> $target'}${hidden ? ' (hidden)' : ''}'
      '${hostHint == null ? '' : ' host $hostHint'}${known ? '' : ' generic'})';
}

const _mailchimp = 'Mailchimp';
const _sendgrid = 'SendGrid';
const _hubspot = 'HubSpot';
const _ses = 'Amazon SES';
const _mandrill = 'Mandrill';
const _klaviyo = 'Klaviyo';
const _google = 'Google';
const _facebook = 'Facebook';
const _instagram = 'Instagram';
const _linkedin = 'LinkedIn';
const _youtube = 'YouTube';
const _safeLinks = 'Outlook Safe Links';
const _proofpoint = 'Proofpoint URL Defense';
const _mimecast = 'Mimecast';
const _barracuda = 'Barracuda Link Protection';
const _symantec = 'Symantec Click-time Protection';
const _trendMicro = 'Trend Micro Click-time Protection';

const _trackingServices = {
  'ActiveCampaign',
  'Campaign Monitor',
  'Constant Contact',
  'AWeber',
  'ConvertKit',
  'Substack',
  'Mailjet',
  'Brevo',
  'Emma',
  'Salesforce Marketing Cloud',
  'Postmark',
  'MailerLite',
  'Iterable',
  'beehiiv',
  'Zoho Campaigns',
  'Mailgun',
  _mailchimp,
  _sendgrid,
  _hubspot,
  _ses,
  _mandrill,
  _klaviyo,
  _google,
  _facebook,
  _instagram,
  _linkedin,
  _youtube,
};
const _protectionServices = {_safeLinks, _proofpoint, _mimecast, _barracuda, _symantec, _trendMicro};

/// How deep nested wrappers are followed (Safe Links around Google around…).
const _maxDepth = 6;

/// Unwraps [url] if it is a known click-tracking redirect, a link-protection
/// wrapper or a generic redirect with an absolute `?url=`; null otherwise.
/// Nested wrappers are followed to the innermost URL.
Redirect? unwrapRedirect(String url) {
  final services = <String>[];
  var current = url;
  String? target;
  String? hint;
  var hidden = false;
  var known = true;
  for (var depth = 0; depth < _maxDepth; depth++) {
    final step = _step(current);
    if (step == null) break;
    services.add(step.service);
    if (!step.known) known = false;
    hint = step.hint ?? hint;
    final next = step.target;
    if (next == null) {
      // An opaque tracker: the destination stays on its server.
      hidden = true;
      target = depth == 0 ? null : current;
      break;
    }
    if (next == current) break;
    target = current = next;
  }
  if (services.isEmpty) return null;
  return Redirect(services: services, target: target, hidden: hidden, hostHint: hint, known: known);
}

typedef _Step = ({String service, String? target, String? hint, bool known});

_Step _found(String service, String? target, {String? hint}) =>
    (service: service, target: target, hint: hint, known: true);

_Step? _step(String url) {
  final uri = Uri.tryParse(url.trim());
  if (uri == null) return null;
  final scheme = uri.scheme.toLowerCase();
  if (scheme != 'http' && scheme != 'https') return null;
  final host = uri.host.toLowerCase();
  if (host.isEmpty) return null;
  final path = uri.path;
  final lowerPath = path.toLowerCase();
  final params = _params(uri.query);

  // Link protection (the recipient's mail filter rewrote the link).
  if (_isUnder(host, 'safelinks.protection.outlook.com') || _isUnder(host, 'safelinks.protection.office365.us')) {
    return _found(_safeLinks, _absolute(params['url']));
  }
  if (host == 'urldefense.com' || _isUnder(host, 'urldefense.proofpoint.com') || host.endsWith('.urldefense.com')) {
    return _found(_proofpoint, _proofpointTarget(url, lowerPath, params));
  }
  if (RegExp(r'^protect(-[a-z0-9]+)?\.mimecast\.com$').hasMatch(host) || _isUnder(host, 'mimecastprotect.com')) {
    return _found(_mimecast, _absolute(params['url']), hint: _domainHint(params['domain']));
  }
  if (host == 'linkprotect.cudasvc.com') return _found(_barracuda, _absolute(params['a'] ?? params['url']));
  if (_isUnder(host, 'clicktime.symantec.com')) return _found(_symantec, _absolute(params['u'] ?? params['url']));
  if (_isUnder(host, 'trendmicro.com') && lowerPath.contains('/clicktime/')) {
    return _found(_trendMicro, _absolute(params['url']));
  }

  // Click trackers of mailing services.
  if (_isUnder(host, 'list-manage.com') && lowerPath.startsWith('/track/click')) {
    return _found(_mailchimp, _absolute(params['url']));
  }
  if ((lowerPath == '/ls/click' || lowerPath == '/wf/click') &&
      (params.containsKey('upn') || _isUnder(host, 'sendgrid.net'))) {
    final service = _isUnder(host, 'klclick.com') || _isUnder(host, 'klclick1.com') ? _klaviyo : _sendgrid;
    return _found(service, _absolute(params['url']) ?? _fromBase64(params['upn']));
  }
  if (_isHubSpot(host, lowerPath)) return _found(_hubspot, _absolute(params['url']));
  if (host.endsWith('.awstrack.me') && path.startsWith('/L0/')) {
    final rest = url.substring(url.indexOf('/L0/') + 4);
    final end = rest.indexOf('/');
    return _found(_ses, _absolute(end < 0 ? rest : rest.substring(0, end)));
  }
  if (host == 'mandrillapp.com' && lowerPath.startsWith('/track/click')) {
    final segments = uri.pathSegments;
    final last = segments.length > 3 ? segments.last : null;
    return _found(_mandrill, _fromBase64(params['p']), hint: _domainHint(last));
  }

  // Other mailing services' click tracking: the destination stays on their
  // servers.
  if (path.length > 1) {
    for (final (domain, service, prefix) in _opaqueTrackers) {
      if (_isUnder(host, domain) && lowerPath.startsWith(prefix)) return _found(service, null);
    }
  }

  // Redirects of big platforms.
  if (_isGoogle(host)) {
    if (lowerPath == '/url') return _found(_google, _absolute(params['q'] ?? params['url']));
    if (lowerPath.startsWith('/amp/s/')) return _found(_google, _absolute('https://${path.substring(7)}'));
  }
  if (const {'l.facebook.com', 'lm.facebook.com', 'l.messenger.com'}.contains(host) && lowerPath == '/l.php') {
    return _found(_facebook, _absolute(params['u']));
  }
  if (host == 'l.instagram.com') return _found(_instagram, _absolute(params['u']));
  if (_isUnder(host, 'linkedin.com')) {
    if (lowerPath.startsWith('/redir/')) return _found(_linkedin, _absolute(params['url']));
    if (lowerPath.startsWith('/slink')) return _found(_linkedin, null);
  }
  if (_isUnder(host, 'youtube.com') && lowerPath == '/redirect') {
    return _found(_youtube, _absolute(params['q'] ?? params['url']));
  }
  if (host == 'slack-redir.net' && lowerPath == '/link') return _found('Slack', _absolute(params['url']));
  if (_isUnder(host, 'steamcommunity.com') && lowerPath.startsWith('/linkfilter')) {
    return _found('Steam', _absolute(params['url'] ?? params['u']));
  }
  if (host == 'duckduckgo.com' && lowerPath == '/l/') return _found('DuckDuckGo', _absolute(params['uddg']));
  if ((host == 'vk.com' || host == 'm.vk.com') && lowerPath == '/away.php') {
    return _found('VK', _absolute(params['to']));
  }

  // A generic redirect: a parameter holding an absolute http(s) URL. Share
  // buttons ("sharer.php?u=…") carry one too but open the sharing page.
  if (RegExp(r'share|intent|bookmark|pin/create').hasMatch(lowerPath)) return null;
  for (final name in _genericParameters) {
    final target = _absolute(params[name]);
    if (target != null && Uri.tryParse(target)?.host.toLowerCase() != host) {
      return (service: host, target: target, hint: null, known: false);
    }
  }
  return null;
}

/// Click-tracking domains of mailing services that don't carry the
/// destination: (domain, service, path prefix).
const _opaqueTrackers = [
  ('acemlna.com', 'ActiveCampaign', '/'),
  ('acemlnb.com', 'ActiveCampaign', '/'),
  ('acemlnc.com', 'ActiveCampaign', '/'),
  ('acemlnd.com', 'ActiveCampaign', '/'),
  ('createsend1.com', 'Campaign Monitor', '/t/'),
  ('cmail19.com', 'Campaign Monitor', '/t/'),
  ('cmail20.com', 'Campaign Monitor', '/t/'),
  ('rs6.net', 'Constant Contact', '/tn.jsp'),
  ('clicks.aweber.com', 'AWeber', '/'),
  ('convertkit-mail.com', 'ConvertKit', '/'),
  ('convertkit-mail2.com', 'ConvertKit', '/'),
  ('substack.com', 'Substack', '/redirect/'),
  ('mjt.lu', 'Mailjet', '/lnk/'),
  ('sendibt3.com', 'Brevo', '/'),
  ('sendibt2.com', 'Brevo', '/'),
  ('r.sp1-brevo.net', 'Brevo', '/'),
  ('t.e2ma.net', 'Emma', '/click/'),
  ('cl.exct.net', 'Salesforce Marketing Cloud', '/'),
  ('click.pstmrk.it', 'Postmark', '/'),
  ('click.mlsend.com', 'MailerLite', '/'),
  ('links.iterable.com', 'Iterable', '/'),
  ('link.mail.beehiiv.com', 'beehiiv', '/'),
  ('maillist-manage.com', 'Zoho Campaigns', '/click'),
  ('email.mg.mailgun.net', 'Mailgun', '/c/'),
];

/// Parameter names that usually carry a redirect's destination.
const _genericParameters = [
  'url',
  'u',
  'redirect',
  'redirect_url',
  'redirect_to',
  'redirecturl',
  'redir',
  'dest',
  'destination',
  'target',
  'goto',
  'link',
];

bool _isUnder(String host, String domain) => host == domain || host.endsWith('.$domain');

bool _isGoogle(String host) => RegExp(r'^(www\.)?google\.(com|[a-z]{2}|co\.[a-z]{2}|com\.[a-z]{2})$').hasMatch(host);

bool _isHubSpot(String host, String path) {
  for (final d in const ['hubspotlinks.com', 'hubspotlinksfree.com', 'hs-sales-engage.com', 'hubspotemail.net']) {
    if (_isUnder(host, d)) return true;
  }
  if (host == 'cta-redirect.hubspot.com') return true;
  // HubSpot Sales (formerly Sidekick): t.sidekickopen06.com, t.signaux.com.
  if (RegExp(r'^t\.(sidekickopen\d*|signaux|senal)\.com$').hasMatch(host)) return true;
  return false;
}

/// Query parameters by lower-cased name. Values are percent-decoded but `+`
/// is kept: in a URL value it is far more often a literal plus than a space.
Map<String, String> _params(String query) {
  final out = <String, String>{};
  if (query.isEmpty) return out;
  for (final part in query.split('&')) {
    if (part.isEmpty) continue;
    final eq = part.indexOf('=');
    final name = _decode(eq < 0 ? part : part.substring(0, eq)).toLowerCase();
    final value = eq < 0 ? '' : _decode(part.substring(eq + 1));
    out.putIfAbsent(name, () => value);
  }
  return out;
}

String _decode(String s) {
  try {
    return Uri.decodeComponent(s);
  } on ArgumentError {
    return s;
  } on FormatException {
    return s;
  }
}

final _encodedScheme = RegExp(r'^https?(%3a|:%2f)', caseSensitive: false);
final _absoluteHttp = RegExp(r'^https?://', caseSensitive: false);

/// [value] as an absolute http(s) URL with a host, decoding up to three
/// extra layers of percent-encoding; null if it isn't one.
String? _absolute(String? value) {
  if (value == null) return null;
  var v = value.trim();
  for (var i = 0; i < 3 && _encodedScheme.hasMatch(v); i++) {
    v = _decode(v);
  }
  if (v.startsWith('//')) v = 'https:$v';
  if (!_absoluteHttp.hasMatch(v)) return null;
  v = v.replaceAll(' ', '%20');
  final uri = Uri.tryParse(v);
  if (uri == null || uri.host.isEmpty) return null;
  return v;
}

String? _domainHint(String? value) {
  final v = value?.trim().toLowerCase();
  if (v == null || v.isEmpty) return null;
  return RegExp(r'^[a-z0-9.-]+\.[a-z0-9-]{2,}$').hasMatch(v) ? v : null;
}

final _urlInText = RegExp(r'''https?://[^\s"'<>\\]+''', caseSensitive: false);

/// The first http(s) URL in the base64 (or base64url) decoding of [value]:
/// some trackers carry the destination base64-encoded, sometimes inside
/// JSON.
String? _fromBase64(String? value) {
  if (value == null || value.length < 8) return null;
  var v = value.trim().replaceAll('-', '+').replaceAll('_', '/');
  final dot = v.indexOf('.');
  // Versioned tokens ("u001.<base64>").
  if (dot > 0 && dot < 8) v = v.substring(dot + 1);
  v = v.replaceAll(RegExp(r'[^A-Za-z0-9+/]'), '');
  if (v.length % 4 != 0) v = v.padRight(v.length + 4 - v.length % 4, '=');
  final String text;
  try {
    text = utf8.decode(base64.decode(v), allowMalformed: true);
  } on FormatException {
    return null;
  }
  // JSON escapes slashes ("https:\/\/…"), sometimes twice.
  final m = _urlInText.firstMatch(text.replaceAll(r'\', ''));
  return m == null ? null : _absolute(m[0]!);
}

// Proofpoint URL Defense -------------------------------------------------------

String? _proofpointTarget(String url, String path, Map<String, String> params) {
  if (path.startsWith('/v3/')) return _proofpointV3(url);
  final u = params['u'];
  if (u == null) return null;
  if (path.startsWith('/v2/')) {
    // "-" escapes like "%", "_" stands for "/".
    final percent = u.replaceAll('-', '%').replaceAll('_', '/');
    return _absolute(_htmlUnescape(_decode(percent)));
  }
  return _absolute(u);
}

final _v3 = RegExp(r'/v3/__(.+?)__;([^!]*)!');
final _v3Token = RegExp(r'\*(\*.)?');
const _v3RunAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';

/// v3 keeps the URL readable between `__` markers; characters it couldn't
/// keep are `*` (one) or `**X` (a run) and come, in order, from a base64url
/// string after the `;`.
String? _proofpointV3(String url) {
  final m = _v3.firstMatch(url);
  if (m == null) return null;
  final encoded = _decode(m[1]!);
  List<int> replacements;
  try {
    var b = m[2]!.replaceAll('-', '+').replaceAll('_', '/');
    if (b.length % 4 != 0) b = b.padRight(b.length + 4 - b.length % 4, '=');
    replacements = b.isEmpty ? const [] : utf8.decode(base64.decode(b), allowMalformed: true).runes.toList();
  } on FormatException {
    return null;
  }
  var next = 0;
  final out = StringBuffer();
  var pos = 0;
  for (final t in _v3Token.allMatches(encoded)) {
    out.write(encoded.substring(pos, t.start));
    final run = t[1] == null ? 1 : _v3RunAlphabet.indexOf(t[1]![1]) + 2;
    if (run < 1 || next + run > replacements.length) return null;
    out.write(String.fromCharCodes(replacements.sublist(next, next + run)));
    next += run;
    pos = t.end;
  }
  out.write(encoded.substring(pos));
  return _absolute(out.toString());
}

String _htmlUnescape(String s) => s
    .replaceAll('&amp;', '&')
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&quot;', '"')
    .replaceAll('&#39;', "'");

// Tracking parameters ----------------------------------------------------------

const _trackingParameters = {
  'mc_cid',
  'mc_eid',
  '_hsenc',
  '_hsmi',
  '__hstc',
  '__hssc',
  '__hsfp',
  'hsctatracking',
  'fbclid',
  'gclid',
  'gclsrc',
  'dclid',
  'msclkid',
  'yclid',
  'twclid',
  'ttclid',
  'li_fat_id',
  'igshid',
  'mkt_tok',
  'oly_anon_id',
  'oly_enc_id',
  'vero_id',
  'vero_conv',
  '_ke',
  'ck_subscriber_id',
  'elqtrackid',
  'elqtrack',
  'sc_cid',
  's_cid',
  'trk',
  'trkcampaign',
  'ss_source',
  'ss_campaign_id',
  'wickedid',
  'rb_clickid',
  '_branch_match_id',
};

bool _isTrackingParameter(String name) {
  final n = name.toLowerCase();
  return n.startsWith('utm_') || _trackingParameters.contains(n);
}

/// [url] without parameters that only identify the click (utm_*, mc_eid,
/// _hsenc, fbclid, gclid…). Everything else is kept as written.
String stripTrackingParameters(String url) {
  final q = url.indexOf('?');
  if (q < 0) return url;
  final hash = url.indexOf('#', q);
  final query = url.substring(q + 1, hash < 0 ? url.length : hash);
  final fragment = hash < 0 ? '' : url.substring(hash);
  final kept = [
    for (final part in query.split('&'))
      if (part.isNotEmpty && !_isTrackingParameter(_decode(part.split('=').first))) part,
  ];
  return '${url.substring(0, q)}${kept.isEmpty ? '' : '?${kept.join('&')}'}$fragment';
}
