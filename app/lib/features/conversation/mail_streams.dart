import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';

/// All accounts, for the message, compose and setup screens.
final accountsStreamProvider = StreamProvider.autoDispose<List<MailAccount>>(
  (ref) => ref.watch(repositoryProvider).watchAccounts(),
);

/// The mailboxes of one account.
final accountMailboxesProvider = StreamProvider.autoDispose.family<List<Mailbox>, String>(
  (ref, accountId) => ref.watch(repositoryProvider).watchMailboxes(accountId: accountId),
);

/// The user's own addresses (accounts and identities), lower-cased.
Set<String> ownAddresses(Iterable<MailAccount> accounts) => {
  for (final a in accounts) ...[a.email.toLowerCase(), for (final i in a.identities) i.email.toLowerCase()],
};
