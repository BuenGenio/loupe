// Names of bulk mail: telling identifiers that machines made (the List-Ids of
// bulk-mail services, per-campaign sender addresses) from names people chose,
// and the parts of a sender address that stay the same from one campaign to
// the next.

import 'dart:convert';

/// Hosts, and the endings of hosts, that bulk-mail services (ESPs) put in the
/// List-Ids and sender addresses they make: `spc.265094.4.sparkpostmail.com`,
/// `<hex>.123456.list-id.mcsv.net`, `111929.broadcast`, `7234567_123.xt.local`.
final _espHost = RegExp(
  r'\.('
  r'sparkpostmail\.com|mcsv\.net|mcdlv\.net|rsgsv\.net|list-manage\d*\.com|mailchimpapp\.net|'
  r'(ct\.|wl\.)?sendgrid\.net|xt\.local|exacttarget\.com|sendsay(\.[a-z]{2,})?|broadcast|'
  r'mailgun\.(org|net)|mandrillapp\.com|createsend\d*\.com|cmail\d+\.com|amazonses\.com|'
  r'hubspotemail\.net|hs-email\.[a-z.]+|klaviyomail\.com|mailerlite\.com|mlsend\.com|'
  r'sendinblue\.com|brevosend\.com|sendpulse\.[a-z]+|unisender\.[a-z]+|esputnik\.com|mindbox\.ru|'
  r'mailjet\.com|customeriomail\.com|mktomail\.com|pardot\.com|rsys\d*\.net|constantcontact\.com|'
  r'ccsend\.com|emarsys\.net|acemsd\.com|getresponse\.com|convertkit-mail\d*\.com'
  r')$',
);

/// `list-id.<anything>`: Mailchimp's and Constant Contact's List-Ids.
final _listIdLabel = RegExp(r'(^|\.)list-id\.');

/// Mailchimp's List-Id phrase: `cac06e6fcbbfef544827181d7mc list`.
final _mailchimpPhrase = RegExp(r'^[0-9a-f]{12,}mc list$');

final _hexRun = RegExp(r'[0-9a-f]{12,}', caseSensitive: false);
final _base64ish = RegExp(r'^[A-Za-z0-9+/_-]{8,}={0,2}$');
final _digit = RegExp(r'\d');
final _letter = RegExp(r'\p{L}', unicode: true);
final _space = RegExp(r'\s');
final _longNumber = RegExp(r'^\d{5,}$');

/// Whether [value] looks made by a machine rather than chosen by a person,
/// so it can't name anything: empty; a bulk-mail service's identifier
/// (`spc.265094.4.sparkpostmail.com`, `*.mcsv.net`, `*.list-manage.com`,
/// `*.ct.sendgrid.net`, `*.broadcast`, `*.sendsay`, `<hex>mc list`…); without
/// a letter (`1175803732`, `5186308-24050-40`); a run of at least 12 hex
/// digits (`cac06e6fcbbfef54…`, UUIDs); base64 (`NTE4NjMwOC0yNDA1MC00MA==`);
/// or, as one word, a number of five digits or more between dots or dashes
/// (`list-12345678`), or mostly digits.
///
/// Phrases (`Kestrel developers`), brands (`HSBC`, `1Password`), and list
/// addresses or host names people chose (`dev.lists.example.org`) aren't.
bool looksMachineMade(String value) {
  final s = value.trim();
  if (s.isEmpty) return true;
  final lower = s.toLowerCase();
  if (_espHost.hasMatch(lower) || _listIdLabel.hasMatch(lower) || _mailchimpPhrase.hasMatch(lower)) return true;
  final hasLetter = _letter.hasMatch(s);
  // Digits, separators and symbols only.
  if (!hasLetter) return true;
  // A long run of hex digits with a digit in it (words have no digits).
  if (_hexRun.allMatches(s).any((m) => _digit.hasMatch(m[0]!))) return true;
  if (_space.hasMatch(s)) return false;
  // One word from here on.
  if (_base64ish.hasMatch(s) && _isBase64(s)) return true;
  if (s.split(RegExp(r'[._\-+:/#]')).any(_longNumber.hasMatch)) return true;
  final digits = _digit.allMatches(s).length;
  final alnum = RegExp(r'[\p{L}\d]', unicode: true).allMatches(s).length;
  return digits >= 5 && digits * 10 >= alnum * 4;
}

/// Base64 that people wouldn't write: padded (`…==`), case flipping all the
/// way through (`MTEyNzQxMzMtODAtNQ`), or long and decoding to plain text.
bool _isBase64(String s) {
  if (s.endsWith('=')) return true;
  var flips = 0;
  bool? upper;
  for (final c in s.runes) {
    final ch = String.fromCharCode(c);
    final isUpper = ch != ch.toLowerCase();
    final isLower = ch != ch.toUpperCase();
    if (!isUpper && !isLower) continue;
    if (upper != null && upper != isUpper) flips++;
    upper = isUpper;
  }
  if (flips >= 6 && flips * 2 >= s.length) return true;
  if (s.length < 12) return false;
  try {
    final padded = s.replaceAll('-', '+').replaceAll('_', '/').padRight((s.length + 3) ~/ 4 * 4, '=');
    final bytes = base64.decode(padded);
    return bytes.length >= 6 && bytes.every((b) => b >= 0x20 && b < 0x7f);
  } on FormatException {
    return false;
  }
}

/// [value] trimmed, when it can name something: not empty, not an address,
/// not [looksMachineMade]. Else null.
String? humanName(String? value) {
  final s = value?.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (s == null || s.isEmpty || s.contains('@') || looksMachineMade(s)) return null;
  return s;
}

/// Public suffixes of two labels, under which a domain is registered with
/// three (`hsbc.co.uk`). A short list of the common ones, not the whole
/// Public Suffix List: it only decides which part of a host stays the same.
const _twoLabelSuffixes = {
  'co.uk', 'org.uk', 'me.uk', 'ltd.uk', 'plc.uk', 'net.uk', 'ac.uk', 'gov.uk', 'nhs.uk', //
  'com.au', 'net.au', 'org.au', 'edu.au', 'gov.au', 'id.au',
  'co.nz', 'org.nz', 'net.nz', 'govt.nz', 'ac.nz',
  'co.jp', 'ne.jp', 'or.jp', 'ac.jp', 'go.jp',
  'co.kr', 'or.kr', 'ne.kr',
  'co.za', 'co.in', 'net.in', 'org.in', 'co.id', 'co.il', 'co.th', 'co.ke',
  'com.br', 'net.br', 'org.br', 'gov.br', 'com.cn', 'net.cn', 'org.cn', 'gov.cn', 'edu.cn',
  'com.hk', 'com.tw', 'com.sg', 'com.my', 'com.ph', 'com.vn', 'com.tr', 'com.ua', 'com.ar',
  'com.mx', 'com.co', 'com.pe', 'com.eg', 'com.sa', 'com.pk', 'com.ng', 'com.bd',
  'msk.ru', 'spb.ru', 'com.ru', 'org.ru', 'net.ru',
};

/// The part of [host] its owner registered: `linear.app` of
/// `mail.linear.app`, `hsbc.co.uk` of `news.hsbc.co.uk`. Lower-cased.
String registrableDomainOf(String host) {
  final labels = host.trim().toLowerCase().replaceAll(RegExp(r'\.+$'), '').split('.');
  if (labels.length <= 2) return labels.join('.');
  final lastTwo = labels.sublist(labels.length - 2).join('.');
  final keep = _twoLabelSuffixes.contains(lastTwo) ? 3 : 2;
  return labels.sublist(labels.length - keep).join('.');
}

/// A sender address as it groups newsletters: trimmed, lower-cased, without
/// a `+tag` (`news+spring@shop.example` is `news@shop.example`).
String normalizeSenderAddress(String address) {
  final a = address.trim().toLowerCase();
  final at = a.lastIndexOf('@');
  if (at <= 0) return a;
  final plus = a.indexOf('+');
  return plus > 0 && plus < at ? a.substring(0, plus) + a.substring(at) : a;
}

/// Whether bulk mail from [address] comes from a new address with every
/// campaign: its local part, or a label of its host below the registered
/// domain, looks machine-made (`5186308-24050-40@…`, `reply-fec01672766d…@…`,
/// `news@em-123456.shop.example`), or carries a VERP `=`.
bool isPerCampaignAddress(String address) {
  final a = normalizeSenderAddress(address);
  final at = a.lastIndexOf('@');
  if (at <= 0) return false;
  final local = a.substring(0, at);
  if (local.contains('=') || RegExp(r'\d{6,}').hasMatch(local) || looksMachineMade(local)) return true;
  final host = a.substring(at + 1);
  final registered = registrableDomainOf(host);
  if (host.length <= registered.length) return false;
  final sub = host.substring(0, host.length - registered.length - 1);
  return sub.split('.').any((l) => RegExp(r'\d{5,}').hasMatch(l) || _hexRun.hasMatch(l));
}
