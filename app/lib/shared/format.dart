import 'package:intl/intl.dart';

import '../l10n/l10n.dart';

// The words come from [l10n] when given, else in the device's language
// (the one the app shows).

/// Date in a message list row, Apple Mail style: time today, "Yesterday",
/// weekday within the last week, otherwise a short date.
String formatListDate(DateTime date, {DateTime? now, AppLocalizations? l10n}) {
  final n = now ?? DateTime.now();
  final local = date.toLocal();
  final today = DateTime(n.year, n.month, n.day);
  final day = DateTime(local.year, local.month, local.day);
  final diff = today.difference(day).inDays;
  if (diff <= 0) return DateFormat.jm().format(local);
  if (diff == 1) return (l10n ?? deviceL10n()).sharedYesterday;
  if (diff < 7) return DateFormat.EEEE().format(local);
  return DateFormat.yMd().format(local);
}

/// Full date for message headers, e.g. "4 October 2026 at 14:05".
String formatFullDate(DateTime date, {AppLocalizations? l10n}) {
  final local = date.toLocal();
  return (l10n ?? deviceL10n()).sharedDateAtTime(DateFormat.yMMMMd().format(local), DateFormat.jm().format(local));
}

/// "1.2 MB", "340 KB", "12 bytes".
String formatBytes(int bytes, {AppLocalizations? l10n}) {
  final strings = l10n ?? deviceL10n();
  if (bytes < 1024) return strings.sharedBytes(bytes);
  if (bytes < 1024 * 1024) return strings.sharedKilobytes('${(bytes / 1024).round()}');
  return strings.sharedMegabytes(NumberFormat('0.0').format(bytes / (1024 * 1024)));
}

/// A count with grouping separators for the current locale: "35,722".
String formatCount(int count) => NumberFormat.decimalPattern().format(count);
