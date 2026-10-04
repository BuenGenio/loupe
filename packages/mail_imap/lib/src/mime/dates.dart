/// Lenient parsing of RFC 5322 dates and IMAP INTERNALDATE values.
library;

const _months = {
  'jan': 1,
  'feb': 2,
  'mar': 3,
  'apr': 4,
  'may': 5,
  'jun': 6,
  'jul': 7,
  'aug': 8,
  'sep': 9,
  'oct': 10,
  'nov': 11,
  'dec': 12,
};

const _zones = {
  'ut': 0,
  'utc': 0,
  'gmt': 0,
  'z': 0,
  'est': -300,
  'edt': -240,
  'cst': -360,
  'cdt': -300,
  'mst': -420,
  'mdt': -360,
  'pst': -480,
  'pdt': -420,
  'cet': 60,
  'cest': 120,
};

final _pattern = RegExp(
  r'(\d{1,2})[\s-]+([A-Za-z]{3})[A-Za-z]*\.?[\s-]+(\d{2,4})\s+(\d{1,2}):(\d{1,2})(?::(\d{1,2}))?(?:\s*([+-]\d{4}|[A-Za-z]{1,5}))?',
);

/// Parses "Tue, 1 Jul 2003 10:52:37 +0200" and "17-Jul-1996 02:44:25 -0700".
/// Returns local time, or null if the text isn't a date.
DateTime? parseMailDate(String? text) {
  if (text == null) return null;
  final m = _pattern.firstMatch(text.replaceAll(RegExp(r'\([^)]*\)'), ' '));
  if (m == null) return null;
  final day = int.parse(m[1]!);
  final month = _months[m[2]!.toLowerCase()];
  var year = int.parse(m[3]!);
  if (month == null || day < 1 || day > 31) return null;
  if (m[3]!.length == 2) {
    year += year < 50 ? 2000 : 1900;
  } else if (m[3]!.length == 3) {
    year += 1900;
  }
  final hour = int.parse(m[4]!);
  final minute = int.parse(m[5]!);
  final second = int.tryParse(m[6] ?? '') ?? 0;
  if (hour > 23 || minute > 59 || second > 60) return null;
  var offsetMinutes = 0;
  final zone = m[7];
  if (zone != null) {
    if (zone.startsWith('+') || zone.startsWith('-')) {
      final v = int.parse(zone.substring(1));
      offsetMinutes = (v ~/ 100) * 60 + v % 100;
      if (zone.startsWith('-')) offsetMinutes = -offsetMinutes;
    } else {
      offsetMinutes = _zones[zone.toLowerCase()] ?? 0;
    }
  }
  final utc = DateTime.utc(year, month, day, hour, minute, second).subtract(Duration(minutes: offsetMinutes));
  return utc.toLocal();
}
