import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../shared/mail_actions.dart';
import '../../shared/message_row.dart';
import '../../shared/sheets.dart';
import '../../shared/swipe_row.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../compose/send_later.dart';

/// Messages waiting in every account's Snoozed folder, the soonest to wake
/// first. The Mailboxes screen shows a Snoozed row while there are any.
final snoozedProvider = StreamProvider<List<EmailSummary>>((ref) => ref.watch(repositoryProvider).watchSnoozed());

/// The Snoozed mailbox: every snoozed message with the time it comes back.
/// Swipe right to wake one now, left to change its time; long-press for both.
class SnoozedScreen extends ConsumerWidget {
  const SnoozedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(snoozedProvider).value ?? const <EmailSummary>[];
    final accounts = {for (final a in ref.watch(accountsProvider).value ?? const <MailAccount>[]) a.id: a};
    final vips = ref.watch(vipAddressesProvider).value ?? const <String>{};
    final colors = LoupeColors.of(context);
    final actions = MailActions(context, ref, scope: null, threaded: false);
    final now = DateTime.now();
    final l10n = context.l10n;

    Future<void> changeTime(EmailSummary e) async {
      final at = await actions.askSnoozeTime(current: e.snoozedUntil);
      if (at != null && context.mounted) await actions.snoozeEmails([e], at);
    }

    Future<void> menu(EmailSummary e) async {
      unawaited(HapticFeedback.mediumImpact());
      final choice = await showActionSheet<String>(
        context,
        title: e.subject.trim().isEmpty ? null : e.subject,
        actions: [
          SheetAction(l10n.snoozeWakeNow, 'wake', icon: LoupeIcons.wakeNow),
          SheetAction(l10n.snoozeChangeTimeMenu, 'change', icon: LoupeIcons.snooze),
        ],
      );
      if (!context.mounted) return;
      switch (choice) {
        case 'wake':
          await actions.wakeEmails([e]);
        case 'change':
          await changeTime(e);
      }
    }

    String wakeLabel(EmailSummary e) => switch (e.snoozedUntil) {
      final t? => formatSendTimeFor(context, t, now: now, compact: true),
      null => l10n.snoozeNoTime,
    };

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          LoupeTitleBar(title: l10n.snoozeTitle),
          // A pull also wakes what is due.
          CupertinoSliverRefreshControl(onRefresh: () => ref.read(repositoryProvider).refresh()),
          if (items.isEmpty)
            const SliverFillRemaining(hasScrollBody: false, child: _Empty())
          else ...[
            SliverList.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final e = items[i];
                final account = accounts[e.accountId];
                return SwipeActionRow(
                  key: ValueKey(e.id),
                  leading: [
                    SwipeActionSpec(
                      icon: LoupeIcons.swipeWakeNow,
                      label: l10n.snoozeWakeNow,
                      color: colors.swipeRead,
                      removesRow: true,
                      onTriggered: () => actions.wakeEmails([e]),
                    ),
                  ],
                  trailing: [
                    SwipeActionSpec(
                      icon: LoupeIcons.swipeSnooze,
                      label: l10n.snoozeChangeTime,
                      color: colors.snooze,
                      onTriggered: () => changeTime(e),
                    ),
                  ],
                  child: MessageRow(
                    email: e,
                    isVip: e.from.any((f) => vips.contains(f.email.toLowerCase())),
                    accountColor: accounts.length > 1 && account != null
                        ? colors.accountColor(account.colorIndex)
                        : null,
                    wakeTime: wakeLabel(e),
                    onTap: () => context.push(Routes.message(e.id)),
                    onLongPress: () => menu(e),
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 14, 32, 0),
                child: Text(
                  l10n.snoozeFooter,
                  style: LoupeTextStyles.of(context).footnote,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          SliverToBoxAdapter(child: SizedBox(height: 24 + MediaQuery.paddingOf(context).bottom)),
        ],
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
          Icon(LoupeIcons.snoozed, size: 52, color: colors.tertiaryText),
          const SizedBox(height: 14),
          Text(context.l10n.snoozeEmptyTitle, style: styles.sectionHeader.copyWith(color: colors.secondaryText)),
          const SizedBox(height: 6),
          Text(context.l10n.snoozeEmptyText, style: styles.footnote, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
