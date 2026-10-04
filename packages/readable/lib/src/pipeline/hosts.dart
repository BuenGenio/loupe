// Host names at a glance: international (punycode) names decoded, scripts
// per label, IDN homographs (mixed alphabets, look-alike letters) and
// IP-literal hosts. Pure Dart; used by the link analysis and by the app's
// sender checks.

/// What a host name reveals.
final class HostInfo {
  const HostInfo({
    required this.host,
    required this.display,
    this.ipAddress = false,
    this.international = false,
    this.homograph = false,
    this.looksLike,
    this.scripts = const {},
  });

  /// The host, lower-cased, as written (punycode stays punycode).
  final String host;

  /// The host in Unicode (punycode labels decoded).
  final String display;

  /// An IP address (v4 in any notation, or v6) instead of a name.
  final bool ipAddress;

  /// Has non-ASCII labels (written in Unicode or as `xn--` punycode).
  final bool international;

  /// A label mixes alphabets (Latin with Cyrillic, Greek…) or is written
  /// entirely in letters that imitate Latin ones: an IDN homograph.
  final bool homograph;

  /// For a homograph, the ASCII name it imitates ("apple.com"), if every
  /// look-alike letter could be mapped.
  final String? looksLike;

  /// The scripts of its letters ("Latin", "Cyrillic"…).
  final Set<String> scripts;
}

/// Inspects [host] (as found in a URL or an address; percent-encoded or
/// Unicode labels are fine).
HostInfo inspectHost(String host) {
  var h = host.trim().toLowerCase();
  if (h.contains('%')) {
    try {
      h = Uri.decodeComponent(h);
    } on ArgumentError {
      // Keep it as written.
    }
  }
  if (h.endsWith('.')) h = h.substring(0, h.length - 1);
  if (h.startsWith('[') && h.endsWith(']')) h = h.substring(1, h.length - 1);
  if (isIpLiteral(h)) return HostInfo(host: h, display: h, ipAddress: true);

  final labels = h.split('.');
  final decoded = <String>[];
  var international = false;
  for (final label in labels) {
    if (label.startsWith('xn--')) {
      international = true;
      decoded.add(decodePunycode(label.substring(4)) ?? label);
    } else {
      if (label.runes.any((r) => r > 0x7f)) international = true;
      decoded.add(label);
    }
  }
  final display = decoded.join('.');
  if (!international) return HostInfo(host: h, display: display, scripts: const {'Latin'});

  final scripts = <String>{};
  var homograph = false;
  final tldScripts = _scriptsOf(decoded.last);
  for (final label in decoded) {
    final s = _scriptsOf(label);
    scripts.addAll(s);
    if (_mixesConfusably(s)) homograph = true;
    // A whole label in Cyrillic (or Greek…) letters that all look Latin,
    // under a Latin TLD: "аррӏе.com".
    if (s.length == 1 && _confusableScripts.contains(s.first) && !tldScripts.contains(s.first)) {
      final letters = label.runes.where((r) => _scriptOf(r) != null);
      if (letters.isNotEmpty && letters.every(_latinLookAlikes.containsKey)) homograph = true;
    }
    // Latin look-alike letters outside basic Latin ("pɑypal": U+0251).
    if (s.length == 1 && s.first == 'Latin' && label.runes.any(_latinLookAlikes.containsKey)) {
      final skeleton = _skeleton(label);
      if (!skeleton.runes.any((r) => r > 0x7f)) homograph = true;
    }
  }
  String? looksLike;
  if (homograph) {
    final skeleton = decoded.map(_skeleton).join('.');
    if (!skeleton.runes.any((r) => r > 0x7f)) looksLike = skeleton;
  }
  return HostInfo(
    host: h,
    display: display,
    international: true,
    homograph: homograph,
    looksLike: looksLike,
    scripts: scripts,
  );
}

final _ipv4 = RegExp(r'^\d{1,3}(\.\d{1,3}){3}$');
final _numericLabel = RegExp(r'^(0x[0-9a-f]+|\d+)$');

/// True for IPv6 and for IPv4 in any notation browsers accept (dotted,
/// decimal `3232235777`, hex `0xc0a80001`, octal): no TLD is numeric.
bool isIpLiteral(String host) {
  final h = host.toLowerCase();
  if (h.contains(':')) return true;
  if (_ipv4.hasMatch(h)) return true;
  final last = h.split('.').last;
  return last.isNotEmpty && _numericLabel.hasMatch(last);
}

// Scripts ----------------------------------------------------------------------

/// Scripts with letters that pass for Latin ones.
const _confusableScripts = {'Cyrillic', 'Greek', 'Armenian', 'Cherokee', 'Georgian'};

/// Scripts that may mix with Latin in one label (Japanese, Chinese and
/// Korean names often contain Latin letters).
const _cjk = {'Han', 'Hiragana', 'Katakana', 'Hangul'};

bool _mixesConfusably(Set<String> scripts) {
  if (scripts.length < 2) return false;
  final rest = scripts.difference({'Latin', ..._cjk});
  if (rest.isEmpty) return false;
  // Latin plus anything but CJK, or two non-CJK scripts.
  return scripts.contains('Latin') || rest.length > 1 || scripts.intersection(_cjk).isNotEmpty;
}

Set<String> _scriptsOf(String label) => {for (final r in label.runes) ?_scriptOf(r)};

/// The script of a letter; null for digits, hyphens and other common
/// characters.
String? _scriptOf(int r) {
  if ((r >= 0x61 && r <= 0x7a) || (r >= 0x41 && r <= 0x5a)) return 'Latin';
  if (r < 0x80) return null;
  if ((r >= 0xc0 && r <= 0x2af && r != 0xd7 && r != 0xf7) || (r >= 0x1e00 && r <= 0x1eff)) return 'Latin';
  if ((r >= 0x370 && r <= 0x3ff) || (r >= 0x1f00 && r <= 0x1fff)) return 'Greek';
  if ((r >= 0x400 && r <= 0x52f) || (r >= 0x1c80 && r <= 0x1c8f) || (r >= 0x2de0 && r <= 0x2dff)) return 'Cyrillic';
  if (r >= 0xa640 && r <= 0xa69f) return 'Cyrillic';
  if (r >= 0x530 && r <= 0x58f) return 'Armenian';
  if (r >= 0x590 && r <= 0x5ff) return 'Hebrew';
  if ((r >= 0x600 && r <= 0x6ff) || (r >= 0x750 && r <= 0x77f) || (r >= 0x8a0 && r <= 0x8ff)) return 'Arabic';
  if (r >= 0x900 && r <= 0x97f) return 'Devanagari';
  if (r >= 0xe00 && r <= 0xe7f) return 'Thai';
  if (r >= 0x10a0 && r <= 0x10ff) return 'Georgian';
  if (r >= 0x13a0 && r <= 0x13ff) return 'Cherokee';
  if (r >= 0x3040 && r <= 0x309f) return 'Hiragana';
  if (r >= 0x30a0 && r <= 0x30ff) return 'Katakana';
  if ((r >= 0x4e00 && r <= 0x9fff) || (r >= 0x3400 && r <= 0x4dbf)) return 'Han';
  if ((r >= 0xac00 && r <= 0xd7af) || (r >= 0x1100 && r <= 0x11ff)) return 'Hangul';
  if (r == 0x30fc || r == 0x3005) return null;
  return 'Other';
}

/// Lower-case letters that pass for a Latin one, mapped to it. Only close
/// look-alikes: a Russian word in Cyrillic shouldn't read as a homograph.
const _latinLookAlikes = <int, String>{
  // Cyrillic
  0x430: 'a', 0x435: 'e', 0x43e: 'o', 0x440: 'p', 0x441: 'c', 0x443: 'y', 0x445: 'x', 0x455: 's', //
  0x456: 'i', 0x458: 'j', 0x4bb: 'h', 0x501: 'd', 0x51b: 'q', 0x51d: 'w', 0x4cf: 'l', 0x4af: 'y',
  0x433: 'r',
  // Greek
  0x3bf: 'o', 0x3b1: 'a', 0x3bd: 'v', 0x3c1: 'p', 0x3b9: 'i', 0x3ba: 'k', 0x3c5: 'u', 0x3c7: 'x', //
  0x3f2: 'c',
  // Armenian
  0x585: 'o', 0x57d: 'u', 0x581: 'g', 0x570: 'h', 0x578: 'n', 0x566: 'q',
  // Latin letters outside ASCII that pass for ASCII ones
  0x131: 'i', 0x237: 'j', 0x251: 'a', 0x261: 'g', 0x269: 'i',
};

String _skeleton(String label) =>
    String.fromCharCodes(label.runes.expand((r) => (_latinLookAlikes[r] ?? String.fromCharCode(r)).runes));

/// Maps look-alike letters (Cyrillic "а", Greek "ο", "ɑ"…) to the Latin
/// letters they imitate; other characters are kept.
String latinSkeleton(String text) => _skeleton(text.toLowerCase());

// Punycode (RFC 3492) -------------------------------------------------------------

const _base = 36, _tMin = 1, _tMax = 26, _skew = 38, _damp = 700, _initialBias = 72, _initialN = 128;

/// Decodes the punycode of one label without its `xn--` prefix; null if it
/// is malformed.
String? decodePunycode(String input) {
  final output = <int>[];
  var n = _initialN, i = 0, bias = _initialBias;
  final delimiter = input.lastIndexOf('-');
  var pos = 0;
  if (delimiter >= 0) {
    for (var j = 0; j < delimiter; j++) {
      final c = input.codeUnitAt(j);
      if (c >= 0x80) return null;
      output.add(c);
    }
    pos = delimiter + 1;
  }
  while (pos < input.length) {
    final oldI = i;
    var w = 1;
    for (var k = _base; ; k += _base) {
      if (pos >= input.length) return null;
      final digit = _digit(input.codeUnitAt(pos++));
      if (digit < 0) return null;
      i += digit * w;
      final t = k <= bias ? _tMin : (k >= bias + _tMax ? _tMax : k - bias);
      if (digit < t) break;
      w *= _base - t;
      if (w > 0x7fffffff || i > 0x7fffffff) return null;
    }
    final length = output.length + 1;
    bias = _adapt(i - oldI, length, first: oldI == 0);
    n += i ~/ length;
    i %= length;
    if (n > 0x10ffff || (n >= 0xd800 && n <= 0xdfff)) return null;
    output.insert(i, n);
    i++;
  }
  return String.fromCharCodes(output);
}

int _digit(int c) {
  if (c >= 0x30 && c <= 0x39) return c - 22; // '0'..'9' → 26..35
  if (c >= 0x41 && c <= 0x5a) return c - 0x41;
  if (c >= 0x61 && c <= 0x7a) return c - 0x61;
  return -1;
}

int _adapt(int delta, int points, {required bool first}) {
  var d = first ? delta ~/ _damp : delta ~/ 2;
  d += d ~/ points;
  var k = 0;
  while (d > ((_base - _tMin) * _tMax) ~/ 2) {
    d ~/= _base - _tMin;
    k += _base;
  }
  return k + ((_base - _tMin + 1) * d) ~/ (d + _skew);
}
