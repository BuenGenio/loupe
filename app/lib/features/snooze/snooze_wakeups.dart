import 'package:mail_model/mail_model.dart';

/// The next time a snoozed message of [repository] wakes after [now], if
/// any: background work asks for a wake-up then, so it comes back on time
/// even when Loupe isn't running (snoozes from other devices included).
Future<DateTime?> nextSnoozeWake(MailRepository repository, {DateTime? now}) async {
  final after = now ?? DateTime.now();
  DateTime? next;
  for (final e in await repository.watchSnoozed().first) {
    final at = e.snoozedUntil;
    if (at != null && at.isAfter(after) && (next == null || at.isBefore(next))) next = at;
  }
  return next?.toLocal();
}
