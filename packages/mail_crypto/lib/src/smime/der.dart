/// A small ASN.1 reader (BER, as streaming CMS writers use it) and DER
/// writer: enough for X.509, CMS and PKCS#12.
library;

import 'dart:convert';
import 'dart:typed_data';

/// Input that isn't the ASN.1 structure expected.
final class Asn1Exception implements Exception {
  const Asn1Exception(this.message);
  final String message;

  @override
  String toString() => 'Asn1Exception: $message';
}

/// Universal tags (identifier octets with the constructed bit for SEQUENCE and SET).
abstract final class Tag {
  static const boolean = 0x01;
  static const integer = 0x02;
  static const bitString = 0x03;
  static const octetString = 0x04;
  static const nul = 0x05;
  static const oid = 0x06;
  static const utf8String = 0x0c;
  static const printableString = 0x13;
  static const t61String = 0x14;
  static const ia5String = 0x16;
  static const utcTime = 0x17;
  static const generalizedTime = 0x18;
  static const universalString = 0x1c;
  static const bmpString = 0x1e;
  static const sequence = 0x30;
  static const set = 0x31;
}

/// One ASN.1 element, read from BER or DER. Its exact bytes are kept
/// ([encoded]): signatures are over them.
final class Asn1 {
  Asn1._(this._buffer, this.tag, this._start, this._contentStart, this._contentEnd, this._end, this._depth);

  /// Nesting deeper than this is refused (hostile input).
  static const maxDepth = 48;

  final Uint8List _buffer;

  /// The identifier octet (class, constructed bit, tag number below 31).
  final int tag;
  final int _start;
  final int _contentStart;
  final int _contentEnd;
  final int _end;
  final int _depth;

  /// Reads the element at the start of [bytes]; what follows it is ignored.
  static Asn1 parse(List<int> bytes) {
    final buffer = bytes is Uint8List ? bytes : Uint8List.fromList(bytes);
    return _read(buffer, 0, buffer.length, 0);
  }

  /// Reads every element in [bytes], one after the other.
  static List<Asn1> parseAll(List<int> bytes) {
    final buffer = bytes is Uint8List ? bytes : Uint8List.fromList(bytes);
    return _readList(buffer, 0, buffer.length, 0);
  }

  static List<Asn1> _readList(Uint8List b, int start, int end, int depth) {
    final out = <Asn1>[];
    var at = start;
    while (at < end) {
      final e = _read(b, at, end, depth);
      out.add(e);
      at = e._end;
    }
    return out;
  }

  static Asn1 _read(Uint8List b, int start, int limit, int depth) {
    if (depth > maxDepth) throw const Asn1Exception('Nested too deeply');
    if (start >= limit) throw const Asn1Exception('Truncated');
    final tag = b[start];
    if (tag & 0x1f == 0x1f) throw const Asn1Exception('High tag numbers are not supported');
    var at = start + 1;
    if (at >= limit) throw const Asn1Exception('Truncated length');
    final first = b[at++];
    if (first == 0x80) {
      // Indefinite length (BER): children up to the end-of-contents octets.
      if (tag & 0x20 == 0) throw const Asn1Exception('Indefinite length on a primitive');
      final contentStart = at;
      while (true) {
        if (at + 1 >= limit) throw const Asn1Exception('Missing end of contents');
        if (b[at] == 0 && b[at + 1] == 0) {
          return Asn1._(b, tag, start, contentStart, at, at + 2, depth);
        }
        at = _read(b, at, limit, depth + 1)._end;
      }
    }
    var length = 0;
    if (first < 0x80) {
      length = first;
    } else {
      final n = first & 0x7f;
      if (n > 4) throw const Asn1Exception('Length too long');
      if (at + n > limit) throw const Asn1Exception('Truncated length');
      for (var i = 0; i < n; i++) {
        length = (length << 8) | b[at++];
      }
    }
    final end = at + length;
    if (length < 0 || end > limit) throw const Asn1Exception('Truncated content');
    return Asn1._(b, tag, start, at, end, end, depth);
  }

  /// The whole element: identifier, length and content.
  Uint8List get encoded => Uint8List.sublistView(_buffer, _start, _end);

  /// The content octets (for indefinite lengths, without the end-of-contents).
  Uint8List get content => Uint8List.sublistView(_buffer, _contentStart, _contentEnd);

  bool get constructed => tag & 0x20 != 0;

  /// Context-specific `[n]`, primitive or constructed.
  bool isContext(int n) => tag & 0xc0 == 0x80 && tag & 0x1f == n;

  bool get isSequence => tag == Tag.sequence;
  bool get isSet => tag == Tag.set;

  /// The elements inside a constructed element.
  late final List<Asn1> children = constructed ? _readList(_buffer, _contentStart, _contentEnd, _depth + 1) : const [];

  Asn1 operator [](int i) {
    if (i >= children.length) throw Asn1Exception('Element $i missing');
    return children[i];
  }

  int get length => children.length;

  /// The first child for which [test] holds, or null.
  Asn1? find(bool Function(Asn1) test) {
    for (final c in children) {
      if (test(c)) return c;
    }
    return null;
  }

  /// The child tagged `[n]`, or null.
  Asn1? context(int n) => find((c) => c.isContext(n));

  void expect(int expected, String what) {
    if (tag != expected) {
      throw Asn1Exception('$what: expected tag 0x${expected.toRadixString(16)}, got 0x${tag.toRadixString(16)}');
    }
  }

  /// Octets an INTEGER may have: RSA moduli of 16384 bits and a sign octet
  /// fit. Longer ones are hostile (and slow to turn into numbers).
  static const maxIntegerLength = 2049;

  BigInt get integer {
    final c = content;
    if (c.isEmpty) throw const Asn1Exception('Empty integer');
    if (c.length > maxIntegerLength) throw const Asn1Exception('Integer too large');
    var v = bigIntFromBytes(c);
    if (c[0] & 0x80 != 0) v -= BigInt.one << (c.length * 8);
    return v;
  }

  /// A small INTEGER (a version, a count, a length): within ±2^31.
  int get intValue {
    final v = integer;
    if (v.bitLength > 31) throw const Asn1Exception('Integer out of range');
    return v.toInt();
  }

  bool get boolean => content.isNotEmpty && content[0] != 0;

  String get oid {
    final c = content;
    if (c.isEmpty) throw const Asn1Exception('Empty object identifier');
    final parts = <int>[];
    var v = 0;
    for (final x in c) {
      v = (v << 7) | (x & 0x7f);
      if (x & 0x80 == 0) {
        parts.add(v);
        v = 0;
      }
    }
    if (parts.isEmpty) throw const Asn1Exception('Bad object identifier');
    final first = parts[0];
    final head = first < 40
        ? [0, first]
        : first < 80
        ? [1, first - 40]
        : [2, first - 80];
    return [...head, ...parts.skip(1)].join('.');
  }

  /// An OCTET STRING's bytes; a constructed one (BER) is joined.
  Uint8List get octets {
    if (!constructed) return content;
    final out = BytesBuilder(copy: false);
    for (final c in children) {
      out.add(c.octets);
    }
    return out.takeBytes();
  }

  /// A BIT STRING's bytes, without the unused-bits octet.
  Uint8List get bits {
    final c = constructed ? octets : content;
    if (c.isEmpty) throw const Asn1Exception('Empty bit string');
    return Uint8List.sublistView(c, 1);
  }

  /// A BIT STRING as named bits: bit 0 is the first (most significant) bit.
  int get namedBits {
    final b = bits;
    var v = 0;
    for (var i = 0; i < b.length && i < 4; i++) {
      for (var j = 0; j < 8; j++) {
        if (b[i] & (0x80 >> j) != 0) v |= 1 << (i * 8 + j);
      }
    }
    return v;
  }

  /// A character string in any of the X.509 string types.
  String get string {
    final c = constructed ? octets : content;
    return switch (tag & 0x1f) {
      Tag.bmpString => String.fromCharCodes([for (var i = 0; i + 1 < c.length; i += 2) (c[i] << 8) | c[i + 1]]),
      Tag.universalString => String.fromCharCodes([
        for (var i = 0; i + 3 < c.length; i += 4) (c[i] << 24) | (c[i + 1] << 16) | (c[i + 2] << 8) | c[i + 3],
      ]),
      Tag.t61String => latin1.decode(c),
      _ => utf8.decode(c, allowMalformed: true),
    };
  }

  /// UTCTime or GeneralizedTime, in UTC.
  DateTime get time {
    final s = ascii.decode(content, allowInvalid: true).trim();
    final m = RegExp(r'^(\d{2}|\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})?(?:\.\d+)?(Z|[+-]\d{4})?$').firstMatch(s);
    if (m == null) throw Asn1Exception('Bad time "$s"');
    var year = int.parse(m.group(1)!);
    if (m.group(1)!.length == 2) year += year < 50 ? 2000 : 1900;
    var t = DateTime.utc(
      year,
      int.parse(m.group(2)!),
      int.parse(m.group(3)!),
      int.parse(m.group(4)!),
      int.parse(m.group(5)!),
      int.parse(m.group(6) ?? '0'),
    );
    final zone = m.group(7);
    if (zone != null && zone != 'Z') {
      final minutes = int.parse(zone.substring(1, 3)) * 60 + int.parse(zone.substring(3, 5));
      t = t.subtract(Duration(minutes: zone.startsWith('+') ? minutes : -minutes));
    }
    return t;
  }
}

// Writing (DER) ---------------------------------------------------------------

Uint8List _length(int n) {
  if (n < 0x80) return Uint8List.fromList([n]);
  final bytes = <int>[];
  for (var v = n; v > 0; v >>= 8) {
    bytes.insert(0, v & 0xff);
  }
  return Uint8List.fromList([0x80 | bytes.length, ...bytes]);
}

/// An element with identifier [tag] and [content].
Uint8List der(int tag, List<int> content) {
  final out = BytesBuilder(copy: false)
    ..addByte(tag)
    ..add(_length(content.length))
    ..add(content);
  return out.takeBytes();
}

Uint8List _concat(Iterable<List<int>> items) {
  final out = BytesBuilder(copy: false);
  for (final i in items) {
    out.add(i);
  }
  return out.takeBytes();
}

Uint8List derSequence(Iterable<List<int>> items) => der(Tag.sequence, _concat(items));

/// A SET OF, its elements sorted as DER requires.
Uint8List derSet(Iterable<List<int>> items) {
  final sorted = [...items]..sort(_compareBytes);
  return der(Tag.set, _concat(sorted));
}

int _compareBytes(List<int> a, List<int> b) {
  for (var i = 0; i < a.length && i < b.length; i++) {
    if (a[i] != b[i]) return a[i] - b[i];
  }
  return a.length - b.length;
}

Uint8List derInteger(BigInt v) {
  if (v == BigInt.zero) return der(Tag.integer, const [0]);
  final bytes = <int>[];
  if (v > BigInt.zero) {
    for (var x = v; x > BigInt.zero; x >>= 8) {
      bytes.insert(0, (x & BigInt.from(0xff)).toInt());
    }
    if (bytes[0] & 0x80 != 0) bytes.insert(0, 0);
  } else {
    final n = (v.abs().bitLength + 8) ~/ 8;
    var x = (BigInt.one << (n * 8)) + v;
    for (var i = 0; i < n; i++) {
      bytes.insert(0, (x & BigInt.from(0xff)).toInt());
      x >>= 8;
    }
  }
  return der(Tag.integer, bytes);
}

Uint8List derInt(int v) => derInteger(BigInt.from(v));

Uint8List derOid(String oid) {
  final parts = [for (final p in oid.split('.')) int.parse(p)];
  final out = <int>[];
  void base128(int v) {
    final groups = <int>[v & 0x7f];
    for (v >>= 7; v > 0; v >>= 7) {
      groups.insert(0, 0x80 | (v & 0x7f));
    }
    out.addAll(groups);
  }

  base128(parts[0] * 40 + parts[1]);
  for (final p in parts.skip(2)) {
    base128(p);
  }
  return der(Tag.oid, out);
}

Uint8List derOctets(List<int> bytes) => der(Tag.octetString, bytes);

final Uint8List derNull = Uint8List.fromList(const [Tag.nul, 0]);

Uint8List derBoolean(bool v) => der(Tag.boolean, [v ? 0xff : 0]);

Uint8List derBitString(List<int> bytes) => der(Tag.bitString, [0, ...bytes]);

Uint8List derUtf8(String s) => der(Tag.utf8String, utf8.encode(s));

Uint8List derIa5(String s) => der(Tag.ia5String, ascii.encode(s));

/// UTCTime for 1950–2049 (as RFC 5280 and RFC 5652 require), else GeneralizedTime.
Uint8List derTime(DateTime t) {
  final u = t.toUtc();
  String two(int v) => v.toString().padLeft(2, '0');
  final rest = '${two(u.month)}${two(u.day)}${two(u.hour)}${two(u.minute)}${two(u.second)}Z';
  if (u.year >= 1950 && u.year < 2050) return der(Tag.utcTime, ascii.encode('${two(u.year % 100)}$rest'));
  return der(Tag.generalizedTime, ascii.encode('${u.year.toString().padLeft(4, '0')}$rest'));
}

/// `[n]` around [content]: constructed (EXPLICIT, or IMPLICIT of a
/// constructed type) or primitive (IMPLICIT of a primitive type).
Uint8List derContext(int n, List<int> content, {bool constructed = true}) =>
    der(0x80 | (constructed ? 0x20 : 0) | n, content);

/// An AlgorithmIdentifier: [oid] with [parameters] (absent when null).
Uint8List derAlgorithm(String oid, [List<int>? parameters]) => derSequence([derOid(oid), ?parameters]);

/// [element] with its identifier octet replaced (IMPLICIT tagging).
Uint8List retag(List<int> element, int tag) => Uint8List.fromList([tag, ...element.skip(1)]);

/// Unsigned big-endian bytes of [v], left-padded to [length] when given.
Uint8List unsignedBytes(BigInt v, [int? length]) {
  if (v.isNegative) throw ArgumentError.value(v, 'v', 'Negative');
  final h = v == BigInt.zero ? '' : v.toRadixString(16);
  final n = (h.length + 1) >> 1;
  final out = Uint8List(length != null && length > n ? length : n);
  final digits = h.length.isOdd ? '0$h' : h;
  for (var i = 0, at = out.length - n; i < n; i++, at++) {
    out[at] = int.parse(digits.substring(2 * i, 2 * i + 2), radix: 16);
  }
  return out;
}

/// The unsigned big-endian number in [bytes] (linear time, unlike shifting
/// in one octet at a time).
BigInt bigIntFromBytes(List<int> bytes) => bytes.isEmpty ? BigInt.zero : BigInt.parse(hex(bytes), radix: 16);

String hex(List<int> bytes) => [for (final b in bytes) b.toRadixString(16).padLeft(2, '0')].join().toUpperCase();
