import 'package:intl/intl.dart';
import 'package:mail_model/mail_model.dart';

import 'subscription_providers.dart';

/// "≈ 24 / month", "< 1 / month", or "None lately" when nothing came in the
/// last 90 days.
String volumeLabel(Subscription s) {
  if (s.recentCount == 0) return 'None lately';
  final perMonth = s.perMonth;
  if (perMonth < 1) return '< 1 / month';
  return '≈ ${perMonth.round()} / month';
}

/// "3%"; "<1%" rather than 0% when something was read, and 99% rather than
/// 100% when something wasn't.
String readPercent(Subscription s) {
  final rate = s.readRate;
  final percent = (rate * 100).round();
  if (rate > 0 && percent == 0) return '<1%';
  if (rate < 1 && percent == 100) return '99%';
  return '$percent%';
}

/// "read 3%".
String readLabel(Subscription s) => 'read ${readPercent(s)}';

/// The row's statistics: "≈ 24 / month · read 3%".
String statsLine(Subscription s) => '${volumeLabel(s)} · ${readLabel(s)}';

/// "3 Oct", or "3 Oct 2025" in another year.
String shortDate(DateTime date, {DateTime? now}) {
  final local = date.toLocal();
  final n = now ?? DateTime.now();
  return local.year == n.year ? DateFormat.MMMd().format(local) : DateFormat.yMMMd().format(local);
}

/// What the row says about an unsubscribe: "Unsubscribed on 3 Oct",
/// "Unsubscribe page opened 3 Oct", or "Still sending" once mail came in a
/// week after it.
String unsubscribedLabel(UnsubscribeRecord record, Subscription s, {DateTime? now}) {
  if (record.stillSending(s)) return 'Still sending';
  final date = shortDate(record.at, now: now);
  return record.via == UnsubscribeVia.web ? 'Unsubscribe page opened $date' : 'Unsubscribed on $date';
}

/// How the Unsubscribe button will do it, for its subtitle.
String methodLabel(UnsubscribeMethod method) => switch (method) {
  OneClickUnsubscribe(:final uri) => 'One tap · contacts ${uri.host}',
  MailtoUnsubscribe(:final to) => 'By email to ${to.map((a) => a.email).join(', ')}',
  WebUnsubscribe(:final uri) => 'On the website ${uri.host}',
};

/// The second line of a row: the sender's address, or the List-Id of a list
/// with several senders.
String senderLine(Subscription s) => s.isList && s.senderCount > 1 ? s.listId! : s.address;

/// The privacy footnote of the Subscriptions screens.
const subscriptionsPrivacyNote =
    'Counted on this phone from the mail it has downloaded; nothing is sent anywhere to work this out. '
    'Loupe contacts a sender only when you tap Unsubscribe: one-click sends just “List-Unsubscribe=One-Click” '
    'to the address the sender gave, with no cookies and nothing else about you, and never loads its pages or '
    'images.';
