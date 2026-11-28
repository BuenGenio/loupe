import 'dart:io' show ZLibDecoder;
import 'dart:typed_data';

import '../budget.dart';
import 'syntax.dart';

/// Thrown when a stream uses a filter the extractor doesn't decode.
final class UnsupportedFilter implements Exception {
  const UnsupportedFilter(this.name);
  final String name;
}

/// Decodes [stream]'s bytes through its filters: FlateDecode, ASCIIHexDecode
/// and ASCII85Decode, with no predictor. Others (LZW, images' filters,
/// predictors) throw [UnsupportedFilter]. Every decoded byte is charged to
/// [budget]; a damaged Flate stream gives what decoded before the damage.
Uint8List decodeStream(PdfStream stream, Object? Function(Object?) resolve, Budget budget) {
  final filters = switch (resolve(stream.dict['Filter'])) {
    final PdfName n => [n],
    final List<Object?> l => [for (final f in l) resolve(f)],
    _ => const <Object?>[],
  };
  final params = switch (resolve(stream.dict['DecodeParms'] ?? stream.dict['DP'])) {
    final Map<String, Object?> m => [m],
    final List<Object?> l => [for (final p in l) resolve(p)],
    _ => const <Object?>[],
  };
  var data = stream.data;
  for (final (i, f) in filters.indexed) {
    if (f is! PdfName) throw const UnsupportedFilter('?');
    final p = i < params.length ? params[i] : null;
    if (p is Map<String, Object?>) {
      final predictor = resolve(p['Predictor']);
      if (predictor is int && predictor > 1) throw UnsupportedFilter('${f.value} with a predictor');
    }
    data = switch (f.value) {
      'FlateDecode' || 'Fl' => inflate(data, budget),
      'ASCIIHexDecode' || 'AHx' => _asciiHex(data, budget),
      'ASCII85Decode' || 'A85' => _ascii85(data, budget),
      _ => throw UnsupportedFilter(f.value),
    };
  }
  if (filters.isEmpty) budget.decoded(data.length);
  return data;
}

/// Inflates zlib (or raw deflate) data in small steps, so a bomb is stopped
/// by the budget before it fills memory.
Uint8List inflate(Uint8List data, Budget budget) {
  final zlib = data.length >= 2 && (data[0] & 0x0F) == 8 && ((data[0] << 8) | data[1]) % 31 == 0;
  final out = _CappedSink(budget);
  final sink = ZLibDecoder(raw: !zlib).startChunkedConversion(out);
  const step = 1024;
  try {
    for (var i = 0; i < data.length; i += step) {
      sink.add(Uint8List.sublistView(data, i, i + step > data.length ? data.length : i + step));
    }
    sink.close();
  } on LimitReached {
    rethrow;
  } on Object {
    // Damaged or truncated: keep what came out before the damage.
  }
  return out.bytes();
}

final class _CappedSink implements Sink<List<int>> {
  _CappedSink(this.budget);
  final Budget budget;
  final _out = BytesBuilder(copy: true);

  @override
  void add(List<int> chunk) {
    budget.decoded(chunk.length);
    _out.add(chunk);
  }

  @override
  void close() {}

  Uint8List bytes() => _out.takeBytes();
}

Uint8List _asciiHex(Uint8List data, Budget budget) {
  final out = BytesBuilder(copy: false);
  final lexer = PdfLexer(Uint8List.fromList([0x3C, ...data, 0x3E]));
  final s = lexer.next();
  if (s is PdfString) out.add(s.bytes);
  final bytes = out.takeBytes();
  budget.decoded(bytes.length);
  return bytes;
}

Uint8List _ascii85(Uint8List data, Budget budget) {
  final out = <int>[];
  var tuple = 0;
  var count = 0;
  for (var i = 0; i < data.length; i++) {
    final c = data[i];
    if (c == 0x7E) break; // ~> ends the data
    if (isPdfSpace(c)) continue;
    if (c == 0x7A && count == 0) {
      out.addAll(const [0, 0, 0, 0]);
      continue;
    }
    if (c < 0x21 || c > 0x75) continue;
    tuple = tuple * 85 + (c - 0x21);
    if (++count == 5) {
      out
        ..add((tuple >> 24) & 0xFF)
        ..add((tuple >> 16) & 0xFF)
        ..add((tuple >> 8) & 0xFF)
        ..add(tuple & 0xFF);
      tuple = 0;
      count = 0;
      if (out.length > budget.decodedLeft) budget.decoded(out.length);
    }
  }
  if (count > 1) {
    for (var k = count; k < 5; k++) {
      tuple = tuple * 85 + 84;
    }
    for (var k = 0; k < count - 1; k++) {
      out.add((tuple >> (24 - 8 * k)) & 0xFF);
    }
  }
  budget.decoded(out.length);
  return Uint8List.fromList(out);
}
