import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart' show inspectHost;

import '../../providers.dart';
import '../../router.dart';
import '../../shared/mail_actions.dart';
import '../../shared/sheets.dart';
import '../conversation/sheets.dart' show showSnack;
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
    if (chosen == null) {
      showSnack(messenger, '${s.name} doesn’t say how to unsubscribe. You can block it instead.');
      return false;
    }
    unawaited(HapticFeedback.selectionClick());
    switch (chosen) {
      case OneClickUnsubscribe(:final uri):
        if (!await _confirmOneClick(s, uri) || !context.mounted) return false;
        showSnack(messenger, 'Unsubscribing from ${s.name}…', duration: const Duration(seconds: 30));
        final result = await ref.read(oneClickUnsubscriberProvider).unsubscribe(uri);
        if (result.ok) {
          await ref.read(unsubscribeRecordsProvider.notifier).record(s.key, UnsubscribeVia.oneClick);
          showSnack(messenger, 'Unsubscribed from ${s.name}.');
          return true;
        }
        messenger.hideCurrentSnackBar();
        if (!context.mounted) return false;
        final others = [
          for (final m in methods)
            if (m is! OneClickUnsubscribe) m,
        ];
        if (others.isEmpty) {
          showSnack(messenger, 'Couldn’t unsubscribe: ${result.message}');
          return false;
        }
        final next = await showActionSheet<UnsubscribeMethod>(
          context,
          title: 'Couldn’t Unsubscribe Automatically',
          message: result.message,
          actions: [for (final m in others) SheetAction(_methodAction(m), m)],
        );
        if (next == null || !context.mounted) return false;
        return unsubscribe(s, method: next);
      case final MailtoUnsubscribe m:
        return _unsubscribeByMail(s, m, messenger);
      case WebUnsubscribe(:final uri, :final isSecure):
        final host = inspectHost(uri.host);
        final ok = await _confirm(
          title: 'Open ${host.display}?',
          message: [
            '${s.name} unsubscribes on its website. The page opens in Loupe’s browser; finish there.',
            if (!isSecure) 'The connection to this site isn’t encrypted.',
            if (host.homograph) _homographWarning(host.looksLike),
          ].join('\n\n'),
          action: 'Open',
        );
        if (!ok || !context.mounted) return false;
        final opened = await ref.read(webPageOpenerProvider)(uri);
        if (!opened) {
          showSnack(messenger, 'Couldn’t open ${host.display}.');
          return false;
        }
        await ref.read(unsubscribeRecordsProvider.notifier).record(s.key, UnsubscribeVia.web);
        showSnack(messenger, 'Loupe notes today’s date and tells you if ${s.name} keeps writing.');
        return true;
    }
  }

  static String _methodAction(UnsubscribeMethod m) => switch (m) {
    OneClickUnsubscribe() => 'Try Again',
    MailtoUnsubscribe() => 'Send Unsubscribe Email',
    WebUnsubscribe(:final uri) => 'Open ${inspectHost(uri.host).display}',
  };

  static String _homographWarning(String? looksLike) =>
      'Careful: this address imitates ${looksLike ?? 'another site'} with look-alike letters.';

  Future<bool> _confirmOneClick(Subscription s, Uri uri) async {
    final explained = ref.read(oneClickExplainedProvider);
    final host = inspectHost(uri.host);
    final ok = await _confirm(
      title: 'Unsubscribe from ${s.name}?',
      message: [
        'Loupe will contact ${host.display} to unsubscribe.',
        if (!explained)
          'This is the only time Loupe connects to a website by itself. It sends just '
              '“List-Unsubscribe=One-Click” to the address ${s.name} gave, without cookies or anything else '
              'about you, and doesn’t load the page.',
        if (host.homograph) _homographWarning(host.looksLike),
      ].join('\n\n'),
      action: 'Unsubscribe',
    );
    if (ok && !explained) await ref.read(oneClickExplainedProvider.notifier).set();
    return ok;
  }

  Future<bool> _unsubscribeByMail(Subscription s, MailtoUnsubscribe m, ScaffoldMessengerState messenger) async {
    final accounts = ref.read(accountsProvider).value ?? const <MailAccount>[];
    final latest = await _subs?.watchSubscriptionEmails(s.key, limit: 1).first ?? const <EmailSummary>[];
    final accountId = latest.firstOrNull?.accountId ?? s.accountIds.firstOrNull;
    final account = accounts.where((a) => a.id == accountId).firstOrNull;
    if (account == null || !context.mounted) {
      showSnack(messenger, 'There’s no account to send the unsubscribe email from.');
      return false;
    }
    final message = unsubscribeMessage(
      m,
      account,
      receivedAs: [for (final e in latest) ...e.to, for (final e in latest) ...e.cc],
    );
    final from = account.identityById(message.identityId).email;
    final ok = await _confirm(
      title: 'Unsubscribe from ${s.name}?',
      message:
          'Loupe will send an email to ${m.to.map((a) => a.email).join(', ')} from $from, '
          'with the subject “${m.subject}”.',
      action: 'Send',
    );
    if (!ok || !context.mounted) return false;
    try {
      await _repo.send(message, undoDelay: Duration.zero);
    } on MailException catch (e) {
      showSnack(messenger, e.message);
      return false;
    }
    await ref.read(unsubscribeRecordsProvider.notifier).record(s.key, UnsubscribeVia.mail);
    showSnack(messenger, 'Unsubscribe email sent to ${m.to.first.email}.');
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
          CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
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
    final ok = await confirmDestructive(
      context,
      title: 'Block ${s.name}?',
      message:
          'New mail from ${s.isList && s.senderCount > 1 ? 'this list' : s.address} goes to Junk. '
          'You can change this in Settings › Rules.',
      action: 'Block',
    );
    if (!ok || !context.mounted) return false;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _repo.rules.saveRule(blockRule(s));
    } on MailException catch (e) {
      showSnack(messenger, e.message);
      return false;
    }
    final inbox = s.inboxCount;
    showSnack(
      messenger,
      'Blocked ${s.name}.',
      action: inbox == 0 || !context.mounted
          ? null
          : SnackBarAction(label: 'Move $inbox to Junk', onPressed: () => unawaited(_junkInbox(s))),
      duration: const Duration(seconds: 6),
    );
    return true;
  }

  Future<void> _junkInbox(Subscription s) async {
    final emails = await _subs?.watchSubscriptionEmails(s.key, inboxOnly: true, limit: 1 << 20).first;
    if (emails == null || emails.isEmpty || !context.mounted) return;
    await MailActions(context, ref, scope: null, threaded: false).junkEmails(emails, junk: true);
  }
}
