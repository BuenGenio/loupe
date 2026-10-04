import 'package:intl/intl.dart';

/// Date in a message list row, Apple Mail style: time today, "Yesterday",
/// weekday within the last week, otherwise a short date.
String formatListDate(DateTime date, {DateTime? now}) {
  final n = now ?? DateTime.now();
  final local = date.toLocal();
  final today = DateTime(n.year, n.month, n.day);
  final day = DateTime(local.year, local.month, local.day);
  final diff = today.difference(day).inDays;
  if (diff <= 0) return DateFormat.jm().format(local);
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return DateFormat.EEEE().format(local);
  return DateFormat.yMd().format(local);
}

/// Full date for message headers, e.g. "4 October 2026 at 14:05".
String formatFullDate(DateTime date) {
  final local = date.toLocal();
  return '${DateFormat.yMMMMd().format(local)} at ${DateFormat.jm().format(local)}';
}

/// "1.2 MB", "340 KB", "12 bytes".
String formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes bytes';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).round()} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}

/// A count with grouping separators for the current locale: "35,722".
String formatCount(int count) => NumberFormat.decimalPattern().format(count);
