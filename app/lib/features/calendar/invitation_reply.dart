import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_calendar/mail_calendar.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../settings/app_settings.dart';
import '../compose/send_later.dart' show deviceDateLocale;
import '../conversation/sheets.dart';
import '../openpgp/compose_security.dart';
import '../openpgp/openpgp_providers.dart';
import '../smime/smime_providers.dart';
import 'invitation.dart';
import 'invitation_format.dart';

/// The answer to an invitation, ready to send.
final class InvitationReply {
  const InvitationReply({required this.message, required this.account, required this.identity});

  final OutgoingMessage message;
  final MailAccount account;
  final Identity identity;
}

/// Why an answer can't be sent.
enum InvitationReplyProblem {
  /// The invitation names no organizer to reply to.
  noOrganizer,

  /// No account can send the reply.
  noAccount,
}

/// An answer that can't be sent, and why.
final class InvitationReplyException implements Exception {
  const InvitationReplyException(this.problem);
  final InvitationReplyProblem problem;

  /// What to tell the user.
  String message(AppLocalizations l10n) => switch (problem) {
    InvitationReplyProblem.noOrganizer => l10n.calendarNoOrganizer,
    InvitationReplyProblem.noAccount => l10n.calendarNoAccount,
  };

  @override
  String toString() => 'InvitationReplyException: ${problem.name}';
}

/// The reply that answers [invitation] (in [source]) with [answer]: an iMIP
/// REPLY to the organizer, from the identity the invitation names as the
/// attendee ([replyIdentity]), with a text for people to read ("Sam has
/// accepted: …") and the iCalendar REPLY as its `text/calendar`
/// alternative. It answers [source] (In-Reply-To, $answered).
InvitationReply buildInvitationReply({
  required Invitation invitation,
  required EmailSummary source,
  required List<MailAccount> accounts,
  required PartStat answer,
  required EventTimeFormat format,
  List<(String, String)> headers = const [],
  String? comment,
  DateTime? now,
}) {
  final organizer = invitation.event.organizer;
  if (organizer == null || organizer.email.isEmpty) {
    throw const InvitationReplyException(InvitationReplyProblem.noOrganizer);
  }
  final from = replyIdentity(accounts: accounts, message: source, me: invitation.me, headers: headers);
  if (from == null) throw const InvitationReplyException(InvitationReplyProblem.noAccount);
  final identity = from.identity;
  final name = identity.name?.trim().isNotEmpty ?? false ? identity.name!.trim() : null;
  final ics = buildReply(
    calendar: invitation.calendar,
    event: invitation.event,
    email: invitation.me?.email ?? identity.email,
    name: invitation.me?.name ?? name,
    partStat: answer,
    comment: comment,
    now: (now ?? clock.now()).toUtc(),
  );
  final title = invitation.event.summary;
  final messageId = source.messageIdHeader;
  return InvitationReply(
    account: from.account,
    identity: identity,
    message: OutgoingMessage(
      accountId: from.account.id,
      identityId: identity.id,
      to: [EmailAddress(organizer.email, organizer.name)],
      subject: replySubject(answer, title),
      text: replyText(
        name: name ?? identity.email,
        answer: answer,
        title: title,
        span: invitation.span,
        format: format,
        comment: comment,
      ),
      inReplyTo: messageId,
      references: [...source.references, ?messageId],
      mode: ComposeMode.reply,
      sourceEmailId: source.id,
      calendar: OutgoingCalendar(method: 'REPLY', data: ics),
    ),
  );
}

/// Sends the user's [answer] to [invitation]: through the normal send path
/// (the Outbox, with the Undo delay), protected as compose would protect a
/// reply by default (usually not at all: an organizer seldom has a key),
/// and remembered on the device. Only ever called from a button: replies
/// are never sent on their own. Returns the record to show, or null when
/// nothing was sent.
Future<InvitationRecord?> sendInvitationReply(
  BuildContext context,
  WidgetRef ref, {
  required Invitation invitation,
  required EmailSummary source,
  required PartStat answer,
  List<(String, String)> headers = const [],
  String? comment,
  required ValueChanged<InvitationRecord?> onUndone,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;
  final repo = ref.read(repositoryProvider);
  final accounts = ref.read(accountsProvider).value ?? const <MailAccount>[];
  final now = clock.now();
  final InvitationReply reply;
  try {
    reply = buildInvitationReply(
      invitation: invitation,
      source: source,
      accounts: accounts,
      answer: answer,
      headers: headers,
      comment: comment,
      now: now,
      format: EventTimeFormat(
        l10n: l10n,
        locale: deviceDateLocale(),
        use24h: MediaQuery.alwaysUse24HourFormatOf(context),
        now: now,
      ),
    );
  } on InvitationReplyException catch (e) {
    showSnack(messenger, e.message(l10n));
    return null;
  }

  // The compose defaults: sign or encrypt when the sender's settings and the
  // organizer's key say so; unlocks the key when needed.
  var message = reply.message;
  final keyring = ref.read(keyringStateProvider).value;
  if (keyring != null) {
    final security = ComposeSecurityController(smimeBackend: ref.read(smimeBackendProvider))
      ..update(
        state: keyring,
        smime: ref.read(smimeStateProvider).value,
        from: reply.identity.email,
        recipients: [for (final a in message.to) a.email],
        replyToEncrypted: source.isEncrypted,
      );
    if (!context.mounted) return null;
    final chosen = await security.prepareToSend(context, ref);
    security.dispose();
    if (chosen == null) return null;
    message = message.copyWith(security: chosen);
  }

  final undoSeconds = ref.read(appSettingsProvider).undoSendSeconds;
  final String outboxId;
  try {
    outboxId = await repo.send(message, undoDelay: Duration(seconds: undoSeconds));
  } on MailException catch (e) {
    showSnack(messenger, e.message);
    return null;
  }

  // Remembered at once (the card shows the answer); Undo puts back what was.
  final records = calendarRecordsOf(repo);
  final before = invitation.record;
  final uid = invitation.event.uid;
  final recurrenceId = invitation.event.recurrenceId?.value ?? '';
  final after = (before ?? InvitationRecord.first(invitation.event, invitation.method, invitation.zones)).responded(
    answer,
    invitation.event.sequence,
    now,
  );
  if (records != null && uid != null && uid.isNotEmpty) {
    await records.writeCalendarRecord(uid, jsonEncode(after.toJson()), recurrenceId: recurrenceId);
  }

  showSnack(
    messenger,
    undoSeconds > 0
        ? l10n.calendarReplySending(answer.name, message.to.first.displayName)
        : l10n.calendarReplySent(answer.name),
    duration: Duration(seconds: undoSeconds > 0 ? undoSeconds : 4),
    action: undoSeconds > 0
        ? SnackBarAction(
            label: l10n.commonUndo,
            onPressed: () async {
              final back = await repo.cancelSend(outboxId);
              if (back == null) {
                showSnack(messenger, l10n.calendarReplyAlreadySent);
                return;
              }
              if (records != null && uid != null && uid.isNotEmpty) {
                final previous = before == null ? null : jsonEncode(before.toJson());
                await records.writeCalendarRecord(uid, previous, recurrenceId: recurrenceId);
              }
              onUndone(before);
              showSnack(messenger, l10n.calendarReplyNotSent);
            },
          )
        : null,
  );
  return after;
}
