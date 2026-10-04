import 'thunderbird_qr.dart';

/// What adding a code to a [QrSequence] did.
enum QrSequenceResult {
  /// A new part of the current export.
  added,

  /// That part was already scanned; nothing changed.
  duplicate,

  /// The code belongs to an export with a different number of codes, so
  /// the user started over in Thunderbird: earlier parts were dropped.
  restarted,
}

/// Collects the codes of one export, in any order, ignoring repeats.
final class QrSequence {
  final _parts = <int, TbQrCode>{};
  int _total = 0;

  /// Codes in the export; 0 before the first scan.
  int get total => _total;
  int get scanned => _parts.length;
  bool get isEmpty => _parts.isEmpty;
  bool get isComplete => _total > 0 && _parts.length == _total;
  bool has(int part) => _parts.containsKey(part);

  /// Parts not scanned yet, in order.
  List<int> get missing => [
    for (var i = 1; i <= _total; i++)
      if (!_parts.containsKey(i)) i,
  ];

  /// Accounts of every scanned part, in part order.
  List<TbAccount> get accounts => [for (final part in _parts.keys.toList()..sort()) ..._parts[part]!.accounts];

  /// Accounts the parser had to leave out.
  int get skipped => _parts.values.fold(0, (sum, code) => sum + code.skipped);

  QrSequenceResult add(TbQrCode code) {
    if (_total != 0 && code.total != _total) {
      _parts
        ..clear()
        ..[code.part] = code;
      _total = code.total;
      return QrSequenceResult.restarted;
    }
    _total = code.total;
    if (_parts.containsKey(code.part)) return QrSequenceResult.duplicate;
    _parts[code.part] = code;
    return QrSequenceResult.added;
  }

  /// Forgets every scanned code (and the passwords in them).
  void clear() {
    _parts.clear();
    _total = 0;
  }
}
