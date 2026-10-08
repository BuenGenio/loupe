// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonAdd => 'Add';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonDone => 'Done';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonMore => 'More';

  @override
  String get commonMove => 'Move';

  @override
  String get commonName => 'Name';

  @override
  String get commonNone => 'None';

  @override
  String get commonOff => 'Off';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'On';

  @override
  String get commonOptional => 'Optional';

  @override
  String get commonPassword => 'Password';

  @override
  String get commonRemove => 'Remove';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonSave => 'Save';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Settings';

  @override
  String get commonShare => 'Share';

  @override
  String get commonTryAgain => 'Try Again';

  @override
  String get commonUndo => 'Undo';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count messages', one: '1 message');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archive';

  @override
  String get mailDelete => 'Delete';

  @override
  String get mailFlag => 'Flag';

  @override
  String get mailForward => 'Forward';

  @override
  String get mailMarkAsRead => 'Mark as Read';

  @override
  String get mailMarkAsUnread => 'Mark as Unread';

  @override
  String get mailMoveToJunk => 'Move to Junk';

  @override
  String get mailNewMessage => 'New Message';

  @override
  String get mailNoSubject => 'No Subject';

  @override
  String get mailReply => 'Reply';

  @override
  String get mailReplyAll => 'Reply All';

  @override
  String get mailSend => 'Send';

  @override
  String get mailUnflag => 'Unflag';

  @override
  String get mailboxArchive => 'Archive';

  @override
  String get mailboxDrafts => 'Drafts';

  @override
  String get mailboxInbox => 'Inbox';

  @override
  String get mailboxJunk => 'Junk';

  @override
  String get mailboxOutbox => 'Outbox';

  @override
  String get mailboxSent => 'Sent';

  @override
  String get mailboxTrash => 'Trash';

  @override
  String get welcomeTagline => 'Mail that’s simple on the surface\nand powerful underneath.';

  @override
  String get welcomeAccountsTitle => 'Every account, one calm inbox';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail and any IMAP or JMAP server.';

  @override
  String get welcomeSearchTitle => 'Search that finds it';

  @override
  String get welcomeSearchText => 'Instant results on your phone, then the server’s.';

  @override
  String get welcomePrivacyTitle => 'Private by design';

  @override
  String get welcomePrivacyText => 'No tracking. Remote images stay blocked until you say so.';

  @override
  String get welcomeAddAccount => 'Add Account';

  @override
  String get welcomeImport => 'Import from Thunderbird';

  @override
  String get welcomeTryDemo => 'Try with demo mail';
}
