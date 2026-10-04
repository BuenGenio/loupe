// Limits that keep hostile or monstrous messages from freezing the reader.

/// Hard limits of the pipeline. The defaults handle any sane message; a
/// message that hits one is still shown (truncated) and the reader suggests
/// the Original view.
final class PipelineLimits {
  const PipelineLimits({
    this.maxInputChars = 1000000,
    this.maxDepth = 120,
    this.maxNodes = 60000,
    this.maxBlocks = 4000,
    this.maxFlattenedChars = 100000,
    this.maxDataImageBytes = 8 * 1024 * 1024,
    this.timeLimit = const Duration(seconds: 4),
  });

  /// Characters of HTML or text read; the rest is cut before parsing.
  final int maxInputChars;

  /// DOM depth walked recursively; deeper subtrees are flattened to text.
  final int maxDepth;

  /// Elements visited by the sanitiser and by the converter.
  final int maxNodes;

  /// Blocks produced.
  final int maxBlocks;

  /// Text kept from a flattened (too deep) subtree.
  final int maxFlattenedChars;

  /// Total decoded bytes of `data:` images.
  final int maxDataImageBytes;

  /// Wall-clock budget for sanitising and converting (parsing is bounded by
  /// [maxInputChars]).
  final Duration timeLimit;
}

/// Counts work against [PipelineLimits]. Shared by the pipeline stages.
final class Budget {
  Budget(this.limits) : _clock = Stopwatch()..start();

  final PipelineLimits limits;
  final Stopwatch _clock;
  int _nodes = 0;
  bool _exhausted = false;
  bool _truncated = false;

  /// True once a limit cut the output short.
  bool get exhausted => _exhausted || _truncated;

  void markTruncated() => _truncated = true;

  /// Counts one element; false when the node or time budget is spent.
  bool tick() {
    if (_exhausted) return false;
    _nodes++;
    if (_nodes > limits.maxNodes || ((_nodes & 255) == 0 && _clock.elapsed > limits.timeLimit)) {
      _exhausted = true;
      return false;
    }
    return true;
  }

  /// Starts a new stage with a fresh node count (the time budget is shared).
  void resetNodes() {
    if (_exhausted) _truncated = true;
    _nodes = 0;
    _exhausted = _clock.elapsed > limits.timeLimit;
  }
}
