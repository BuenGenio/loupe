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

  /// Button on the lock screen that shows the phone’s fingerprint, face or screen-lock prompt.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get appLockUnlock;

  /// Under the lock screen’s Unlock button, after the phone’s fingerprint, face or PIN check failed.
  ///
  /// In en, this message translates to:
  /// **'Loupe couldn’t confirm it’s you.'**
  String get appLockFailed;

  /// The phone blocks fingerprint, face or PIN checks for a while after too many failed tries.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again later.'**
  String get appLockLockedOut;

  /// The phone’s own fingerprint, face or PIN prompt failed to appear.
  ///
  /// In en, this message translates to:
  /// **'The prompt couldn’t be shown. Try again.'**
  String get appLockPromptError;

  /// Why App Lock can’t check who is holding the phone: no PIN, pattern or password is set up in the system settings.
  ///
  /// In en, this message translates to:
  /// **'This phone has no screen lock.'**
  String get appLockNoScreenLock;

  /// Title of the system’s fingerprint, face or PIN prompt when Loupe is locked.
  ///
  /// In en, this message translates to:
  /// **'Unlock Loupe'**
  String get appLockUnlockPromptTitle;

  /// Under appLockUnlockPromptTitle in the system’s prompt.
  ///
  /// In en, this message translates to:
  /// **'Confirm it’s you to see your mail.'**
  String get appLockUnlockPromptReason;

  /// Title of the system’s fingerprint, face or PIN prompt when the user turns App Lock on. “App Lock” is the name of the setting in Settings › Security: use the same words.
  ///
  /// In en, this message translates to:
  /// **'Turn On App Lock'**
  String get appLockTurnOnPromptTitle;

  /// Under appLockTurnOnPromptTitle in the system’s prompt.
  ///
  /// In en, this message translates to:
  /// **'Confirm it’s you to turn on App Lock.'**
  String get appLockTurnOnPromptReason;

  /// Snack bar: the phone’s PIN, pattern or password was removed, so App Lock turned itself off.
  ///
  /// In en, this message translates to:
  /// **'App Lock is off: this phone has no screen lock any more. Set one up to turn App Lock on again.'**
  String get appLockScreenLockRemoved;

  /// Lock After choice: Loupe locks as soon as it leaves the screen. Title Case, like the other choices.
  ///
  /// In en, this message translates to:
  /// **'Immediately'**
  String get appLockAfterImmediately;

  /// Lock After choice: how long Loupe can be in the background before it asks again. Title Case.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Minute} other{{count} Minutes}}'**
  String appLockAfterMinutes(int count);

  /// Lock After choice, as appLockAfterMinutes. Title Case.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Hour} other{{count} Hours}}'**
  String appLockAfterHours(int count);

  /// Message header: the message was encrypted with OpenPGP (only its recipients can read it) and decrypted on this device.
  ///
  /// In en, this message translates to:
  /// **'Encrypted'**
  String get openpgpEncrypted;

  /// Message header: only part of the message was encrypted.
  ///
  /// In en, this message translates to:
  /// **'Encrypted in part'**
  String get openpgpEncryptedInPart;

  /// Message header: encrypted, and the user’s key (their OpenPGP key) is locked: its passphrase, a password that protects the key, is needed.
  ///
  /// In en, this message translates to:
  /// **'Encrypted · locked'**
  String get openpgpEncryptedLocked;

  /// Message header: encrypted to an OpenPGP key that isn’t on this device, so it can’t be read.
  ///
  /// In en, this message translates to:
  /// **'Encrypted · no key'**
  String get openpgpEncryptedNoKey;

  /// Message header: the encrypted data is damaged.
  ///
  /// In en, this message translates to:
  /// **'Encrypted · damaged'**
  String get openpgpEncryptedDamaged;

  /// Message header: encrypted with an algorithm Loupe can’t decrypt.
  ///
  /// In en, this message translates to:
  /// **'Encrypted · unsupported'**
  String get openpgpEncryptedUnsupported;

  /// Stands in for the signer’s name in “Signed by {name}” when their key has no name. Lower case.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get openpgpUnknownSigner;

  /// Message header: the message has a digital signature (proof of who sent it), but by a key the user doesn’t have, so it can’t be checked.
  ///
  /// In en, this message translates to:
  /// **'Unknown key'**
  String get openpgpUnknownKey;

  /// Message header: the digital signature doesn’t match the message, which may have been changed.
  ///
  /// In en, this message translates to:
  /// **'Signature invalid'**
  String get openpgpSignatureInvalid;

  /// Message header: a valid signature, but by a key that belongs to someone other than the sender.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name}, not the sender'**
  String openpgpSignedByNotSender(String name);

  /// Message header: only part of the message is covered by the signature.
  ///
  /// In en, this message translates to:
  /// **'Signed in part by {name}'**
  String openpgpSignedInPartBy(String name);

  /// Message header: a valid digital signature by the named person’s key.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name}'**
  String openpgpSignedBy(String name);

  /// Message header: signed with a key the user marked as not belonging to its owner (see openpgpRejectKey).
  ///
  /// In en, this message translates to:
  /// **'Signed with a rejected key'**
  String get openpgpSignedWithRejectedKey;

  /// Message header: a valid signature, but the user hasn’t yet accepted (trusted) the signer’s key as really theirs.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name} · key not accepted'**
  String openpgpSignedByNotAccepted(String name);

  /// Button: unlock the user’s OpenPGP key by typing its passphrase (in the message header, and in the passphrase dialog).
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get openpgpUnlock;

  /// Title of the message’s encryption details.
  ///
  /// In en, this message translates to:
  /// **'Can’t decrypt this message'**
  String get openpgpCantDecrypt;

  /// Title of the message’s encryption details. Keep “OpenPGP”: it is the standard’s name.
  ///
  /// In en, this message translates to:
  /// **'Encrypted with OpenPGP'**
  String get openpgpEncryptedWithOpenPgp;

  /// Section header in the message’s encryption details.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get openpgpEncryption;

  /// Row in the message’s encryption details.
  ///
  /// In en, this message translates to:
  /// **'Decrypted on this device'**
  String get openpgpDecryptedHere;

  /// Row in the message’s encryption details.
  ///
  /// In en, this message translates to:
  /// **'Not decrypted'**
  String get openpgpNotDecrypted;

  /// Row in the message’s encryption details: the user’s OpenPGP key needs its passphrase before it can decrypt.
  ///
  /// In en, this message translates to:
  /// **'Your key is locked.'**
  String get openpgpKeyLocked;

  /// Under openpgpDecryptedHere: the keys the message was encrypted to, by their IDs (groups of hex digits).
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{For key {keys}} other{For keys {keys}}}'**
  String openpgpForKeys(int count, String keys);

  /// Row label: the real subject, encrypted inside the message (the visible one is “...”).
  ///
  /// In en, this message translates to:
  /// **'Protected subject'**
  String get openpgpProtectedSubject;

  /// Action in the message’s encryption details: type the key’s passphrase.
  ///
  /// In en, this message translates to:
  /// **'Unlock Key'**
  String get openpgpUnlockKey;

  /// Section header in the message details about its digital signature (proof of who sent it).
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get openpgpSignature;

  /// Row label: a key’s fingerprint, its unique ID shown as groups of hex digits that people compare to check a key.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint'**
  String get openpgpFingerprint;

  /// Instead of a fingerprint when the key isn’t known: its short ID.
  ///
  /// In en, this message translates to:
  /// **'Key id {id}'**
  String openpgpKeyIdValue(String id);

  /// Row label; the value is the date and time the message was signed.
  ///
  /// In en, this message translates to:
  /// **'Signed'**
  String get openpgpSigned;

  /// Row label; the value says what is wrong with the signature.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get openpgpProblem;

  /// Row label: whether the user accepted a correspondent’s key, i.e. trusts that it really belongs to them (Thunderbird’s word).
  ///
  /// In en, this message translates to:
  /// **'Acceptance'**
  String get openpgpAcceptance;

  /// Action: choose whether to accept the signer’s key.
  ///
  /// In en, this message translates to:
  /// **'Change Acceptance…'**
  String get openpgpChangeAcceptance;

  /// Footnote of the message’s encryption and signature details.
  ///
  /// In en, this message translates to:
  /// **'Checked on this device with OpenPGP, compatible with Thunderbird.'**
  String get openpgpCheckedFooter;

  /// Message details, under the title. A passphrase is the password that protects the user’s OpenPGP key.
  ///
  /// In en, this message translates to:
  /// **'Your key is locked. Unlock it with its passphrase to read this message.'**
  String get openpgpSummaryLocked;

  /// Message details: the message was encrypted for a key (the user’s secret key) that isn’t on this phone.
  ///
  /// In en, this message translates to:
  /// **'It was encrypted to a key that isn’t on this device.'**
  String get openpgpSummaryNoSecretKey;

  /// Message details.
  ///
  /// In en, this message translates to:
  /// **'The encrypted data is damaged or was changed on the way.'**
  String get openpgpSummaryDamaged;

  /// Message details.
  ///
  /// In en, this message translates to:
  /// **'It uses an algorithm Loupe doesn’t support.'**
  String get openpgpSummaryUnsupported;

  /// Message details: first sentence for an encrypted message; a sentence about its signature follows.
  ///
  /// In en, this message translates to:
  /// **'Only you and the other recipients can read it.'**
  String get openpgpSummaryEncrypted;

  /// Message details: there is no digital signature proving who sent it.
  ///
  /// In en, this message translates to:
  /// **'It isn’t signed, so the sender isn’t confirmed.'**
  String get openpgpSummaryNotSigned;

  /// Message details.
  ///
  /// In en, this message translates to:
  /// **'It is signed, but with a key you don’t have, so the signature can’t be checked.'**
  String get openpgpSummaryUnknownKey;

  /// Message details.
  ///
  /// In en, this message translates to:
  /// **'The signature doesn’t match: the message may have been changed.'**
  String get openpgpSummaryBadSignature;

  /// Message details.
  ///
  /// In en, this message translates to:
  /// **'The signature is valid, but the key belongs to another address than the sender’s.'**
  String get openpgpSummaryMismatch;

  /// Message details. “Unsigned content” quotes the separator line shown in the message’s text, which is not translated yet: keep it in English.
  ///
  /// In en, this message translates to:
  /// **'Only part of the message is signed. Text outside the signature (a mailing list footer, for example) is shown below the “Unsigned content” line, and other parts of the message, such as attachments, aren’t covered either.'**
  String get openpgpSummaryPartial;

  /// Message details.
  ///
  /// In en, this message translates to:
  /// **'Signed with your own key.'**
  String get openpgpSummaryOwnKey;

  /// Message details: the user compared the key’s fingerprint (its unique ID) with its owner.
  ///
  /// In en, this message translates to:
  /// **'The signature is valid, and you verified the key’s fingerprint.'**
  String get openpgpSummaryVerified;

  /// Message details.
  ///
  /// In en, this message translates to:
  /// **'The signature is valid. You accepted the key without checking its fingerprint.'**
  String get openpgpSummaryUnverified;

  /// Message details.
  ///
  /// In en, this message translates to:
  /// **'The signature is valid, but you rejected this key.'**
  String get openpgpSummaryRejected;

  /// Message details.
  ///
  /// In en, this message translates to:
  /// **'The signature is valid, but you haven’t accepted this key yet. Compare its fingerprint with the sender.'**
  String get openpgpSummaryUndecided;

  /// A correspondent’s key: the user said it doesn’t belong to its owner.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get openpgpAcceptanceRejected;

  /// A correspondent’s key: the user hasn’t decided yet whether to trust it.
  ///
  /// In en, this message translates to:
  /// **'Not accepted'**
  String get openpgpAcceptanceUndecided;

  /// A correspondent’s key: the user trusts it belongs to its owner, without having compared the fingerprint.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get openpgpAcceptanceUnverified;

  /// A correspondent’s key: accepted, and the user compared its fingerprint with the owner.
  ///
  /// In en, this message translates to:
  /// **'Accepted and verified'**
  String get openpgpAcceptanceVerified;

  /// Title of the choice whether to trust that a correspondent’s OpenPGP key really belongs to them.
  ///
  /// In en, this message translates to:
  /// **'Accept {name}’s key?'**
  String openpgpAcceptKeyTitle(String name);

  /// Under openpgpAcceptKeyTitle: the key’s fingerprint (its unique ID, groups of hex digits).
  ///
  /// In en, this message translates to:
  /// **'Fingerprint {fingerprint}'**
  String openpgpFingerprintValue(String fingerprint);

  /// Choice under openpgpAcceptKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Yes, I verified the fingerprint'**
  String get openpgpAcceptVerified;

  /// Choice under openpgpAcceptKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Yes, without checking'**
  String get openpgpAcceptUnverified;

  /// Choice under openpgpAcceptKeyTitle: decide later.
  ///
  /// In en, this message translates to:
  /// **'Not yet'**
  String get openpgpAcceptLater;

  /// Choice under openpgpAcceptKeyTitle: the key doesn’t belong to its owner.
  ///
  /// In en, this message translates to:
  /// **'Reject this key'**
  String get openpgpRejectKey;

  /// Shown as the conversation’s subject when the decrypted subject is empty.
  ///
  /// In en, this message translates to:
  /// **'(no subject)'**
  String get openpgpNoSubject;

  /// Title of the screen with the user’s OpenPGP keys and S/MIME certificates. Other texts name it as “Settings › End-to-End Encryption”.
  ///
  /// In en, this message translates to:
  /// **'End-to-End Encryption'**
  String get openpgpEncryptionTitle;

  /// Section header: the user’s own OpenPGP keys (each a key pair that decrypts and signs their mail). Keep “OpenPGP”.
  ///
  /// In en, this message translates to:
  /// **'My OpenPGP Keys'**
  String get openpgpMyKeys;

  /// Under openpgpMyKeys when there is none. “Account Settings › End-To-End Encryption › Export Secret Key” are Thunderbird’s menu items: use Thunderbird’s own words in your language.
  ///
  /// In en, this message translates to:
  /// **'With a key, you can read encrypted mail and sign and encrypt your own. Using Thunderbird? Export your key there (Account Settings › End-To-End Encryption › Export Secret Key) and import it here.'**
  String get openpgpMyKeysFooter;

  /// Row that adds an OpenPGP key: import one or make a new one.
  ///
  /// In en, this message translates to:
  /// **'Add Key…'**
  String get openpgpAddKey;

  /// Section header: the user’s email addresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get openpgpAddresses;

  /// Under openpgpAddresses.
  ///
  /// In en, this message translates to:
  /// **'Which key each address uses, and when it encrypts and signs.'**
  String get openpgpAddressesFooter;

  /// Section header: other people’s public keys, which encrypt mail to them and check their signatures.
  ///
  /// In en, this message translates to:
  /// **'Correspondents’ OpenPGP Keys'**
  String get openpgpCorrespondentsKeys;

  /// Under openpgpCorrespondentsKeys. The fingerprint is a key’s unique ID.
  ///
  /// In en, this message translates to:
  /// **'Accept a key once you trust it belongs to its owner; compare the fingerprint with them to mark it verified.'**
  String get openpgpCorrespondentsKeysFooter;

  /// Row: add a correspondent’s public key (the part of their key they share so others can encrypt to them).
  ///
  /// In en, this message translates to:
  /// **'Import Public Key…'**
  String get openpgpImportPublicKey;

  /// Section header: keys that arrived in messages’ headers through Autocrypt. Keep “Autocrypt”: it is a standard’s name.
  ///
  /// In en, this message translates to:
  /// **'Collected from Autocrypt'**
  String get openpgpCollected;

  /// Under openpgpCollected.
  ///
  /// In en, this message translates to:
  /// **'Keys that arrived with messages. Loupe can encrypt to them when both sides ask for it.'**
  String get openpgpCollectedFooter;

  /// Section header: what Loupe keeps of decrypted mail on the phone.
  ///
  /// In en, this message translates to:
  /// **'On This Device'**
  String get openpgpOnThisDevice;

  /// Under openpgpOnThisDevice.
  ///
  /// In en, this message translates to:
  /// **'Encrypted messages hide their subject. Loupe keeps the subject of each message you open in its encrypted database on this device, so the list, search and notifications show it. In the background, Loupe can also decrypt the subjects of new messages with keys that have no passphrase; it downloads each message (up to 1 MB) to do so.'**
  String get openpgpOnThisDeviceFooter;

  /// Switch.
  ///
  /// In en, this message translates to:
  /// **'Decrypt Subjects in the Background'**
  String get openpgpDecryptSubjects;

  /// Under openpgpIndexDecrypted.
  ///
  /// In en, this message translates to:
  /// **'Search finds encrypted messages by their sender, recipients and subject. With this on, Loupe also adds the text of each encrypted message it decrypts to the search index in its encrypted database on this device, so search finds it by its text too. Turning it off removes that text from the index.'**
  String get openpgpIndexFooter;

  /// Switch.
  ///
  /// In en, this message translates to:
  /// **'Index Decrypted Messages for Search'**
  String get openpgpIndexDecrypted;

  /// Section header. A passphrase is a password that protects a key or certificate on the phone.
  ///
  /// In en, this message translates to:
  /// **'Passphrases'**
  String get openpgpPassphrases;

  /// Under openpgpPassphrases. "Remember" refers to the switch openpgpRememberPassphrases.
  ///
  /// In en, this message translates to:
  /// **'OpenPGP keys and S/MIME certificates you protect with a passphrase are unlocked when needed. Without \"Remember\", they are locked again two minutes after each use.'**
  String get openpgpPassphrasesFooter;

  /// Switch.
  ///
  /// In en, this message translates to:
  /// **'Remember Passphrases'**
  String get openpgpRememberPassphrases;

  /// Under openpgpRememberPassphrases: how long.
  ///
  /// In en, this message translates to:
  /// **'Until Loupe closes'**
  String get openpgpRememberPassphrasesDetail;

  /// Button: forget every passphrase typed so far.
  ///
  /// In en, this message translates to:
  /// **'Lock Keys Now'**
  String get openpgpLockKeysNow;

  /// Snack bar after openpgpLockKeysNow.
  ///
  /// In en, this message translates to:
  /// **'Keys locked.'**
  String get openpgpKeysLocked;

  /// After a key’s algorithm and ID: its owner cancelled it. Lower case, in a list: “Ed25519 · 8A3F 21C0 · revoked”.
  ///
  /// In en, this message translates to:
  /// **'revoked'**
  String get openpgpKeyStateRevoked;

  /// As openpgpKeyStateRevoked: the key is past its expiry date.
  ///
  /// In en, this message translates to:
  /// **'expired'**
  String get openpgpKeyStateExpired;

  /// As openpgpKeyStateRevoked.
  ///
  /// In en, this message translates to:
  /// **'never expires'**
  String get openpgpKeyStateNeverExpires;

  /// As openpgpKeyStateRevoked.
  ///
  /// In en, this message translates to:
  /// **'expires {date}'**
  String openpgpKeyStateExpires(String date);

  /// Next to an email address: it has no OpenPGP key or S/MIME certificate.
  ///
  /// In en, this message translates to:
  /// **'No Key'**
  String get openpgpNoKey;

  /// Switch for an email address, and next to the address when it is on: mail from it is always encrypted.
  ///
  /// In en, this message translates to:
  /// **'Always Encrypt'**
  String get openpgpAlwaysEncrypt;

  /// Title of the choices behind openpgpAddKey.
  ///
  /// In en, this message translates to:
  /// **'Add an OpenPGP Key'**
  String get openpgpAddKeyTitle;

  /// Under openpgpAddKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Import the key you use in Thunderbird, or make a new one.'**
  String get openpgpAddKeyMessage;

  /// Choice: paste a copied key.
  ///
  /// In en, this message translates to:
  /// **'Import from Clipboard'**
  String get openpgpImportFromClipboard;

  /// Choice: pick a key file.
  ///
  /// In en, this message translates to:
  /// **'Import from File'**
  String get openpgpImportFromFile;

  /// Choice: make a new OpenPGP key.
  ///
  /// In en, this message translates to:
  /// **'Generate New Key'**
  String get openpgpGenerateNewKey;

  /// Title of the choices behind openpgpImportPublicKey.
  ///
  /// In en, this message translates to:
  /// **'Import a Public Key'**
  String get openpgpImportPublicKeyTitle;

  /// Choice under openpgpImportPublicKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'From Clipboard'**
  String get openpgpFromClipboard;

  /// Choice under openpgpImportPublicKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'From File'**
  String get openpgpFromFile;

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'The clipboard is empty. Copy the key first.'**
  String get openpgpClipboardEmpty;

  /// Title and section header of an OpenPGP key’s details.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get openpgpKey;

  /// A key’s validity: its owner cancelled it.
  ///
  /// In en, this message translates to:
  /// **'Revoked'**
  String get openpgpValidityRevoked;

  /// A key’s validity.
  ///
  /// In en, this message translates to:
  /// **'Expired {date}'**
  String openpgpValidityExpired(String date);

  /// A key’s validity, and the choice of no expiry date when making a new key.
  ///
  /// In en, this message translates to:
  /// **'Never expires'**
  String get openpgpNeverExpires;

  /// A key’s validity.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String openpgpValidUntil(String date);

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint copied.'**
  String get openpgpFingerprintCopied;

  /// Row label; the value is a name like Ed25519.
  ///
  /// In en, this message translates to:
  /// **'Algorithm'**
  String get openpgpAlgorithm;

  /// Row label; the value is a date.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get openpgpCreated;

  /// Row label; the value is like openpgpValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Validity'**
  String get openpgpValidity;

  /// Row label: what protects the user’s secret key on the phone.
  ///
  /// In en, this message translates to:
  /// **'Protection'**
  String get openpgpProtection;

  /// Value of openpgpProtection: the key needs its passphrase.
  ///
  /// In en, this message translates to:
  /// **'Passphrase'**
  String get openpgpProtectionPassphrase;

  /// Value of openpgpProtection: only the phone’s secure storage protects it (no passphrase).
  ///
  /// In en, this message translates to:
  /// **'Keychain only'**
  String get openpgpProtectionKeychain;

  /// Under openpgpSharePublicKey and openpgpBackUpSecretKey. The secret key is the private half of the key pair, which decrypts and signs.
  ///
  /// In en, this message translates to:
  /// **'Share your public key so others can encrypt to you. The backup is your secret key, protected by its passphrase if it has one: keep it private.'**
  String get openpgpKeyDetailsFooter;

  /// Button.
  ///
  /// In en, this message translates to:
  /// **'Share Public Key'**
  String get openpgpSharePublicKey;

  /// Button.
  ///
  /// In en, this message translates to:
  /// **'Copy Public Key'**
  String get openpgpCopyPublicKey;

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Public key copied.'**
  String get openpgpPublicKeyCopied;

  /// Button: save the user’s secret key to a file.
  ///
  /// In en, this message translates to:
  /// **'Back Up Secret Key'**
  String get openpgpBackUpSecretKey;

  /// Button: delete one of the user’s own keys.
  ///
  /// In en, this message translates to:
  /// **'Delete Key'**
  String get openpgpDeleteKey;

  /// Button: remove a correspondent’s key.
  ///
  /// In en, this message translates to:
  /// **'Remove Key'**
  String get openpgpRemoveKey;

  /// Title of the confirmation.
  ///
  /// In en, this message translates to:
  /// **'Back Up Secret Key?'**
  String get openpgpBackUpTitle;

  /// Under openpgpBackUpTitle.
  ///
  /// In en, this message translates to:
  /// **'The backup is protected by your key’s passphrase. Anyone with both can read your mail.'**
  String get openpgpBackUpProtected;

  /// Under openpgpBackUpTitle.
  ///
  /// In en, this message translates to:
  /// **'This key has no passphrase: anyone with the backup can read your mail and sign as you.'**
  String get openpgpBackUpUnprotected;

  /// Button that confirms openpgpBackUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Back Up'**
  String get openpgpBackUp;

  /// Confirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete your key {name}?'**
  String openpgpDeleteOwnKeyTitle(String name);

  /// Confirmation.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}’s key?'**
  String openpgpRemoveKeyTitle(String name);

  /// Under openpgpDeleteOwnKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Mail encrypted to this key can’t be read on this device anymore, unless you import it again.'**
  String get openpgpDeleteOwnKeyMessage;

  /// Under openpgpRemoveKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'You can import it again later.'**
  String get openpgpRemoveKeyMessage;

  /// Section header: the key an email address uses.
  ///
  /// In en, this message translates to:
  /// **'OpenPGP Key'**
  String get openpgpKeyHeader;

  /// “End-to-End Encryption” is the screen titled openpgpEncryptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a key in End-to-End Encryption to encrypt and sign mail from this address.'**
  String get openpgpAddressNoKeyFooter;

  /// Row: make a new OpenPGP key for this address.
  ///
  /// In en, this message translates to:
  /// **'Generate a Key…'**
  String get openpgpGenerateAKey;

  /// Section header: when mail from this address is encrypted and signed.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get openpgpSending;

  /// Under openpgpSending. Keep “Autocrypt”.
  ///
  /// In en, this message translates to:
  /// **'Automatic encryption turns on when every recipient has an accepted key or a trusted certificate, or when Autocrypt says both sides want it. Encrypted mail is always signed.'**
  String get openpgpSendingFooter;

  /// Switch.
  ///
  /// In en, this message translates to:
  /// **'Encrypt Automatically'**
  String get openpgpEncryptAutomatically;

  /// Under openpgpAlwaysEncrypt.
  ///
  /// In en, this message translates to:
  /// **'Refuses to send when a recipient has no key'**
  String get openpgpAlwaysEncryptDetail;

  /// Switch: add a digital signature to mail that isn’t encrypted.
  ///
  /// In en, this message translates to:
  /// **'Sign Unencrypted Mail'**
  String get openpgpSignUnencrypted;

  /// Switch.
  ///
  /// In en, this message translates to:
  /// **'Attach My Public Key'**
  String get openpgpAttachPublicKey;

  /// Under the Autocrypt section. Keep “Autocrypt”.
  ///
  /// In en, this message translates to:
  /// **'Autocrypt sends your public key along with every message, so other apps can encrypt to you without any setup.'**
  String get openpgpAutocryptFooter;

  /// Switch (Autocrypt).
  ///
  /// In en, this message translates to:
  /// **'Send My Key with Mail'**
  String get openpgpSendMyKey;

  /// Switch (Autocrypt).
  ///
  /// In en, this message translates to:
  /// **'Prefer Encryption'**
  String get openpgpPreferEncryption;

  /// Under openpgpPreferEncryption.
  ///
  /// In en, this message translates to:
  /// **'Ask others to encrypt when they can'**
  String get openpgpPreferEncryptionDetail;

  /// Choice: how long a new key is valid.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 year} other{{count} years}}'**
  String openpgpValidityYears(int count);

  /// Snack bar: the two passphrases typed differ.
  ///
  /// In en, this message translates to:
  /// **'The passphrases don’t match.'**
  String get openpgpPassphrasesDontMatch;

  /// Snack bar after making a new key.
  ///
  /// In en, this message translates to:
  /// **'Your key {id} is ready.'**
  String openpgpKeyReady(String id);

  /// Title of the screen that makes a new OpenPGP key.
  ///
  /// In en, this message translates to:
  /// **'New Key'**
  String get openpgpNewKey;

  /// Section header above the name and address the new key is for.
  ///
  /// In en, this message translates to:
  /// **'For'**
  String get openpgpNewKeyFor;

  /// Placeholder of the name field.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get openpgpYourName;

  /// Row label: the email address the new key is for.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get openpgpAddress;

  /// Section header, field label and placeholder for a passphrase: the password that protects an OpenPGP key.
  ///
  /// In en, this message translates to:
  /// **'Passphrase'**
  String get openpgpPassphrase;

  /// Under the passphrase fields of a new key.
  ///
  /// In en, this message translates to:
  /// **'Optional. Without one, your phone’s keychain alone protects the key and Loupe never asks. With one, Loupe asks for it when the key is needed.'**
  String get openpgpNewKeyPassphraseFooter;

  /// Field label: type the passphrase again.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get openpgpRepeatPassphrase;

  /// Section header: how long the new key is valid.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get openpgpExpires;

  /// Under openpgpExpires.
  ///
  /// In en, this message translates to:
  /// **'You can make a new key before it expires. Thunderbird uses three years too.'**
  String get openpgpExpiresFooter;

  /// Button that makes the new key.
  ///
  /// In en, this message translates to:
  /// **'Generate Key'**
  String get openpgpGenerateKey;

  /// Title of the list of the user’s addresses to make the key for.
  ///
  /// In en, this message translates to:
  /// **'Key for'**
  String get openpgpKeyFor;

  /// Title when sending encrypted mail to someone without a key.
  ///
  /// In en, this message translates to:
  /// **'Can’t Encrypt'**
  String get openpgpCantEncrypt;

  /// Under openpgpCantEncrypt. “Settings › End-to-End Encryption” names the screen titled openpgpEncryptionTitle: use the same words.
  ///
  /// In en, this message translates to:
  /// **'There is no OpenPGP key for {names}, and this address always encrypts. Remove the recipient, or import their key in Settings › End-to-End Encryption.'**
  String openpgpNoKeyAlwaysEncrypt(String names);

  /// Under openpgpCantEncrypt. An S/MIME certificate is a digital ID, issued by a certificate authority, that encrypts mail to its owner. “Settings › End-to-End Encryption” names the screen titled openpgpEncryptionTitle: use the same words.
  ///
  /// In en, this message translates to:
  /// **'There is no valid S/MIME certificate for {names}, and this address always encrypts. Remove the recipient, or import their certificate in Settings › End-to-End Encryption.'**
  String openpgpNoCertificateAlwaysEncrypt(String names);

  /// Under openpgpCantEncrypt.
  ///
  /// In en, this message translates to:
  /// **'There is no OpenPGP key for {names}.'**
  String openpgpNoKeyFor(String names);

  /// Under openpgpCantEncrypt.
  ///
  /// In en, this message translates to:
  /// **'There is no valid S/MIME certificate for {names}.'**
  String openpgpNoCertificateFor(String names);

  /// Button under openpgpCantEncrypt.
  ///
  /// In en, this message translates to:
  /// **'Send Unencrypted'**
  String get openpgpSendUnencrypted;

  /// Title: the message can’t get its digital signature.
  ///
  /// In en, this message translates to:
  /// **'Can’t Sign'**
  String get openpgpCantSign;

  /// Under openpgpCantSign. “Settings › End-to-End Encryption” names the screen titled openpgpEncryptionTitle: use the same words.
  ///
  /// In en, this message translates to:
  /// **'The private key of your S/MIME certificate isn’t on this device. Import the certificate again (a .p12 or .pfx file) in Settings › End-to-End Encryption.'**
  String get openpgpCantSignMessage;

  /// Under the subject while writing: recipients without an OpenPGP key, who can’t get encrypted mail.
  ///
  /// In en, this message translates to:
  /// **'No key for {names}'**
  String openpgpComposeNoKey(String names);

  /// As openpgpComposeNoKey, for S/MIME certificates.
  ///
  /// In en, this message translates to:
  /// **'No certificate for {names}'**
  String openpgpComposeNoCertificate(String names);

  /// Under the subject while writing. Keep “Autocrypt”.
  ///
  /// In en, this message translates to:
  /// **'Keys from Autocrypt'**
  String get openpgpComposeAutocryptKeys;

  /// Under the subject while writing: encryption is possible.
  ///
  /// In en, this message translates to:
  /// **'Everyone has a key'**
  String get openpgpComposeEveryoneHasKey;

  /// As openpgpComposeEveryoneHasKey, for S/MIME.
  ///
  /// In en, this message translates to:
  /// **'Everyone has a certificate'**
  String get openpgpComposeEveryoneHasCertificate;

  /// Toggle under the subject while writing.
  ///
  /// In en, this message translates to:
  /// **'Encrypt'**
  String get openpgpComposeEncrypt;

  /// Toggle under the subject while writing: add a digital signature.
  ///
  /// In en, this message translates to:
  /// **'Sign'**
  String get openpgpComposeSign;

  /// Read out by screen readers for the button that switches between OpenPGP and S/MIME.
  ///
  /// In en, this message translates to:
  /// **'{standard}, switch'**
  String openpgpComposeSwitchStandard(String standard);

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'No OpenPGP key found.'**
  String get openpgpNoKeyFound;

  /// Title: an attachment holds a secret key (the private half of a key pair, which decrypts and signs).
  ///
  /// In en, this message translates to:
  /// **'Import a Secret Key?'**
  String get openpgpImportSecretKeyTitle;

  /// Under openpgpImportSecretKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'This attachment holds a secret key ({names}). Import it as your own key only if you exported it yourself, from Thunderbird for example.'**
  String openpgpImportSecretKeyMessage(String names);

  /// Button under openpgpImportSecretKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Import as My Key'**
  String get openpgpImportAsMyKey;

  /// An item in openpgpImported’s list. Lower case.
  ///
  /// In en, this message translates to:
  /// **'your key {name}'**
  String openpgpImportedOwnKey(String name);

  /// Title before importing correspondents’ public keys.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Import {names}’s key?} other{Import {count} keys ({names})?}}'**
  String openpgpImportPublicKeysTitle(int count, String names);

  /// Choice: import the keys and trust that they belong to their owners.
  ///
  /// In en, this message translates to:
  /// **'Import and Accept'**
  String get openpgpImportAndAccept;

  /// Choice: import the keys without accepting them yet.
  ///
  /// In en, this message translates to:
  /// **'Import, Decide Later'**
  String get openpgpImportDecideLater;

  /// An item in openpgpImported’s list.
  ///
  /// In en, this message translates to:
  /// **'{name}’s key'**
  String openpgpImportedPublicKey(String name);

  /// Snack bar. keys: openpgpImportedOwnKey and openpgpImportedPublicKey items, separated by commas.
  ///
  /// In en, this message translates to:
  /// **'Imported {keys}.'**
  String openpgpImported(String keys);

  /// Under a message’s attachments, next to openpgpImport.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{An OpenPGP key is attached.} other{{count} OpenPGP keys are attached.}}'**
  String openpgpKeysAttached(int count);

  /// Button: import the keys attached to the message.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get openpgpImport;

  /// Title of the dialog that asks for a key’s passphrase.
  ///
  /// In en, this message translates to:
  /// **'Unlock OpenPGP Key'**
  String get openpgpUnlockKeyTitle;

  /// In the passphrase dialog.
  ///
  /// In en, this message translates to:
  /// **'Enter the passphrase of {name}’s key ({id}).'**
  String openpgpEnterPassphrase(String name, String id);

  /// In the passphrase dialog, after a wrong one.
  ///
  /// In en, this message translates to:
  /// **'That passphrase is wrong. Try again.'**
  String get openpgpWrongPassphrase;

  /// Shown in place of the text of a message the user’s locked key can’t decrypt yet.
  ///
  /// In en, this message translates to:
  /// **'This message is encrypted. Unlock your OpenPGP key to read it.'**
  String get openpgpExplainLocked;

  /// Shown in place of the message’s text. “Settings › End-to-End Encryption” names the screen titled openpgpEncryptionTitle: use the same words.
  ///
  /// In en, this message translates to:
  /// **'This message is encrypted, but not to any OpenPGP key on this device. If you read it in Thunderbird, import your key from there: Settings › End-to-End Encryption.'**
  String get openpgpExplainNoKey;

  /// Shown in place of the message’s text (OpenPGP and S/MIME).
  ///
  /// In en, this message translates to:
  /// **'This encrypted message is damaged, so it can’t be decrypted safely.'**
  String get openpgpExplainDamaged;

  /// Shown in place of the message’s text (OpenPGP and S/MIME).
  ///
  /// In en, this message translates to:
  /// **'This message uses encryption that Loupe can’t read yet.'**
  String get openpgpExplainUnsupported;

  /// Shown in place of the message’s text. “Settings › End-to-End Encryption” names the screen titled openpgpEncryptionTitle: use the same words.
  ///
  /// In en, this message translates to:
  /// **'This message is encrypted with S/MIME, but not to any certificate on this device. Import your certificate (a .p12 or .pfx file) in Settings › End-to-End Encryption.'**
  String get openpgpExplainSmimeNoKey;

  /// Shown in place of the message’s text. reason: openpgpExplainSmimeUnlock, or a sentence from the phone about its certificate.
  ///
  /// In en, this message translates to:
  /// **'This message is encrypted. {reason}'**
  String openpgpExplainSmimeLocked(String reason);

  /// The reason in openpgpExplainSmimeLocked: type the certificate’s passphrase.
  ///
  /// In en, this message translates to:
  /// **'Unlock your S/MIME certificate to read it.'**
  String get openpgpExplainSmimeUnlock;

  /// Error when opening an attachment of a decrypted message.
  ///
  /// In en, this message translates to:
  /// **'This attachment is no longer available.'**
  String get openpgpAttachmentGone;

  /// Message header: encrypted with S/MIME (the standard Outlook uses) and decrypted. Keep “S/MIME”.
  ///
  /// In en, this message translates to:
  /// **'Encrypted (S/MIME)'**
  String get smimeEncrypted;

  /// Message header: encrypted to a certificate (a digital ID with its private key) that isn’t on this device.
  ///
  /// In en, this message translates to:
  /// **'Encrypted (S/MIME) · no certificate'**
  String get smimeEncryptedNoCertificate;

  /// Message header.
  ///
  /// In en, this message translates to:
  /// **'Encrypted (S/MIME) · damaged'**
  String get smimeEncryptedDamaged;

  /// Message header.
  ///
  /// In en, this message translates to:
  /// **'Encrypted (S/MIME) · unsupported'**
  String get smimeEncryptedUnsupported;

  /// Message header: the user’s certificate needs its passphrase first.
  ///
  /// In en, this message translates to:
  /// **'Encrypted (S/MIME) · locked'**
  String get smimeEncryptedLocked;

  /// Stands in for the signer’s name in “Signed by {name}” when the certificate has none. Lower case.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get smimeUnknownSigner;

  /// Message header: the digital signature shows the message was changed after it was signed.
  ///
  /// In en, this message translates to:
  /// **'Signature invalid: message modified'**
  String get smimeSignatureModified;

  /// Message header.
  ///
  /// In en, this message translates to:
  /// **'Signature insecure: outdated algorithm'**
  String get smimeSignatureWeak;

  /// Message header.
  ///
  /// In en, this message translates to:
  /// **'Signature can’t be checked'**
  String get smimeSignatureUncheckable;

  /// Message header: signed, but the signer’s certificate isn’t in the message.
  ///
  /// In en, this message translates to:
  /// **'Signed · certificate missing'**
  String get smimeSignedCertificateMissing;

  /// Message header: the certificate authority cancelled the signer’s certificate.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name} · certificate revoked'**
  String smimeSignedByRevoked(String name);

  /// Message header: signed long before or after the message’s date.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name} · at another date'**
  String smimeSignedByOtherDate(String name);

  /// Message header: a valid signature by a trusted certificate.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name}'**
  String smimeSignedBy(String name);

  /// Message header.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name} · invalid certificate'**
  String smimeSignedByInvalid(String name);

  /// Message header: the certificate comes from an authority Loupe doesn’t trust.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name} · not trusted'**
  String smimeSignedByUntrusted(String name);

  /// Message header.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name} · certificate expired'**
  String smimeSignedByExpired(String name);

  /// Message header.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name} · certificate not yet valid'**
  String smimeSignedByNotYetValid(String name);

  /// Message header.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name} · certificate not for mail'**
  String smimeSignedByNotForMail(String name);

  /// Message header.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name}, not the sender'**
  String smimeSignedByNotSender(String name);

  /// Title of the message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'Can’t decrypt this message'**
  String get smimeCantDecrypt;

  /// Title of the message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'Encrypted with S/MIME'**
  String get smimeEncryptedWithSmime;

  /// Section header in the message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get smimeEncryption;

  /// Row in the message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'Decrypted on this device'**
  String get smimeDecryptedHere;

  /// Row in the message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'Not decrypted'**
  String get smimeNotDecrypted;

  /// After the cipher’s name: the encryption also proves the message wasn’t changed. Lower case, in a list: “AES-256-GCM · authenticated”.
  ///
  /// In en, this message translates to:
  /// **'authenticated'**
  String get smimeAuthenticated;

  /// In the same list as smimeAuthenticated: how many certificates the message was encrypted to. Lower case.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{for 1 certificate} other{for {count} certificates}}'**
  String smimeForCertificates(int count);

  /// Section header in the message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get smimeSignature;

  /// Row label; the value is the certificate authority that issued the certificate.
  ///
  /// In en, this message translates to:
  /// **'Issued by'**
  String get smimeIssuedBy;

  /// Row label; the value is smimeValidRange.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get smimeValid;

  /// A certificate’s validity, from one date to another.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to}'**
  String smimeValidRange(String from, String to);

  /// Row label: the certificate’s unique ID (SHA-256 is the name of the method). Sentence case.
  ///
  /// In en, this message translates to:
  /// **'SHA-256 fingerprint'**
  String get smimeSha256Fingerprint;

  /// Row label; the value is the date and time it was signed.
  ///
  /// In en, this message translates to:
  /// **'Signed'**
  String get smimeSigned;

  /// Row label; the value says what is wrong.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get smimeProblem;

  /// Row: asking the certificate authority whether it cancelled (revoked) the signer’s certificate.
  ///
  /// In en, this message translates to:
  /// **'Checking revocation…'**
  String get smimeCheckingRevocation;

  /// Row: the authority says the certificate wasn’t cancelled.
  ///
  /// In en, this message translates to:
  /// **'Not revoked'**
  String get smimeNotRevoked;

  /// Row: the authority cancelled the certificate.
  ///
  /// In en, this message translates to:
  /// **'Revoked'**
  String get smimeRevoked;

  /// Row: no answer about whether the certificate was cancelled.
  ///
  /// In en, this message translates to:
  /// **'Revocation unknown'**
  String get smimeRevocationUnknown;

  /// Under smimeRevoked.
  ///
  /// In en, this message translates to:
  /// **'Since {date}'**
  String smimeRevokedSince(String date);

  /// Under smimeNotRevoked: how and when it was checked. A revocation list is the authority’s list of cancelled certificates.
  ///
  /// In en, this message translates to:
  /// **'Asked the authority (its revocation list), {date}'**
  String smimeAskedAuthorityCrl(String date);

  /// As smimeAskedAuthorityCrl. Keep “OCSP”: the protocol’s name.
  ///
  /// In en, this message translates to:
  /// **'Asked the authority (OCSP), {date}'**
  String smimeAskedAuthorityOcsp(String date);

  /// Action: trust the certificate authority that issued the signer’s certificate.
  ///
  /// In en, this message translates to:
  /// **'Trust “{name}”…'**
  String smimeTrustIssuer(String name);

  /// Action in the message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'Trust This Certificate…'**
  String get smimeTrustThisCertificateEllipsis;

  /// Footnote of the message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'Checked on this device with S/MIME, compatible with Outlook and Thunderbird; revocation with the certificate authority.'**
  String get smimeCheckedFooterRevocation;

  /// Footnote of the message’s S/MIME details. “Settings › End-to-End Encryption” names the screen titled openpgpEncryptionTitle: use the same words.
  ///
  /// In en, this message translates to:
  /// **'Checked on this device with S/MIME, compatible with Outlook and Thunderbird. Revocation isn’t checked (Settings › End-to-End Encryption).'**
  String get smimeCheckedFooter;

  /// Confirmation: trust a certificate authority.
  ///
  /// In en, this message translates to:
  /// **'Trust {name} for mail?'**
  String smimeTrustAuthorityTitle(String name);

  /// Confirmation.
  ///
  /// In en, this message translates to:
  /// **'Trust {name}’s certificate?'**
  String smimeTrustCertificateTitle(String name);

  /// Under smimeTrustAuthorityTitle. CA: certificate authority. The fingerprint is the certificate’s unique ID.
  ///
  /// In en, this message translates to:
  /// **'Every certificate this authority issues will be trusted, like your company’s CA. Compare the fingerprint with its owner first:\n{fingerprint}'**
  String smimeTrustAuthorityMessage(String fingerprint);

  /// Before trusting a certificate. The fingerprint is its unique ID.
  ///
  /// In en, this message translates to:
  /// **'Compare the fingerprint with its owner first:\n{fingerprint}'**
  String smimeTrustMessage(String fingerprint);

  /// Button: trust the certificate or authority.
  ///
  /// In en, this message translates to:
  /// **'Trust'**
  String get smimeTrust;

  /// Message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'It was encrypted to a certificate that isn’t on this device.'**
  String get smimeSummaryNoKey;

  /// Message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'The encrypted data is damaged or was changed on the way.'**
  String get smimeSummaryDamaged;

  /// Message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'It uses an algorithm Loupe doesn’t support.'**
  String get smimeSummaryUnsupported;

  /// Message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'Your S/MIME certificate is locked.'**
  String get smimeSummaryLocked;

  /// Message’s S/MIME details: first sentence for an encrypted message; one about its signature follows.
  ///
  /// In en, this message translates to:
  /// **'Only you and the other recipients can read it.'**
  String get smimeSummaryEncrypted;

  /// Message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'It isn’t signed, so the sender isn’t confirmed.'**
  String get smimeSummaryNotSigned;

  /// Message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'The signature doesn’t match: the message was changed after it was signed.'**
  String get smimeSummaryModified;

  /// Message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'The signature can’t be checked.'**
  String get smimeSummaryUncheckable;

  /// Message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'The signer’s certificate isn’t in the message, so it can’t be checked.'**
  String get smimeSummaryNoCertificate;

  /// Message’s S/MIME details. Revoked: cancelled before it expired.
  ///
  /// In en, this message translates to:
  /// **'The certificate authority revoked the signer’s certificate: the signature can’t be trusted.'**
  String get smimeSummaryRevoked;

  /// As smimeSummaryRevoked; reason comes from the authority, in English.
  ///
  /// In en, this message translates to:
  /// **'The certificate authority revoked the signer’s certificate ({reason}): the signature can’t be trusted.'**
  String smimeSummaryRevokedReason(String reason);

  /// Message’s S/MIME details.
  ///
  /// In en, this message translates to:
  /// **'It was signed more than an hour away from the message’s date: it may be an old message sent again.'**
  String get smimeDateMismatch;

  /// Message’s S/MIME details. issuer: the certificate authority.
  ///
  /// In en, this message translates to:
  /// **'The signature is valid, and {issuer} vouches that the certificate belongs to the sender.'**
  String smimeSummaryValid(String issuer);

  /// A certificate problem.
  ///
  /// In en, this message translates to:
  /// **'The certificate or one of its issuers is invalid.'**
  String get smimeProblemInvalidChain;

  /// A certificate problem.
  ///
  /// In en, this message translates to:
  /// **'The certificate comes from an authority Loupe doesn’t trust.'**
  String get smimeProblemUntrusted;

  /// A certificate problem.
  ///
  /// In en, this message translates to:
  /// **'The certificate had expired.'**
  String get smimeProblemExpired;

  /// A certificate problem.
  ///
  /// In en, this message translates to:
  /// **'The certificate wasn’t valid yet.'**
  String get smimeProblemNotYetValid;

  /// A certificate problem.
  ///
  /// In en, this message translates to:
  /// **'The certificate isn’t meant for mail.'**
  String get smimeProblemWrongUsage;

  /// A certificate problem.
  ///
  /// In en, this message translates to:
  /// **'The certificate belongs to another address than the sender’s.'**
  String get smimeProblemWrongAddress;

  /// A certificate’s trust: issued by a trusted authority.
  ///
  /// In en, this message translates to:
  /// **'Trusted · {issuer}'**
  String smimeTrustedBy(String issuer);

  /// A certificate’s trust: issued by an authority Loupe doesn’t trust.
  ///
  /// In en, this message translates to:
  /// **'Not trusted · {issuer}'**
  String smimeNotTrustedBy(String issuer);

  /// A certificate’s trust.
  ///
  /// In en, this message translates to:
  /// **'Expired {date}'**
  String smimeExpiredOn(String date);

  /// A certificate’s trust: not valid yet.
  ///
  /// In en, this message translates to:
  /// **'Valid from {date}'**
  String smimeValidFrom(String date);

  /// A certificate’s trust.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get smimeTrustInvalid;

  /// A certificate’s trust: it isn’t meant for email.
  ///
  /// In en, this message translates to:
  /// **'Not for mail'**
  String get smimeTrustNotForMail;

  /// A certificate’s trust: it is for another email address.
  ///
  /// In en, this message translates to:
  /// **'Another address'**
  String get smimeTrustAnotherAddress;

  /// Section header: the user’s own S/MIME certificates (digital IDs with their private keys). Keep “S/MIME”.
  ///
  /// In en, this message translates to:
  /// **'My S/MIME Certificates'**
  String get smimeMyCertificates;

  /// Under smimeMyCertificates when there is none.
  ///
  /// In en, this message translates to:
  /// **'For S/MIME, as Outlook and many companies use it. Import your certificate with its private key (a .p12 or .pfx file), exported from Outlook, Windows, macOS or Thunderbird.'**
  String get smimeMyCertificatesFooter;

  /// As smimeMyCertificatesFooter, on a phone that offers its installed certificates.
  ///
  /// In en, this message translates to:
  /// **'For S/MIME, as Outlook and many companies use it. Import your certificate with its private key (a .p12 or .pfx file), exported from Outlook, Windows, macOS or Thunderbird, or use one your company or you installed on this device.'**
  String get smimeMyCertificatesFooterDevice;

  /// After a certificate’s addresses: it expired. Lower case, in a list: “sam@example.com · expired”.
  ///
  /// In en, this message translates to:
  /// **'expired'**
  String get smimeCertificateExpired;

  /// As smimeCertificateExpired: valid until.
  ///
  /// In en, this message translates to:
  /// **'until {date}'**
  String smimeCertificateUntil(String date);

  /// As smimeCertificateExpired: the certificate is installed on the phone, not in Loupe.
  ///
  /// In en, this message translates to:
  /// **'on this device'**
  String get smimeCertificateOnDevice;

  /// Row: import a certificate file.
  ///
  /// In en, this message translates to:
  /// **'Import Certificate…'**
  String get smimeImportCertificateEllipsis;

  /// Row: pick a certificate installed on the phone.
  ///
  /// In en, this message translates to:
  /// **'Use a Certificate from This Device…'**
  String get smimeUseDeviceCertificate;

  /// Section header: other people’s certificates.
  ///
  /// In en, this message translates to:
  /// **'Correspondents’ Certificates'**
  String get smimeCorrespondentsCertificates;

  /// Under smimeCorrespondentsCertificates.
  ///
  /// In en, this message translates to:
  /// **'Collected from signed mail, as Outlook and Thunderbird do. Mail is encrypted only to trusted certificates: Loupe trusts the authorities Mozilla trusts for email, and those you add.'**
  String get smimeCorrespondentsCertificatesFooter;

  /// Section header: checking whether certificates were cancelled (revoked) by their authority.
  ///
  /// In en, this message translates to:
  /// **'Revocation'**
  String get smimeRevocation;

  /// Under smimeRevocation. Keep “OCSP”. "Revoked" quotes the header’s word.
  ///
  /// In en, this message translates to:
  /// **'When you open signed mail, Loupe asks the authority that issued the signer’s certificate whether it was revoked (its OCSP responder, or its revocation list). The authority can then see when someone at your internet address reads mail signed with that certificate. Answers are kept on this device until they expire. A revoked certificate shows as \"Revoked\" in the message header.'**
  String get smimeRevocationFooter;

  /// Switch.
  ///
  /// In en, this message translates to:
  /// **'Check Certificate Revocation Online'**
  String get smimeCheckRevocation;

  /// Section header: certificate authorities (which issue certificates) the user chose to trust.
  ///
  /// In en, this message translates to:
  /// **'Trusted Authorities'**
  String get smimeTrustedAuthorities;

  /// Under smimeTrustedAuthorities. count: how many authorities Mozilla trusts.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{Trusted by you, besides the {count} that Mozilla trusts for email.}}'**
  String smimeTrustedAuthoritiesFooter(int count);

  /// Under an authority’s name.
  ///
  /// In en, this message translates to:
  /// **'Certificate authority'**
  String get smimeCertificateAuthority;

  /// Title of the choices for importing a correspondent’s certificate.
  ///
  /// In en, this message translates to:
  /// **'Import a Certificate'**
  String get smimeImportACertificate;

  /// Under smimeImportACertificate.
  ///
  /// In en, this message translates to:
  /// **'A correspondent’s certificate (.cer, .crt, .pem) or a certificate authority’s.'**
  String get smimeImportContactMessage;

  /// Choice under smimeImportACertificate.
  ///
  /// In en, this message translates to:
  /// **'From Clipboard'**
  String get smimeFromClipboard;

  /// Choice under smimeImportACertificate.
  ///
  /// In en, this message translates to:
  /// **'From File'**
  String get smimeFromFile;

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'The clipboard is empty. Copy the certificate first.'**
  String get smimeClipboardEmpty;

  /// Title and section header of a certificate’s details.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get smimeCertificate;

  /// Under a certificate installed on the phone.
  ///
  /// In en, this message translates to:
  /// **'Its private key stays in Android’s credential storage, where your company or you installed it: Loupe asks Android to sign and decrypt with it. Signed mail is signed when you send it.'**
  String get smimeOnDeviceFooter;

  /// Row label: the certificate’s email addresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get smimeAddresses;

  /// Row label; the value lists what the certificate is for (smimeUsageSigning…).
  ///
  /// In en, this message translates to:
  /// **'For'**
  String get smimeUsage;

  /// Value of smimeUsage.
  ///
  /// In en, this message translates to:
  /// **'Nothing Loupe uses'**
  String get smimeUsageNone;

  /// In smimeUsage’s list.
  ///
  /// In en, this message translates to:
  /// **'Signing'**
  String get smimeUsageSigning;

  /// In smimeUsage’s list.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get smimeUsageEncryption;

  /// In smimeUsage’s list: it issues other certificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get smimeUsageCertificates;

  /// Row label; the value is a name like RSA 2048.
  ///
  /// In en, this message translates to:
  /// **'Algorithm'**
  String get smimeAlgorithm;

  /// Row label. Sentence case.
  ///
  /// In en, this message translates to:
  /// **'Serial number'**
  String get smimeSerialNumber;

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint copied.'**
  String get smimeFingerprintCopied;

  /// Row label: another ID of the certificate (Windows calls it the thumbprint). Sentence case.
  ///
  /// In en, this message translates to:
  /// **'SHA-1 thumbprint'**
  String get smimeSha1Thumbprint;

  /// Row label: where the certificate’s private key is.
  ///
  /// In en, this message translates to:
  /// **'Private key'**
  String get smimePrivateKey;

  /// Value of smimePrivateKey: in Android’s credential storage.
  ///
  /// In en, this message translates to:
  /// **'On this device'**
  String get smimeKeyOnDevice;

  /// Value of smimePrivateKey.
  ///
  /// In en, this message translates to:
  /// **'In Loupe, with a passphrase'**
  String get smimeKeyInLoupeWithPassphrase;

  /// Value of smimePrivateKey.
  ///
  /// In en, this message translates to:
  /// **'In Loupe'**
  String get smimeKeyInLoupe;

  /// Row label: where a correspondent’s certificate came from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get smimeSource;

  /// Value of smimeSource.
  ///
  /// In en, this message translates to:
  /// **'Signed mail'**
  String get smimeSourceSignedMail;

  /// Value of smimeSource.
  ///
  /// In en, this message translates to:
  /// **'Imported'**
  String get smimeSourceImported;

  /// Section header: how far the certificate is trusted, and why.
  ///
  /// In en, this message translates to:
  /// **'Trust'**
  String get smimeTrustHeader;

  /// Under an authority in the certificate’s chain: the trusted one at the top.
  ///
  /// In en, this message translates to:
  /// **'Trusted root'**
  String get smimeTrustedRoot;

  /// Under an authority in the certificate’s chain.
  ///
  /// In en, this message translates to:
  /// **'Issuer'**
  String get smimeIssuer;

  /// Row: trust the authority at the top of the chain.
  ///
  /// In en, this message translates to:
  /// **'Trust “{name}”'**
  String smimeTrustNamed(String name);

  /// Row.
  ///
  /// In en, this message translates to:
  /// **'Trust This Authority'**
  String get smimeTrustThisAuthority;

  /// Row.
  ///
  /// In en, this message translates to:
  /// **'Trust This Certificate'**
  String get smimeTrustThisCertificate;

  /// Row.
  ///
  /// In en, this message translates to:
  /// **'Stop Trusting'**
  String get smimeStopTrusting;

  /// Section header and placeholder: the password that protects the certificate’s private key on this phone.
  ///
  /// In en, this message translates to:
  /// **'Passphrase'**
  String get smimePassphrase;

  /// Under smimePassphrase. “Remember Passphrases” is openpgpRememberPassphrases: use the same words.
  ///
  /// In en, this message translates to:
  /// **'Optional. With a passphrase, the private key is also encrypted on this device (Argon2id and AES-256), and Loupe asks for it to sign and decrypt; Remember Passphrases says for how long. Mail you send is signed as you send it; background work can’t use the key.'**
  String get smimePassphraseFooter;

  /// Row.
  ///
  /// In en, this message translates to:
  /// **'Change Passphrase…'**
  String get smimeChangePassphrase;

  /// Row.
  ///
  /// In en, this message translates to:
  /// **'Set Passphrase…'**
  String get smimeSetPassphraseEllipsis;

  /// Row, and the button of smimeRemovePassphraseTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Passphrase'**
  String get smimeRemovePassphrase;

  /// Button.
  ///
  /// In en, this message translates to:
  /// **'Share Certificate'**
  String get smimeShareCertificate;

  /// Button: delete one of the user’s own certificates.
  ///
  /// In en, this message translates to:
  /// **'Delete Certificate'**
  String get smimeDeleteCertificate;

  /// Button: remove a correspondent’s certificate.
  ///
  /// In en, this message translates to:
  /// **'Remove Certificate'**
  String get smimeRemoveCertificate;

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Passphrase changed.'**
  String get smimePassphraseChanged;

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Passphrase set.'**
  String get smimePassphraseSet;

  /// Confirmation.
  ///
  /// In en, this message translates to:
  /// **'Remove the Passphrase?'**
  String get smimeRemovePassphraseTitle;

  /// Under smimeRemovePassphraseTitle. The keychain is the phone’s secure storage.
  ///
  /// In en, this message translates to:
  /// **'The private key is then protected by the keychain only, as without a passphrase: Loupe no longer asks for it, and background work can use it.'**
  String get smimeRemovePassphraseMessage;

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Passphrase removed.'**
  String get smimePassphraseRemoved;

  /// Confirmation.
  ///
  /// In en, this message translates to:
  /// **'Trust {name}?'**
  String smimeTrustTitle(String name);

  /// Under smimeTrustTitle for a certificate authority.
  ///
  /// In en, this message translates to:
  /// **'Every certificate it issues will be trusted for mail. Compare the fingerprint with its owner first:\n{fingerprint}'**
  String smimeTrustCaMessage(String fingerprint);

  /// Confirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete your certificate {name}?'**
  String smimeDeleteOwnTitle(String name);

  /// Confirmation.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}’s certificate?'**
  String smimeRemoveContactTitle(String name);

  /// Under smimeDeleteOwnTitle for a certificate installed on the phone. “Settings › Security › Encryption & credentials” are Android’s menu items: use Android’s own words in your language.
  ///
  /// In en, this message translates to:
  /// **'Loupe stops using it: mail encrypted to it can’t be read in Loupe anymore. The certificate stays on this device (Settings › Security › Encryption & credentials).'**
  String get smimeDeleteDeviceMessage;

  /// Under smimeDeleteOwnTitle.
  ///
  /// In en, this message translates to:
  /// **'Its private key is deleted from this device: mail encrypted to it can’t be read here anymore, unless you import it again.'**
  String get smimeDeleteOwnMessage;

  /// Under smimeRemoveContactTitle.
  ///
  /// In en, this message translates to:
  /// **'It comes back with their next signed message.'**
  String get smimeRemoveContactMessage;

  /// Under the S/MIME section of an address without a certificate.
  ///
  /// In en, this message translates to:
  /// **'Import a certificate for this address to sign and encrypt with S/MIME, as Outlook does.'**
  String get smimeAddressImportFooter;

  /// Row.
  ///
  /// In en, this message translates to:
  /// **'Import a Certificate…'**
  String get smimeImportACertificateEllipsis;

  /// Under smimePreferSmime: “both” are OpenPGP and S/MIME.
  ///
  /// In en, this message translates to:
  /// **'When both could protect a message, the preferred one is used, unless only the other has a key or certificate for every recipient.'**
  String get smimePreferFooter;

  /// Switch.
  ///
  /// In en, this message translates to:
  /// **'Prefer S/MIME'**
  String get smimePreferSmime;

  /// Under smimePreferSmime.
  ///
  /// In en, this message translates to:
  /// **'Rather than OpenPGP'**
  String get smimePreferSmimeDetail;

  /// Title of the dialog asking for the password a .p12 or .pfx certificate file was exported with.
  ///
  /// In en, this message translates to:
  /// **'Certificate Password'**
  String get smimeCertificatePassword;

  /// Under smimeCertificatePassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the password the certificate file was exported with.'**
  String get smimeCertificatePasswordPrompt;

  /// Button: import the certificate (in the password dialog, and under a message’s attachments).
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get smimeImport;

  /// In the password dialog, after a wrong one.
  ///
  /// In en, this message translates to:
  /// **'That password is wrong. Try again.'**
  String get smimeWrongPassword;

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'No certificate found.'**
  String get smimeNoCertificateFound;

  /// An item in smimeImportedCertificates’ list.
  ///
  /// In en, this message translates to:
  /// **'{name}’s certificate'**
  String smimeCertificateOf(String name);

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Nothing new to import.'**
  String get smimeNothingNew;

  /// Snack bar. certificates: smimeCertificateOf items, separated by commas.
  ///
  /// In en, this message translates to:
  /// **'Imported {certificates}.'**
  String smimeImportedCertificates(String certificates);

  /// Snack bar: certificate authorities the user chose to trust.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Imported a trusted authority.} other{Imported {count} trusted authorities.}}'**
  String smimeImportedAuthorities(int count);

  /// Snack bar, as smimeImportedCertificates and smimeImportedAuthorities together.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Imported {certificates} and a trusted authority.} other{Imported {certificates} and {count} trusted authorities.}}'**
  String smimeImportedCertificatesAndAuthorities(int count, String certificates);

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'This file has no private key. Export your certificate with its private key.'**
  String get smimeNoPrivateKey;

  /// Title: an attachment holds a certificate with its private key.
  ///
  /// In en, this message translates to:
  /// **'Import as Your Certificate?'**
  String get smimeImportAsYoursTitle;

  /// Under smimeImportAsYoursTitle. names: name (addresses).
  ///
  /// In en, this message translates to:
  /// **'This attachment holds a certificate with its private key: {names}. Import it only if you exported it yourself, from Outlook or Thunderbird for example.'**
  String smimeImportAsYoursMessage(String names);

  /// Button under smimeImportAsYoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Import as My Certificate'**
  String get smimeImportAsMine;

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Imported your certificate {names}.'**
  String smimeImportedOwn(String names);

  /// Snack bar.
  ///
  /// In en, this message translates to:
  /// **'Added your certificate {name} ({addresses}) from this device.'**
  String smimeAddedFromDevice(String name, String addresses);

  /// Title: offer to trust a certificate authority Loupe doesn’t know.
  ///
  /// In en, this message translates to:
  /// **'Trust “{name}” for Mail?'**
  String smimeTrustUnknownAuthorityTitle(String name);

  /// Under smimeTrustUnknownAuthorityTitle.
  ///
  /// In en, this message translates to:
  /// **'Loupe doesn’t know this certificate authority (a company’s own, perhaps). Trust it to check the certificates it issues. Compare its fingerprint with your IT department first:\n{fingerprint}'**
  String smimeTrustUnknownAuthorityMessage(String fingerprint);

  /// Under a message’s attachments, next to smimeImport.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{A certificate is attached.} other{{count} certificates are attached.}}'**
  String smimeCertificatesAttached(int count);

  /// Button on an opened certificate file.
  ///
  /// In en, this message translates to:
  /// **'Import Certificate'**
  String get smimeImportCertificate;

  /// Title of the dialog asking for a certificate’s passphrase.
  ///
  /// In en, this message translates to:
  /// **'Unlock S/MIME Certificate'**
  String get smimeUnlockTitle;

  /// In the passphrase dialog.
  ///
  /// In en, this message translates to:
  /// **'Enter the passphrase of {name}’s certificate ({addresses}).'**
  String smimeEnterPassphrase(String name, String addresses);

  /// In the passphrase dialog, after a wrong one.
  ///
  /// In en, this message translates to:
  /// **'That passphrase is wrong. Try again.'**
  String get smimeWrongPassphrase;

  /// Button of the passphrase dialog.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get smimeUnlock;

  /// In smimeSetPassphraseTitle’s dialog, when the field is empty.
  ///
  /// In en, this message translates to:
  /// **'Enter a passphrase.'**
  String get smimeEnterAPassphrase;

  /// In smimeSetPassphraseTitle’s dialog.
  ///
  /// In en, this message translates to:
  /// **'The two passphrases differ.'**
  String get smimePassphrasesDiffer;

  /// Title of the dialog that sets a new passphrase.
  ///
  /// In en, this message translates to:
  /// **'Set Passphrase'**
  String get smimeSetPassphraseTitle;

  /// In smimeSetPassphraseTitle’s dialog.
  ///
  /// In en, this message translates to:
  /// **'Loupe will ask for it to sign and decrypt. If you forget it, import the certificate again from its .p12 file.'**
  String get smimeSetPassphraseText;

  /// Placeholder of the second passphrase field: type it again.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get smimePassphraseAgain;

  /// Button of smimeSetPassphraseTitle’s dialog.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get smimeSetPassphraseButton;

  /// In the message’s S/MIME details, and in place of its text, after the passphrase wasn’t given.
  ///
  /// In en, this message translates to:
  /// **'Your S/MIME certificate is locked. Open the message again to unlock it.'**
  String get smimeLockedOpenAgain;

  /// Error.
  ///
  /// In en, this message translates to:
  /// **'This device doesn’t offer its certificates.'**
  String get smimeDeviceHasNoCertificates;

  /// Error.
  ///
  /// In en, this message translates to:
  /// **'Loupe can’t read this certificate.'**
  String get smimeCantReadCertificate;

  /// Error.
  ///
  /// In en, this message translates to:
  /// **'This certificate isn’t for mail: it has no email address, or isn’t meant for signing or encrypting.'**
  String get smimeCertificateNotForMail;

  /// Error about a certificate installed on the phone. “Settings › End-to-End Encryption” names the screen titled openpgpEncryptionTitle: use the same words.
  ///
  /// In en, this message translates to:
  /// **'The certificate isn’t on this device anymore, or Loupe may no longer use it. Choose it again in Settings › End-to-End Encryption.'**
  String get smimeDeviceCertificateGone;

  /// Error.
  ///
  /// In en, this message translates to:
  /// **'The certificate on this device can only be used while Loupe is open.'**
  String get smimeDeviceCertificateAppOnly;

  /// Error.
  ///
  /// In en, this message translates to:
  /// **'The encrypted key is damaged.'**
  String get smimeDeviceKeyDamaged;

  /// Error. reason: Android’s words, in English, or smimeDeviceNotSupported.
  ///
  /// In en, this message translates to:
  /// **'The certificate on this device can’t do this: {reason}.'**
  String smimeDeviceCertificateCantDo(String reason);

  /// The reason in smimeDeviceCertificateCantDo. Lower case.
  ///
  /// In en, this message translates to:
  /// **'not supported'**
  String get smimeDeviceNotSupported;

  /// Error. reason: Android’s words or error code, in English.
  ///
  /// In en, this message translates to:
  /// **'The certificate on this device failed: {reason}.'**
  String smimeDeviceCertificateFailed(String reason);

  /// Why revocation couldn’t be checked: the certificate authority’s address to ask isn’t http or https.
  ///
  /// In en, this message translates to:
  /// **'The authority’s address isn’t a web address.'**
  String get smimeAuthorityNotWebAddress;

  /// Why revocation couldn’t be checked.
  ///
  /// In en, this message translates to:
  /// **'The certificate authority didn’t answer in time.'**
  String get smimeAuthorityTimeout;

  /// Why revocation couldn’t be checked.
  ///
  /// In en, this message translates to:
  /// **'The certificate authority couldn’t be reached.'**
  String get smimeAuthorityUnreachable;

  /// Why revocation couldn’t be checked: the web server’s HTTP status code.
  ///
  /// In en, this message translates to:
  /// **'The certificate authority answered {status}.'**
  String smimeAuthorityStatus(String status);

  /// Why revocation couldn’t be checked.
  ///
  /// In en, this message translates to:
  /// **'The certificate authority’s answer is too large.'**
  String get smimeAuthorityAnswerTooLarge;

  /// Why revocation wasn’t checked.
  ///
  /// In en, this message translates to:
  /// **'Not checked: only certificates from an authority Loupe trusts are checked.'**
  String get smimeRevocationNotChecked;

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
