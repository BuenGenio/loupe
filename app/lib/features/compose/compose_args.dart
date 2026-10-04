import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

/// How the compose screen opens: a new message, a reply, a forward or a draft.
@immutable
class ComposeArgs {
  const ComposeArgs({
    this.mode = ComposeMode.newMessage,
    this.sourceEmailId,
    this.accountId,
    this.to = const [],
    this.subject,
    this.body,
    this.cc = const [],
    this.bcc = const [],
    this.message,
    this.sendAt,
    this.outboxId,
    this.toList = false,
  }) : recoverySession = null,
       attachmentsFromDraft = false;

  /// Reopens [message] as it was (after "Undo" of a send, from the Outbox,
  /// or a recovered draft), with its Send Later time.
  const ComposeArgs.restore(
    OutgoingMessage this.message, {
    this.sendAt,
    this.outboxId,
    this.recoverySession,
    this.attachmentsFromDraft = false,
  }) : mode = ComposeMode.newMessage,
       toList = false,
       sourceEmailId = null,
       accountId = null,
       to = const [],
       cc = const [],
       bcc = const [],
       subject = null,
       body = null;

  final ComposeMode mode;

  /// A reply goes to the mailing list (List-Post) instead of the sender.
  final bool toList;

  /// The message replied to, forwarded, or the draft being edited.
  final String? sourceEmailId;

  /// Preferred sending account; defaults to the source message's account or the first account.
  final String? accountId;
  final List<EmailAddress> to;
  final List<EmailAddress> cc;
  final List<EmailAddress> bcc;
  final String? subject;
  final String? body;

  /// A complete message to edit again; overrides everything else.
  final OutgoingMessage? message;

  /// The Send Later time to start with.
  final DateTime? sendAt;

  /// Editing this waiting message of the Outbox: sending replaces it there,
  /// and nothing is autosaved to Drafts.
  final String? outboxId;

  /// Continues the compose session that left this message behind (crash
  /// recovery), taking over its local copy.
  final String? recoverySession;

  /// The local copy couldn't keep the attachments: load them from the draft
  /// ([OutgoingMessage.draftId]).
  final bool attachmentsFromDraft;

  /// Arguments for a `mailto:` link.
  static ComposeArgs fromMailto(Uri uri, {String? accountId}) {
    List<EmailAddress> split(String? s) => [
      for (final part in (s ?? '').split(','))
        if (part.trim().isNotEmpty) EmailAddress(Uri.decodeComponent(part.trim())),
    ];
    final q = uri.queryParameters.map((k, v) => MapEntry(k.toLowerCase(), v));
    return ComposeArgs(
      accountId: accountId,
      to: [...split(uri.path), ...split(q['to'])],
      cc: split(q['cc']),
      bcc: split(q['bcc']),
      subject: q['subject'],
      body: q['body'],
    );
  }
}

/// Opens the compose screen.
Future<void> openCompose(BuildContext context, [ComposeArgs args = const ComposeArgs()]) =>
    context.push<void>('/compose', extra: args);
