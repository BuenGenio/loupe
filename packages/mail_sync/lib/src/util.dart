import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:mail_model/mail_model.dart';

/// Runs tasks one at a time (one transport connection is not re-entrant).
/// Priority tasks (user-visible work such as opening a message) run before
/// queued normal ones, but never interrupt the running task.
final class SerialQueue {
  final _queue = ListQueue<(bool, Future<void> Function())>();
  bool _busy = false;

  Future<T> run<T>(Future<T> Function() task, {bool priority = false}) {
    final completer = Completer<T>();
    Future<void> wrapped() async {
      try {
        completer.complete(await task());
      } catch (e, st) {
        completer.completeError(e, st);
      }
    }

    if (priority) {
      // After the last queued priority task, before the first normal one.
      final items = _queue.toList();
      final at = items.indexWhere((t) => !t.$1);
      items.insert(at < 0 ? items.length : at, (true, wrapped));
      _queue
        ..clear()
        ..addAll(items);
    } else {
      _queue.add((false, wrapped));
    }
    unawaited(_pump());
    return completer.future;
  }

  Future<void> _pump() async {
    if (_busy) return;
    _busy = true;
    while (_queue.isNotEmpty) {
      await _queue.removeFirst().$2();
    }
    _busy = false;
  }
}

/// A value with a stream that emits the current value on listen and every
/// later change.
final class ValueStream<T> {
  ValueStream(this._value);

  T _value;
  final _changes = StreamController<T>.broadcast(sync: true);

  T get value => _value;

  set value(T v) {
    _value = v;
    if (!_changes.isClosed) _changes.add(v);
  }

  Stream<T> get stream => Stream.multi((m) {
    m.add(_value);
    final sub = _changes.stream.listen(m.add, onDone: m.close);
    // Not returning the cancel future: a broadcast subscription returns a
    // root-zone future, which stalls `first` under fake_async.
    m.onCancel = () => unawaited(sub.cancel());
  });

  Future<void> close() => _changes.close();
}

final _random = Random.secure();

/// A random UUID (version 4).
String newId() {
  final b = List<int>.generate(16, (_) => _random.nextInt(256));
  b[6] = (b[6] & 0x0f) | 0x40;
  b[8] = (b[8] & 0x3f) | 0x80;
  final h = b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
  return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-${h.substring(16, 20)}-${h.substring(20)}';
}

/// A new Message-ID (without angle brackets) in the sender's domain.
String newMessageId(String fromEmail) {
  final at = fromEmail.lastIndexOf('@');
  final domain = at >= 0 && at < fromEmail.length - 1 ? fromEmail.substring(at + 1) : 'loupe.invalid';
  return '${newId().replaceAll('-', '')}@$domain';
}

/// Exponential backoff: [base] × 2^[attempt], capped at [max].
Duration backoff(Duration base, Duration max, int attempt) {
  final ms = base.inMilliseconds * pow(2, attempt.clamp(0, 20));
  return ms >= max.inMilliseconds ? max : Duration(milliseconds: ms.toInt());
}

/// Local placeholder ids (drafts saved while offline): `<account>|local|<uuid>`.
String localEmailId(String accountId) => '$accountId|local|${newId()}';

bool isLocalEmailId(String id) {
  final parts = id.split('|');
  return parts.length == 3 && parts[1] == 'local';
}

/// A message for the status line or a snackbar. Never includes message
/// content or credentials.
String describeError(Object error) => switch (error) {
  MailException(:final message) => message,
  TimeoutException() => 'The server took too long to answer',
  _ => 'Something went wrong',
};

MailException asMailException(Object error, [String fallback = 'Something went wrong']) => switch (error) {
  final MailException e => e,
  TimeoutException() => MailException(MailErrorKind.connection, 'The server took too long to answer', error),
  _ => MailException(MailErrorKind.unknown, fallback, error),
};

/// Groups [ids] by account, keeping order.
Map<String, List<String>> groupByAccount(Iterable<String> ids) {
  final out = <String, List<String>>{};
  for (final id in ids) {
    (out[MailIds.accountOf(id)] ??= []).add(id);
  }
  return out;
}
