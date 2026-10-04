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
  });

  final ComposeMode mode;

  /// The message replied to, forwarded, or the draft being edited.
  final String? sourceEmailId;

  /// Preferred sending account; defaults to the source message's account or the first account.
  final String? accountId;
  final List<EmailAddress> to;
  final String? subject;
  final String? body;
}

/// Opens the compose screen.
Future<void> openCompose(BuildContext context, [ComposeArgs args = const ComposeArgs()]) =>
    context.push<void>('/compose', extra: args);
