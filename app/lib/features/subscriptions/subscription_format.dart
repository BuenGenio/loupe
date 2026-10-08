import 'package:intl/intl.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import 'one_click.dart';
import 'subscription_providers.dart';

/// "≈ 24 / month", "< 1 / month", or "None lately" when nothing came in the
/// last 90 days.
String volumeLabel(AppLocalizations l10n, Subscription s) {
  if (s.recentCount == 0) return l10n.subscriptionsVolumeNone;
  final perMonth = s.perMonth;
  if (perMonth < 1) return l10n.subscriptionsVolumeUnderOne;
  return l10n.subscriptionsVolumePerMonth(perMonth.round());
}

/// "3%"; "<1%" rather than 0% when something was read, and 99% rather than
/// 100% when something wasn't.
String readPercent(AppLocalizations l10n, Subscription s) {
  final rate = s.readRate;
  final percent = (rate * 100).round();
  if (rate > 0 && percent == 0) return l10n.subscriptionsPercentUnderOne;
  if (rate < 1 && percent == 100) return l10n.subscriptionsPercent(99);
  return l10n.subscriptionsPercent(percent);
}

/// "read 3%".
String readLabel(AppLocalizations l10n, Subscription s) => l10n.subscriptionsReadLabel(readPercent(l10n, s));

/// The row's statistics: "≈ 24 / month · read 3%".
String statsLine(AppLocalizations l10n, Subscription s) => '${volumeLabel(l10n, s)} · ${readLabel(l10n, s)}';

/// "3 Oct", or "3 Oct 2025" in another year.
String shortDate(DateTime date, {DateTime? now}) {
  final local = date.toLocal();
  final n = now ?? DateTime.now();
  return local.year == n.year ? DateFormat.MMMd().format(local) : DateFormat.yMMMd().format(local);
}

/// What the row says about an unsubscribe: "Unsubscribed on 3 Oct",
/// "Unsubscribe page opened 3 Oct", or "Still sending" once mail came in a
/// week after it.
String unsubscribedLabel(AppLocalizations l10n, UnsubscribeRecord record, Subscription s, {DateTime? now}) {
  if (record.stillSending(s)) return l10n.subscriptionsStillSending;
  final date = shortDate(record.at, now: now);
  return record.via == UnsubscribeVia.web
      ? l10n.subscriptionsUnsubscribePageOpened(date)
      : l10n.subscriptionsUnsubscribedOn(date);
}

/// How the Unsubscribe button will do it, for its subtitle.
String methodLabel(AppLocalizations l10n, UnsubscribeMethod method) => switch (method) {
  OneClickUnsubscribe(:final uri) => l10n.subscriptionsMethodOneClick(uri.host),
  MailtoUnsubscribe(:final to) => l10n.subscriptionsMethodMail(to.map((a) => a.email).join(', ')),
  WebUnsubscribe(:final uri) => l10n.subscriptionsMethodWeb(uri.host),
};

/// Why a one-click unsubscribe didn't work, for the user; null when it did.
String? oneClickFailureText(AppLocalizations l10n, OneClickResult result) => switch (result.outcome) {
  OneClickOutcome.unsubscribed => null,
  OneClickOutcome.refused => l10n.subscriptionsOneClickRefused(result.host, result.statusCode ?? 0),
  OneClickOutcome.redirectedAway => l10n.subscriptionsOneClickRedirected(result.host),
  OneClickOutcome.failed => switch (result.failure) {
    OneClickFailure.notAllowed => l10n.subscriptionsOneClickNotAllowed,
    OneClickFailure.timeout => l10n.subscriptionsOneClickTimeout(result.host),
    OneClickFailure.unreachable || null => l10n.subscriptionsOneClickUnreachable(result.host),
  },
};

/// The second line of a row: a discussion's address (else its List-Id);
/// the sender's address, its domain when the address changes with every
/// campaign, or the List-Id of a newsletter list with several senders.
String senderLine(Subscription s) {
  if (s.isDiscussion) return s.postAddress?.email.toLowerCase() ?? s.listId!;
  if (s.brandDomain case final domain?) return domain;
  return s.isList && s.senderCount > 1 ? s.listId! : s.address;
}
