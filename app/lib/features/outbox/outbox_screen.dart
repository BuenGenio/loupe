import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../shared/sheets.dart';
import '../../shared/swipe_row.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../compose/compose_args.dart';
import '../compose/send_later.dart';
import '../conversation/sheets.dart' show showSnack;
import '../openpgp/openpgp_providers.dart';

/// Messages waiting to be sent: queued (undo window), scheduled, being sent
/// and failed. The Mailboxes screen shows an Outbox row while there are any.
final outboxProvider = StreamProvider<List<OutboxItem>>((ref) => ref.watch(repositoryProvider).watchOutbox());

/// The Outbox: failed messages first (with their error and Retry), then
/// those about to go and the scheduled ones. Tap one to edit it; swipe or
/// long-press for Send Now, Reschedule and Cancel.
class OutboxScreen extends ConsumerWidget {
  const OutboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(outboxProvider).value ?? const <OutboxItem>[];
    final actions = OutboxActions(context, ref);
    final failed = [
      for (final i in items)
        if (i.status == OutboxStatus.failed) i,
    ];
    final sending = [
      for (final i in items)
        if (i.status == OutboxStatus.queued || i.status == OutboxStatus.sending) i,
    ];
    final scheduled = [
      for (final i in items)
        if (i.status == OutboxStatus.scheduled) i,
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const LoupeTitleBar(title: 'Outbox'),
          if (items.isEmpty)
            const SliverFillRemaining(hasScrollBody: false, child: _Empty())
          else
            for (final (title, list) in [('Not Sent', failed), ('Sending', sending), ('Scheduled', scheduled)])
              if (list.isNotEmpty) ...[
                SliverToBoxAdapter(child: _SectionHeader(title)),
                SliverList.builder(itemCount: list.length, itemBuilder: (context, i) => actions.row(list[i])),
              ],
          SliverToBoxAdapter(child: SizedBox(height: 24 + MediaQuery.paddingOf(context).bottom)),
        ],
      ),
    );
  }
}

/// What can be done to a waiting message, with feedback in a snack bar.
class OutboxActions {
  OutboxActions(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  MailRepository get _repo => ref.read(repositoryProvider);

  Future<void> _run(Future<void> Function(ScaffoldMessengerState messenger) action) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action(messenger);
    } on MailException catch (e) {
      showSnack(messenger, e.message);
    } on Object catch (e) {
      debugPrint('Outbox action failed: ${e.runtimeType}');
      showSnack(messenger, 'That didn’t work. The message is still in the Outbox.');
    }
  }

  /// Reopens compose; sending there replaces the waiting message.
  Future<void> edit(OutboxItem item) async {
    if (item.status == OutboxStatus.sending) {
      showSnack(ScaffoldMessenger.of(context), 'This message is being sent.');
      return;
    }
    await context.push<void>(
      Routes.compose,
      extra: ComposeArgs.restore(
        item.message,
        sendAt: item.status == OutboxStatus.scheduled ? item.sendAt : null,
        outboxId: item.id,
      ),
    );
  }

  /// Send Now, and Retry of a failed message.
  Future<void> sendNow(OutboxItem item) async {
    if (!await _unlockToSign(item) || !context.mounted) return;
    await _run((_) => _repo.sendNow(item.id));
  }

  /// Signed OpenPGP mail composed again needs its key: Send Now before the
  /// time it was composed for, a new time ([recompose]), or a Retry of one
  /// that waited for the key (composed when queued, it goes out without
  /// one). Asks for the passphrase now, while the user is here, so it can
  /// go out from the background later. False if they cancelled.
  Future<bool> _unlockToSign(OutboxItem item, {bool recompose = false}) async {
    final m = item.message;
    if (!m.security.sign || m.security.isSmime) return true;
    final composed = item.composedFor;
    if (!recompose && composed != null && !composed.isAfter(clock.now())) return true;
    try {
      final account = (await _repo.watchAccounts().first).where((a) => a.id == m.accountId).firstOrNull;
      if (account == null) return true;
      if (!context.mounted) return false;
      final service = await ref.read(openPgpServiceProvider.future);
      final key = service.state.ownKeyFor(account.identityById(m.identityId).email);
      if (key == null) return true;
      return await service.unlock(key.fingerprint) != null;
    } on Object catch (e) {
      // Sending says what is wrong.
      debugPrint('Unlocking to send failed: ${e.runtimeType}');
      return true;
    }
  }

  Future<void> reschedule(OutboxItem item) async {
    final scheduled = item.status == OutboxStatus.scheduled;
    final choice = await showSendLaterSheet(
      context,
      now: clock.now(),
      current: scheduled ? item.sendAt : null,
      title: 'Reschedule',
    );
    if (choice == null || !context.mounted) return;
    final at = choice.at;
    if (at == null) return sendNow(item);
    // Composed again for the new time.
    if (!await _unlockToSign(item, recompose: true) || !context.mounted) return;
    await _run((messenger) async {
      await _repo.rescheduleSend(item.id, at);
      wakeUpAt(ref, at);
      if (!context.mounted) return;
      showSnack(messenger, 'Rescheduled for ${formatSendTimeFor(context, at, now: DateTime.now())}');
    });
  }

  /// Takes the message out of the Outbox: back to Drafts, or discarded
  /// (with Undo, which queues it again).
  Future<void> cancel(OutboxItem item) async {
    final choice = await showActionSheet<bool>(
      context,
      title: 'Cancel Sending?',
      actions: const [
        SheetAction('Move to Drafts', true, icon: LoupeIcons.drafts),
        SheetAction('Discard Message', false, icon: LoupeIcons.trash, destructive: true),
      ],
    );
    if (choice == null || !context.mounted) return;
    final repo = _repo;
    await _run((messenger) async {
      if (choice) {
        // Into Drafts first: if saving fails (often why sending failed:
        // the server refused it), the message stays in the Outbox.
        final draftId = await repo.saveDraft(item.message);
        if (await repo.cancelSend(item.id) == null) {
          // It went out meanwhile: the copy in Drafts isn't wanted.
          try {
            await repo.deleteDraft(draftId);
          } on Object {
            // Left in Drafts; harmless.
          }
          showSnack(messenger, 'Already sent.');
          return;
        }
        showSnack(messenger, 'Moved to Drafts');
        return;
      }
      final message = await repo.cancelSend(item.id);
      if (message == null) {
        showSnack(messenger, 'Already sent.');
        return;
      }
      // Undo restores the schedule as it was; one that is overdue by then
      // is sent at once by the repository.
      final scheduled = item.status == OutboxStatus.scheduled;
      showSnack(
        messenger,
        'Message discarded',
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            try {
              await repo.send(message, sendAt: scheduled ? item.sendAt : null);
            } on MailException catch (e) {
              showSnack(messenger, e.message);
            }
          },
        ),
      );
    });
  }

  Future<void> showMenu(OutboxItem item) async {
    if (item.status == OutboxStatus.sending) return;
    final failed = item.status == OutboxStatus.failed;
    final choice = await showActionSheet<String>(
      context,
      title: item.message.subject.isEmpty ? null : item.message.subject,
      actions: [
        SheetAction(failed ? 'Retry' : 'Send Now', 'send', icon: failed ? LoupeIcons.retry : LoupeIcons.sendNow),
        const SheetAction('Reschedule…', 'reschedule', icon: LoupeIcons.reschedule),
        const SheetAction('Edit', 'edit', icon: LoupeIcons.edit),
        const SheetAction('Cancel Sending…', 'cancel', icon: LoupeIcons.cancelSend, destructive: true),
      ],
    );
    if (choice == null || !context.mounted) return;
    switch (choice) {
      case 'send':
        await sendNow(item);
      case 'reschedule':
        await reschedule(item);
      case 'edit':
        await edit(item);
      case 'cancel':
        await cancel(item);
    }
  }

  Widget row(OutboxItem item) {
    final colors = LoupeColors.of(context);
    final busy = item.status == OutboxStatus.sending;
    return SwipeActionRow(
      key: ValueKey(item.id),
      enabled: !busy,
      leading: [
        SwipeActionSpec(
          icon: LoupeIcons.swipeSendNow,
          label: item.status == OutboxStatus.failed ? 'Retry' : 'Send Now',
          color: colors.swipeRead,
          onTriggered: () => sendNow(item),
        ),
      ],
      trailing: [
        SwipeActionSpec(
          icon: LoupeIcons.swipeCancelSend,
          label: 'Cancel',
          color: colors.swipeTrash,
          onTriggered: () => cancel(item),
        ),
        SwipeActionSpec(
          icon: LoupeIcons.swipeReschedule,
          label: 'Reschedule',
          color: colors.swipeFlag,
          onTriggered: () => reschedule(item),
        ),
      ],
      child: _OutboxRow(
        item: item,
        onTap: () => edit(item),
        onLongPress: () => showMenu(item),
        onRetry: () => sendNow(item),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
    child: Semantics(
      header: true,
      child: Text(title.toUpperCase(), style: LoupeTextStyles.of(context).footnote.copyWith(letterSpacing: 0.2)),
    ),
  );
}

/// One waiting message: recipients and when it goes, the subject, then the
/// error and Retry if it failed, or the start of the text.
class _OutboxRow extends StatelessWidget {
  const _OutboxRow({required this.item, required this.onTap, required this.onLongPress, required this.onRetry});

  final OutboxItem item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final metrics = LoupeMetrics.of(context);
    final m = item.message;
    final recipients = [
      for (final a in [...m.to, ...m.cc, ...m.bcc]) a.displayName,
    ];
    final failed = item.status == OutboxStatus.failed;
    final when = switch (item.status) {
      OutboxStatus.scheduled => formatSendTimeFor(context, item.sendAt, now: DateTime.now(), compact: true),
      OutboxStatus.queued => 'Sending soon',
      OutboxStatus.sending => 'Sending…',
      OutboxStatus.failed => 'Not sent',
    };
    final preview = m.text.replaceAll(RegExp(r'\s+'), ' ').trim();
    final gutter = switch (item.status) {
      OutboxStatus.sending => const CupertinoActivityIndicator(radius: 7),
      OutboxStatus.failed => Icon(LoupeIcons.warning, size: 16, color: colors.destructive),
      OutboxStatus.scheduled => Icon(LoupeIcons.sendLater, size: 16, color: colors.secondaryText),
      OutboxStatus.queued => Icon(LoupeIcons.sendNow, size: 16, color: colors.secondaryText),
    };
    return MergeSemantics(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: metrics.rowVerticalPadding,
                  bottom: metrics.rowVerticalPadding,
                  right: 14,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: metrics.rowGutter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Center(child: gutter),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  recipients.isEmpty ? 'No Recipients' : recipients.join(', '),
                                  style: styles.sender,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(when, style: styles.date.copyWith(color: failed ? colors.destructive : null)),
                            ],
                          ),
                          const SizedBox(height: 1),
                          Text(
                            m.subject.isEmpty ? '(No Subject)' : m.subject,
                            style: styles.subject,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (failed) ...[
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                item.error ?? 'Sending failed.',
                                style: styles.preview.copyWith(color: colors.destructive),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CupertinoButton(
                                key: ValueKey('outbox-retry-${item.id}'),
                                padding: const EdgeInsets.only(top: 4),
                                minimumSize: const Size(44, 32),
                                onPressed: onRetry,
                                child: const Text('Retry', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ] else if (preview.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Text(preview, style: styles.preview, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: metrics.rowGutter,
                right: 0,
                bottom: 0,
                child: Divider(height: 0.5, thickness: 0.5, color: colors.separator),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LoupeIcons.outbox, size: 52, color: colors.tertiaryText),
          const SizedBox(height: 14),
          Text('Nothing to Send', style: styles.sectionHeader.copyWith(color: colors.secondaryText)),
          const SizedBox(height: 6),
          Text(
            'Messages you send later wait here until it’s time.',
            style: styles.footnote,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
