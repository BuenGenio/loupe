import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../router.dart';
import '../../shared/mailbox_ref_codec.dart';

/// What the list pane of the wide layout shows. Each has the route that
/// shows it on a phone.
@immutable
sealed class ListTarget {
  const ListTarget();

  /// The phone route.
  String get location;

  /// The target of a route [path] (as declared in the router) with its
  /// decoded [params]; null for routes that aren't lists.
  static ListTarget? fromRoute(String? path, Map<String, String> params) => switch (path) {
    '/list/:ref' => MailboxTarget(MailboxRefCodec.decode(params['ref']!)),
    '/smart/:id' => SmartMailboxTarget(params['id']!),
    '/mailing-list/:id' => MailingListTarget(params['id']!),
    Routes.snoozed => const SnoozedTarget(),
    Routes.outbox => const OutboxTarget(),
    _ => null,
  };
}

/// A mailbox or a unified mailbox: the message list.
final class MailboxTarget extends ListTarget {
  const MailboxTarget(this.ref);

  final MailboxRef ref;

  @override
  String get location => Routes.list(ref);

  @override
  bool operator ==(Object other) => other is MailboxTarget && other.ref == ref;

  @override
  int get hashCode => ref.hashCode;
}

final class SmartMailboxTarget extends ListTarget {
  const SmartMailboxTarget(this.id);

  final String id;

  @override
  String get location => Routes.smartMailbox(id);

  @override
  bool operator ==(Object other) => other is SmartMailboxTarget && other.id == id;

  @override
  int get hashCode => Object.hash(SmartMailboxTarget, id);
}

final class MailingListTarget extends ListTarget {
  const MailingListTarget(this.listId);

  final String listId;

  @override
  String get location => Routes.mailingList(listId);

  @override
  bool operator ==(Object other) => other is MailingListTarget && other.listId == listId;

  @override
  int get hashCode => Object.hash(MailingListTarget, listId);
}

final class SnoozedTarget extends ListTarget {
  const SnoozedTarget();

  @override
  String get location => Routes.snoozed;

  @override
  bool operator ==(Object other) => other is SnoozedTarget;

  @override
  int get hashCode => (SnoozedTarget).hashCode;
}

final class OutboxTarget extends ListTarget {
  const OutboxTarget();

  @override
  String get location => Routes.outbox;

  @override
  bool operator ==(Object other) => other is OutboxTarget;

  @override
  int get hashCode => (OutboxTarget).hashCode;
}

/// The list the wide layout starts with.
const defaultListTarget = MailboxTarget(VirtualMailboxRef(VirtualMailbox.allInboxes));

/// What the wide layout shows: a list and, perhaps, a conversation.
///
/// It lives above the widgets, so it survives rotation, folding and
/// resizing. On a phone the route stack is what counts; [MailHome] turns one
/// into the other when the width crosses the breakpoint.
@immutable
final class MailSelection {
  const MailSelection({this.list, this.messageId, this.threadId});

  /// Null until a list is chosen: [defaultListTarget].
  final ListTarget? list;

  /// The conversation shown, by one of its messages.
  final String? messageId;

  /// Its thread, once known (for the list's highlight).
  final String? threadId;

  ListTarget get listOrDefault => list ?? defaultListTarget;

  /// Whether [row] is the conversation shown.
  bool shows(ThreadSummary row) =>
      messageId != null && (row.threadId == threadId || row.latest.id == messageId || row.threadId == messageId);

  @override
  bool operator ==(Object other) =>
      other is MailSelection && other.list == list && other.messageId == messageId && other.threadId == threadId;

  @override
  int get hashCode => Object.hash(list, messageId, threadId);

  @override
  String toString() => 'MailSelection(${list?.location}, $messageId, $threadId)';
}

final mailSelectionProvider = NotifierProvider<MailSelectionController, MailSelection>(MailSelectionController.new);

class MailSelectionController extends Notifier<MailSelection> {
  @override
  MailSelection build() => const MailSelection();

  /// Shows [target] in the list pane, with no conversation.
  void showList(ListTarget target) => state = MailSelection(list: target);

  void showMessage(String messageId, {String? threadId}) =>
      state = MailSelection(list: state.list, messageId: messageId, threadId: threadId);

  /// Learns the thread of the conversation shown (for the highlight).
  void setThread(String messageId, String threadId) {
    if (state.messageId == messageId && state.threadId != threadId) {
      state = MailSelection(list: state.list, messageId: messageId, threadId: threadId);
    }
  }

  void closeMessage() {
    if (state.messageId != null) state = MailSelection(list: state.list);
  }

  void set(MailSelection selection) => state = selection;
}
