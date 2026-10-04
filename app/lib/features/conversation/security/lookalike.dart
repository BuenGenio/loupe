// Look-alike sender domains: a name that imitates a well-known brand's or
// the user's own domain ("paypa1.com", "northwlnd.example",
// "paypal-secure.com"). Pure Dart.

import 'package:readable/readable.dart' show inspectHost, latinSkeleton, registrableDomain;

/// A brand often imitated in phishing, and the domains it really sends from.
final class Brand {
  const Brand(this.name, this.domains);
  final String name;

  /// Registrable domains; the first one names the brand in explanations.
  final List<String> domains;
}

/// Brands phishing imitates most. Small on purpose: a look-alike check
/// against thousands of names would flag ordinary companies.
const wellKnownBrands = [
  Brand('PayPal', ['paypal.com', 'paypal.me']),
  Brand('Apple', ['apple.com', 'icloud.com', 'me.com', 'mac.com']),
  Brand('Microsoft', [
    'microsoft.com',
    'microsoftonline.com',
    'office.com',
    'office365.com',
    'outlook.com',
    'live.com',
    'hotmail.com',
    'sharepoint.com',
    'onmicrosoft.com',
  ]),
  Brand('Google', ['google.com', 'gmail.com', 'googlemail.com', 'youtube.com']),
  Brand('Amazon', ['amazon.com', 'amazon.co.uk', 'amazon.de', 'amazon.fr', 'amazon.es', 'amazon.it', 'amazonses.com']),
  Brand('Netflix', ['netflix.com']),
  Brand('Facebook', ['facebook.com', 'facebookmail.com', 'meta.com']),
  Brand('Instagram', ['instagram.com']),
  Brand('WhatsApp', ['whatsapp.com']),
  Brand('LinkedIn', ['linkedin.com']),
  Brand('Dropbox', ['dropbox.com', 'dropboxmail.com']),
  Brand('DocuSign', ['docusign.com', 'docusign.net']),
  Brand('Adobe', ['adobe.com']),
  Brand('DHL', ['dhl.com', 'dhl.de']),
  Brand('FedEx', ['fedex.com']),
  Brand('USPS', ['usps.com']),
  Brand('Royal Mail', ['royalmail.com']),
  Brand('Chase', ['chase.com']),
  Brand('Wells Fargo', ['wellsfargo.com']),
  Brand('Bank of America', ['bankofamerica.com']),
  Brand('Citibank', ['citibank.com', 'citi.com']),
  Brand('HSBC', ['hsbc.com', 'hsbc.co.uk']),
  Brand('Barclays', ['barclays.com', 'barclays.co.uk']),
  Brand('American Express', ['americanexpress.com', 'aexp.com']),
  Brand('Mastercard', ['mastercard.com']),
  Brand('eBay', ['ebay.com']),
  Brand('Coinbase', ['coinbase.com']),
  Brand('Binance', ['binance.com']),
  Brand('Steam', ['steampowered.com', 'steamcommunity.com']),
  Brand('Spotify', ['spotify.com']),
  Brand('Yahoo', ['yahoo.com']),
  Brand('Zoom', ['zoom.us']),
  Brand('Slack', ['slack.com']),
  Brand('GitHub', ['github.com']),
  Brand('Booking.com', ['booking.com']),
  Brand('Airbnb', ['airbnb.com']),
  Brand('Walmart', ['walmart.com']),
];

/// Free mail providers: the user's address there says nothing about whom a
/// look-alike would imitate (they're covered as brands where it matters).
const freeMailDomains = {
  'gmail.com',
  'googlemail.com',
  'outlook.com',
  'hotmail.com',
  'live.com',
  'msn.com',
  'yahoo.com',
  'icloud.com',
  'me.com',
  'mac.com',
  'aol.com',
  'proton.me',
  'protonmail.com',
  'gmx.de',
  'gmx.net',
  'web.de',
  'mail.com',
  'yandex.ru',
  'zoho.com',
  'fastmail.com',
  'hey.com',
};

/// The name part of a registrable domain: "paypal" for "paypal.com" and
/// "www.paypal.co.uk".
String labelOf(String domain) => registrableDomain(domain).split('.').first;

/// A domain imitating another one.
final class Lookalike {
  const Lookalike({required this.imitates, required this.name, required this.strong, this.own = false});

  /// The real domain it imitates ("paypal.com").
  final String imitates;

  /// Who that is ("PayPal", or the domain for the user's own).
  final String name;

  /// A near-identical spelling (swapped letters, look-alike characters, one
  /// typo). Otherwise the name only appears in it ("paypal-secure.com").
  final bool strong;

  /// It imitates one of the user's own domains.
  final bool own;

  @override
  String toString() => 'Lookalike($imitates, strong: $strong, own: $own)';
}

/// Words phishing domains add to a brand ("paypal-secure", "applesupport").
const _affixes = {
  'secure',
  'security',
  'support',
  'login',
  'signin',
  'account',
  'accounts',
  'verify',
  'verification',
  'service',
  'services',
  'help',
  'helpdesk',
  'billing',
  'update',
  'team',
  'mail',
  'alert',
  'alerts',
  'notice',
  'info',
  'online',
  'id',
  'auth',
  'pay',
  'payment',
  'payments',
  'refund',
  'center',
  'centre',
  'portal',
  'web',
  'app',
  'customer',
  'review',
  'confirm',
  'official',
};

/// Whether [domain] (a sender's) imitates a well-known brand or one of
/// [ownDomains]; null when it doesn't, or when it is the real thing.
Lookalike? findLookalike(
  String domain, {
  Iterable<String> ownDomains = const [],
  List<Brand> brands = wellKnownBrands,
}) {
  final host = inspectHost(domain);
  if (host.ipAddress || host.host.isEmpty) return null;
  final display = host.display;
  final reg = registrableDomain(display);
  final candidates = [
    for (final d in ownDomains)
      if (!freeMailDomains.contains(registrableDomain(d))) Brand(registrableDomain(d), [registrableDomain(d)]),
    ...brands,
  ];
  // The real thing (or a subdomain of it) is never a look-alike.
  for (final b in candidates) {
    for (final d in b.domains) {
      if (reg == d || display == d || display.endsWith('.$d')) return null;
    }
  }
  final label = reg.split('.').first;
  final skeleton = _skeleton(label);
  final words = label.split(RegExp('[-_]')).where((w) => w.isNotEmpty).toList();
  final subLabels = display.substring(0, display.length - reg.length).split('.').where((l) => l.isNotEmpty).toSet();
  Lookalike? weak;
  for (final (i, b) in candidates.indexed) {
    final own = i < candidates.length - brands.length;
    for (final (j, d) in b.domains.indexed) {
      final real = labelOf(d);
      // The same name under another TLD is usually the brand's own country site.
      if (real.length < 3 || label == real) continue;
      final realSkeleton = _skeleton(real);
      final strong =
          skeleton == realSkeleton ||
          (real.length >= 5 && _typo(label, real)) ||
          // A disguised brand next to other words: "amaz0n-mail".
          words.any((w) => w != real && w.length >= 3 && _skeleton(w) == realSkeleton);
      if (strong) return Lookalike(imitates: d, name: b.name, strong: true, own: own);
      // Only the brand's main name counts inside a longer domain: other
      // domains are words like "office" and "live".
      if (j == 0 && weak == null && real.length >= 3 && (_contains(label, real) || subLabels.contains(real))) {
        weak = Lookalike(imitates: d, name: b.name, strong: false, own: own);
      }
    }
  }
  return weak;
}

/// [label] combines [brand] with a typical phishing word: "paypal-secure",
/// "secure-paypal-login", "applesupport". Other combinations ("apple-farm",
/// "paypal-community") are left alone.
bool _contains(String label, String brand) {
  final tokens = label.split(RegExp(r'[-_\d]+')).where((t) => t.isNotEmpty).toList();
  if (tokens.contains(brand)) return tokens.any(_affixes.contains);
  final String rest;
  if (label.startsWith(brand)) {
    rest = label.substring(brand.length);
  } else if (label.endsWith(brand)) {
    rest = label.substring(0, label.length - brand.length);
  } else {
    return false;
  }
  return _affixes.contains(rest.replaceAll('-', ''));
}

/// Characters that pass for others in a domain, folded: digits for letters,
/// "rn" for "m", Cyrillic and Greek look-alikes for Latin, i for l.
String _skeleton(String label) {
  var s = latinSkeleton(label).replaceAll(RegExp('[-_.]'), '');
  s = s.replaceAll('rn', 'm').replaceAll('vv', 'w').replaceAll('cl', 'd');
  const map = {
    '0': 'o',
    '1': 'l',
    'i': 'l',
    '|': 'l',
    '!': 'l',
    '3': 'e',
    '5': 's',
    r'$': 's',
    '4': 'a',
    '@': 'a',
    '8': 'b',
  };
  return s.split('').map((c) => map[c] ?? c).join();
}

/// [a] is [b] with a typical typo: two neighbours swapped ("micorsoft") or
/// a doubled or undoubled letter ("paypall", "gogle"). Other one-letter
/// changes make real words ("booking", "cooking") and don't count.
bool _typo(String a, String b) {
  if (a.length == b.length) {
    final diff = [
      for (var i = 0; i < a.length; i++)
        if (a[i] != b[i]) i,
    ];
    return diff.length == 2 && diff[1] == diff[0] + 1 && a[diff[0]] == b[diff[1]] && a[diff[1]] == b[diff[0]];
  }
  if ((a.length - b.length).abs() != 1) return false;
  final long = a.length > b.length ? a : b;
  final short = a.length > b.length ? b : a;
  var i = 0;
  while (i < short.length && long[i] == short[i]) {
    i++;
  }
  if (long.substring(0, i) + long.substring(i + 1) != short) return false;
  return (i > 0 && long[i] == long[i - 1]) || (i + 1 < long.length && long[i] == long[i + 1]);
}
