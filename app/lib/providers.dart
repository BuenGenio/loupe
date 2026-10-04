import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import 'shared/mailbox_display.dart';

/// The active repository: demo data or real accounts. Every screen reads mail
/// only through this. Overridden at startup (with `repositoryForMode`) and in tests.
final repositoryProvider = Provider<MailRepository>(
  (ref) => throw UnimplementedError('repositoryProvider must be overridden'),
);

final accountsProvider = StreamProvider<List<MailAccount>>((ref) => ref.watch(repositoryProvider).watchAccounts());

/// Mailboxes of every account, with unread and total counts; each role is
/// held by one mailbox per account.
final mailboxesProvider = StreamProvider<List<Mailbox>>(
  (ref) => ref.watch(repositoryProvider).watchMailboxes().map(withUniqueRoles),
);

final virtualCountsProvider = StreamProvider<Map<VirtualMailbox, int>>(
  (ref) => ref.watch(repositoryProvider).watchVirtualCounts(),
);

final syncStatusProvider = StreamProvider<List<AccountSyncStatus>>(
  (ref) => ref.watch(repositoryProvider).watchSyncStatus(),
);

/// Lower-cased VIP addresses.
final vipAddressesProvider = StreamProvider<Set<String>>((ref) => ref.watch(repositoryProvider).watchVipAddresses());

/// What a message list shows. Value-equal, so it can key a provider family.
@immutable
final class ListQuery {
  const ListQuery(this.ref, {this.filters = const {}, this.threaded = true});

  final MailboxRef ref;
  final Set<QuickFilter> filters;
  final bool threaded;

  @override
  bool operator ==(Object other) =>
      other is ListQuery && other.ref == ref && setEquals(other.filters, filters) && other.threaded == threaded;

  @override
  int get hashCode => Object.hash(ref, Object.hashAllUnordered(filters), threaded);
}

final messageListProvider = StreamProvider.autoDispose.family<List<ThreadSummary>, ListQuery>(
  (ref, query) => ref.watch(repositoryProvider).watchList(query.ref, filters: query.filters, threaded: query.threaded),
);
