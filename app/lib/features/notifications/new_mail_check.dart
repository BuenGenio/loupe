import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../platform/support_directory.dart';
import '../openpgp/decrypted_mail.dart';
import 'mail_notifier.dart';
import 'new_mail.dart';
import 'notification_content.dart';
import 'notification_settings.dart';

/// Looks for new mail after a sync and notifies about it; also tidies what
/// is showing. Runs after each background sync, and silently when the app
/// goes to the background (what arrived while it was open was seen there).
final class NewMailCheck {
  NewMailCheck({
    required this.notifier,
    required this.state,
    this.subjects,
    this.subjectBudget = const Duration(seconds: 15),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final MailNotifier notifier;
  final NewMailStateStore state;

  /// Decrypts the protected subjects of new encrypted mail before it is
  /// notified (Decrypt Subjects in the Background); returns null when that
  /// is off or no key can do it without a passphrase.
  final Future<SubjectDecryptor?> Function()? subjects;

  /// How long notifying may wait for [subjects].
  final Duration subjectBudget;
  final DateTime Function() _clock;

  /// Finds mail that arrived since the last check and shows notifications
  /// for it under [settings]; [silent] only moves the watermarks. [since]
  /// is when the sync before this check started (default: now).
  ///
  /// Returns the new mail found (notified or not).
  Future<List<NewMail>> run(
    MailRepository repository,
    NotificationSettings settings, {
    bool silent = false,
    DateTime? since,
  }) async {
    final detection = await detectNewMail(repository, await state.read(), now: since ?? _clock());
    if (!silent && detection.mail.isNotEmpty) {
      final mail = await _withSubjects(repository, detection.mail);
      final accounts = await repository.watchAccounts().first;
      final mailboxes = await repository.watchMailboxes().first;
      final notifications = messageNotifications(
        mail,
        accounts: accounts,
        settings: settings,
        archivable: archivableAccounts(accounts, mailboxes),
      );
      if (notifications.isNotEmpty) await notifier.show(notifications);
    }
    // After showing: a check cut short re-notifies (quietly: same ids)
    // rather than losing mail.
    await state.write(detection.state);
    await tidy(repository, settings);
    return detection.mail;
  }

  /// [mail] with the protected subjects [subjects] could decrypt.
  Future<List<NewMail>> _withSubjects(MailRepository repository, List<NewMail> mail) async {
    final factory = subjects;
    if (factory == null || !mail.any((m) => m.email.isEncrypted && !m.email.hasDecryptedSubject)) return mail;
    try {
      final decryptor = await factory();
      if (decryptor == null) return mail;
      final found = await decryptor.decrypt(repository, [for (final m in mail) m.email], budget: subjectBudget);
      return [
        for (final m in mail)
          if (found[m.email.id] case final subject?)
            NewMail(m.email.copyWith(subject: subject, hasDecryptedSubject: true), fromVip: m.fromVip)
          else
            m,
      ];
    } on Object {
      return mail;
    }
  }

  /// Removes notifications of messages that were read, moved or deleted
  /// (here or on another device) or whose account is muted, and refreshes
  /// each account's group summary.
  Future<void> tidy(MailRepository repository, NotificationSettings settings) async {
    final accounts = {for (final a in await repository.watchAccounts().first) a.id: a};
    final children = <String, List<ShownNotification>>{};
    final summaries = <String>{};
    for (final n in await notifier.shown()) {
      switch (n.target) {
        case MessageTarget(:final emailId, :final accountId):
          final email = await repository.getEmail(emailId);
          final stale =
              email == null ||
              email.isSeen ||
              // A local move renames the message.
              email.id != emailId ||
              !accounts.containsKey(accountId) ||
              !settings.notifiesFor(accountId);
          if (stale) {
            await notifier.cancel(n.id, tag: n.tag);
          } else {
            (children[accountId] ??= []).add(n);
          }
        case AccountTarget(:final accountId):
          summaries.add(accountId);
        case null:
          break;
      }
    }
    for (final accountId in {...summaries, ...children.keys}) {
      final account = accounts[accountId];
      final list = children[accountId] ?? const <ShownNotification>[];
      if (account == null || list.isEmpty) {
        await notifier.cancel(summaryNotificationId(accountId), tag: AccountTarget(accountId).encode());
      } else {
        await notifier.show([summaryNotification(account, list, hideContent: settings.hideContent)]);
      }
    }
  }
}

/// Accounts with somewhere to archive to (Archive, or All Mail on Gmail),
/// whose notifications get an Archive button.
Set<String> archivableAccounts(List<MailAccount> accounts, List<Mailbox> mailboxes) {
  final gmail = {
    for (final a in accounts)
      if (a.provider == ProviderKind.gmail) a.id,
  };
  return {
    for (final m in mailboxes)
      if (m.role == MailboxRole.archive || (m.role == MailboxRole.all && gmail.contains(m.accountId))) m.accountId,
  };
}

final newMailCheckProvider = Provider<NewMailCheck>(
  (ref) => NewMailCheck(
    notifier: ref.watch(mailNotifierProvider),
    state: FileNewMailStateStore(ref.watch(supportDirectoryProvider.future)),
  ),
);
