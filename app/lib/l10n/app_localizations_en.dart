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
  String get settingsAccountsHeader => 'Accounts';

  @override
  String get settingsAddAccount => 'Add Account';

  @override
  String get settingsMailHeader => 'Mail';

  @override
  String get settingsSwipeActions => 'Swipe Actions';

  @override
  String get settingsSwipeLeft => 'Swipe Left';

  @override
  String get settingsSwipeLeftFooter => 'A full swipe runs this action. Flag and More are always one short swipe away.';

  @override
  String get settingsSwipeRight => 'Swipe Right';

  @override
  String get settingsSwipeRightFooter => 'A full swipe runs this action.';

  @override
  String get settingsSwipeToggleRead => 'Mark as Read / Unread';

  @override
  String get settingsSwipeTrash => 'Trash';

  @override
  String get settingsSwipeMove => 'Move Message';

  @override
  String get settingsSwipeSnooze => 'Snooze';

  @override
  String get settingsThreaded => 'Organize by Conversation';

  @override
  String get settingsUndoSendDelay => 'Undo Send Delay';

  @override
  String get settingsUndoSendDelayFooter => 'Sent messages wait this long, so you can take them back.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(seconds, locale: localeName, other: '$seconds seconds', one: '1 second');
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Appearance';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'Automatic';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsDensity => 'Message List';

  @override
  String get settingsDensityComfortable => 'Comfortable';

  @override
  String get settingsDensityCompact => 'Compact';

  @override
  String get settingsReadingHeader => 'Reading';

  @override
  String get settingsReadingFooter => 'Remote images can tell senders when and where you opened a message.';

  @override
  String get settingsDefaultView => 'Default View';

  @override
  String get settingsDefaultViewFooter => 'You can switch any message with the Aa button.';

  @override
  String get settingsViewReadable => 'Readable';

  @override
  String get settingsViewReadableDetail => 'Clean, legible, follows dark mode';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Exactly as the sender designed it';

  @override
  String get settingsViewPlain => 'Plain Text';

  @override
  String get settingsViewPlainDetail => 'Just the words';

  @override
  String get settingsPlainTextFont => 'Plain Text Font';

  @override
  String get settingsFontSans => 'Sans Serif';

  @override
  String get settingsFontMono => 'Monospaced';

  @override
  String get settingsFontMonoDetail => 'Keeps ASCII art and tables aligned';

  @override
  String get settingsTechnicalLists => 'Technical Lists';

  @override
  String get settingsLoadRemoteImages => 'Load Remote Images';

  @override
  String get settingsOpenLinksDirectly => 'Open Links Directly';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Skip click trackers when the destination is known';

  @override
  String get settingsSecurityHeader => 'Security';

  @override
  String get settingsAppLock => 'App Lock';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe asks when it starts, and when you come back after being away for the Lock After time.';

  @override
  String get settingsAppLockFooterOff =>
      'App Lock asks for your fingerprint, face or screen lock before your mail shows.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'App Lock is still off. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Set Up a Passcode';

  @override
  String get settingsScreenLockTextIos =>
      'App Lock uses Face ID, Touch ID or your passcode, and this iPhone has no passcode. Set one up in the Settings app, then turn on App Lock.';

  @override
  String get settingsScreenLockTitleAndroid => 'Set Up a Screen Lock';

  @override
  String get settingsScreenLockTextAndroid =>
      'App Lock uses your phone’s screen lock, or a fingerprint or face added to it, and this phone has none. Set up a PIN, pattern or password in Android’s settings, then turn on App Lock.';

  @override
  String get settingsOpenSystemSettings => 'Open Settings';

  @override
  String get settingsOpenAndroidSettings => 'Open Android Settings';

  @override
  String get settingsLockAfter => 'Lock After';

  @override
  String get settingsLockAfterFooter => 'How long Loupe can be in the background before it asks again.';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsEncryption => 'End-to-End Encryption';

  @override
  String get settingsAdvanced => 'Advanced';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demo mail is a made-up mailbox that lives only on this phone. Nothing is sent anywhere.';

  @override
  String get settingsDemoMode => 'Demo Mode';

  @override
  String get settingsResetApp => 'Reset App';

  @override
  String get settingsResetFooter => 'Forgets all settings and returns to the welcome screen.';

  @override
  String get settingsResetTitle => 'Reset Loupe?';

  @override
  String get settingsResetMessage =>
      'This forgets every setting, smart mailbox and recent search, and returns to the welcome screen.';

  @override
  String get settingsAboutHeader => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicences => 'Licences';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacyDetail =>
      'Loupe has no analytics and no tracking. Your mail goes only to your mail servers.';

  @override
  String get settingsNotificationsOffIos => 'Notifications are off for Loupe in Settings.';

  @override
  String get settingsNotificationsOffAndroid => 'Notifications are off for Loupe in Android Settings.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system doesn’t let Loupe show notifications. Allow them in Settings.';
  }

  @override
  String get settingsNewMailHeader => 'New Mail';

  @override
  String get settingsNewMailFooterDemo =>
      'Demo mail doesn’t arrive in the background. Send a test notification to see how new mail looks.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe checks for new mail in the background when iOS lets it, which can be hours apart for apps you don’t open often. You’re told about new messages in your inboxes, and from VIPs in any folder.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe checks for new mail about every 15 minutes, when Android allows. You’re told about new messages in your inboxes, and from VIPs in any folder.';

  @override
  String get settingsNoAccounts => 'No Accounts';

  @override
  String get settingsVipOnly => 'VIP Only';

  @override
  String get settingsVipOnlyDetail => 'Only messages from your VIPs';

  @override
  String get settingsHideContent => 'Hide Content';

  @override
  String get settingsHideContentFooterOn =>
      'Notifications only say “New message from” and the account, not who wrote or what about.';

  @override
  String get settingsHideContentFooterOff =>
      'Hide Content keeps the sender, subject and preview off the lock screen and out of notifications.';

  @override
  String get settingsBackgroundAppRefresh => 'Background App Refresh';

  @override
  String get settingsBackgroundRefreshFooter =>
      'New mail only arrives in the background while Background App Refresh is on for Loupe in Settings. iOS can’t keep a connection to your inboxes open, so there’s no Instant Delivery.';

  @override
  String get settingsInstantDelivery => 'Instant Delivery';

  @override
  String get settingsInstantDeliveryFooter =>
      'Instant Delivery (experimental) keeps a connection to your inboxes open, so new mail arrives within seconds. It shows a quiet “Watching for new mail” notification and uses more battery.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android may stop Instant Delivery to save battery. Let Loupe use the battery without restrictions to keep it running.';

  @override
  String get settingsExperimental => 'Experimental';

  @override
  String get settingsComingSoon => 'Coming Soon';

  @override
  String get settingsAllowUnrestrictedBattery => 'Allow Unrestricted Battery Use';

  @override
  String get settingsSendTestNotification => 'Send Test Notification';

  @override
  String get settingsAppIconBadge => 'App Icon Badge';

  @override
  String get settingsBadgeNote => 'The badge updates whenever Loupe checks for mail, also in the background.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'This phone’s home screen doesn’t show numbers on app icons. The badge updates whenever Loupe checks for mail, also in the background.';

  @override
  String get settingsTestNotificationBody => 'Notifications for new mail look like this.';

  @override
  String get settingsAccountRemoved => 'This account was removed.';

  @override
  String get settingsAccountHeader => 'Account';

  @override
  String get settingsAccountDescription => 'Description';

  @override
  String get settingsAccountDescriptionHint => 'Work, Personal…';

  @override
  String get settingsEmail => 'Email';

  @override
  String get settingsColour => 'Colour';

  @override
  String get settingsColourFooter => 'Marks this account’s messages in All Inboxes.';

  @override
  String settingsColourNumber(int number) {
    return 'Colour $number';
  }

  @override
  String get settingsSendingHeader => 'Sending';

  @override
  String get settingsSendingFooter =>
      'Each identity has its own signature. Replies go out from the address a message was sent to.';

  @override
  String get settingsFoldersHeader => 'Folders';

  @override
  String get settingsFoldersFooter =>
      'Loupe shows and syncs the folders you subscribe to, as Thunderbird does. Inbox, Drafts, Sent, Junk, Trash and Archive always show.';

  @override
  String get settingsShowAllFolders => 'Show All Folders';

  @override
  String get settingsIncoming => 'Incoming';

  @override
  String get settingsOutgoing => 'Outgoing';

  @override
  String get settingsConnectionNotEncrypted => 'Not encrypted';

  @override
  String get settingsSignIn => 'Sign-in';

  @override
  String get settingsSignInExpired => 'Expired';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider no longer accepts Loupe’s sign-in for this account, so its mail isn’t syncing. Sign in again to fix it.';
  }

  @override
  String get settingsSignInAgain => 'Sign In Again';

  @override
  String get settingsSigningIn => 'Signing In…';

  @override
  String get settingsRemoveAccount => 'Remove Account';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Remove “$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Its mail and settings are removed from this phone. Nothing is deleted on the server.';

  @override
  String get settingsManageFolders => 'Manage Folders';

  @override
  String get settingsNoFolders => 'No folders yet.';

  @override
  String get settingsManageFoldersFooter =>
      'Subscribed folders show on the Mailboxes screen and sync in the background. Other mail apps on the same account usually follow these subscriptions too.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Keeps your Smart Mailboxes for your other devices. Hidden on the Mailboxes screen.';

  @override
  String get settingsFolderAlwaysShown => 'Always Shown';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Subscribe to $folder';
  }

  @override
  String get settingsIdentities => 'Identities';

  @override
  String get settingsIdentitiesFooterReorder =>
      'The first identity is the default for new messages. Drag to change the order.';

  @override
  String get settingsIdentitiesFooterSingle => 'The default identity for new messages.';

  @override
  String get settingsIdentitiesReplyFooter => 'A reply goes out from the identity the message was sent to.';

  @override
  String get settingsIdentityDefault => 'Default';

  @override
  String settingsIdentityReorder(String email) {
    return 'Reorder $email';
  }

  @override
  String get settingsAddIdentity => 'Add Identity';

  @override
  String get settingsNewIdentity => 'New Identity';

  @override
  String get settingsIdentity => 'Identity';

  @override
  String get settingsIdentityNameHint => 'Your name';

  @override
  String get settingsReplyTo => 'Reply-To';

  @override
  String get settingsSignature => 'Signature';

  @override
  String get settingsSignatureFooter => 'Added below “-- ” in messages from this identity.';

  @override
  String get settingsNoSignature => 'No signature';

  @override
  String get settingsCopyToMyself => 'Copy to Myself';

  @override
  String get settingsCopyToMyselfFooter => 'Added to every message from this identity.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Use for Replies To';

  @override
  String get settingsReplyPatternsFooter =>
      'Replies to messages sent to these addresses go out from this identity. * stands for anything: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'An address, or a pattern where * stands for anything.';

  @override
  String get settingsAddReplyPattern => 'Add Address or Pattern';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Remove $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Invalid Pattern';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '“$input” isn’t an address or a pattern like *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'No Address';

  @override
  String get settingsIdentityNoAddressMessage => 'Enter the email address to send from.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Invalid Address';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Reply-To “$address” isn’t a valid email address.',
      'cc': 'Cc “$address” isn’t a valid email address.',
      'bcc': 'Bcc “$address” isn’t a valid email address.',
      'other': '“$address” isn’t a valid email address.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Save Identity';

  @override
  String get settingsDiscardChanges => 'Discard Changes';

  @override
  String get settingsDeleteIdentity => 'Delete Identity';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Delete “$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Messages already sent from it stay as they are.';

  @override
  String get settingsLastIdentityFooter => 'An account needs at least one identity.';

  @override
  String get rulesTitle => 'Rules';

  @override
  String get rulesNewRule => 'New Rule';

  @override
  String get rulesLoadError => 'Couldn’t load the rules.';

  @override
  String get rulesEmptyTitle => 'No Rules';

  @override
  String get rulesEmptyText =>
      'Rules file, tag and flag new mail for you. Make one with the compose button above, or from a search with “Make This a Rule”.';

  @override
  String get rulesListFooter =>
      'Rules run from top to bottom on new mail in the Inbox. Touch and hold a rule to move it.';

  @override
  String get rulesChangeError => 'Couldn’t Change the Rule';

  @override
  String get rulesConditionEveryMessage => 'Every message';

  @override
  String rulesMoveRule(String rule) {
    return 'Move $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule on';
  }

  @override
  String get rulesServerRulesHeader => 'Server Rules';

  @override
  String get rulesServerRulesFooter =>
      'Server rules run on the mail server as mail arrives, also while this phone is off. They are kept in a Sieve script named “loupe”.';

  @override
  String get rulesStatusUnknown => 'Unknown';

  @override
  String get rulesStatusError => 'Couldn’t ask the server.';

  @override
  String get rulesStatusChecking => 'Checking…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Run from “$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '“$script” is the active script. Tap to let it run Loupe’s rules too.';
  }

  @override
  String get rulesStatusNoScript => 'No script is active on the server. Saving a server rule turns Loupe’s on.';

  @override
  String get rulesStatusUnavailable => 'Not Available';

  @override
  String get rulesStatusNoSieve => 'This account’s server offers no Sieve (ManageSieve or JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Move to $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Move to a folder';

  @override
  String rulesActionTag(String tag) {
    return 'Tag $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Remove Tag $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Keep in Inbox';

  @override
  String rulesActionForward(String address) {
    return 'Forward to $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Forward to $address, keep no copy';
  }

  @override
  String get rulesActionStop => 'Stop';

  @override
  String get rulesNoActions => 'Does nothing yet';

  @override
  String get rulesLocationDevice => 'Device';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'This Device';

  @override
  String get rulesNewRuleTitle => 'New Rule';

  @override
  String get rulesEditRuleTitle => 'Edit Rule';

  @override
  String get rulesDefaultNameEveryMessage => 'Every Message';

  @override
  String get rulesConditionHeader => 'When a New Message Matches';

  @override
  String get rulesConditionFooter =>
      'Write it as you would search: from:, to:, s: (subject), b: (body), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:invoice';

  @override
  String get rulesAccounts => 'Accounts';

  @override
  String get rulesAllAccounts => 'All Accounts';

  @override
  String get rulesRemovedAccount => 'Removed account';

  @override
  String get rulesAccountsFooter => 'A rule for all accounts also covers accounts you add later.';

  @override
  String get rulesActionsHeader => 'Then';

  @override
  String get rulesForwardingFooter =>
      'Forwarding sends every matching message to another address as it arrives, also while this phone is off. Some providers limit how much mail may be forwarded.';

  @override
  String get rulesForwardingHiddenFooter => 'Forwarding only runs in server rules, so it is left out here.';

  @override
  String rulesRemoveAction(String action) {
    return 'Remove $action';
  }

  @override
  String get rulesAddAction => 'Add Action';

  @override
  String get rulesAddMove => 'Move to Folder…';

  @override
  String get rulesAddTagMenu => 'Add Tag…';

  @override
  String get rulesRemoveTagMenu => 'Remove Tag…';

  @override
  String get rulesAddForward => 'Forward To…';

  @override
  String get rulesStopProcessing => 'Stop Processing More Rules';

  @override
  String get rulesRunOnHeader => 'Run On';

  @override
  String get rulesRunOnDeviceFooter => 'This device runs the rule on new Inbox mail each time Loupe checks for mail.';

  @override
  String get rulesRunOnServerFooter =>
      'The mail server runs the rule as mail arrives, also while this phone is off. Needs Sieve, over ManageSieve (Dovecot, mailcow) or JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Apply to Existing Messages…';

  @override
  String get rulesDeleteRule => 'Delete Rule';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Delete “$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Folder in Which Account?';

  @override
  String get rulesMoveAccountMessage => 'Mail of the other accounts goes to the folder with the same name there.';

  @override
  String get rulesAddTag => 'Add Tag';

  @override
  String get rulesRemoveTag => 'Remove Tag';

  @override
  String get rulesForwardTo => 'Forward To';

  @override
  String get rulesForwardToMessage =>
      'The server sends every matching message on to this address, also while this phone is off. Use an address you own or trust.';

  @override
  String get rulesNotAnAddressTitle => 'Not an Email Address';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '“$address” isn’t an address to forward to.';
  }

  @override
  String get rulesKeepCopyTitle => 'Keep a Copy Here?';

  @override
  String get rulesKeepCopy => 'Keep a Copy';

  @override
  String get rulesDontKeepCopy => 'Don’t Keep a Copy';

  @override
  String get rulesCheckCondition => 'Check the Condition';

  @override
  String get rulesChooseActionTitle => 'Choose an Action';

  @override
  String get rulesChooseActionMessage => 'Add what the rule does with the messages it matches.';

  @override
  String get rulesSaveError => 'Couldn’t Save the Rule';

  @override
  String get rulesSaveServerError => 'Couldn’t Save the Server Rule';

  @override
  String get rulesRunOnDeviceInstead => 'Run on This Device Instead';

  @override
  String get rulesNothingToApplyTitle => 'Nothing to Apply';

  @override
  String get rulesNothingToApplyMessage => 'Give the rule a condition that works and an action first.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Apply “$rule” to Messages in…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Inboxes';

  @override
  String get rulesApplyScopeAll => 'All Mailboxes';

  @override
  String get rulesFindingMessages => 'Finding Messages…';

  @override
  String get rulesSearchError => 'Couldn’t Search';

  @override
  String get rulesSearchErrorUnknown => 'Something went wrong.';

  @override
  String get rulesNoMatchesTitle => 'No Messages Match';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Nothing there matches “$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Apply “$rule” to $countString Messages?',
      one: 'Apply “$rule” to $countString Message?',
    );
    return '$_temp0';
  }

  @override
  String rulesApplyConfirm(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Apply to $countString Messages',
      one: 'Apply to $countString Message',
    );
    return '$_temp0';
  }

  @override
  String rulesApplied(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Applied “$rule” to $countString messages',
      one: 'Applied “$rule” to $countString message',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Asking the server what it can do…';

  @override
  String get rulesServerUnreachable => 'Couldn’t reach the server.';

  @override
  String rulesServerProblem(String problem) {
    return 'Can’t run on the server: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Can’t run on the server of $account: $problem';
  }

  @override
  String get rulesShowScript => 'Show Script';

  @override
  String get rulesHideScript => 'Hide Script';

  @override
  String get rulesMatchingHeader => 'Matching Messages';

  @override
  String get rulesMatchingHeaderLoading => 'Matching Messages…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Matching Messages',
      one: '$countString Matching Message',
    );
    return '$_temp0';
  }

  @override
  String rulesMatchingCountMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString+ Matching Messages',
      one: '$countString+ Matching Message',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'From the last 30 days. The rule itself only acts on new mail, unless you apply it to existing messages.';

  @override
  String rulesConditionError(String error) {
    return 'The condition has an error: $error';
  }

  @override
  String get rulesPreviewNoSender => '(no sender)';

  @override
  String get rulesPreviewNoSubject => '(no subject)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'and $countString more');
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nothing from the last 30 days.';

  @override
  String get rulesIncludeTitle => 'Turn On Server Rules';

  @override
  String get rulesIncludeLeaveOff => 'Leave Off';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'The server already runs Loupe’s rules for $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '“$script” is the active script on $account’s server, so the server runs it and not Loupe’s rules. Loupe won’t replace it. It can add these lines to it, and the server then runs Loupe’s rules after the script’s own:';
  }

  @override
  String get rulesShowWholeScript => 'Show Whole Script';

  @override
  String get rulesHideWholeScript => 'Hide Whole Script';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Nothing else in “$script” changes. If its filters are edited in the webmail later, the webmail may rewrite it without these lines; Loupe then shows server rules as off again.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Add to “$script”';
  }

  @override
  String get subscriptionsTitle => 'Subscriptions';

  @override
  String get subscriptionsNewsletters => 'Newsletters';

  @override
  String get subscriptionsDiscussions => 'Discussions';

  @override
  String get subscriptionsFilter => 'Filter';

  @override
  String get subscriptionsFilterNeverRead => 'Never Read';

  @override
  String get subscriptionsFilterRarelyRead => 'Rarely Read';

  @override
  String get subscriptionsFilterAll => 'All';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Couldn’t Count Subscriptions';

  @override
  String get subscriptionsNoMatches => 'No Matches';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'No newsletter is called “$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'No list is called “$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'No Newsletters';

  @override
  String get subscriptionsNoNewslettersDetail => 'Newsletters and other bulk mail show up here once they arrive.';

  @override
  String get subscriptionsNothingNeverRead => 'Nothing Never Read';

  @override
  String get subscriptionsNothingRarelyRead => 'Nothing Rarely Read';

  @override
  String get subscriptionsNothingFilteredDetail => 'You read some of everything you get.';

  @override
  String get subscriptionsNoDiscussions => 'No Discussions';

  @override
  String get subscriptionsNoDiscussionsDetail => 'Mailing lists you can write to show up here once their mail arrives.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Lists that several people write to. Touch and hold one to pin it to Mailboxes, read it as plain text, or move it to Newsletters.';

  @override
  String get subscriptionsPrivacyNote =>
      'Counted on this phone from the mail it has downloaded; nothing is sent anywhere to work this out. Loupe contacts a sender only when you tap Unsubscribe: one-click sends just “List-Unsubscribe=One-Click” to the address the sender gave, with no cookies and nothing else about you, and never loads its pages or images.';

  @override
  String get subscriptionsVolumeNone => 'None lately';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / month';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / month';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'read $percent';
  }

  @override
  String get subscriptionsStillSending => 'Still sending';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Unsubscribed on $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Unsubscribe page opened $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'One tap · contacts $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'By email to $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'On the website $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Unsubscribe';

  @override
  String get subscriptionsUnsubscribeAgain => 'Unsubscribe Again';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Archive $countString in Inbox');
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Create Rule…';

  @override
  String get subscriptionsCreateRuleDetail => 'Move or archive its future mail';

  @override
  String get subscriptionsTreatAsDiscussion => 'Treat as Discussion';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'A list people write to: read it forum style';

  @override
  String get subscriptionsTreatAsNewsletter => 'Treat as Newsletter';

  @override
  String get subscriptionsBlockSender => 'Block Sender';

  @override
  String get subscriptionsBlock => 'Block';

  @override
  String get subscriptionsBlocked => 'Blocked';

  @override
  String get subscriptionsBlockedDetail => 'New mail goes to Junk';

  @override
  String get subscriptionsPin => 'Pin to Mailboxes';

  @override
  String get subscriptionsUnpin => 'Unpin from Mailboxes';

  @override
  String get subscriptionsOpenDefaultView => 'Open in Default View';

  @override
  String get subscriptionsOpenPlainText => 'Open as Plain Text (Mono)';

  @override
  String get subscriptionsPinned => 'Pinned';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$countString unread');
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'No mail from this sender now.';

  @override
  String get subscriptionsLatestMessages => 'LATEST MESSAGES';

  @override
  String get subscriptionsMail => 'Mail';

  @override
  String get subscriptionsNoneIn90Days => 'None in 90 days';

  @override
  String get subscriptionsRead => 'Read';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString of $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Last Received';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Folders', one: 'Folder');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Still Sending';

  @override
  String get subscriptionsUnsubscribedTitle => 'Unsubscribed';

  @override
  String subscriptionsSince(String date) {
    return 'since $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'page opened $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender doesn’t say how to unsubscribe.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender doesn’t say how to unsubscribe. You can block it instead.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Unsubscribing from $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Unsubscribed from $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Couldn’t unsubscribe: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Couldn’t Unsubscribe Automatically';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Send Unsubscribe Email';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Open $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Open $site?';
  }

  @override
  String get subscriptionsOpen => 'Open';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender unsubscribes on its website. The page opens in Loupe’s browser; finish there.';
  }

  @override
  String get subscriptionsWebInsecure => 'The connection to this site isn’t encrypted.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Careful: this address imitates $site with look-alike letters.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Careful: this address imitates another site with look-alike letters.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Couldn’t open $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe notes today’s date and tells you if $sender keeps writing.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Unsubscribe from $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe will contact $site to unsubscribe.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'This is the only time Loupe contacts a sender’s website. It sends just “List-Unsubscribe=One-Click” to the address $sender gave, without cookies or anything else about you, and doesn’t load the page.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'The unsubscribe link isn’t a secure address on the internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site didn’t answer in time.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Couldn’t reach $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site sent the request on to another page, which Loupe doesn’t follow.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site refused the request (error $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'There’s no account to send the unsubscribe email from.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe will send an email to $to from $from, with the subject “$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Unsubscribe email sent to $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Block $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'New mail from this list goes to Junk. You can change this in Settings › Rules.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'New mail from $address goes to Junk. You can change this in Settings › Rules.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Blocked $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Move $count to Junk');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Block $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender is in Newsletters now.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender is in Discussions now.';
  }

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
