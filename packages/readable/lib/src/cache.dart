import 'pipeline/pipeline.dart';

/// Identifies one pipeline result: the message, the view mode and the
/// content's shape (so a changed body for the same id isn't served stale).
typedef PipelineKey = (String emailId, PipelineMode mode, int htmlLength, int textLength, int bodyHash, bool flowed);

/// A small LRU of pipeline results, so reopening a message or scrolling a
/// conversation back and forth doesn't re-parse.
final class PipelineCache {
  PipelineCache({this.capacity = 24});

  static final instance = PipelineCache();

  final int capacity;
  final _entries = <PipelineKey, PipelineOutput>{};

  PipelineOutput? operator [](PipelineKey key) {
    final value = _entries.remove(key);
    if (value != null) _entries[key] = value;
    return value;
  }

  void operator []=(PipelineKey key, PipelineOutput value) {
    _entries.remove(key);
    _entries[key] = value;
    while (_entries.length > capacity) {
      _entries.remove(_entries.keys.first);
    }
  }

  void clear() => _entries.clear();
}

/// A cheap hash of a (possibly large) body: length plus samples, not every
/// character.
int sampleHash(String? s) {
  if (s == null) return 0;
  if (s.length <= 4096) return s.hashCode;
  return Object.hash(s.length, s.substring(0, 2048).hashCode, s.substring(s.length - 2048).hashCode);
}
