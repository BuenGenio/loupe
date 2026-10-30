import 'document.dart';

/// Thrown inside the extractor when a limit is reached; the reader keeps
/// what it read so far and says which limit stopped it.
final class LimitReached implements Exception {
  const LimitReached(this.limit);
  final ExtractionLimit limit;

  @override
  String toString() => 'LimitReached(${limit.name})';
}

/// Thrown inside the extractor for input it can't make sense of. Never
/// leaves the package: the result says the document is damaged.
final class Malformed implements Exception {
  const Malformed(this.reason);
  final String reason;

  @override
  String toString() => 'Malformed($reason)';
}

/// What one extraction may still spend: decoded bytes, operators, kept
/// characters and time. Checked as work is done, so hostile input stops
/// early instead of running long.
final class Budget {
  Budget(this.limits) : _clock = Stopwatch()..start();

  final ExtractionLimits limits;
  final Stopwatch _clock;
  var _decoded = 0;
  var _operators = 0;
  var _characters = 0;

  int get decodedLeft => limits.maxDecodedBytes - _decoded;

  void decoded(int bytes) {
    _decoded += bytes;
    if (_decoded > limits.maxDecodedBytes) throw const LimitReached(ExtractionLimit.decodedBytes);
  }

  void operator() {
    // The clock is read every 1024 operators: cheap, and often enough.
    if (++_operators & 1023 == 0) checkTime();
    if (_operators > limits.maxOperators) throw const LimitReached(ExtractionLimit.operators);
  }

  void characters(int n) {
    _characters += n;
    if (_characters > limits.maxCharacters) throw const LimitReached(ExtractionLimit.characters);
  }

  void checkTime() {
    if (_clock.elapsed > limits.maxDuration) throw const LimitReached(ExtractionLimit.time);
  }
}
