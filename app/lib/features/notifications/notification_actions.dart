import 'package:mail_model/mail_model.dart';

import 'notification_content.dart';

/// Runs a notification button on [repository]: Archive or Mark as Read.
/// (Reply opens the app instead.)
Future<void> runMailAction(MailRepository repository, MailAction action, String emailId) async {
  switch (action) {
    case MailAction.archive:
      await repository.archive([emailId]);
    case MailAction.markRead:
      await repository.setKeywords([emailId], add: {Keywords.seen});
    case MailAction.reply:
      break;
  }
}

/// A notification button handed from the background isolate to the app
/// (see `ForegroundBridge`).
typedef MailActionRequest = ({MailAction action, MessageTarget target});

Map<String, Object?> encodeMailActionRequest(MailAction action, MessageTarget target) => {
  'type': 'mailAction',
  'action': action.id,
  'email': target.emailId,
  'account': target.accountId,
};

MailActionRequest? decodeMailActionRequest(Map<String, Object?> request) => switch (request) {
  {'type': 'mailAction', 'action': final String id, 'email': final String email, 'account': final String account}
      when MailAction.byId(id) != null =>
    (action: MailAction.byId(id)!, target: MessageTarget(email, account)),
  _ => null,
};
