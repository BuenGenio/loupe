import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart' show inspectHost;

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../shared/mail_actions.dart';
import '../../shared/sheets.dart';
import '../conversation/reader_prefs.dart';
import '../conversation/sheets.dart' show showSnack;
import 'subscription_format.dart';
import 'subscription_providers.dart';

/// What the Subscriptions screens do: unsubscribe (asking first), archive a
/// sender's Inbox mail with Undo, and the rules that deal with its future
/// mail.
class SubscriptionActions {
  SubscriptionActions(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  MailRepository get _repo => ref.read(repositoryProvider);
  MailSubscriptions? get _subs => subscriptionsOf(_repo);

  // Unsubscribe -----------------------------------------------------------------------

  /// Unsubscribes from [s] with [method] (default: the best one it offers),
  /// after the user agrees, and records the date. A failed one-click offers
  /// the other ways. Returns whether it happened.
  Future<bool> unsubscribe(Subscription s, {UnsubscribeMethod? method}) async {
    final methods = s.unsubscribe;
    final chosen = method ?? methods.firstOrNull;
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    if (chosen == null) {
      showSnack(messenger, l10n.subscriptionsNoMethodBlock(s.name));
      return false;
    }
    unawaited(HapticFeedback.selectionClick());
    switch (chosen) {
      case OneClickUnsubscribe(:final uri):
        if (!await _confirmOneClick(s, uri) || !context.mounted) return false;
        showSnack(messenger, l10n.subscriptionsUnsubscribing(s.name), duration: const Duration(seconds: 30));
        final result = await ref.read(oneClickUnsubscriberProvider).unsubscribe(uri);
        if (result.ok) {
          await ref.read(unsubscribeRecordsProvider.notifier).record(s.key, UnsubscribeVia.oneClick);
          showSnack(messenger, l10n.subscriptionsUnsubscribed(s.name));
          return true;
        }
        messenger.hideCurrentSnackBar();
        if (!context.mounted) return false;
        final reason = oneClickFailureText(l10n, result) ?? '';
        final others = [
          for (final m in methods)
            if (m is! OneClickUnsubscribe) m,
        ];
        if (others.isEmpty) {
          showSnack(messenger, l10n.subscriptionsUnsubscribeFailed(reason));
          return false;
        }
        final next = await showActionSheet<UnsubscribeMethod>(
          context,
          title: l10n.subscriptionsOneClickFailedTitle,
          message: reason,
          actions: [for (final m in others) SheetAction(_methodAction(l10n, m), m)],
        );
        if (next == null || !context.mounted) return false;
        return unsubscribe(s, method: next);
      case final MailtoUnsubscribe m:
        return _unsubscribeByMail(s, m, messenger);
      case WebUnsubscribe(:final uri, :final isSecure):
        final host = inspectHost(uri.host);
        final ok = await _confirm(
          title: l10n.subscriptionsOpenSiteTitle(host.display),
          message: [
            l10n.subscriptionsWebExplanation(s.name),
            if (!isSecure) l10n.subscriptionsWebInsecure,
            if (host.homograph) _homographWarning(l10n, host.looksLike),
          ].join('\n\n'),
          action: l10n.subscriptionsOpen,
        );
        if (!ok || !context.mounted) return false;
        final opened = await ref.read(webPageOpenerProvider)(uri);
        if (!opened) {
          showSnack(messenger, l10n.subscriptionsOpenSiteFailed(host.display));
          return false;
        }
        await ref.read(unsubscribeRecordsProvider.notifier).record(s.key, UnsubscribeVia.web);
        showSnack(messenger, l10n.subscriptionsWebOpened(s.name));
        return true;
    }
  }

  static String _methodAction(AppLocalizations l10n, UnsubscribeMethod m) => switch (m) {
    OneClickUnsubscribe() => l10n.commonTryAgain,
    MailtoUnsubscribe() => l10n.subscriptionsSendUnsubscribeEmail,
    WebUnsubscribe(:final uri) => l10n.subscriptionsOpenSite(inspectHost(uri.host).display),
  };

  static String _homographWarning(AppLocalizations l10n, String? looksLike) =>
      looksLike == null ? l10n.subscriptionsHomographWarningUnknown : l10n.subscriptionsHomographWarning(looksLike);

  Future<bool> _confirmOneClick(Subscription s, Uri uri) async {
    final l10n = context.l10n;
    final explained = ref.read(oneClickExplainedProvider);
    final host = inspectHost(uri.host);
    final ok = await _confirm(
      title: l10n.subscriptionsUnsubscribeTitle(s.name),
      message: [
        l10n.subscriptionsOneClickContact(host.display),
        if (!explained) l10n.subscriptionsOneClickExplanation(s.name),
        if (host.homograph) _homographWarning(l10n, host.looksLike),
      ].join('\n\n'),
      action: l10n.subscriptionsUnsubscribe,
    );
    if (ok && !explained) await ref.read(oneClickExplainedProvider.notifier).set();
    return ok;
  }

  Future<bool> _unsubscribeByMail(Subscription s, MailtoUnsubscribe m, ScaffoldMessengerState messenger) async {
    final l10n = context.l10n;
    final accounts = ref.read(accountsProvider).value ?? const <MailAccount>[];
    final latest = await _subs?.watchSubscriptionEmails(s.key, limit: 1).first ?? const <EmailSummary>[];
    final accountId = latest.firstOrNull?.accountId ?? s.accountIds.firstOrNull;
    final account = accounts.where((a) => a.id == accountId).firstOrNull;
    if (account == null || !context.mounted) {
      showSnack(messenger, l10n.subscriptionsNoAccountToSend);
      return false;
    }
    final message = unsubscribeMessage(
      m,
      account,
      receivedAs: [for (final e in latest) ...e.to, for (final e in latest) ...e.cc],
    );
    final from = account.identityById(message.identityId).email;
    final ok = await _confirm(
      title: l10n.subscriptionsUnsubscribeTitle(s.name),
      message: l10n.subscriptionsMailConfirm(m.to.map((a) => a.email).join(', '), from, m.subject),
      action: l10n.mailSend,
    );
    if (!ok || !context.mounted) return false;
    try {
      await _repo.send(message, undoDelay: Duration.zero);
    } on MailException catch (e) {
      showSnack(messenger, e.message);
      return false;
    }
    await ref.read(unsubscribeRecordsProvider.notifier).record(s.key, UnsubscribeVia.mail);
    showSnack(messenger, l10n.subscriptionsMailSent(m.to.first.email));
    return true;
  }

  Future<bool> _confirm({required String title, required String message, required String action}) async {
    final ok = await showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Padding(padding: const EdgeInsets.only(top: 8), child: Text(message)),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.commonCancel),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(action),
          ),
        ],
      ),
    );
    return ok ?? false;
  }

  // Follow-ups ------------------------------------------------------------------------

  /// Archives [s]'s mail in the Inbox, with Undo. Returns whether it did.
  Future<bool> archiveAll(Subscription s) async {
    final emails = await _subs?.watchSubscriptionEmails(s.key, inboxOnly: true, limit: 1 << 20).first;
    if (emails == null || emails.isEmpty || !context.mounted) return false;
    return MailActions(context, ref, scope: null, threaded: false).archiveEmails(emails);
  }

  /// The archive folder of [accountId] (Gmail: All Mail).
  String? _archiveOf(String accountId) {
    final boxes = ref.read(mailboxesProvider).value ?? const <Mailbox>[];
    final mine = boxes.where((m) => m.accountId == accountId);
    return (mine.where((m) => m.role == MailboxRole.archive).firstOrNull ??
            mine.where((m) => m.role == MailboxRole.all).firstOrNull)
        ?.id;
  }

  /// Opens the rule editor for [s]'s future mail, set to archive it.
  void createRule(Subscription s) {
    final archive = s.accountIds.isEmpty ? null : _archiveOf(s.accountIds.first);
    unawaited(
      context.push(
        Routes.newRule(
          condition: subscriptionCondition(s),
          name: s.name,
          actions: [if (archive != null) MoveToMailboxAction(archive)],
        ),
      ),
    );
  }

  /// Adds a rule sending [s]'s future mail to Junk, after asking; then
  /// offers to move what is in the Inbox there too.
  Future<bool> block(Subscription s) async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.subscriptionsBlockTitle(s.name),
      message: s.isList && s.senderCount > 1
          ? l10n.subscriptionsBlockListMessage
          : l10n.subscriptionsBlockSenderMessage(s.address),
      action: l10n.subscriptionsBlock,
    );
    if (!ok || !context.mounted) return false;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _repo.rules.saveRule(blockRule(l10n, s));
    } on MailException catch (e) {
      showSnack(messenger, e.message);
      return false;
    }
    final inbox = s.inboxCount;
    showSnack(
      messenger,
      l10n.subscriptionsBlockedSender(s.name),
      action: inbox == 0 || !context.mounted
          ? null
          : SnackBarAction(label: l10n.subscriptionsMoveToJunk(inbox), onPressed: () => unawaited(_junkInbox(s))),
      duration: const Duration(seconds: 6),
    );
    return true;
  }

  // Newsletters and discussions --------------------------------------------------------

  /// "Treat as Newsletter" / "Treat as Discussion": every List-Id of [s]
  /// becomes [kind] on this device, with Undo.
  Future<void> setKind(Subscription s, SubscriptionKind kind) async {
    final subs = _subs;
    final lists = s.listIds;
    if (subs == null || lists.isEmpty) return;
    unawaited(HapticFeedback.selectionClick());
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    await subs.setListKind(lists, kind);
    showSnack(
      messenger,
      kind == SubscriptionKind.newsletter
          ? l10n.subscriptionsNowNewsletter(s.name)
          : l10n.subscriptionsNowDiscussion(s.name),
      action: SnackBarAction(label: l10n.commonUndo, onPressed: () => unawaited(subs.setListKind(lists, s.kind))),
    );
  }

  /// Pins the discussion [s] to the Mailboxes screen, or unpins it.
  Future<void> togglePin(Subscription s) async {
    final listId = s.listId;
    if (listId == null) return;
    unawaited(HapticFeedback.selectionClick());
    await ref.read(pinnedListsProvider.notifier).toggle(listId);
  }

  /// Opens the messages of the discussion [s] as plain text in Mono (Settings
  /// › Technical Lists), or in the default view again.
  Future<void> toggleTechnical(Subscription s) async {
    final listId = s.listId;
    if (listId == null) return;
    final technical = ref.read(readerPrefsProvider).technicalLists.contains(listId);
    await ref.read(readerPrefsProvider.notifier).setTechnicalList(listId, technical: !technical);
  }

  Future<void> _junkInbox(Subscription s) async {
    final emails = await _subs?.watchSubscriptionEmails(s.key, inboxOnly: true, limit: 1 << 20).first;
    if (emails == null || emails.isEmpty || !context.mounted) return;
    await MailActions(context, ref, scope: null, threaded: false).junkEmails(emails, junk: true);
  }
}
