import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import 'new_mail.dart';
import 'notification_settings.dart';

/// The buttons on a new-mail notification.
enum MailAction {
  archive('archive'),
  markRead('read'),
  reply('reply');

  const MailAction(this.id);

  /// The platform action id.
  final String id;

  String label(AppLocalizations l10n) => switch (this) {
    archive => l10n.mailArchive,
    markRead => l10n.mailMarkAsRead,
    reply => l10n.mailReply,
  };

  static MailAction? byId(String? id) => values.where((a) => a.id == id).firstOrNull;
}

/// Where tapping a notification leads; carried as its payload.
@immutable
sealed class NotificationTarget {
  const NotificationTarget();

  String encode();

  static NotificationTarget? decode(String? payload) {
    if (payload == null || payload.isEmpty) return null;
    try {
      final j = (jsonDecode(payload) as Map).cast<String, Object?>();
      return switch (j) {
        {'k': 'm', 'e': final String email, 'a': final String account} => MessageTarget(email, account),
        {'k': 'a', 'a': final String account} => AccountTarget(account),
        _ => null,
      };
    } on FormatException {
      return null;
    } on TypeError {
      return null;
    }
  }
}

/// A message: tapping opens it.
final class MessageTarget extends NotificationTarget {
  const MessageTarget(this.emailId, this.accountId);

  final String emailId;
  final String accountId;

  @override
  String encode() => jsonEncode({'k': 'm', 'e': emailId, 'a': accountId});

  @override
  bool operator ==(Object other) => other is MessageTarget && other.emailId == emailId;

  @override
  int get hashCode => emailId.hashCode;
}

/// An account's group summary: tapping opens its inbox.
final class AccountTarget extends NotificationTarget {
  const AccountTarget(this.accountId);

  final String accountId;

  @override
  String encode() => jsonEncode({'k': 'a', 'a': accountId});

  @override
  bool operator ==(Object other) => other is AccountTarget && other.accountId == accountId;

  @override
  int get hashCode => accountId.hashCode;
}

/// An Android notification channel: one per account and one for VIPs, so
/// each can have its own sound or be turned off in system settings.
@immutable
final class MailChannel {
  const MailChannel._(this.id, [this._account]);

  MailChannel.account(MailAccount account)
    : this._('mail.${account.id}', (name: accountName(account), email: account.email));

  static const vip = MailChannel._('mail.vip');

  /// Channels Loupe made for accounts start with this.
  static const accountPrefix = 'mail.';

  final String id;

  /// The account's name and address; null for [vip].
  final ({String name, String email})? _account;

  /// The account's name, or "VIP".
  String name(AppLocalizations l10n) => _account?.name ?? l10n.notificationsVipChannel;

  /// What the system's settings say about the channel.
  String description(AppLocalizations l10n) => switch (_account) {
    final account? => l10n.notificationsAccountChannelDescription(account.email),
    null => l10n.notificationsVipChannelDescription,
  };

  @override
  bool operator ==(Object other) => other is MailChannel && other.id == id && other._account?.name == _account?.name;

  @override
  int get hashCode => Object.hash(id, _account?.name);
}

String accountName(MailAccount account) => account.displayName.trim().isEmpty ? account.email : account.displayName;

/// One notification to show: plain data that the platform notifier turns
/// into an Android notification.
@immutable
final class MailNotification {
  const MailNotification({
    required this.id,
    required this.channel,
    required this.groupKey,
    required this.title,
    this.body,
    this.expandedBody,
    this.lines = const [],
    this.subText,
    this.when,
    this.target,
    this.actions = const [],
    this.isSummary = false,
  });

  final int id;
  final MailChannel channel;

  /// Notifications of one account group under its summary.
  final String groupKey;
  final bool isSummary;
  final String title;
  final String? body;

  /// Shown when expanded: subject and preview.
  final String? expandedBody;

  /// A summary's lines, one per message.
  final List<String> lines;

  /// The account, next to the app name.
  final String? subText;
  final DateTime? when;
  final NotificationTarget? target;
  final List<MailAction> actions;

  /// The platform tag: the target again. Android reports a showing
  /// notification's tag but not its payload, and cancels by id and tag.
  String? get tag => target?.encode();
}

/// A notification that is showing, as the system reports it: its id and
/// tag, and the text it shows.
@immutable
final class ShownNotification {
  const ShownNotification({required this.id, this.tag, this.title, this.body});

  final int id;
  final String? tag;
  final String? title;
  final String? body;

  NotificationTarget? get target => NotificationTarget.decode(tag);
}

/// A stable notification id for [key] (FNV-1a, 27 bits: the plugin numbers
/// a notification's buttons from id × 16, which must not overflow).
int notificationIdFor(String key) {
  var hash = 0x811c9dc5;
  for (final unit in utf8.encode(key)) {
    hash = ((hash ^ unit) * 0x01000193) & 0xffffffff;
  }
  final id = (hash ^ (hash >> 27)) & 0x07ffffff;
  return id == 0 ? 1 : id;
}

int messageNotificationId(String emailId) => notificationIdFor('m|$emailId');

int summaryNotificationId(String accountId) => notificationIdFor('s|$accountId');

String groupKeyFor(String accountId) => 'loupe.account.$accountId';

/// The most new-mail notifications shown per account and check; the
/// summary still counts them all.
const maxNotificationsPerAccount = 6;

/// Notifications for [mail] (oldest first): one per message, except mail of
/// muted accounts, mail that isn't from a VIP when [NotificationSettings.vipOnly]
/// is on, and the oldest beyond [perAccount] per account.
///
/// [archivable] lists the accounts that have somewhere to archive to. The
/// text is in [l10n], by default the device's language ([deviceL10n]):
/// this runs in the background too.
List<MailNotification> messageNotifications(
  List<NewMail> mail, {
  required List<MailAccount> accounts,
  required NotificationSettings settings,
  Set<String> archivable = const {},
  int perAccount = maxNotificationsPerAccount,
  AppLocalizations? l10n,
}) {
  final strings = l10n ?? deviceL10n();
  final byId = {for (final a in accounts) a.id: a};
  final kept = <String, List<NewMail>>{};
  for (final m in mail) {
    final account = byId[m.email.accountId];
    if (account == null || !settings.notifiesFor(account.id)) continue;
    if (settings.vipOnly && !m.fromVip) continue;
    (kept[account.id] ??= []).add(m);
  }
  return [
    for (final MapEntry(key: accountId, value: list) in kept.entries)
      for (final m in list.skip(list.length > perAccount ? list.length - perAccount : 0))
        messageNotification(
          m,
          byId[accountId]!,
          hideContent: settings.hideContent,
          canArchive: archivable.contains(accountId),
          showAccount: accounts.length > 1,
          l10n: strings,
        ),
  ];
}

/// The notification for one new message, in [l10n] (by default the
/// device's language).
///
/// Encrypted mail says "Encrypted message" unless its protected subject
/// was decrypted on this device already ([EmailSummary.hasDecryptedSubject]).
MailNotification messageNotification(
  NewMail mail,
  MailAccount account, {
  required bool hideContent,
  bool canArchive = true,
  bool showAccount = false,
  AppLocalizations? l10n,
}) {
  final strings = l10n ?? deviceL10n();
  final e = mail.email;
  final sealed = e.isEncrypted && !e.hasDecryptedSubject;
  final subject = sealed
      ? strings.notificationsEncryptedMessage
      : e.subject.trim().isEmpty
      ? strings.notificationsNoSubject
      : e.subject.trim();
  final sender = e.sender;
  final from = sender == null ? strings.notificationsUnknownSender : _displayName(sender);
  final preview = sealed ? '' : e.preview.trim();
  return MailNotification(
    id: messageNotificationId(e.id),
    channel: mail.fromVip ? MailChannel.vip : MailChannel.account(account),
    groupKey: groupKeyFor(account.id),
    title: hideContent ? strings.notificationsHiddenMessage(accountName(account)) : from,
    body: hideContent ? null : subject,
    expandedBody: hideContent || preview.isEmpty ? null : '$subject\n$preview',
    subText: hideContent || !showAccount ? null : accountName(account),
    when: e.receivedAt,
    target: MessageTarget(e.id, account.id),
    actions: [if (canArchive) MailAction.archive, MailAction.markRead, MailAction.reply],
  );
}

/// The group summary of [account] over the notifications that show for it,
/// in [l10n] (by default the device's language).
MailNotification summaryNotification(
  MailAccount account,
  List<ShownNotification> children, {
  required bool hideContent,
  AppLocalizations? l10n,
}) {
  final strings = l10n ?? deviceL10n();
  return MailNotification(
    id: summaryNotificationId(account.id),
    channel: MailChannel.account(account),
    groupKey: groupKeyFor(account.id),
    isSummary: true,
    title: strings.notificationsNewMessages(children.length),
    body: hideContent ? strings.notificationsHiddenSummary(accountName(account)) : _senders(children),
    lines: hideContent
        ? const []
        : [
            for (final c in children.take(5)) [?c.title, ?c.body].where((s) => s.isNotEmpty).join(' – '),
          ],
    subText: accountName(account),
    target: AccountTarget(account.id),
  );
}

String _displayName(EmailAddress a) {
  final name = a.name?.trim() ?? '';
  return name.isEmpty ? a.email : name;
}

String? _senders(List<ShownNotification> children) {
  final names = <String>[];
  for (final c in children) {
    final t = c.title;
    if (t != null && t.isNotEmpty && !names.contains(t)) names.add(t);
  }
  return names.isEmpty ? null : names.join(', ');
}
