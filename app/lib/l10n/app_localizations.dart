import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get commonMore;

  /// No description provided for @commonMove.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get commonMove;

  /// No description provided for @commonName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get commonName;

  /// No description provided for @commonNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get commonNone;

  /// No description provided for @commonOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get commonOff;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get commonOn;

  /// No description provided for @commonOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get commonOptional;

  /// No description provided for @commonPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get commonPassword;

  /// No description provided for @commonRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get commonRemove;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get commonSearch;

  /// No description provided for @commonServer.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get commonServer;

  /// No description provided for @commonSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get commonSettings;

  /// No description provided for @commonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get commonShare;

  /// Button after something failed.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get commonTryAgain;

  /// No description provided for @commonUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get commonUndo;

  /// No description provided for @commonMessageCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 message} other{{count} messages}}'**
  String commonMessageCount(int count);

  /// Action: archive a message. The folder is mailboxArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get mailArchive;

  /// Action: move a message to the trash.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get mailDelete;

  /// No description provided for @mailFlag.
  ///
  /// In en, this message translates to:
  /// **'Flag'**
  String get mailFlag;

  /// No description provided for @mailForward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get mailForward;

  /// No description provided for @mailMarkAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as Read'**
  String get mailMarkAsRead;

  /// No description provided for @mailMarkAsUnread.
  ///
  /// In en, this message translates to:
  /// **'Mark as Unread'**
  String get mailMarkAsUnread;

  /// No description provided for @mailMoveToJunk.
  ///
  /// In en, this message translates to:
  /// **'Move to Junk'**
  String get mailMoveToJunk;

  /// No description provided for @mailNewMessage.
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get mailNewMessage;

  /// Shown in place of a message's empty subject.
  ///
  /// In en, this message translates to:
  /// **'No Subject'**
  String get mailNoSubject;

  /// No description provided for @mailReply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get mailReply;

  /// No description provided for @mailReplyAll.
  ///
  /// In en, this message translates to:
  /// **'Reply All'**
  String get mailReplyAll;

  /// No description provided for @mailSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get mailSend;

  /// No description provided for @mailUnflag.
  ///
  /// In en, this message translates to:
  /// **'Unflag'**
  String get mailUnflag;

  /// The archive folder. The action is mailArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get mailboxArchive;

  /// No description provided for @mailboxDrafts.
  ///
  /// In en, this message translates to:
  /// **'Drafts'**
  String get mailboxDrafts;

  /// No description provided for @mailboxInbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get mailboxInbox;

  /// No description provided for @mailboxJunk.
  ///
  /// In en, this message translates to:
  /// **'Junk'**
  String get mailboxJunk;

  /// No description provided for @mailboxOutbox.
  ///
  /// In en, this message translates to:
  /// **'Outbox'**
  String get mailboxOutbox;

  /// No description provided for @mailboxSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get mailboxSent;

  /// No description provided for @mailboxTrash.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get mailboxTrash;

  /// Settings: section header above the accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get settingsAccountsHeader;

  /// No description provided for @settingsAddAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get settingsAddAccount;

  /// Settings: section header for the mail options.
  ///
  /// In en, this message translates to:
  /// **'Mail'**
  String get settingsMailHeader;

  /// Settings row and the title of its page: what swiping a message in the list does.
  ///
  /// In en, this message translates to:
  /// **'Swipe Actions'**
  String get settingsSwipeActions;

  /// Section header: the action behind a message swiped to the left.
  ///
  /// In en, this message translates to:
  /// **'Swipe Left'**
  String get settingsSwipeLeft;

  /// No description provided for @settingsSwipeLeftFooter.
  ///
  /// In en, this message translates to:
  /// **'A full swipe runs this action. Flag and More are always one short swipe away.'**
  String get settingsSwipeLeftFooter;

  /// Section header: the action behind a message swiped to the right.
  ///
  /// In en, this message translates to:
  /// **'Swipe Right'**
  String get settingsSwipeRight;

  /// No description provided for @settingsSwipeRightFooter.
  ///
  /// In en, this message translates to:
  /// **'A full swipe runs this action.'**
  String get settingsSwipeRightFooter;

  /// Swipe action: marks a message read, or unread when it is read.
  ///
  /// In en, this message translates to:
  /// **'Mark as Read / Unread'**
  String get settingsSwipeToggleRead;

  /// Swipe action: moves the message to the trash.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get settingsSwipeTrash;

  /// Swipe action: asks for a folder to move the message to.
  ///
  /// In en, this message translates to:
  /// **'Move Message'**
  String get settingsSwipeMove;

  /// Swipe action: hides the message until a chosen time.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get settingsSwipeSnooze;

  /// Switch: show messages grouped into conversations (threads).
  ///
  /// In en, this message translates to:
  /// **'Organize by Conversation'**
  String get settingsThreaded;

  /// Settings row and the title of its page: how long a sent message waits so it can be taken back.
  ///
  /// In en, this message translates to:
  /// **'Undo Send Delay'**
  String get settingsUndoSendDelay;

  /// No description provided for @settingsUndoSendDelayFooter.
  ///
  /// In en, this message translates to:
  /// **'Sent messages wait this long, so you can take them back.'**
  String get settingsUndoSendDelayFooter;

  /// A choice of Undo Send Delay.
  ///
  /// In en, this message translates to:
  /// **'{seconds, plural, =1{1 second} other{{seconds} seconds}}'**
  String settingsUndoSendSeconds(int seconds);

  /// Settings row: opens the smart mailbox settings.
  ///
  /// In en, this message translates to:
  /// **'Smart Mailboxes'**
  String get settingsSmartMailboxes;

  /// Settings: section header for the theme and the message list's density.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearanceHeader;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// Theme choice: light or dark as the system is set.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get settingsThemeSystem;

  /// Theme choice.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// Theme choice.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// Settings: how roomy the message list is (Comfortable or Compact).
  ///
  /// In en, this message translates to:
  /// **'Message List'**
  String get settingsDensity;

  /// Message list density choice.
  ///
  /// In en, this message translates to:
  /// **'Comfortable'**
  String get settingsDensityComfortable;

  /// Message list density choice.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get settingsDensityCompact;

  /// Settings: section header for the reading options.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get settingsReadingHeader;

  /// No description provided for @settingsReadingFooter.
  ///
  /// In en, this message translates to:
  /// **'Remote images can tell senders when and where you opened a message.'**
  String get settingsReadingFooter;

  /// Settings row and the title of its page: how messages show at first (Readable, Original or Plain Text).
  ///
  /// In en, this message translates to:
  /// **'Default View'**
  String get settingsDefaultView;

  /// “Aa” is the reader options button in a message; keep it as it is.
  ///
  /// In en, this message translates to:
  /// **'You can switch any message with the Aa button.'**
  String get settingsDefaultViewFooter;

  /// Default view choice: Loupe's clean layout of the message.
  ///
  /// In en, this message translates to:
  /// **'Readable'**
  String get settingsViewReadable;

  /// No description provided for @settingsViewReadableDetail.
  ///
  /// In en, this message translates to:
  /// **'Clean, legible, follows dark mode'**
  String get settingsViewReadableDetail;

  /// Default view choice: the message as the sender designed it.
  ///
  /// In en, this message translates to:
  /// **'Original'**
  String get settingsViewOriginal;

  /// No description provided for @settingsViewOriginalDetail.
  ///
  /// In en, this message translates to:
  /// **'Exactly as the sender designed it'**
  String get settingsViewOriginalDetail;

  /// Default view choice: the message's text alone.
  ///
  /// In en, this message translates to:
  /// **'Plain Text'**
  String get settingsViewPlain;

  /// No description provided for @settingsViewPlainDetail.
  ///
  /// In en, this message translates to:
  /// **'Just the words'**
  String get settingsViewPlainDetail;

  /// Settings row and the title of its page: the font of plain-text messages.
  ///
  /// In en, this message translates to:
  /// **'Plain Text Font'**
  String get settingsPlainTextFont;

  /// Plain text font choice.
  ///
  /// In en, this message translates to:
  /// **'Sans Serif'**
  String get settingsFontSans;

  /// Plain text font choice: every letter as wide as the others.
  ///
  /// In en, this message translates to:
  /// **'Monospaced'**
  String get settingsFontMono;

  /// No description provided for @settingsFontMonoDetail.
  ///
  /// In en, this message translates to:
  /// **'Keeps ASCII art and tables aligned'**
  String get settingsFontMonoDetail;

  /// Settings row: the mailing lists whose messages open as plain text in a monospaced font.
  ///
  /// In en, this message translates to:
  /// **'Technical Lists'**
  String get settingsTechnicalLists;

  /// No description provided for @settingsLoadRemoteImages.
  ///
  /// In en, this message translates to:
  /// **'Load Remote Images'**
  String get settingsLoadRemoteImages;

  /// Switch: open a link's real destination instead of the click tracker it goes through.
  ///
  /// In en, this message translates to:
  /// **'Open Links Directly'**
  String get settingsOpenLinksDirectly;

  /// No description provided for @settingsOpenLinksDirectlyDetail.
  ///
  /// In en, this message translates to:
  /// **'Skip click trackers when the destination is known'**
  String get settingsOpenLinksDirectlyDetail;

  /// Settings: section header for App Lock.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecurityHeader;

  /// Switch: ask for the fingerprint, face or screen lock before Loupe shows mail.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get settingsAppLock;

  /// “Lock After” is the setting settingsLockAfter.
  ///
  /// In en, this message translates to:
  /// **'Loupe asks when it starts, and when you come back after being away for the Lock After time.'**
  String get settingsAppLockFooterOn;

  /// No description provided for @settingsAppLockFooterOff.
  ///
  /// In en, this message translates to:
  /// **'App Lock asks for your fingerprint, face or screen lock before your mail shows.'**
  String get settingsAppLockFooterOff;

  /// Snack bar after App Lock couldn't be turned on.
  ///
  /// In en, this message translates to:
  /// **'App Lock is still off. {reason}'**
  String settingsAppLockStillOff(String reason);

  /// iPhone: dialog title when App Lock can't be turned on because the phone has no passcode.
  ///
  /// In en, this message translates to:
  /// **'Set Up a Passcode'**
  String get settingsScreenLockTitleIos;

  /// No description provided for @settingsScreenLockTextIos.
  ///
  /// In en, this message translates to:
  /// **'App Lock uses Face ID, Touch ID or your passcode, and this iPhone has no passcode. Set one up in the Settings app, then turn on App Lock.'**
  String get settingsScreenLockTextIos;

  /// Android: dialog title when App Lock can't be turned on because the phone has no screen lock.
  ///
  /// In en, this message translates to:
  /// **'Set Up a Screen Lock'**
  String get settingsScreenLockTitleAndroid;

  /// No description provided for @settingsScreenLockTextAndroid.
  ///
  /// In en, this message translates to:
  /// **'App Lock uses your phone’s screen lock, or a fingerprint or face added to it, and this phone has none. Set up a PIN, pattern or password in Android’s settings, then turn on App Lock.'**
  String get settingsScreenLockTextAndroid;

  /// Button: opens the phone's Settings app.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get settingsOpenSystemSettings;

  /// Button: opens Android's settings for Loupe.
  ///
  /// In en, this message translates to:
  /// **'Open Android Settings'**
  String get settingsOpenAndroidSettings;

  /// Settings row and the title of its page: how long Loupe may be in the background before App Lock asks again.
  ///
  /// In en, this message translates to:
  /// **'Lock After'**
  String get settingsLockAfter;

  /// No description provided for @settingsLockAfterFooter.
  ///
  /// In en, this message translates to:
  /// **'How long Loupe can be in the background before it asks again.'**
  String get settingsLockAfterFooter;

  /// Settings row and the title of its page.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// Settings row: opens the OpenPGP and S/MIME settings.
  ///
  /// In en, this message translates to:
  /// **'End-to-End Encryption'**
  String get settingsEncryption;

  /// Settings row and the title of its page: demo mode, reset and About.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get settingsAdvanced;

  /// Section header: the demo mailbox.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get settingsDemoHeader;

  /// No description provided for @settingsDemoFooter.
  ///
  /// In en, this message translates to:
  /// **'Demo mail is a made-up mailbox that lives only on this phone. Nothing is sent anywhere.'**
  String get settingsDemoFooter;

  /// No description provided for @settingsDemoMode.
  ///
  /// In en, this message translates to:
  /// **'Demo Mode'**
  String get settingsDemoMode;

  /// Button: forget every setting and go back to the welcome screen.
  ///
  /// In en, this message translates to:
  /// **'Reset App'**
  String get settingsResetApp;

  /// No description provided for @settingsResetFooter.
  ///
  /// In en, this message translates to:
  /// **'Forgets all settings and returns to the welcome screen.'**
  String get settingsResetFooter;

  /// No description provided for @settingsResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Loupe?'**
  String get settingsResetTitle;

  /// No description provided for @settingsResetMessage.
  ///
  /// In en, this message translates to:
  /// **'This forgets every setting, smart mailbox and recent search, and returns to the welcome screen.'**
  String get settingsResetMessage;

  /// Section header: the app's version, licences and privacy.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutHeader;

  /// The app's version number, shown beside it.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// Opens the licences of the open-source libraries in the app.
  ///
  /// In en, this message translates to:
  /// **'Licences'**
  String get settingsLicences;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacyDetail.
  ///
  /// In en, this message translates to:
  /// **'Loupe has no analytics and no tracking. Your mail goes only to your mail servers.'**
  String get settingsPrivacyDetail;

  /// iPhone: snack bar when a test notification can't be shown.
  ///
  /// In en, this message translates to:
  /// **'Notifications are off for Loupe in Settings.'**
  String get settingsNotificationsOffIos;

  /// Android: snack bar when a test notification can't be shown.
  ///
  /// In en, this message translates to:
  /// **'Notifications are off for Loupe in Android Settings.'**
  String get settingsNotificationsOffAndroid;

  /// No description provided for @settingsNotificationsBlockedFooter.
  ///
  /// In en, this message translates to:
  /// **'{system} doesn’t let Loupe show notifications. Allow them in Settings.'**
  String settingsNotificationsBlockedFooter(String system);

  /// Section header: the accounts that notify about new mail.
  ///
  /// In en, this message translates to:
  /// **'New Mail'**
  String get settingsNewMailHeader;

  /// No description provided for @settingsNewMailFooterDemo.
  ///
  /// In en, this message translates to:
  /// **'Demo mail doesn’t arrive in the background. Send a test notification to see how new mail looks.'**
  String get settingsNewMailFooterDemo;

  /// No description provided for @settingsNewMailFooterIos.
  ///
  /// In en, this message translates to:
  /// **'Loupe checks for new mail in the background when iOS lets it, which can be hours apart for apps you don’t open often. You’re told about new messages in your inboxes, and from VIPs in any folder.'**
  String get settingsNewMailFooterIos;

  /// No description provided for @settingsNewMailFooterAndroid.
  ///
  /// In en, this message translates to:
  /// **'Loupe checks for new mail about every 15 minutes, when Android allows. You’re told about new messages in your inboxes, and from VIPs in any folder.'**
  String get settingsNewMailFooterAndroid;

  /// No description provided for @settingsNoAccounts.
  ///
  /// In en, this message translates to:
  /// **'No Accounts'**
  String get settingsNoAccounts;

  /// Switch: notify only about messages from VIPs.
  ///
  /// In en, this message translates to:
  /// **'VIP Only'**
  String get settingsVipOnly;

  /// No description provided for @settingsVipOnlyDetail.
  ///
  /// In en, this message translates to:
  /// **'Only messages from your VIPs'**
  String get settingsVipOnlyDetail;

  /// Switch: notifications don't show the sender, subject or preview.
  ///
  /// In en, this message translates to:
  /// **'Hide Content'**
  String get settingsHideContent;

  /// “New message from” quotes the hidden notification's title; use the same words as there.
  ///
  /// In en, this message translates to:
  /// **'Notifications only say “New message from” and the account, not who wrote or what about.'**
  String get settingsHideContentFooterOn;

  /// No description provided for @settingsHideContentFooterOff.
  ///
  /// In en, this message translates to:
  /// **'Hide Content keeps the sender, subject and preview off the lock screen and out of notifications.'**
  String get settingsHideContentFooterOff;

  /// iOS's setting of that name; use Apple's words for it. Opens Loupe's page in the Settings app.
  ///
  /// In en, this message translates to:
  /// **'Background App Refresh'**
  String get settingsBackgroundAppRefresh;

  /// No description provided for @settingsBackgroundRefreshFooter.
  ///
  /// In en, this message translates to:
  /// **'New mail only arrives in the background while Background App Refresh is on for Loupe in Settings. iOS can’t keep a connection to your inboxes open, so there’s no Instant Delivery.'**
  String get settingsBackgroundRefreshFooter;

  /// Android: keeps a connection to the inboxes open so new mail arrives at once.
  ///
  /// In en, this message translates to:
  /// **'Instant Delivery'**
  String get settingsInstantDelivery;

  /// “Watching for new mail” quotes the notification's text; use the same words as there.
  ///
  /// In en, this message translates to:
  /// **'Instant Delivery (experimental) keeps a connection to your inboxes open, so new mail arrives within seconds. It shows a quiet “Watching for new mail” notification and uses more battery.'**
  String get settingsInstantDeliveryFooter;

  /// No description provided for @settingsBatteryRestrictedFooter.
  ///
  /// In en, this message translates to:
  /// **'Android may stop Instant Delivery to save battery. Let Loupe use the battery without restrictions to keep it running.'**
  String get settingsBatteryRestrictedFooter;

  /// No description provided for @settingsExperimental.
  ///
  /// In en, this message translates to:
  /// **'Experimental'**
  String get settingsExperimental;

  /// No description provided for @settingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get settingsComingSoon;

  /// Button: opens Android's battery settings for Loupe.
  ///
  /// In en, this message translates to:
  /// **'Allow Unrestricted Battery Use'**
  String get settingsAllowUnrestrictedBattery;

  /// No description provided for @settingsSendTestNotification.
  ///
  /// In en, this message translates to:
  /// **'Send Test Notification'**
  String get settingsSendTestNotification;

  /// Settings row and the title of its page: the number on the app's icon.
  ///
  /// In en, this message translates to:
  /// **'App Icon Badge'**
  String get settingsAppIconBadge;

  /// No description provided for @settingsBadgeNote.
  ///
  /// In en, this message translates to:
  /// **'The badge updates whenever Loupe checks for mail, also in the background.'**
  String get settingsBadgeNote;

  /// No description provided for @settingsBadgeUnsupportedFooter.
  ///
  /// In en, this message translates to:
  /// **'This phone’s home screen doesn’t show numbers on app icons. The badge updates whenever Loupe checks for mail, also in the background.'**
  String get settingsBadgeUnsupportedFooter;

  /// Text of the test notification when there is no message to show in it.
  ///
  /// In en, this message translates to:
  /// **'Notifications for new mail look like this.'**
  String get settingsTestNotificationBody;

  /// No description provided for @settingsAccountRemoved.
  ///
  /// In en, this message translates to:
  /// **'This account was removed.'**
  String get settingsAccountRemoved;

  /// Section header: the account's name and address.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccountHeader;

  /// Field label: the account's name in Loupe.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get settingsAccountDescription;

  /// Placeholder of the account name field: two example names.
  ///
  /// In en, this message translates to:
  /// **'Work, Personal…'**
  String get settingsAccountDescriptionHint;

  /// Label: an email address.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get settingsEmail;

  /// Section header: the account's colour.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get settingsColour;

  /// No description provided for @settingsColourFooter.
  ///
  /// In en, this message translates to:
  /// **'Marks this account’s messages in All Inboxes.'**
  String get settingsColourFooter;

  /// Screen reader label of a colour swatch.
  ///
  /// In en, this message translates to:
  /// **'Colour {number}'**
  String settingsColourNumber(int number);

  /// Section header: the account's identities.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get settingsSendingHeader;

  /// No description provided for @settingsSendingFooter.
  ///
  /// In en, this message translates to:
  /// **'Each identity has its own signature. Replies go out from the address a message was sent to.'**
  String get settingsSendingFooter;

  /// Section header: the account's folder options.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get settingsFoldersHeader;

  /// No description provided for @settingsFoldersFooter.
  ///
  /// In en, this message translates to:
  /// **'Loupe shows and syncs the folders you subscribe to, as Thunderbird does. Inbox, Drafts, Sent, Junk, Trash and Archive always show.'**
  String get settingsFoldersFooter;

  /// Switch: show the folders not subscribed to as well.
  ///
  /// In en, this message translates to:
  /// **'Show All Folders'**
  String get settingsShowAllFolders;

  /// The incoming mail server (IMAP or JMAP).
  ///
  /// In en, this message translates to:
  /// **'Incoming'**
  String get settingsIncoming;

  /// The outgoing mail server (SMTP).
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get settingsOutgoing;

  /// A server's connection security, the other choices being TLS and STARTTLS.
  ///
  /// In en, this message translates to:
  /// **'Not encrypted'**
  String get settingsConnectionNotEncrypted;

  /// Section header and row: how the account signs in to its server (a password, or a provider such as Google).
  ///
  /// In en, this message translates to:
  /// **'Sign-in'**
  String get settingsSignIn;

  /// The account's sign-in no longer works.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get settingsSignInExpired;

  /// No description provided for @settingsSignInExpiredFooter.
  ///
  /// In en, this message translates to:
  /// **'{provider} no longer accepts Loupe’s sign-in for this account, so its mail isn’t syncing. Sign in again to fix it.'**
  String settingsSignInExpiredFooter(String provider);

  /// No description provided for @settingsSignInAgain.
  ///
  /// In en, this message translates to:
  /// **'Sign In Again'**
  String get settingsSignInAgain;

  /// In place of Sign In Again while it runs.
  ///
  /// In en, this message translates to:
  /// **'Signing In…'**
  String get settingsSigningIn;

  /// No description provided for @settingsRemoveAccount.
  ///
  /// In en, this message translates to:
  /// **'Remove Account'**
  String get settingsRemoveAccount;

  /// No description provided for @settingsRemoveAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove “{account}”?'**
  String settingsRemoveAccountTitle(String account);

  /// No description provided for @settingsRemoveAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Its mail and settings are removed from this phone. Nothing is deleted on the server.'**
  String get settingsRemoveAccountMessage;

  /// Settings row and the title of its page: the folders the account subscribes to.
  ///
  /// In en, this message translates to:
  /// **'Manage Folders'**
  String get settingsManageFolders;

  /// No description provided for @settingsNoFolders.
  ///
  /// In en, this message translates to:
  /// **'No folders yet.'**
  String get settingsNoFolders;

  /// No description provided for @settingsManageFoldersFooter.
  ///
  /// In en, this message translates to:
  /// **'Subscribed folders show on the Mailboxes screen and sync in the background. Other mail apps on the same account usually follow these subscriptions too.'**
  String get settingsManageFoldersFooter;

  /// Under the name of the server folder that stores the smart mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Keeps your Smart Mailboxes for your other devices. Hidden on the Mailboxes screen.'**
  String get settingsSmartMailboxesFolder;

  /// Beside a special folder (Inbox, Sent…), which has no switch.
  ///
  /// In en, this message translates to:
  /// **'Always Shown'**
  String get settingsFolderAlwaysShown;

  /// Screen reader label of a folder's switch.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to {folder}'**
  String settingsSubscribeToFolder(String folder);

  /// The addresses an account sends from. Settings row and the title of its page.
  ///
  /// In en, this message translates to:
  /// **'Identities'**
  String get settingsIdentities;

  /// No description provided for @settingsIdentitiesFooterReorder.
  ///
  /// In en, this message translates to:
  /// **'The first identity is the default for new messages. Drag to change the order.'**
  String get settingsIdentitiesFooterReorder;

  /// No description provided for @settingsIdentitiesFooterSingle.
  ///
  /// In en, this message translates to:
  /// **'The default identity for new messages.'**
  String get settingsIdentitiesFooterSingle;

  /// No description provided for @settingsIdentitiesReplyFooter.
  ///
  /// In en, this message translates to:
  /// **'A reply goes out from the identity the message was sent to.'**
  String get settingsIdentitiesReplyFooter;

  /// Beside the first identity: the one new messages use.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get settingsIdentityDefault;

  /// Screen reader label of an identity's drag handle.
  ///
  /// In en, this message translates to:
  /// **'Reorder {email}'**
  String settingsIdentityReorder(String email);

  /// No description provided for @settingsAddIdentity.
  ///
  /// In en, this message translates to:
  /// **'Add Identity'**
  String get settingsAddIdentity;

  /// Title of the page making a new identity.
  ///
  /// In en, this message translates to:
  /// **'New Identity'**
  String get settingsNewIdentity;

  /// Title of the page editing an identity.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get settingsIdentity;

  /// Placeholder of the identity's name field.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get settingsIdentityNameHint;

  /// Field label: the address replies go to (the Reply-To header).
  ///
  /// In en, this message translates to:
  /// **'Reply-To'**
  String get settingsReplyTo;

  /// No description provided for @settingsSignature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get settingsSignature;

  /// “-- ” (two dashes and a space) is the standard signature separator; keep it as it is.
  ///
  /// In en, this message translates to:
  /// **'Added below “-- ” in messages from this identity.'**
  String get settingsSignatureFooter;

  /// Placeholder of the empty signature field.
  ///
  /// In en, this message translates to:
  /// **'No signature'**
  String get settingsNoSignature;

  /// Section header: addresses copied (Cc or Bcc) on every message from the identity.
  ///
  /// In en, this message translates to:
  /// **'Copy to Myself'**
  String get settingsCopyToMyself;

  /// No description provided for @settingsCopyToMyselfFooter.
  ///
  /// In en, this message translates to:
  /// **'Added to every message from this identity.'**
  String get settingsCopyToMyselfFooter;

  /// Field label: carbon copy, as in a message's Cc field.
  ///
  /// In en, this message translates to:
  /// **'Cc'**
  String get settingsCc;

  /// Field label: blind carbon copy, as in a message's Bcc field.
  ///
  /// In en, this message translates to:
  /// **'Bcc'**
  String get settingsBcc;

  /// Section header and dialog title: the addresses whose replies go out from this identity.
  ///
  /// In en, this message translates to:
  /// **'Use for Replies To'**
  String get settingsReplyPatterns;

  /// No description provided for @settingsReplyPatternsFooter.
  ///
  /// In en, this message translates to:
  /// **'Replies to messages sent to these addresses go out from this identity. * stands for anything: *@example.com, me+*@example.com.'**
  String get settingsReplyPatternsFooter;

  /// No description provided for @settingsReplyPatternPrompt.
  ///
  /// In en, this message translates to:
  /// **'An address, or a pattern where * stands for anything.'**
  String get settingsReplyPatternPrompt;

  /// No description provided for @settingsAddReplyPattern.
  ///
  /// In en, this message translates to:
  /// **'Add Address or Pattern'**
  String get settingsAddReplyPattern;

  /// Tooltip of the button removing an address or pattern.
  ///
  /// In en, this message translates to:
  /// **'Remove {pattern}'**
  String settingsRemoveReplyPattern(String pattern);

  /// No description provided for @settingsInvalidPatternTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid Pattern'**
  String get settingsInvalidPatternTitle;

  /// No description provided for @settingsInvalidPatternMessage.
  ///
  /// In en, this message translates to:
  /// **'“{input}” isn’t an address or a pattern like *@example.com.'**
  String settingsInvalidPatternMessage(String input);

  /// No description provided for @settingsIdentityNoAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'No Address'**
  String get settingsIdentityNoAddressTitle;

  /// No description provided for @settingsIdentityNoAddressMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter the email address to send from.'**
  String get settingsIdentityNoAddressMessage;

  /// No description provided for @settingsIdentityInvalidAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid Address'**
  String get settingsIdentityInvalidAddressTitle;

  /// Which field holds the address: replyTo, cc, bcc, or other for the identity's own address. Use the same words as settingsReplyTo, settingsCc and settingsBcc.
  ///
  /// In en, this message translates to:
  /// **'{field, select, replyTo{Reply-To “{address}” isn’t a valid email address.} cc{Cc “{address}” isn’t a valid email address.} bcc{Bcc “{address}” isn’t a valid email address.} other{“{address}” isn’t a valid email address.}}'**
  String settingsIdentityInvalidAddress(String field, String address);

  /// No description provided for @settingsSaveIdentity.
  ///
  /// In en, this message translates to:
  /// **'Save Identity'**
  String get settingsSaveIdentity;

  /// No description provided for @settingsDiscardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard Changes'**
  String get settingsDiscardChanges;

  /// No description provided for @settingsDeleteIdentity.
  ///
  /// In en, this message translates to:
  /// **'Delete Identity'**
  String get settingsDeleteIdentity;

  /// No description provided for @settingsDeleteIdentityTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete “{email}”?'**
  String settingsDeleteIdentityTitle(String email);

  /// No description provided for @settingsDeleteIdentityMessage.
  ///
  /// In en, this message translates to:
  /// **'Messages already sent from it stay as they are.'**
  String get settingsDeleteIdentityMessage;

  /// No description provided for @settingsLastIdentityFooter.
  ///
  /// In en, this message translates to:
  /// **'An account needs at least one identity.'**
  String get settingsLastIdentityFooter;

  /// The Rules screen's title, and its row in Settings.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rulesTitle;

  /// Tooltip of the button that makes a new rule.
  ///
  /// In en, this message translates to:
  /// **'New Rule'**
  String get rulesNewRule;

  /// No description provided for @rulesLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t load the rules.'**
  String get rulesLoadError;

  /// No description provided for @rulesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Rules'**
  String get rulesEmptyTitle;

  /// “Make This a Rule” is the search screen's action of that name; use the same words as there.
  ///
  /// In en, this message translates to:
  /// **'Rules file, tag and flag new mail for you. Make one with the compose button above, or from a search with “Make This a Rule”.'**
  String get rulesEmptyText;

  /// No description provided for @rulesListFooter.
  ///
  /// In en, this message translates to:
  /// **'Rules run from top to bottom on new mail in the Inbox. Touch and hold a rule to move it.'**
  String get rulesListFooter;

  /// Dialog title; the server's error message follows.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t Change the Rule'**
  String get rulesChangeError;

  /// In the rule list, in place of an empty condition.
  ///
  /// In en, this message translates to:
  /// **'Every message'**
  String get rulesConditionEveryMessage;

  /// Screen reader label of a rule's drag handle, which changes its place in the list.
  ///
  /// In en, this message translates to:
  /// **'Move {rule}'**
  String rulesMoveRule(String rule);

  /// Screen reader label of a rule's on/off switch.
  ///
  /// In en, this message translates to:
  /// **'{rule} on'**
  String rulesRuleOn(String rule);

  /// Section header: per account, whether the mail server runs Loupe's rules.
  ///
  /// In en, this message translates to:
  /// **'Server Rules'**
  String get rulesServerRulesHeader;

  /// “loupe” is the script's name on the server; keep it as it is.
  ///
  /// In en, this message translates to:
  /// **'Server rules run on the mail server as mail arrives, also while this phone is off. They are kept in a Sieve script named “loupe”.'**
  String get rulesServerRulesFooter;

  /// Server rules state when the server couldn't be asked.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get rulesStatusUnknown;

  /// No description provided for @rulesStatusError.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t ask the server.'**
  String get rulesStatusError;

  /// No description provided for @rulesStatusChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get rulesStatusChecking;

  /// Server rules are on, run from another script that includes Loupe's.
  ///
  /// In en, this message translates to:
  /// **'Run from “{script}”.'**
  String rulesStatusViaInclude(String script);

  /// No description provided for @rulesStatusOtherScript.
  ///
  /// In en, this message translates to:
  /// **'“{script}” is the active script. Tap to let it run Loupe’s rules too.'**
  String rulesStatusOtherScript(String script);

  /// No description provided for @rulesStatusNoScript.
  ///
  /// In en, this message translates to:
  /// **'No script is active on the server. Saving a server rule turns Loupe’s on.'**
  String get rulesStatusNoScript;

  /// Server rules state: the server can't run rules.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get rulesStatusUnavailable;

  /// No description provided for @rulesStatusNoSieve.
  ///
  /// In en, this message translates to:
  /// **'This account’s server offers no Sieve (ManageSieve or JMAP).'**
  String get rulesStatusNoSieve;

  /// A rule's action.
  ///
  /// In en, this message translates to:
  /// **'Move to {folder}'**
  String rulesActionMove(String folder);

  /// A rule's action, when its folder is unknown.
  ///
  /// In en, this message translates to:
  /// **'Move to a folder'**
  String get rulesActionMoveUnknown;

  /// A rule's action: adds a tag.
  ///
  /// In en, this message translates to:
  /// **'Tag {tag}'**
  String rulesActionTag(String tag);

  /// A rule's action.
  ///
  /// In en, this message translates to:
  /// **'Remove Tag {tag}'**
  String rulesActionRemoveTag(String tag);

  /// A rule's action: the message stays in the Inbox, and later rules don't run.
  ///
  /// In en, this message translates to:
  /// **'Keep in Inbox'**
  String get rulesActionKeepInInbox;

  /// A rule's action.
  ///
  /// In en, this message translates to:
  /// **'Forward to {address}'**
  String rulesActionForward(String address);

  /// A rule's action.
  ///
  /// In en, this message translates to:
  /// **'Forward to {address}, keep no copy'**
  String rulesActionForwardNoCopy(String address);

  /// Last in the list of a rule's actions: later rules don't run.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get rulesActionStop;

  /// In place of a rule's actions when it has none.
  ///
  /// In en, this message translates to:
  /// **'Does nothing yet'**
  String get rulesNoActions;

  /// Small badge: the rule runs on this device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get rulesLocationDevice;

  /// Small badge and choice: the rule runs on the mail server.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get rulesLocationServer;

  /// Choice: the rule runs on this device.
  ///
  /// In en, this message translates to:
  /// **'This Device'**
  String get rulesLocationThisDevice;

  /// Title of the rule editor for a new rule.
  ///
  /// In en, this message translates to:
  /// **'New Rule'**
  String get rulesNewRuleTitle;

  /// Title of the rule editor for an existing rule.
  ///
  /// In en, this message translates to:
  /// **'Edit Rule'**
  String get rulesEditRuleTitle;

  /// A rule's name when none was typed and the condition is empty.
  ///
  /// In en, this message translates to:
  /// **'Every Message'**
  String get rulesDefaultNameEveryMessage;

  /// No description provided for @rulesConditionHeader.
  ///
  /// In en, this message translates to:
  /// **'When a New Message Matches'**
  String get rulesConditionHeader;

  /// from:, to:, s:, b:, tag:, has:attachment and larger:2M are search keywords; keep them as they are.
  ///
  /// In en, this message translates to:
  /// **'Write it as you would search: from:, to:, s: (subject), b: (body), tag:, has:attachment, larger:2M…'**
  String get rulesConditionFooter;

  /// Placeholder of the condition field: an example search. Keep from: and s:; the address and the word may change.
  ///
  /// In en, this message translates to:
  /// **'from:alice@example.com s:invoice'**
  String get rulesConditionHint;

  /// Row and the title of its page: the accounts a rule acts on.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get rulesAccounts;

  /// No description provided for @rulesAllAccounts.
  ///
  /// In en, this message translates to:
  /// **'All Accounts'**
  String get rulesAllAccounts;

  /// In the list of a rule's accounts, for an account that was removed.
  ///
  /// In en, this message translates to:
  /// **'Removed account'**
  String get rulesRemovedAccount;

  /// No description provided for @rulesAccountsFooter.
  ///
  /// In en, this message translates to:
  /// **'A rule for all accounts also covers accounts you add later.'**
  String get rulesAccountsFooter;

  /// Section header above a rule's actions, after “When a New Message Matches”.
  ///
  /// In en, this message translates to:
  /// **'Then'**
  String get rulesActionsHeader;

  /// No description provided for @rulesForwardingFooter.
  ///
  /// In en, this message translates to:
  /// **'Forwarding sends every matching message to another address as it arrives, also while this phone is off. Some providers limit how much mail may be forwarded.'**
  String get rulesForwardingFooter;

  /// No description provided for @rulesForwardingHiddenFooter.
  ///
  /// In en, this message translates to:
  /// **'Forwarding only runs in server rules, so it is left out here.'**
  String get rulesForwardingHiddenFooter;

  /// Screen reader label of the button removing one of a rule's actions.
  ///
  /// In en, this message translates to:
  /// **'Remove {action}'**
  String rulesRemoveAction(String action);

  /// Button and the title of its menu: adds an action to a rule.
  ///
  /// In en, this message translates to:
  /// **'Add Action'**
  String get rulesAddAction;

  /// No description provided for @rulesAddMove.
  ///
  /// In en, this message translates to:
  /// **'Move to Folder…'**
  String get rulesAddMove;

  /// No description provided for @rulesAddTagMenu.
  ///
  /// In en, this message translates to:
  /// **'Add Tag…'**
  String get rulesAddTagMenu;

  /// No description provided for @rulesRemoveTagMenu.
  ///
  /// In en, this message translates to:
  /// **'Remove Tag…'**
  String get rulesRemoveTagMenu;

  /// No description provided for @rulesAddForward.
  ///
  /// In en, this message translates to:
  /// **'Forward To…'**
  String get rulesAddForward;

  /// No description provided for @rulesStopProcessing.
  ///
  /// In en, this message translates to:
  /// **'Stop Processing More Rules'**
  String get rulesStopProcessing;

  /// Section header: where the rule runs (This Device or Server).
  ///
  /// In en, this message translates to:
  /// **'Run On'**
  String get rulesRunOnHeader;

  /// No description provided for @rulesRunOnDeviceFooter.
  ///
  /// In en, this message translates to:
  /// **'This device runs the rule on new Inbox mail each time Loupe checks for mail.'**
  String get rulesRunOnDeviceFooter;

  /// No description provided for @rulesRunOnServerFooter.
  ///
  /// In en, this message translates to:
  /// **'The mail server runs the rule as mail arrives, also while this phone is off. Needs Sieve, over ManageSieve (Dovecot, mailcow) or JMAP (Stalwart).'**
  String get rulesRunOnServerFooter;

  /// No description provided for @rulesApplyToExisting.
  ///
  /// In en, this message translates to:
  /// **'Apply to Existing Messages…'**
  String get rulesApplyToExisting;

  /// No description provided for @rulesDeleteRule.
  ///
  /// In en, this message translates to:
  /// **'Delete Rule'**
  String get rulesDeleteRule;

  /// No description provided for @rulesDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete “{rule}”?'**
  String rulesDeleteTitle(String rule);

  /// No description provided for @rulesMoveAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Folder in Which Account?'**
  String get rulesMoveAccountTitle;

  /// No description provided for @rulesMoveAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Mail of the other accounts goes to the folder with the same name there.'**
  String get rulesMoveAccountMessage;

  /// Title of the menu of tags to add.
  ///
  /// In en, this message translates to:
  /// **'Add Tag'**
  String get rulesAddTag;

  /// Title of the menu of tags to remove.
  ///
  /// In en, this message translates to:
  /// **'Remove Tag'**
  String get rulesRemoveTag;

  /// Title of the dialog asking for the address to forward to.
  ///
  /// In en, this message translates to:
  /// **'Forward To'**
  String get rulesForwardTo;

  /// No description provided for @rulesForwardToMessage.
  ///
  /// In en, this message translates to:
  /// **'The server sends every matching message on to this address, also while this phone is off. Use an address you own or trust.'**
  String get rulesForwardToMessage;

  /// No description provided for @rulesNotAnAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Not an Email Address'**
  String get rulesNotAnAddressTitle;

  /// No description provided for @rulesNotAnAddressMessage.
  ///
  /// In en, this message translates to:
  /// **'“{address}” isn’t an address to forward to.'**
  String rulesNotAnAddressMessage(String address);

  /// No description provided for @rulesKeepCopyTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep a Copy Here?'**
  String get rulesKeepCopyTitle;

  /// No description provided for @rulesKeepCopy.
  ///
  /// In en, this message translates to:
  /// **'Keep a Copy'**
  String get rulesKeepCopy;

  /// No description provided for @rulesDontKeepCopy.
  ///
  /// In en, this message translates to:
  /// **'Don’t Keep a Copy'**
  String get rulesDontKeepCopy;

  /// Dialog title; what is wrong with the condition follows.
  ///
  /// In en, this message translates to:
  /// **'Check the Condition'**
  String get rulesCheckCondition;

  /// No description provided for @rulesChooseActionTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose an Action'**
  String get rulesChooseActionTitle;

  /// No description provided for @rulesChooseActionMessage.
  ///
  /// In en, this message translates to:
  /// **'Add what the rule does with the messages it matches.'**
  String get rulesChooseActionMessage;

  /// Dialog title; the error message follows.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t Save the Rule'**
  String get rulesSaveError;

  /// Dialog title; the server's error message follows.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t Save the Server Rule'**
  String get rulesSaveServerError;

  /// No description provided for @rulesRunOnDeviceInstead.
  ///
  /// In en, this message translates to:
  /// **'Run on This Device Instead'**
  String get rulesRunOnDeviceInstead;

  /// No description provided for @rulesNothingToApplyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing to Apply'**
  String get rulesNothingToApplyTitle;

  /// No description provided for @rulesNothingToApplyMessage.
  ///
  /// In en, this message translates to:
  /// **'Give the rule a condition that works and an action first.'**
  String get rulesNothingToApplyMessage;

  /// Title of a menu: Inboxes or All Mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Apply “{rule}” to Messages in…'**
  String rulesApplyScopeTitle(String rule);

  /// No description provided for @rulesApplyScopeInboxes.
  ///
  /// In en, this message translates to:
  /// **'Inboxes'**
  String get rulesApplyScopeInboxes;

  /// No description provided for @rulesApplyScopeAll.
  ///
  /// In en, this message translates to:
  /// **'All Mailboxes'**
  String get rulesApplyScopeAll;

  /// No description provided for @rulesFindingMessages.
  ///
  /// In en, this message translates to:
  /// **'Finding Messages…'**
  String get rulesFindingMessages;

  /// No description provided for @rulesSearchError.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t Search'**
  String get rulesSearchError;

  /// No description provided for @rulesSearchErrorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get rulesSearchErrorUnknown;

  /// No description provided for @rulesNoMatchesTitle.
  ///
  /// In en, this message translates to:
  /// **'No Messages Match'**
  String get rulesNoMatchesTitle;

  /// No description provided for @rulesNoMatchesMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing there matches “{condition}”.'**
  String rulesNoMatchesMessage(String condition);

  /// No description provided for @rulesApplyConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Apply “{rule}” to {count} Message?} other{Apply “{rule}” to {count} Messages?}}'**
  String rulesApplyConfirmTitle(int count, String rule);

  /// Button.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Apply to {count} Message} other{Apply to {count} Messages}}'**
  String rulesApplyConfirm(int count);

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Applied “{rule}” to {count} message} other{Applied “{rule}” to {count} messages}}'**
  String rulesApplied(int count, String rule);

  /// No description provided for @rulesServerChecking.
  ///
  /// In en, this message translates to:
  /// **'Asking the server what it can do…'**
  String get rulesServerChecking;

  /// No description provided for @rulesServerUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t reach the server.'**
  String get rulesServerUnreachable;

  /// No description provided for @rulesServerProblem.
  ///
  /// In en, this message translates to:
  /// **'Can’t run on the server: {problem}'**
  String rulesServerProblem(String problem);

  /// No description provided for @rulesServerProblemOf.
  ///
  /// In en, this message translates to:
  /// **'Can’t run on the server of {account}: {problem}'**
  String rulesServerProblemOf(String account, String problem);

  /// No description provided for @rulesShowScript.
  ///
  /// In en, this message translates to:
  /// **'Show Script'**
  String get rulesShowScript;

  /// No description provided for @rulesHideScript.
  ///
  /// In en, this message translates to:
  /// **'Hide Script'**
  String get rulesHideScript;

  /// Section header above the messages a rule's condition matches.
  ///
  /// In en, this message translates to:
  /// **'Matching Messages'**
  String get rulesMatchingHeader;

  /// rulesMatchingHeader while the search runs.
  ///
  /// In en, this message translates to:
  /// **'Matching Messages…'**
  String get rulesMatchingHeaderLoading;

  /// Section header above the messages a rule's condition matches.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} Matching Message} other{{count} Matching Messages}}'**
  String rulesMatchingCount(int count);

  /// rulesMatchingCount when there are more than were counted (“50+”).
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count}+ Matching Message} other{{count}+ Matching Messages}}'**
  String rulesMatchingCountMore(int count);

  /// No description provided for @rulesPreviewFooter.
  ///
  /// In en, this message translates to:
  /// **'From the last 30 days. The rule itself only acts on new mail, unless you apply it to existing messages.'**
  String get rulesPreviewFooter;

  /// No description provided for @rulesConditionError.
  ///
  /// In en, this message translates to:
  /// **'The condition has an error: {error}'**
  String rulesConditionError(String error);

  /// No description provided for @rulesPreviewNoSender.
  ///
  /// In en, this message translates to:
  /// **'(no sender)'**
  String get rulesPreviewNoSender;

  /// No description provided for @rulesPreviewNoSubject.
  ///
  /// In en, this message translates to:
  /// **'(no subject)'**
  String get rulesPreviewNoSubject;

  /// Below the first matching messages: how many more there are.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{and {count} more}}'**
  String rulesPreviewMore(int count);

  /// No description provided for @rulesPreviewEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing from the last 30 days.'**
  String get rulesPreviewEmpty;

  /// No description provided for @rulesIncludeTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn On Server Rules'**
  String get rulesIncludeTitle;

  /// Button: close without letting the server run Loupe's rules.
  ///
  /// In en, this message translates to:
  /// **'Leave Off'**
  String get rulesIncludeLeaveOff;

  /// No description provided for @rulesIncludeAlreadyOn.
  ///
  /// In en, this message translates to:
  /// **'The server already runs Loupe’s rules for {account}.'**
  String rulesIncludeAlreadyOn(String account);

  /// The lines of Sieve code follow it.
  ///
  /// In en, this message translates to:
  /// **'“{script}” is the active script on {account}’s server, so the server runs it and not Loupe’s rules. Loupe won’t replace it. It can add these lines to it, and the server then runs Loupe’s rules after the script’s own:'**
  String rulesIncludeExplanation(String script, String account);

  /// No description provided for @rulesShowWholeScript.
  ///
  /// In en, this message translates to:
  /// **'Show Whole Script'**
  String get rulesShowWholeScript;

  /// No description provided for @rulesHideWholeScript.
  ///
  /// In en, this message translates to:
  /// **'Hide Whole Script'**
  String get rulesHideWholeScript;

  /// No description provided for @rulesIncludeFootnote.
  ///
  /// In en, this message translates to:
  /// **'Nothing else in “{script}” changes. If its filters are edited in the webmail later, the webmail may rewrite it without these lines; Loupe then shows server rules as off again.'**
  String rulesIncludeFootnote(String script);

  /// Button: adds the lines to the server's script.
  ///
  /// In en, this message translates to:
  /// **'Add to “{script}”'**
  String rulesIncludeAdd(String script);

  /// The screen of newsletters and mailing lists.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptionsTitle;

  /// Tab: newsletters, offers and other bulk mail, by sender.
  ///
  /// In en, this message translates to:
  /// **'Newsletters'**
  String get subscriptionsNewsletters;

  /// Tab: mailing lists that people write to.
  ///
  /// In en, this message translates to:
  /// **'Discussions'**
  String get subscriptionsDiscussions;

  /// Placeholder of the field that filters the list by name or address.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get subscriptionsFilter;

  /// Filter chip: newsletters none of whose mail was read.
  ///
  /// In en, this message translates to:
  /// **'Never Read'**
  String get subscriptionsFilterNeverRead;

  /// Filter chip: newsletters under a quarter of whose mail was read.
  ///
  /// In en, this message translates to:
  /// **'Rarely Read'**
  String get subscriptionsFilterRarelyRead;

  /// Filter chip: every newsletter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get subscriptionsFilterAll;

  /// Screen reader label of a filter chip: its name and how many newsletters it shows.
  ///
  /// In en, this message translates to:
  /// **'{filter}, {count}'**
  String subscriptionsFilterChip(String filter, int count);

  /// No description provided for @subscriptionsCountError.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t Count Subscriptions'**
  String get subscriptionsCountError;

  /// No description provided for @subscriptionsNoMatches.
  ///
  /// In en, this message translates to:
  /// **'No Matches'**
  String get subscriptionsNoMatches;

  /// No description provided for @subscriptionsNoNewsletterMatch.
  ///
  /// In en, this message translates to:
  /// **'No newsletter is called “{text}”.'**
  String subscriptionsNoNewsletterMatch(String text);

  /// No description provided for @subscriptionsNoListMatch.
  ///
  /// In en, this message translates to:
  /// **'No list is called “{text}”.'**
  String subscriptionsNoListMatch(String text);

  /// No description provided for @subscriptionsNoNewsletters.
  ///
  /// In en, this message translates to:
  /// **'No Newsletters'**
  String get subscriptionsNoNewsletters;

  /// No description provided for @subscriptionsNoNewslettersDetail.
  ///
  /// In en, this message translates to:
  /// **'Newsletters and other bulk mail show up here once they arrive.'**
  String get subscriptionsNoNewslettersDetail;

  /// Empty list under the Never Read filter: every newsletter was read some.
  ///
  /// In en, this message translates to:
  /// **'Nothing Never Read'**
  String get subscriptionsNothingNeverRead;

  /// Empty list under the Rarely Read filter.
  ///
  /// In en, this message translates to:
  /// **'Nothing Rarely Read'**
  String get subscriptionsNothingRarelyRead;

  /// No description provided for @subscriptionsNothingFilteredDetail.
  ///
  /// In en, this message translates to:
  /// **'You read some of everything you get.'**
  String get subscriptionsNothingFilteredDetail;

  /// No description provided for @subscriptionsNoDiscussions.
  ///
  /// In en, this message translates to:
  /// **'No Discussions'**
  String get subscriptionsNoDiscussions;

  /// No description provided for @subscriptionsNoDiscussionsDetail.
  ///
  /// In en, this message translates to:
  /// **'Mailing lists you can write to show up here once their mail arrives.'**
  String get subscriptionsNoDiscussionsDetail;

  /// No description provided for @subscriptionsDiscussionsFootnote.
  ///
  /// In en, this message translates to:
  /// **'Lists that several people write to. Touch and hold one to pin it to Mailboxes, read it as plain text, or move it to Newsletters.'**
  String get subscriptionsDiscussionsFootnote;

  /// “List-Unsubscribe=One-Click” is the exact text sent; keep it as it is.
  ///
  /// In en, this message translates to:
  /// **'Counted on this phone from the mail it has downloaded; nothing is sent anywhere to work this out. Loupe contacts a sender only when you tap Unsubscribe: one-click sends just “List-Unsubscribe=One-Click” to the address the sender gave, with no cookies and nothing else about you, and never loads its pages or images.'**
  String get subscriptionsPrivacyNote;

  /// How much a newsletter sends: nothing in the last 90 days.
  ///
  /// In en, this message translates to:
  /// **'None lately'**
  String get subscriptionsVolumeNone;

  /// How much a newsletter sends: less than one message a month.
  ///
  /// In en, this message translates to:
  /// **'< 1 / month'**
  String get subscriptionsVolumeUnderOne;

  /// How much a newsletter sends: about this many messages a month.
  ///
  /// In en, this message translates to:
  /// **'≈ {count} / month'**
  String subscriptionsVolumePerMonth(int count);

  /// How much of a newsletter's mail was read, in percent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String subscriptionsPercent(int percent);

  /// Under one percent of a newsletter's mail was read, but some was.
  ///
  /// In en, this message translates to:
  /// **'<1%'**
  String get subscriptionsPercentUnderOne;

  /// After how much a newsletter sends: “≈ 24 / month · read 3%”.
  ///
  /// In en, this message translates to:
  /// **'read {percent}'**
  String subscriptionsReadLabel(String percent);

  /// Under a newsletter: mail kept coming after unsubscribing.
  ///
  /// In en, this message translates to:
  /// **'Still sending'**
  String get subscriptionsStillSending;

  /// No description provided for @subscriptionsUnsubscribedOn.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed on {date}'**
  String subscriptionsUnsubscribedOn(String date);

  /// Under a newsletter whose unsubscribe web page was opened.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe page opened {date}'**
  String subscriptionsUnsubscribePageOpened(String date);

  /// Under Unsubscribe: how it is done.
  ///
  /// In en, this message translates to:
  /// **'One tap · contacts {site}'**
  String subscriptionsMethodOneClick(String site);

  /// Under Unsubscribe: how it is done.
  ///
  /// In en, this message translates to:
  /// **'By email to {addresses}'**
  String subscriptionsMethodMail(String addresses);

  /// Under Unsubscribe: how it is done.
  ///
  /// In en, this message translates to:
  /// **'On the website {site}'**
  String subscriptionsMethodWeb(String site);

  /// Button.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get subscriptionsUnsubscribe;

  /// No description provided for @subscriptionsUnsubscribeAgain.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe Again'**
  String get subscriptionsUnsubscribeAgain;

  /// Archives a newsletter's messages in the Inbox.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{Archive {count} in Inbox}}'**
  String subscriptionsArchiveInbox(int count);

  /// No description provided for @subscriptionsCreateRule.
  ///
  /// In en, this message translates to:
  /// **'Create Rule…'**
  String get subscriptionsCreateRule;

  /// No description provided for @subscriptionsCreateRuleDetail.
  ///
  /// In en, this message translates to:
  /// **'Move or archive its future mail'**
  String get subscriptionsCreateRuleDetail;

  /// No description provided for @subscriptionsTreatAsDiscussion.
  ///
  /// In en, this message translates to:
  /// **'Treat as Discussion'**
  String get subscriptionsTreatAsDiscussion;

  /// No description provided for @subscriptionsTreatAsDiscussionDetail.
  ///
  /// In en, this message translates to:
  /// **'A list people write to: read it forum style'**
  String get subscriptionsTreatAsDiscussionDetail;

  /// No description provided for @subscriptionsTreatAsNewsletter.
  ///
  /// In en, this message translates to:
  /// **'Treat as Newsletter'**
  String get subscriptionsTreatAsNewsletter;

  /// No description provided for @subscriptionsBlockSender.
  ///
  /// In en, this message translates to:
  /// **'Block Sender'**
  String get subscriptionsBlockSender;

  /// Button: sends a newsletter's mail to Junk from now on.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get subscriptionsBlock;

  /// A newsletter whose mail goes to Junk.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get subscriptionsBlocked;

  /// No description provided for @subscriptionsBlockedDetail.
  ///
  /// In en, this message translates to:
  /// **'New mail goes to Junk'**
  String get subscriptionsBlockedDetail;

  /// No description provided for @subscriptionsPin.
  ///
  /// In en, this message translates to:
  /// **'Pin to Mailboxes'**
  String get subscriptionsPin;

  /// No description provided for @subscriptionsUnpin.
  ///
  /// In en, this message translates to:
  /// **'Unpin from Mailboxes'**
  String get subscriptionsUnpin;

  /// No description provided for @subscriptionsOpenDefaultView.
  ///
  /// In en, this message translates to:
  /// **'Open in Default View'**
  String get subscriptionsOpenDefaultView;

  /// No description provided for @subscriptionsOpenPlainText.
  ///
  /// In en, this message translates to:
  /// **'Open as Plain Text (Mono)'**
  String get subscriptionsOpenPlainText;

  /// Screen reader: the list is pinned to the Mailboxes screen.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get subscriptionsPinned;

  /// Screen reader: how many of a list's messages are unread.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} unread}}'**
  String subscriptionsUnreadCount(int count);

  /// No description provided for @subscriptionsNoMailNow.
  ///
  /// In en, this message translates to:
  /// **'No mail from this sender now.'**
  String get subscriptionsNoMailNow;

  /// Section header, in capitals like the other section headers.
  ///
  /// In en, this message translates to:
  /// **'LATEST MESSAGES'**
  String get subscriptionsLatestMessages;

  /// Row: how much mail a newsletter sends.
  ///
  /// In en, this message translates to:
  /// **'Mail'**
  String get subscriptionsMail;

  /// No description provided for @subscriptionsNoneIn90Days.
  ///
  /// In en, this message translates to:
  /// **'None in 90 days'**
  String get subscriptionsNoneIn90Days;

  /// Row: how much of a newsletter's mail was read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get subscriptionsRead;

  /// No description provided for @subscriptionsReadDetail.
  ///
  /// In en, this message translates to:
  /// **'{percent} · {read} of {total}'**
  String subscriptionsReadDetail(String percent, int read, int total);

  /// No description provided for @subscriptionsLastReceived.
  ///
  /// In en, this message translates to:
  /// **'Last Received'**
  String get subscriptionsLastReceived;

  /// Row: the folders a newsletter's mail is in; their names follow.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Folder} other{Folders}}'**
  String subscriptionsFolders(int count);

  /// Row: mail kept coming after unsubscribing.
  ///
  /// In en, this message translates to:
  /// **'Still Sending'**
  String get subscriptionsStillSendingTitle;

  /// No description provided for @subscriptionsUnsubscribedTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed'**
  String get subscriptionsUnsubscribedTitle;

  /// Beside Still Sending: when the user unsubscribed.
  ///
  /// In en, this message translates to:
  /// **'since {date}'**
  String subscriptionsSince(String date);

  /// Beside Unsubscribed: the unsubscribe web page was opened then.
  ///
  /// In en, this message translates to:
  /// **'page opened {date}'**
  String subscriptionsPageOpened(String date);

  /// No description provided for @subscriptionsNoMethod.
  ///
  /// In en, this message translates to:
  /// **'{sender} doesn’t say how to unsubscribe.'**
  String subscriptionsNoMethod(String sender);

  /// No description provided for @subscriptionsNoMethodBlock.
  ///
  /// In en, this message translates to:
  /// **'{sender} doesn’t say how to unsubscribe. You can block it instead.'**
  String subscriptionsNoMethodBlock(String sender);

  /// No description provided for @subscriptionsUnsubscribing.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribing from {sender}…'**
  String subscriptionsUnsubscribing(String sender);

  /// No description provided for @subscriptionsUnsubscribed.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed from {sender}.'**
  String subscriptionsUnsubscribed(String sender);

  /// No description provided for @subscriptionsUnsubscribeFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t unsubscribe: {reason}'**
  String subscriptionsUnsubscribeFailed(String reason);

  /// Menu title; why, and the other ways to unsubscribe, follow.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t Unsubscribe Automatically'**
  String get subscriptionsOneClickFailedTitle;

  /// No description provided for @subscriptionsSendUnsubscribeEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Unsubscribe Email'**
  String get subscriptionsSendUnsubscribeEmail;

  /// Menu item: opens the sender's unsubscribe page.
  ///
  /// In en, this message translates to:
  /// **'Open {site}'**
  String subscriptionsOpenSite(String site);

  /// No description provided for @subscriptionsOpenSiteTitle.
  ///
  /// In en, this message translates to:
  /// **'Open {site}?'**
  String subscriptionsOpenSiteTitle(String site);

  /// Button: opens the unsubscribe page.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get subscriptionsOpen;

  /// No description provided for @subscriptionsWebExplanation.
  ///
  /// In en, this message translates to:
  /// **'{sender} unsubscribes on its website. The page opens in Loupe’s browser; finish there.'**
  String subscriptionsWebExplanation(String sender);

  /// No description provided for @subscriptionsWebInsecure.
  ///
  /// In en, this message translates to:
  /// **'The connection to this site isn’t encrypted.'**
  String get subscriptionsWebInsecure;

  /// No description provided for @subscriptionsHomographWarning.
  ///
  /// In en, this message translates to:
  /// **'Careful: this address imitates {site} with look-alike letters.'**
  String subscriptionsHomographWarning(String site);

  /// No description provided for @subscriptionsHomographWarningUnknown.
  ///
  /// In en, this message translates to:
  /// **'Careful: this address imitates another site with look-alike letters.'**
  String get subscriptionsHomographWarningUnknown;

  /// No description provided for @subscriptionsOpenSiteFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t open {site}.'**
  String subscriptionsOpenSiteFailed(String site);

  /// No description provided for @subscriptionsWebOpened.
  ///
  /// In en, this message translates to:
  /// **'Loupe notes today’s date and tells you if {sender} keeps writing.'**
  String subscriptionsWebOpened(String sender);

  /// No description provided for @subscriptionsUnsubscribeTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe from {sender}?'**
  String subscriptionsUnsubscribeTitle(String sender);

  /// No description provided for @subscriptionsOneClickContact.
  ///
  /// In en, this message translates to:
  /// **'Loupe will contact {site} to unsubscribe.'**
  String subscriptionsOneClickContact(String site);

  /// “List-Unsubscribe=One-Click” is the exact text sent; keep it as it is.
  ///
  /// In en, this message translates to:
  /// **'This is the only time Loupe contacts a sender’s website. It sends just “List-Unsubscribe=One-Click” to the address {sender} gave, without cookies or anything else about you, and doesn’t load the page.'**
  String subscriptionsOneClickExplanation(String sender);

  /// No description provided for @subscriptionsOneClickNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'The unsubscribe link isn’t a secure address on the internet.'**
  String get subscriptionsOneClickNotAllowed;

  /// No description provided for @subscriptionsOneClickTimeout.
  ///
  /// In en, this message translates to:
  /// **'{site} didn’t answer in time.'**
  String subscriptionsOneClickTimeout(String site);

  /// No description provided for @subscriptionsOneClickUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t reach {site}.'**
  String subscriptionsOneClickUnreachable(String site);

  /// No description provided for @subscriptionsOneClickRedirected.
  ///
  /// In en, this message translates to:
  /// **'{site} sent the request on to another page, which Loupe doesn’t follow.'**
  String subscriptionsOneClickRedirected(String site);

  /// No description provided for @subscriptionsOneClickRefused.
  ///
  /// In en, this message translates to:
  /// **'{site} refused the request (error {status}).'**
  String subscriptionsOneClickRefused(String site, int status);

  /// No description provided for @subscriptionsNoAccountToSend.
  ///
  /// In en, this message translates to:
  /// **'There’s no account to send the unsubscribe email from.'**
  String get subscriptionsNoAccountToSend;

  /// No description provided for @subscriptionsMailConfirm.
  ///
  /// In en, this message translates to:
  /// **'Loupe will send an email to {to} from {from}, with the subject “{subject}”.'**
  String subscriptionsMailConfirm(String to, String from, String subject);

  /// No description provided for @subscriptionsMailSent.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe email sent to {address}.'**
  String subscriptionsMailSent(String address);

  /// No description provided for @subscriptionsBlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Block {sender}?'**
  String subscriptionsBlockTitle(String sender);

  /// No description provided for @subscriptionsBlockListMessage.
  ///
  /// In en, this message translates to:
  /// **'New mail from this list goes to Junk. You can change this in Settings › Rules.'**
  String get subscriptionsBlockListMessage;

  /// No description provided for @subscriptionsBlockSenderMessage.
  ///
  /// In en, this message translates to:
  /// **'New mail from {address} goes to Junk. You can change this in Settings › Rules.'**
  String subscriptionsBlockSenderMessage(String address);

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Blocked {sender}.'**
  String subscriptionsBlockedSender(String sender);

  /// Snack bar button: moves the blocked sender's messages in the Inbox to Junk.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{Move {count} to Junk}}'**
  String subscriptionsMoveToJunk(int count);

  /// The name of the rule that Block Sender makes.
  ///
  /// In en, this message translates to:
  /// **'Block {sender}'**
  String subscriptionsBlockRuleName(String sender);

  /// No description provided for @subscriptionsNowNewsletter.
  ///
  /// In en, this message translates to:
  /// **'{sender} is in Newsletters now.'**
  String subscriptionsNowNewsletter(String sender);

  /// No description provided for @subscriptionsNowDiscussion.
  ///
  /// In en, this message translates to:
  /// **'{sender} is in Discussions now.'**
  String subscriptionsNowDiscussion(String sender);

  /// First launch, under the app name. Two short lines.
  ///
  /// In en, this message translates to:
  /// **'Mail that’s simple on the surface\nand powerful underneath.'**
  String get welcomeTagline;

  /// No description provided for @welcomeAccountsTitle.
  ///
  /// In en, this message translates to:
  /// **'Every account, one calm inbox'**
  String get welcomeAccountsTitle;

  /// No description provided for @welcomeAccountsText.
  ///
  /// In en, this message translates to:
  /// **'Gmail, Outlook, iCloud, Fastmail and any IMAP or JMAP server.'**
  String get welcomeAccountsText;

  /// No description provided for @welcomeSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search that finds it'**
  String get welcomeSearchTitle;

  /// No description provided for @welcomeSearchText.
  ///
  /// In en, this message translates to:
  /// **'Instant results on your phone, then the server’s.'**
  String get welcomeSearchText;

  /// No description provided for @welcomePrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Private by design'**
  String get welcomePrivacyTitle;

  /// No description provided for @welcomePrivacyText.
  ///
  /// In en, this message translates to:
  /// **'No tracking. Remote images stay blocked until you say so.'**
  String get welcomePrivacyText;

  /// No description provided for @welcomeAddAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get welcomeAddAccount;

  /// No description provided for @welcomeImport.
  ///
  /// In en, this message translates to:
  /// **'Import from Thunderbird'**
  String get welcomeImport;

  /// No description provided for @welcomeTryDemo.
  ///
  /// In en, this message translates to:
  /// **'Try with demo mail'**
  String get welcomeTryDemo;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
