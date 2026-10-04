/// IMAP sequence sets (`1:5,7,9:12`) of UIDs or sequence numbers.
library;

/// Parses a sequence set. A `*` is replaced by [star]; without [star] it is
/// skipped. Ranges are expanded in the order given (`5:3` yields 5, 4, 3), which
/// matters for UIDPLUS COPYUID pairing. Throws [FormatException] on junk.
List<int> parseSequenceSet(String text, {int? star}) {
  final result = <int>[];
  for (final part in text.trim().split(',')) {
    if (part.isEmpty) continue;
    final colon = part.indexOf(':');
    if (colon < 0) {
      final n = _number(part, star);
      if (n != null) result.add(n);
      continue;
    }
    final a = _number(part.substring(0, colon), star);
    final b = _number(part.substring(colon + 1), star);
    if (a == null || b == null) continue;
    if (a <= b) {
      for (var i = a; i <= b; i++) {
        result.add(i);
      }
    } else {
      for (var i = a; i >= b; i--) {
        result.add(i);
      }
    }
  }
  return result;
}

int? _number(String s, int? star) {
  final t = s.trim();
  if (t == '*') return star;
  final n = int.tryParse(t);
  if (n == null || n < 0) throw FormatException('Invalid sequence set element', s);
  return n;
}

/// Formats numbers as a compact sequence set (`1:3,7`). Sorts and de-duplicates.
String formatSequenceSet(Iterable<int> numbers) {
  final sorted = numbers.toSet().toList()..sort();
  if (sorted.isEmpty) return '';
  final buffer = StringBuffer();
  var start = sorted.first;
  var prev = start;
  void flush() {
    if (buffer.isNotEmpty) buffer.write(',');
    buffer.write(start == prev ? '$start' : '$start:$prev');
  }

  for (final n in sorted.skip(1)) {
    if (n == prev + 1) {
      prev = n;
      continue;
    }
    flush();
    start = prev = n;
  }
  flush();
  return buffer.toString();
}

/// Splits [numbers] (sorted ascending) into chunks of at most [size].
Iterable<List<int>> chunked(List<int> numbers, int size) sync* {
  for (var i = 0; i < numbers.length; i += size) {
    yield numbers.sublist(i, i + size > numbers.length ? numbers.length : i + size);
  }
}
