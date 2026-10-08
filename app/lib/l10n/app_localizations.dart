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

  /// Title of the account setup screen.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get accountSetupTitle;

  /// Title of account setup's last step, once the account is added.
  ///
  /// In en, this message translates to:
  /// **'Account Added'**
  String get accountSetupTitleDone;

  /// No description provided for @accountSetupAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a Mail Account'**
  String get accountSetupAddressTitle;

  /// No description provided for @accountSetupAddressText.
  ///
  /// In en, this message translates to:
  /// **'Loupe finds the settings for most providers.'**
  String get accountSetupAddressText;

  /// Placeholder of the Name field: the user's own name, as recipients see it.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get accountSetupNameHint;

  /// Label of the email address field.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get accountSetupEmail;

  /// Placeholder of the email address field: an example address.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get accountSetupEmailHint;

  /// Button: look up the settings for the address.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get accountSetupContinue;

  /// On the Continue button while Loupe looks up the server settings.
  ///
  /// In en, this message translates to:
  /// **'Looking up settings…'**
  String get accountSetupLookingUp;

  /// Button: add accounts from Thunderbird desktop's QR codes instead.
  ///
  /// In en, this message translates to:
  /// **'Import from Thunderbird'**
  String get accountSetupImport;

  /// No description provided for @accountSetupInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get accountSetupInvalidEmail;

  /// No description provided for @accountSetupSettingsNotFoundFor.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find settings for {domain}. Enter them below.'**
  String accountSetupSettingsNotFoundFor(String domain);

  /// No description provided for @accountSetupCheckServers.
  ///
  /// In en, this message translates to:
  /// **'Check the server names and ports.'**
  String get accountSetupCheckServers;

  /// No description provided for @accountSetupEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password.'**
  String get accountSetupEnterPassword;

  /// On the sign-in button while Loupe connects to the mail server.
  ///
  /// In en, this message translates to:
  /// **'Connecting…'**
  String get accountSetupConnecting;

  /// On the sign-in button while the provider's sign-in page is open in the browser.
  ///
  /// In en, this message translates to:
  /// **'Waiting for {provider}…'**
  String accountSetupWaitingFor(String provider);

  /// A help page in the browser couldn't be opened.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the page.'**
  String get accountSetupCouldNotOpenPage;

  /// The account was added, but its name and colour couldn't be saved.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t save the name.'**
  String get accountSetupCouldNotSaveName;

  /// Button under a certificate error: trust the server's own certificate and try again.
  ///
  /// In en, this message translates to:
  /// **'Trust This Certificate'**
  String get accountSetupTrustCertificate;

  /// Placeholder of the password field.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get accountSetupPasswordRequired;

  /// Tooltip of the eye button in the password field.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get accountSetupShowPassword;

  /// Tooltip of the eye button in the password field.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get accountSetupHidePassword;

  /// Label of the password field for providers that only take an app password from mail apps.
  ///
  /// In en, this message translates to:
  /// **'App Password'**
  String get accountSetupAppPassword;

  /// Label of the password field for Fastmail over JMAP, which takes an API token.
  ///
  /// In en, this message translates to:
  /// **'API Token'**
  String get accountSetupApiToken;

  /// Heading of the incoming server's settings.
  ///
  /// In en, this message translates to:
  /// **'Incoming · {protocol}'**
  String accountSetupIncoming(String protocol);

  /// Heading of the outgoing server's settings. SMTP is the protocol's name.
  ///
  /// In en, this message translates to:
  /// **'Outgoing · SMTP'**
  String get accountSetupOutgoing;

  /// Button: connect with the password and add the account.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get accountSetupSignIn;

  /// Button that opens the provider's sign-in page in the browser.
  ///
  /// In en, this message translates to:
  /// **'Sign in with {provider}'**
  String accountSetupSignInWith(String provider);

  /// Button: connect with an app password instead of signing in with Google.
  ///
  /// In en, this message translates to:
  /// **'Use an App Password'**
  String get accountSetupUseAppPassword;

  /// Button: connect with an app password instead of signing in with Google.
  ///
  /// In en, this message translates to:
  /// **'Use an App Password Instead'**
  String get accountSetupUseAppPasswordInstead;

  /// No description provided for @accountSetupUseDifferentAddress.
  ///
  /// In en, this message translates to:
  /// **'Use a Different Address'**
  String get accountSetupUseDifferentAddress;

  /// Link to Google's help page.
  ///
  /// In en, this message translates to:
  /// **'How to Create an App Password'**
  String get accountSetupHowToCreateAppPassword;

  /// Link to the provider's help page on creating an app password or API token.
  ///
  /// In en, this message translates to:
  /// **'How to Create One'**
  String get accountSetupHowToCreateOne;

  /// No description provided for @accountSetupGoogleNote.
  ///
  /// In en, this message translates to:
  /// **'You sign in on Google’s page, and Loupe never sees your password. Allow Loupe to read, send and organise your mail.'**
  String get accountSetupGoogleNote;

  /// The quoted words are the button's (accountSetupSignInWith). 2-Step Verification is Google's name for it.
  ///
  /// In en, this message translates to:
  /// **'“Sign in with Google” isn\'t available in this build yet. You can connect with an app password instead (it needs 2-Step Verification on your Google account).'**
  String get accountSetupGmailAppPasswordOnlyNote;

  /// No description provided for @accountSetupGmailAppPasswordNote.
  ///
  /// In en, this message translates to:
  /// **'Create an app password in your Google account and paste it below.'**
  String get accountSetupGmailAppPasswordNote;

  /// No description provided for @accountSetupMicrosoftNote.
  ///
  /// In en, this message translates to:
  /// **'You sign in on Microsoft’s page, and Loupe never sees your password. This works for Outlook.com and Hotmail, and for work or school accounts on Microsoft 365.'**
  String get accountSetupMicrosoftNote;

  /// No description provided for @accountSetupMicrosoftUnavailableNote.
  ///
  /// In en, this message translates to:
  /// **'Microsoft sign-in arrives in a later build. Outlook, Hotmail and Microsoft 365 accounts need it: they no longer accept passwords from mail apps.'**
  String get accountSetupMicrosoftUnavailableNote;

  /// No description provided for @accountSetupICloudNote.
  ///
  /// In en, this message translates to:
  /// **'iCloud Mail needs an app-specific password, not your Apple Account password.'**
  String get accountSetupICloudNote;

  /// No description provided for @accountSetupYahooNote.
  ///
  /// In en, this message translates to:
  /// **'Yahoo Mail needs an app password, not your account password.'**
  String get accountSetupYahooNote;

  /// Settings › Privacy & Security › Manage API tokens are Fastmail's menu items.
  ///
  /// In en, this message translates to:
  /// **'Loupe connects to Fastmail over JMAP with an API token: Settings › Privacy & Security › Manage API tokens, for JMAP, with access to email and sending.'**
  String get accountSetupFastmailJmapNote;

  /// No description provided for @accountSetupFastmailNote.
  ///
  /// In en, this message translates to:
  /// **'Fastmail needs an app password for mail apps.'**
  String get accountSetupFastmailNote;

  /// No description provided for @accountSetupServerSettings.
  ///
  /// In en, this message translates to:
  /// **'Server Settings'**
  String get accountSetupServerSettings;

  /// Under Server Settings: Loupe found no settings for the address.
  ///
  /// In en, this message translates to:
  /// **'Not found automatically'**
  String get accountSetupSettingsNotFound;

  /// Under Server Settings: where Loupe found the settings, such as a lookup service or a domain.
  ///
  /// In en, this message translates to:
  /// **'Found via {source}'**
  String accountSetupSettingsFoundVia(String source);

  /// No description provided for @accountSetupEditSettings.
  ///
  /// In en, this message translates to:
  /// **'Edit Settings'**
  String get accountSetupEditSettings;

  /// No description provided for @accountSetupSyncing.
  ///
  /// In en, this message translates to:
  /// **'Your mail is syncing.'**
  String get accountSetupSyncing;

  /// Label of the account's name as Loupe shows it (Work, Gmail), on the last step.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get accountSetupDescription;

  /// Placeholder of the account's name: example names.
  ///
  /// In en, this message translates to:
  /// **'Work, Personal…'**
  String get accountSetupDescriptionHint;

  /// Label of the account's colour choice.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get accountSetupColour;

  /// Screen reader label of one colour to choose.
  ///
  /// In en, this message translates to:
  /// **'Colour {number}'**
  String accountSetupColourNumber(int number);

  /// No description provided for @accountSetupSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get accountSetupSaving;

  /// No description provided for @accountSetupDatabaseUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Loupe couldn’t open its mail database on this phone. Close Loupe, open it again and retry.'**
  String get accountSetupDatabaseUnavailable;

  /// error is the technical name of what went wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong ({error}). Try again.'**
  String accountSetupUnexpectedError(String error);

  /// Connection security: no encryption (the others are TLS and STARTTLS).
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get accountSetupSecurityNone;

  /// Label of the choice between IMAP and JMAP.
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get accountSetupProtocol;

  /// No description provided for @accountSetupPort.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get accountSetupPort;

  /// Label of the connection security choice: TLS, STARTTLS or none.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get accountSetupSecurity;

  /// No description provided for @accountSetupUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get accountSetupUsername;

  /// Placeholder of the Username field: by default it's the address.
  ///
  /// In en, this message translates to:
  /// **'Your email address'**
  String get accountSetupUsernameHint;

  /// No description provided for @accountSetupNoEncryptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect Without Encryption?'**
  String get accountSetupNoEncryptionTitle;

  /// No description provided for @accountSetupNoEncryptionText.
  ///
  /// In en, this message translates to:
  /// **'Your password and every message would travel as plain text. Anyone on the network, such as public Wi-Fi, could read them. Only use this for a server on your own network.'**
  String get accountSetupNoEncryptionText;

  /// No description provided for @accountSetupUseWithoutEncryption.
  ///
  /// In en, this message translates to:
  /// **'Use Without Encryption'**
  String get accountSetupUseWithoutEncryption;

  /// No description provided for @accountSetupApiTokenRejected.
  ///
  /// In en, this message translates to:
  /// **'API token rejected. Create a Fastmail API token for JMAP with access to email, and paste it.'**
  String get accountSetupApiTokenRejected;

  /// No description provided for @accountSetupAppPasswordRejected.
  ///
  /// In en, this message translates to:
  /// **'Password rejected. Use an app password, not your account password.'**
  String get accountSetupAppPasswordRejected;

  /// No description provided for @accountSetupPasswordRejected.
  ///
  /// In en, this message translates to:
  /// **'Password rejected. Check it and try again.'**
  String get accountSetupPasswordRejected;

  /// No description provided for @accountSetupServerUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach server. Check the server settings and your connection.'**
  String get accountSetupServerUnreachable;

  /// details is the connection's own message, in English.
  ///
  /// In en, this message translates to:
  /// **'The server\'s certificate isn\'t trusted. {details}'**
  String accountSetupCertificateUntrusted(String details);

  /// The quoted words are the button's (accountSetupSignInWith).
  ///
  /// In en, this message translates to:
  /// **'Sign-in was cancelled. Tap “Sign in with {provider}” to try again.'**
  String accountSetupOAuthCancelled(String provider);

  /// No description provided for @accountSetupOAuthDeniedGmail.
  ///
  /// In en, this message translates to:
  /// **'Loupe needs permission to read and send your Gmail. Sign in again and allow access, with the Gmail box ticked.'**
  String get accountSetupOAuthDeniedGmail;

  /// No description provided for @accountSetupOAuthDenied.
  ///
  /// In en, this message translates to:
  /// **'Loupe needs permission to read and send your mail. Sign in again and accept the permissions.'**
  String get accountSetupOAuthDenied;

  /// No description provided for @accountSetupOAuthAdminApproval.
  ///
  /// In en, this message translates to:
  /// **'Your organisation must approve Loupe before you can use it with this account. Ask your IT administrator to grant admin consent for Loupe in Microsoft Entra ID, then try again.'**
  String get accountSetupOAuthAdminApproval;

  /// No description provided for @accountSetupOAuthBlocked.
  ///
  /// In en, this message translates to:
  /// **'Your organisation’s sign-in rules don’t allow Loupe on this device. Ask your IT administrator.'**
  String get accountSetupOAuthBlocked;

  /// No description provided for @accountSetupOAuthNetwork.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t reach {provider}. Check your internet connection and try again.'**
  String accountSetupOAuthNetwork(String provider);

  /// No description provided for @accountSetupOAuthMisconfigured.
  ///
  /// In en, this message translates to:
  /// **'Sign-in with {provider} isn’t set up correctly in this version of Loupe. Please report this.'**
  String accountSetupOAuthMisconfigured(String provider);

  /// No description provided for @accountSetupOAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign-in with {provider} didn’t work. Try again.'**
  String accountSetupOAuthFailed(String provider);

  /// No description provided for @accountSetupOAuthRefusedGmail.
  ///
  /// In en, this message translates to:
  /// **'{provider} signed you in, but Gmail refused access for this address. Choose the same account when signing in. Work or school accounts may have IMAP turned off by their administrator.'**
  String accountSetupOAuthRefusedGmail(String provider);

  /// No description provided for @accountSetupOAuthRefused.
  ///
  /// In en, this message translates to:
  /// **'{provider} signed you in, but the mail server refused access for this address. Choose the same account when signing in. Work or school accounts may have IMAP turned off by their administrator.'**
  String accountSetupOAuthRefused(String provider);

  /// No description provided for @accountSetupOAuthServerUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach the mail server. Check your connection and try again.'**
  String get accountSetupOAuthServerUnreachable;

  /// No description provided for @accountSetupSignInUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Sign-in with {provider} isn’t available in this version.'**
  String accountSetupSignInUnavailable(String provider);

  /// account is the account's name in Loupe.
  ///
  /// In en, this message translates to:
  /// **'Signed in again. {account} is syncing.'**
  String accountSetupSignedInAgain(String account);

  /// Button: sign in with the provider again, after it stopped accepting Loupe's sign-in.
  ///
  /// In en, this message translates to:
  /// **'Sign In Again'**
  String get accountSetupSignInAgain;

  /// On the Sign In Again button while the browser is open.
  ///
  /// In en, this message translates to:
  /// **'Signing In…'**
  String get accountSetupSigningIn;

  /// account is the account's name in Loupe.
  ///
  /// In en, this message translates to:
  /// **'{provider} no longer accepts Loupe’s sign-in for {email}, so {account} isn’t syncing. Sign in again to get its mail.'**
  String accountSetupSignInExpired(String provider, String email, String account);

  /// Title of the screen that adds accounts from Thunderbird desktop's QR codes.
  ///
  /// In en, this message translates to:
  /// **'Import from Thunderbird'**
  String get accountImportTitle;

  /// No description provided for @accountImportPointCamera.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at the QR code Thunderbird shows.'**
  String get accountImportPointCamera;

  /// How many of the export's QR codes were scanned.
  ///
  /// In en, this message translates to:
  /// **'Scanned {scanned} of {total}'**
  String accountImportProgress(int scanned, int total);

  /// Screen reader label of the dots that show the scanned codes.
  ///
  /// In en, this message translates to:
  /// **'{total, plural, other{Scanned {scanned} of {total} codes}}'**
  String accountImportProgressLabel(int scanned, int total);

  /// Accounts in the codes scanned so far.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 account so far} other{{count} accounts so far}}'**
  String accountImportAccountsSoFar(int count);

  /// Tools › Export for Mobile is Thunderbird's menu item: use its name in Thunderbird in your language.
  ///
  /// In en, this message translates to:
  /// **'On your computer, open Thunderbird and choose Tools › Export for Mobile. Select your accounts, then scan each code it shows. Codes can be scanned in any order.'**
  String get accountImportInstructions;

  /// Button: go on with the accounts scanned so far, before every code is scanned.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Continue with 1 Account} other{Continue with {count} Accounts}}'**
  String accountImportContinueWith(int count);

  /// Button: paste a code's text instead of scanning it.
  ///
  /// In en, this message translates to:
  /// **'Paste Text Instead'**
  String get accountImportPasteInstead;

  /// Button: forget the codes scanned so far.
  ///
  /// In en, this message translates to:
  /// **'Start Over'**
  String get accountImportStartOver;

  /// No description provided for @accountImportDuplicateCode.
  ///
  /// In en, this message translates to:
  /// **'That code was already added.'**
  String get accountImportDuplicateCode;

  /// No description provided for @accountImportRestarted.
  ///
  /// In en, this message translates to:
  /// **'This code is from a new export, so the codes scanned before were set aside.'**
  String get accountImportRestarted;

  /// No description provided for @accountImportNotThunderbird.
  ///
  /// In en, this message translates to:
  /// **'This isn\'t a Thunderbird account code.'**
  String get accountImportNotThunderbird;

  /// No description provided for @accountImportNewerVersion.
  ///
  /// In en, this message translates to:
  /// **'This code comes from a newer Thunderbird. Update Loupe to import it.'**
  String get accountImportNewerVersion;

  /// No description provided for @accountImportDamaged.
  ///
  /// In en, this message translates to:
  /// **'This Thunderbird code couldn\'t be read.'**
  String get accountImportDamaged;

  /// No description provided for @accountImportTooLarge.
  ///
  /// In en, this message translates to:
  /// **'This code is too large to be a Thunderbird export.'**
  String get accountImportTooLarge;

  /// The system settings (to allow the camera) couldn't be opened.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t open Settings.'**
  String get accountImportCouldNotOpenSettings;

  /// No description provided for @accountImportCameraOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera Access Is Off'**
  String get accountImportCameraOffTitle;

  /// No description provided for @accountImportCameraOffText.
  ///
  /// In en, this message translates to:
  /// **'Allow Loupe to use the camera in Settings to scan the code, or paste the code’s text instead.'**
  String get accountImportCameraOffText;

  /// No description provided for @accountImportNoCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'No Camera'**
  String get accountImportNoCameraTitle;

  /// No description provided for @accountImportNoCameraText.
  ///
  /// In en, this message translates to:
  /// **'Loupe can’t use a camera here. Paste the code’s text instead.'**
  String get accountImportNoCameraText;

  /// No description provided for @accountImportCameraFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'The Camera Didn’t Start'**
  String get accountImportCameraFailedTitle;

  /// No description provided for @accountImportCameraFailedText.
  ///
  /// In en, this message translates to:
  /// **'Try again, or paste the code’s text instead.'**
  String get accountImportCameraFailedText;

  /// Button: open the system settings to allow the camera.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get accountImportOpenSettings;

  /// Heading of the list of accounts read from the codes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No Accounts Found} =1{Found 1 Account} other{Found {count} Accounts}}'**
  String accountImportFound(int count);

  /// No description provided for @accountImportNoneReadable.
  ///
  /// In en, this message translates to:
  /// **'None of the accounts in these codes could be read.'**
  String get accountImportNoneReadable;

  /// No description provided for @accountImportChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose the accounts to add to Loupe.'**
  String get accountImportChoose;

  /// count is how many codes weren't scanned; codes are their numbers (accountImportCodeList for more than one).
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Code {codes} of {total} wasn’t scanned, so its accounts aren’t listed.} other{Codes {codes} of {total} weren’t scanned, so their accounts aren’t listed.}}'**
  String accountImportMissingCodes(int count, String codes, int total);

  /// The numbers of the codes not scanned, in accountImportMissingCodes. codes is a list of numbers with commas.
  ///
  /// In en, this message translates to:
  /// **'{codes} and {last}'**
  String accountImportCodeList(String codes, String last);

  /// No description provided for @accountImportScanMore.
  ///
  /// In en, this message translates to:
  /// **'Scan More Codes'**
  String get accountImportScanMore;

  /// No description provided for @accountImportSkipped.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 account in the codes couldn’t be read. They may use settings from a newer Thunderbird.} other{{count} accounts in the codes couldn’t be read. They may use settings from a newer Thunderbird.}}'**
  String accountImportSkipped(int count);

  /// No description provided for @accountImportScanAgain.
  ///
  /// In en, this message translates to:
  /// **'Scan Again'**
  String get accountImportScanAgain;

  /// No description provided for @accountImportAlreadyAdded.
  ///
  /// In en, this message translates to:
  /// **'An account with this address is already in Loupe.'**
  String get accountImportAlreadyAdded;

  /// No description provided for @accountImportSignsInWith.
  ///
  /// In en, this message translates to:
  /// **'You’ll sign in with {provider} when it’s added, as in Thunderbird.'**
  String accountImportSignsInWith(String provider);

  /// No description provided for @accountImportGmailAppPassword.
  ///
  /// In en, this message translates to:
  /// **'Add the account with an app password (it needs 2-Step Verification).'**
  String get accountImportGmailAppPassword;

  /// The quoted words are the button's (accountSetupSignInWith).
  ///
  /// In en, this message translates to:
  /// **'Thunderbird signs in to Gmail with Google. “Sign in with Google” arrives in a later build; until then, add the account with an app password (it needs 2-Step Verification).'**
  String get accountImportGmailNoSignIn;

  /// No description provided for @accountImportBrowserSignIn.
  ///
  /// In en, this message translates to:
  /// **'Thunderbird signs in to this account in the browser. Loupe can’t do that yet: use an app password if your provider offers one.'**
  String get accountImportBrowserSignIn;

  /// No description provided for @accountImportUnencrypted.
  ///
  /// In en, this message translates to:
  /// **'Connects without encryption. Use this only on your own network.'**
  String get accountImportUnencrypted;

  /// Placeholder of the password field when the server refused the password that came with the code.
  ///
  /// In en, this message translates to:
  /// **'Enter it again'**
  String get accountImportEnterAgain;

  /// Beside an account once it is added.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get accountImportAdded;

  /// On the button while the chosen accounts are added one by one.
  ///
  /// In en, this message translates to:
  /// **'Adding {index} of {total}…'**
  String accountImportAdding(int index, int total);

  /// Button: add the chosen accounts. With none chosen it is greyed out.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Add Accounts} =1{Add 1 Account} other{Add {count} Accounts}}'**
  String accountImportAddAccounts(int count);

  /// No description provided for @accountImportPasteTitle.
  ///
  /// In en, this message translates to:
  /// **'Paste Export Text'**
  String get accountImportPasteTitle;

  /// No description provided for @accountImportPasteText.
  ///
  /// In en, this message translates to:
  /// **'Paste the text of a Thunderbird export code, one code per line.'**
  String get accountImportPasteText;

  /// No description provided for @accountImportPop3.
  ///
  /// In en, this message translates to:
  /// **'POP3 accounts aren’t supported. Loupe keeps mail on the server with IMAP.'**
  String get accountImportPop3;

  /// No description provided for @accountImportKerberos.
  ///
  /// In en, this message translates to:
  /// **'This account signs in with Kerberos, which Loupe doesn’t support.'**
  String get accountImportKerberos;

  /// No description provided for @accountImportNtlm.
  ///
  /// In en, this message translates to:
  /// **'This account signs in with NTLM, which Loupe doesn’t support.'**
  String get accountImportNtlm;

  /// No description provided for @accountImportClientCertificate.
  ///
  /// In en, this message translates to:
  /// **'This account signs in with a client certificate, which Loupe doesn’t support yet.'**
  String get accountImportClientCertificate;

  /// No description provided for @accountImportMicrosoftSignIn.
  ///
  /// In en, this message translates to:
  /// **'Microsoft sign-in arrives in a later build. Outlook and Microsoft 365 accounts no longer accept passwords from mail apps.'**
  String get accountImportMicrosoftSignIn;

  /// No description provided for @accountImportEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the password.'**
  String get accountImportEnterPassword;

  /// No description provided for @accountImportEnterAppPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the app password.'**
  String get accountImportEnterAppPassword;

  /// No description provided for @accountImportEnterApiToken.
  ///
  /// In en, this message translates to:
  /// **'Enter the API token.'**
  String get accountImportEnterApiToken;

  /// No description provided for @accountImportStorageFailed.
  ///
  /// In en, this message translates to:
  /// **'Loupe couldn’t open its account storage. Try again later.'**
  String get accountImportStorageFailed;

  /// No description provided for @accountImportFailed.
  ///
  /// In en, this message translates to:
  /// **'The account couldn’t be added. Try again, or add it manually.'**
  String get accountImportFailed;

  /// Title of the compose screen while the subject is empty.
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get composeNewMessageTitle;

  /// Tooltip of the paper clip button: attach a file.
  ///
  /// In en, this message translates to:
  /// **'Attach'**
  String get composeAttach;

  /// The clock button beside Send, and the title of its sheet: send at a chosen time.
  ///
  /// In en, this message translates to:
  /// **'Send Later'**
  String get composeSendLater;

  /// Screen reader label of the Send button when a Send Later time is set.
  ///
  /// In en, this message translates to:
  /// **'Send {time}'**
  String composeSendAt(String time);

  /// Screen reader hint of the Send button.
  ///
  /// In en, this message translates to:
  /// **'Long-press to send later'**
  String get composeSendHint;

  /// No description provided for @composeNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Add an account to send mail.'**
  String get composeNoAccount;

  /// Label of the recipients field.
  ///
  /// In en, this message translates to:
  /// **'To:'**
  String get composeTo;

  /// Label of the copy recipients field.
  ///
  /// In en, this message translates to:
  /// **'Cc:'**
  String get composeCc;

  /// Label of the blind copy recipients field.
  ///
  /// In en, this message translates to:
  /// **'Bcc:'**
  String get composeBcc;

  /// Collapsed row under the recipients: tap to show the Cc, Bcc and From fields.
  ///
  /// In en, this message translates to:
  /// **'Cc/Bcc, From: {email}'**
  String composeCcBccFrom(String email);

  /// Label before the sender's name and address.
  ///
  /// In en, this message translates to:
  /// **'From:'**
  String get composeFromLabel;

  /// Label before the subject field.
  ///
  /// In en, this message translates to:
  /// **'Subject:'**
  String get composeSubjectLabel;

  /// The identity's Reply-To address. Reply-To is a header's name: write it as mail apps in your language do.
  ///
  /// In en, this message translates to:
  /// **'Reply-To: {address}'**
  String composeReplyTo(String address);

  /// Heading of the sheet that picks the sender.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get composeFrom;

  /// In the sender picker: reply from an address of the user's that isn't saved as an identity.
  ///
  /// In en, this message translates to:
  /// **'Reply from {email}'**
  String composeReplyFrom(String email);

  /// In the sender picker: send from an address of the user's that isn't saved as an identity.
  ///
  /// In en, this message translates to:
  /// **'Send from {email}'**
  String composeSendFrom(String email);

  /// Under the compose header: suggests replying from the address the original was sent to.
  ///
  /// In en, this message translates to:
  /// **'Reply from {email}?'**
  String composeReplyFromSuggestion(String email);

  /// Under the compose header: suggests sending from the address the original was sent to.
  ///
  /// In en, this message translates to:
  /// **'Send from {email}?'**
  String composeSendFromSuggestion(String email);

  /// Screen reader label of the button that hides the suggested sender.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get composeDismiss;

  /// account is the account's name in Loupe.
  ///
  /// In en, this message translates to:
  /// **'Not saved as an identity · {account}'**
  String composeAliasNotSaved(String account);

  /// No description provided for @composeSaveAsIdentity.
  ///
  /// In en, this message translates to:
  /// **'Save as Identity'**
  String get composeSaveAsIdentity;

  /// No description provided for @composeAliasSaved.
  ///
  /// In en, this message translates to:
  /// **'{email} is saved as an identity.'**
  String composeAliasSaved(String email);

  /// Screen reader label of a recipient that isn't a valid address.
  ///
  /// In en, this message translates to:
  /// **'Invalid address {address}'**
  String composeInvalidAddressLabel(String address);

  /// No description provided for @composeOriginalNotFound.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find the original message.'**
  String get composeOriginalNotFound;

  /// No description provided for @composeDraftNotFound.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find the draft.'**
  String get composeDraftNotFound;

  /// No description provided for @composeAttachmentsLost.
  ///
  /// In en, this message translates to:
  /// **'The attachments couldn’t be recovered. Add them again.'**
  String get composeAttachmentsLost;

  /// error is the server's or the app's message, often in English.
  ///
  /// In en, this message translates to:
  /// **'Some attachments couldn\'t be added: {error}'**
  String composeSomeAttachmentsFailed(String error);

  /// No description provided for @composeAttachmentsLarge.
  ///
  /// In en, this message translates to:
  /// **'Attachments total {size}; some servers refuse messages this large.'**
  String composeAttachmentsLarge(String size);

  /// No description provided for @composeAttachFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t attach the file.'**
  String get composeAttachFailed;

  /// No description provided for @composeInvalidAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid Address'**
  String get composeInvalidAddressTitle;

  /// No description provided for @composeInvalidAddress.
  ///
  /// In en, this message translates to:
  /// **'“{address}” isn\'t a valid email address.'**
  String composeInvalidAddress(String address);

  /// Title of the question before sending a message without a subject.
  ///
  /// In en, this message translates to:
  /// **'No Subject'**
  String get composeNoSubjectTitle;

  /// No description provided for @composeNoSubjectText.
  ///
  /// In en, this message translates to:
  /// **'This message has no subject. Send it anyway?'**
  String get composeNoSubjectText;

  /// No description provided for @composeSentBeforeChanges.
  ///
  /// In en, this message translates to:
  /// **'It was sent before your changes, which are saved in Drafts.'**
  String get composeSentBeforeChanges;

  /// Snack bar after scheduling a message.
  ///
  /// In en, this message translates to:
  /// **'Scheduled for {time}'**
  String composeScheduled(String time);

  /// Snack bar while a message waits out its undo time.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get composeSending;

  /// Snack bar after a message was sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get composeSent;

  /// No description provided for @composeSendFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t send. Try again.'**
  String get composeSendFailed;

  /// Snack bar when Undo comes too late.
  ///
  /// In en, this message translates to:
  /// **'Already sent.'**
  String get composeAlreadySent;

  /// Closing a message from the Outbox: forget the edits.
  ///
  /// In en, this message translates to:
  /// **'Discard Changes'**
  String get composeDiscardChanges;

  /// Closing a message from the Outbox: put it back with the edits.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get composeSaveChanges;

  /// No description provided for @composeDeleteDraft.
  ///
  /// In en, this message translates to:
  /// **'Delete Draft'**
  String get composeDeleteDraft;

  /// No description provided for @composeSaveDraft.
  ///
  /// In en, this message translates to:
  /// **'Save Draft'**
  String get composeSaveDraft;

  /// No description provided for @composeDraftSaved.
  ///
  /// In en, this message translates to:
  /// **'Draft saved'**
  String get composeDraftSaved;

  /// Line above the quoted original in a reply; it goes out with the message.
  ///
  /// In en, this message translates to:
  /// **'On {date} at {time}, {name} wrote:'**
  String composeAttribution(String date, String time, String name);

  /// Line above the quoted original in a reply, when the sender is unknown.
  ///
  /// In en, this message translates to:
  /// **'On {date} at {time}, someone wrote:'**
  String composeAttributionUnknown(String date, String time);

  /// First line of the forwarded original in a message. Keep the ten hyphens and the space on each side: Loupe finds the forwarded original by them.
  ///
  /// In en, this message translates to:
  /// **'---------- Forwarded message ----------'**
  String get composeForwardHeader;

  /// In a forwarded message: the original's sender.
  ///
  /// In en, this message translates to:
  /// **'From: {addresses}'**
  String composeForwardFrom(String addresses);

  /// In a forwarded message: when the original was sent.
  ///
  /// In en, this message translates to:
  /// **'Date: {date} at {time}'**
  String composeForwardDate(String date, String time);

  /// In a forwarded message: the original's subject.
  ///
  /// In en, this message translates to:
  /// **'Subject: {subject}'**
  String composeForwardSubject(String subject);

  /// In a forwarded message: the original's recipients.
  ///
  /// In en, this message translates to:
  /// **'To: {addresses}'**
  String composeForwardTo(String addresses);

  /// In a forwarded message: the original's copy recipients.
  ///
  /// In en, this message translates to:
  /// **'Cc: {addresses}'**
  String composeForwardCc(String addresses);

  /// Send Later choice: today at 18:00.
  ///
  /// In en, this message translates to:
  /// **'Later Today'**
  String get composeLaterToday;

  /// Send Later choice: tomorrow at 08:00.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow Morning'**
  String get composeTomorrowMorning;

  /// Send Later choice: next Monday at 08:00.
  ///
  /// In en, this message translates to:
  /// **'Monday Morning'**
  String get composeMondayMorning;

  /// No description provided for @composePickDateTime.
  ///
  /// In en, this message translates to:
  /// **'Pick Date & Time…'**
  String get composePickDateTime;

  /// In the Send Later sheet: drop the chosen time and send right away.
  ///
  /// In en, this message translates to:
  /// **'Send Without Delay'**
  String get composeSendWithoutDelay;

  /// When a waiting message goes out.
  ///
  /// In en, this message translates to:
  /// **'Today at {time}'**
  String composeSendTimeToday(String time);

  /// When a waiting message goes out.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow at {time}'**
  String composeSendTimeTomorrow(String time);

  /// When a waiting message goes out: day is a weekday in the coming week, or a date.
  ///
  /// In en, this message translates to:
  /// **'{day} at {time}'**
  String composeSendTimeDay(String day, String time);

  /// When a waiting message goes out, short (on the Send button).
  ///
  /// In en, this message translates to:
  /// **'Today {time}'**
  String composeSendTimeTodayShort(String time);

  /// When a waiting message goes out, short (on the Send button).
  ///
  /// In en, this message translates to:
  /// **'Tomorrow {time}'**
  String composeSendTimeTomorrowShort(String time);

  /// When a waiting message goes out, short (on the Send button): day is a short weekday or date.
  ///
  /// In en, this message translates to:
  /// **'{day} {time}'**
  String composeSendTimeDayShort(String day, String time);

  /// Asked at launch when a message was left unsent when Loupe closed.
  ///
  /// In en, this message translates to:
  /// **'Continue editing your draft?'**
  String get composeRecoveryTitle;

  /// A message without a subject. recipients is none, one or other (several); name is the first recipient's.
  ///
  /// In en, this message translates to:
  /// **'{recipients, select, none{A message wasn’t sent when Loupe closed.} one{A message to {name} wasn’t sent when Loupe closed.} other{A message to {name} and others wasn’t sent when Loupe closed.}}'**
  String composeRecoveryUntitled(String recipients, String name);

  /// recipients is none, one or other (several); name is the first recipient's.
  ///
  /// In en, this message translates to:
  /// **'{recipients, select, none{“{subject}” wasn’t sent when Loupe closed.} one{“{subject}” to {name} wasn’t sent when Loupe closed.} other{“{subject}” to {name} and others wasn’t sent when Loupe closed.}}'**
  String composeRecoveryWithSubject(String recipients, String subject, String name);

  /// No description provided for @composeRecoveryContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue Editing'**
  String get composeRecoveryContinue;

  /// No description provided for @composeRecoverySave.
  ///
  /// In en, this message translates to:
  /// **'Save to Drafts'**
  String get composeRecoverySave;

  /// Delete the message left unsent.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get composeRecoveryDiscard;

  /// No description provided for @composeRecoverySaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to Drafts'**
  String get composeRecoverySaved;

  /// Outbox section heading (shown in capitals): messages that failed.
  ///
  /// In en, this message translates to:
  /// **'Not Sent'**
  String get outboxSectionFailed;

  /// Outbox section heading (shown in capitals): messages about to go.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get outboxSectionSending;

  /// Outbox section heading (shown in capitals): messages sent later.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get outboxSectionScheduled;

  /// Beside a message waiting out its undo time.
  ///
  /// In en, this message translates to:
  /// **'Sending soon'**
  String get outboxStatusQueued;

  /// Beside a message being sent.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get outboxStatusSending;

  /// Beside a message that failed.
  ///
  /// In en, this message translates to:
  /// **'Not sent'**
  String get outboxStatusFailed;

  /// No description provided for @outboxNoRecipients.
  ///
  /// In en, this message translates to:
  /// **'No Recipients'**
  String get outboxNoRecipients;

  /// No description provided for @outboxNoSubject.
  ///
  /// In en, this message translates to:
  /// **'(No Subject)'**
  String get outboxNoSubject;

  /// Under a failed message when the server gave no reason.
  ///
  /// In en, this message translates to:
  /// **'Sending failed.'**
  String get outboxSendingFailed;

  /// No description provided for @outboxEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing to Send'**
  String get outboxEmptyTitle;

  /// No description provided for @outboxEmptyText.
  ///
  /// In en, this message translates to:
  /// **'Messages you send later wait here until it’s time.'**
  String get outboxEmptyText;

  /// No description provided for @outboxSendNow.
  ///
  /// In en, this message translates to:
  /// **'Send Now'**
  String get outboxSendNow;

  /// Swipe action: pick a new send time.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get outboxReschedule;

  /// Menu item: pick a new send time.
  ///
  /// In en, this message translates to:
  /// **'Reschedule…'**
  String get outboxRescheduleMenu;

  /// Title of the sheet that picks a new send time.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get outboxRescheduleTitle;

  /// No description provided for @outboxRescheduled.
  ///
  /// In en, this message translates to:
  /// **'Rescheduled for {time}'**
  String outboxRescheduled(String time);

  /// Swipe action: stop sending the message.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get outboxCancel;

  /// Menu item: stop sending the message.
  ///
  /// In en, this message translates to:
  /// **'Cancel Sending…'**
  String get outboxCancelSending;

  /// No description provided for @outboxCancelTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel Sending?'**
  String get outboxCancelTitle;

  /// No description provided for @outboxMoveToDrafts.
  ///
  /// In en, this message translates to:
  /// **'Move to Drafts'**
  String get outboxMoveToDrafts;

  /// No description provided for @outboxDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard Message'**
  String get outboxDiscard;

  /// No description provided for @outboxMovedToDrafts.
  ///
  /// In en, this message translates to:
  /// **'Moved to Drafts'**
  String get outboxMovedToDrafts;

  /// No description provided for @outboxDiscarded.
  ///
  /// In en, this message translates to:
  /// **'Message discarded'**
  String get outboxDiscarded;

  /// The message went out before it could be taken out of the Outbox.
  ///
  /// In en, this message translates to:
  /// **'Already sent.'**
  String get outboxAlreadySent;

  /// No description provided for @outboxBeingSent.
  ///
  /// In en, this message translates to:
  /// **'This message is being sent.'**
  String get outboxBeingSent;

  /// No description provided for @outboxActionFailed.
  ///
  /// In en, this message translates to:
  /// **'That didn’t work. The message is still in the Outbox.'**
  String get outboxActionFailed;

  /// App icon badge choice: the number of unread messages in the inboxes.
  ///
  /// In en, this message translates to:
  /// **'Unread in Inboxes'**
  String get notificationsBadgeInboxes;

  /// App icon badge choice: the number of unread messages from VIPs.
  ///
  /// In en, this message translates to:
  /// **'Unread in VIP'**
  String get notificationsBadgeVip;

  /// Name of the notification channel for mail from VIPs, in the system's notification settings.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get notificationsVipChannel;

  /// Description of the VIP notification channel, in the system's notification settings.
  ///
  /// In en, this message translates to:
  /// **'New mail from your VIPs, in any account'**
  String get notificationsVipChannelDescription;

  /// Description of an account's notification channel, in the system's notification settings.
  ///
  /// In en, this message translates to:
  /// **'New mail in {email}'**
  String notificationsAccountChannelDescription(String email);

  /// No description provided for @notificationsUnknownSender.
  ///
  /// In en, this message translates to:
  /// **'Unknown Sender'**
  String get notificationsUnknownSender;

  /// No description provided for @notificationsNoSubject.
  ///
  /// In en, this message translates to:
  /// **'(No Subject)'**
  String get notificationsNoSubject;

  /// In a new-mail notification, in place of an encrypted message's subject.
  ///
  /// In en, this message translates to:
  /// **'Encrypted message'**
  String get notificationsEncryptedMessage;

  /// A new-mail notification with Hide Content on: only the account's name in Loupe.
  ///
  /// In en, this message translates to:
  /// **'New message from {account}'**
  String notificationsHiddenMessage(String account);

  /// Title of an account's notification summary.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 new message} other{{count} new messages}}'**
  String notificationsNewMessages(int count);

  /// An account's notification summary with Hide Content on.
  ///
  /// In en, this message translates to:
  /// **'New messages in {account}'**
  String notificationsHiddenSummary(String account);

  /// Name of the notification channel of Instant Delivery (new mail in seconds), in the system's notification settings.
  ///
  /// In en, this message translates to:
  /// **'Instant Delivery'**
  String get platformInstantChannel;

  /// Description of the Instant Delivery notification channel.
  ///
  /// In en, this message translates to:
  /// **'Shows while Loupe watches your inboxes for new mail'**
  String get platformInstantChannelDescription;

  /// Title of the quiet notification that shows while Instant Delivery runs.
  ///
  /// In en, this message translates to:
  /// **'Watching for new mail'**
  String get platformInstantTitle;

  /// Text of the quiet notification that shows while Instant Delivery runs.
  ///
  /// In en, this message translates to:
  /// **'Instant Delivery is on'**
  String get platformInstantText;

  /// In place of a part of a screen that failed to show.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong showing this. Go back and try again.'**
  String get platformErrorBox;

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
