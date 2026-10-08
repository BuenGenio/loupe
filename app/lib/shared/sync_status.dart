import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mail_model/mail_model.dart';

import '../l10n/l10n.dart';
import '../providers.dart';
import '../theme/theme.dart';

/// "Updated Just Now" for the toolbar, from the accounts' sync status.
String syncStatusText(
  List<AccountSyncStatus> statuses,
  List<MailAccount> accounts,
  DateTime now,
  AppLocalizations l10n,
) {
  if (statuses.isEmpty) return accounts.isEmpty ? l10n.sharedSyncNoAccounts : '';
  if (statuses.any((s) => s.phase == SyncPhase.syncing)) return l10n.sharedSyncChecking;
  final failed = statuses.where((s) => s.phase == SyncPhase.error).toList();
  if (failed.isNotEmpty) {
    final name = accounts.where((a) => a.id == failed.first.accountId).map((a) => a.displayName).firstOrNull;
    final error = failed.first.error ?? l10n.sharedSyncFailed;
    return name == null ? error : l10n.sharedSyncAccountError(name, error);
  }
  if (statuses.every((s) => s.phase == SyncPhase.offline)) return l10n.sharedSyncOffline;
  final times = statuses.map((s) => s.lastSuccess).whereType<DateTime>().toList();
  if (times.isEmpty) return '';
  final oldest = times.reduce((a, b) => a.isBefore(b) ? a : b);
  final age = now.difference(oldest);
  if (age.inMinutes < 1) return l10n.sharedSyncJustNow;
  if (age.inMinutes < 60) return l10n.sharedSyncMinutesAgo(age.inMinutes);
  final sameDay = oldest.year == now.year && oldest.month == now.month && oldest.day == now.day;
  return sameDay
      ? l10n.sharedSyncAtTime(DateFormat.jm().format(oldest))
      : l10n.sharedSyncOnDate(DateFormat.MMMd().format(oldest));
}

/// The centre of a bottom toolbar: sync status, with an optional second line.
class SyncStatusLine extends ConsumerStatefulWidget {
  const SyncStatusLine({super.key, this.detail});

  /// Second line, e.g. "12 Unread".
  final String? detail;

  @override
  ConsumerState<SyncStatusLine> createState() => _SyncStatusLineState();
}

class _SyncStatusLineState extends ConsumerState<SyncStatusLine> {
  // "Updated 3 minutes ago" must age even when nothing else changes.
  late final Timer _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
    if (mounted) setState(() {});
  });

  @override
  void initState() {
    super.initState();
    _ticker;
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    final statuses = ref.watch(syncStatusProvider).value ?? const [];
    final accounts = ref.watch(accountsProvider).value ?? const [];
    final text = syncStatusText(statuses, accounts, DateTime.now(), context.l10n);
    final syncing = statuses.any((s) => s.phase == SyncPhase.syncing);
    return Semantics(
      liveRegion: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              text,
              key: ValueKey(text),
              style: styles.caption.copyWith(
                color: syncing ? LoupeColors.of(context).secondaryText : LoupeColors.of(context).label,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.detail != null && widget.detail!.isNotEmpty)
            Text(widget.detail!, style: styles.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
