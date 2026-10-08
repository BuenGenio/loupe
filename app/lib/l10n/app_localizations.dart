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

  /// Snack bar when an action on a message (flag, mark as read, tags) failed for an unknown reason.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get conversationSomethingWentWrong;

  /// Choice in the menu of a long press on Reply: reply to the mailing list's address.
  ///
  /// In en, this message translates to:
  /// **'Reply to List'**
  String get conversationReplyToList;

  /// Short label of a big button in a message's menu, next to Reply, Reply All and Forward: reply to the mailing list.
  ///
  /// In en, this message translates to:
  /// **'Reply List'**
  String get conversationReplyList;

  /// No description provided for @conversationThreadMuted.
  ///
  /// In en, this message translates to:
  /// **'Thread muted. New messages in it arrive read.'**
  String get conversationThreadMuted;

  /// No description provided for @conversationThreadUnmuted.
  ///
  /// In en, this message translates to:
  /// **'Thread unmuted.'**
  String get conversationThreadUnmuted;

  /// No description provided for @conversationLinkFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the link.'**
  String get conversationLinkFailed;

  /// Title of an empty conversation screen: the message is gone.
  ///
  /// In en, this message translates to:
  /// **'No Message'**
  String get conversationGoneTitle;

  /// No description provided for @conversationGoneText.
  ///
  /// In en, this message translates to:
  /// **'This message was moved or deleted.'**
  String get conversationGoneText;

  /// Screen reader label of the icon after a muted thread's subject.
  ///
  /// In en, this message translates to:
  /// **'Muted'**
  String get conversationMuted;

  /// Screen reader label of the “Aa” toolbar button.
  ///
  /// In en, this message translates to:
  /// **'Reader Options'**
  String get conversationReaderOptions;

  /// Screen reader hint of the “Aa” toolbar button: what it changes.
  ///
  /// In en, this message translates to:
  /// **'Text size and view'**
  String get conversationReaderOptionsHint;

  /// Toolbar button: move the conversation to the trash.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get conversationTrash;

  /// Screen reader hint of the Reply toolbar button.
  ///
  /// In en, this message translates to:
  /// **'Long-press for Reply All and Forward'**
  String get conversationReplyHint;

  /// No description provided for @conversationOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re Offline'**
  String get conversationOfflineTitle;

  /// No description provided for @conversationOfflineText.
  ///
  /// In en, this message translates to:
  /// **'This conversation isn\'t downloaded yet. It will load when you\'re back online.'**
  String get conversationOfflineText;

  /// No description provided for @conversationErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Can\'t Show This Message'**
  String get conversationErrorTitle;

  /// Under “Can't Show This Message” when the reason is unknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get conversationErrorText;

  /// Banner above a conversation shown from the phone's copy while there is no connection.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline'**
  String get conversationOfflineBanner;

  /// Banner above a conversation shown from the phone's copy when updating it failed.
  ///
  /// In en, this message translates to:
  /// **'Not updated'**
  String get conversationNotUpdated;

  /// Shown instead of the user's own name as a message's sender or recipient (“to me”). Lower case in English.
  ///
  /// In en, this message translates to:
  /// **'me'**
  String get conversationMe;

  /// Shown in place of the sender's name when a message has none.
  ///
  /// In en, this message translates to:
  /// **'(no sender)'**
  String get conversationNoSender;

  /// Under the sender of a message without recipients, in place of “to …”.
  ///
  /// In en, this message translates to:
  /// **'no recipients'**
  String get conversationNoRecipients;

  /// Under the sender of a message: whom it was sent to. Lower case in English.
  ///
  /// In en, this message translates to:
  /// **'to {names}'**
  String conversationRecipients(String names);

  /// Under the sender of a message with more than two recipients: the first two, and how many more.
  ///
  /// In en, this message translates to:
  /// **'to {names} +{more}'**
  String conversationRecipientsMore(String names, int more);

  /// Label in a message's expanded header, before the sender.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get conversationHeaderFrom;

  /// Label in a message's expanded header, before the recipients.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get conversationHeaderTo;

  /// Label in a message's expanded header, before the copied recipients.
  ///
  /// In en, this message translates to:
  /// **'Cc'**
  String get conversationHeaderCc;

  /// Label in a message's expanded header, before the blind-copied recipients.
  ///
  /// In en, this message translates to:
  /// **'Bcc'**
  String get conversationHeaderBcc;

  /// Label in a message's expanded header, before the address replies go to.
  ///
  /// In en, this message translates to:
  /// **'Reply-To'**
  String get conversationHeaderReplyTo;

  /// Label in a message's expanded header, before the date it was sent.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get conversationHeaderDate;

  /// Label in a message's expanded header, before the sender checks (DKIM, SPF, DMARC).
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get conversationHeaderSecurity;

  /// Tooltip of the seal in a message's expanded header: the server confirmed the sender (DKIM or DMARC).
  ///
  /// In en, this message translates to:
  /// **'Verified sender'**
  String get conversationVerifiedSender;

  /// Tooltip of the warning in a message's expanded header: the server's sender checks failed.
  ///
  /// In en, this message translates to:
  /// **'Unverified sender'**
  String get conversationUnverifiedSender;

  /// Screen reader label of the grey lines shown while a message body loads.
  ///
  /// In en, this message translates to:
  /// **'Loading message'**
  String get conversationLoadingMessage;

  /// No description provided for @conversationBodyError.
  ///
  /// In en, this message translates to:
  /// **'This message couldn\'t be loaded.'**
  String get conversationBodyError;

  /// No description provided for @conversationBodyOffline.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. The message will load when you\'re back online.'**
  String get conversationBodyOffline;

  /// Above a message whose layout the Readable view can't keep. “Original” is the view's name in the “Aa” sheet.
  ///
  /// In en, this message translates to:
  /// **'Looks better in Original view'**
  String get conversationOriginalHint;

  /// Button: switch the message to the Original view.
  ///
  /// In en, this message translates to:
  /// **'Show Original'**
  String get conversationShowOriginal;

  /// Screen reader hint of the conversation's title bar: what a tap does.
  ///
  /// In en, this message translates to:
  /// **'Scroll to the top'**
  String get conversationScrollToTop;

  /// Menu item: opens the tags of the message.
  ///
  /// In en, this message translates to:
  /// **'Tags…'**
  String get conversationTagsMenu;

  /// No description provided for @conversationMuteThread.
  ///
  /// In en, this message translates to:
  /// **'Mute Thread'**
  String get conversationMuteThread;

  /// No description provided for @conversationUnmuteThread.
  ///
  /// In en, this message translates to:
  /// **'Unmute Thread'**
  String get conversationUnmuteThread;

  /// Menu item: asks which folder to move the message to.
  ///
  /// In en, this message translates to:
  /// **'Move…'**
  String get conversationMoveMenu;

  /// Menu item of a message in the trash.
  ///
  /// In en, this message translates to:
  /// **'Delete Permanently'**
  String get conversationDeletePermanently;

  /// No description provided for @conversationMoveToTrash.
  ///
  /// In en, this message translates to:
  /// **'Move to Trash'**
  String get conversationMoveToTrash;

  /// Menu item of a message marked as junk: it isn't.
  ///
  /// In en, this message translates to:
  /// **'Not Junk'**
  String get conversationNotJunk;

  /// No description provided for @conversationShowAllHeaders.
  ///
  /// In en, this message translates to:
  /// **'Show All Headers'**
  String get conversationShowAllHeaders;

  /// Menu item: shows the message's raw text.
  ///
  /// In en, this message translates to:
  /// **'View Source'**
  String get conversationViewSource;

  /// No description provided for @conversationSaveAsFile.
  ///
  /// In en, this message translates to:
  /// **'Save as File…'**
  String get conversationSaveAsFile;

  /// No description provided for @conversationShareAsFile.
  ///
  /// In en, this message translates to:
  /// **'Share as File…'**
  String get conversationShareAsFile;

  /// Menu item: asks whether to search mail from the sender, to the recipient or with the subject.
  ///
  /// In en, this message translates to:
  /// **'Search from This Message…'**
  String get conversationSearchFromMessageMenu;

  /// Switch in the sheet of a tapped address: the person is a VIP (their mail gets a star and its own mailbox).
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get conversationVip;

  /// No description provided for @conversationCopyAddress.
  ///
  /// In en, this message translates to:
  /// **'Copy Address'**
  String get conversationCopyAddress;

  /// No description provided for @conversationAddressCopied.
  ///
  /// In en, this message translates to:
  /// **'Address copied'**
  String get conversationAddressCopied;

  /// In the sheet of a tapped address.
  ///
  /// In en, this message translates to:
  /// **'Search Messages from {name}'**
  String conversationSearchMessagesFrom(String name);

  /// Title of the sheet that tags a message.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get conversationTags;

  /// Title of the sheet with every header field of a message.
  ///
  /// In en, this message translates to:
  /// **'All Headers'**
  String get conversationAllHeaders;

  /// Button (tooltip) that copies all of a message's headers or source.
  ///
  /// In en, this message translates to:
  /// **'Copy All'**
  String get conversationCopyAll;

  /// No description provided for @conversationHeadersCopied.
  ///
  /// In en, this message translates to:
  /// **'Headers copied'**
  String get conversationHeadersCopied;

  /// No description provided for @conversationNoHeaders.
  ///
  /// In en, this message translates to:
  /// **'No headers'**
  String get conversationNoHeaders;

  /// Title of the choices: search mail from the sender, to the recipient or with the subject.
  ///
  /// In en, this message translates to:
  /// **'Search from This Message'**
  String get conversationSearchFromMessageTitle;

  /// Choice under “Search from This Message”: mail from this person.
  ///
  /// In en, this message translates to:
  /// **'From {name}'**
  String conversationSearchFrom(String name);

  /// Choice under “Search from This Message”: mail to this person.
  ///
  /// In en, this message translates to:
  /// **'To {name}'**
  String conversationSearchTo(String name);

  /// Choice under “Search from This Message”: mail with this subject.
  ///
  /// In en, this message translates to:
  /// **'Subject “{subject}”'**
  String conversationSearchSubject(String subject);

  /// Title of the screen with a message's raw text (View Source).
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get conversationSourceTitle;

  /// No description provided for @conversationSourceCopied.
  ///
  /// In en, this message translates to:
  /// **'Source copied'**
  String get conversationSourceCopied;

  /// No description provided for @conversationShareFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t share the message.'**
  String get conversationShareFailed;

  /// Button (tooltip) in View Source: wrap long lines.
  ///
  /// In en, this message translates to:
  /// **'Wrap Lines'**
  String get conversationWrapLines;

  /// Button (tooltip) in View Source: stop wrapping long lines.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Wrap Lines'**
  String get conversationDontWrapLines;

  /// No description provided for @conversationSourceError.
  ///
  /// In en, this message translates to:
  /// **'The source couldn\'t be loaded.'**
  String get conversationSourceError;

  /// Above a very long message source, which is cut for display.
  ///
  /// In en, this message translates to:
  /// **'Showing the first {shown} of {total}. Copy or share to get all of it.'**
  String conversationSourceCut(String shown, String total);

  /// Name of an attachment that has none.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get conversationAttachmentUntitled;

  /// Screen reader label of an attachment's ⋯ button.
  ///
  /// In en, this message translates to:
  /// **'More actions for {name}'**
  String conversationAttachmentMoreActions(String name);

  /// Title of the list of folders to move a message to.
  ///
  /// In en, this message translates to:
  /// **'Move to…'**
  String get conversationMoveTo;

  /// No description provided for @conversationMailboxesError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load mailboxes.'**
  String get conversationMailboxesError;

  /// View of a message in the “Aa” sheet: rebuilt for easy reading.
  ///
  /// In en, this message translates to:
  /// **'Readable'**
  String get conversationReaderReadable;

  /// View of a message in the “Aa” sheet: as the sender designed it.
  ///
  /// In en, this message translates to:
  /// **'Original'**
  String get conversationReaderOriginal;

  /// View of a message in the “Aa” sheet: plain text.
  ///
  /// In en, this message translates to:
  /// **'Plain'**
  String get conversationReaderPlain;

  /// Font of the Plain view in the “Aa” sheet: sans-serif.
  ///
  /// In en, this message translates to:
  /// **'Sans'**
  String get conversationReaderSans;

  /// Font of the Plain view in the “Aa” sheet: monospace.
  ///
  /// In en, this message translates to:
  /// **'Mono'**
  String get conversationReaderMono;

  /// Switch in the “Aa” sheet: the Readable view keeps the message's colours.
  ///
  /// In en, this message translates to:
  /// **'Keep original colours'**
  String get conversationReaderKeepColours;

  /// Switch in the “Aa” sheet: use these settings for this sender's mail from now on.
  ///
  /// In en, this message translates to:
  /// **'Remember for this sender'**
  String get conversationReaderRemember;

  /// Red label next to the sender: the message is likely phishing.
  ///
  /// In en, this message translates to:
  /// **'Possible phishing'**
  String get conversationSecurityPossiblePhishing;

  /// Amber label next to the sender: something about the message deserves a second look.
  ///
  /// In en, this message translates to:
  /// **'Be careful'**
  String get conversationSecurityBeCareful;

  /// Screen reader label of the green seal next to the sender: the sender is confirmed and nothing looks wrong.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get conversationSecurityVerified;

  /// Result of the phishing check: nothing suspicious. Title of its sheet.
  ///
  /// In en, this message translates to:
  /// **'No issues found'**
  String get conversationSecurityNoIssues;

  /// Screen reader label of the shield next to the sender: tracking pixels and click trackers found.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 tracker} other{{count} trackers}}'**
  String conversationSecurityTrackers(int count);

  /// Screen reader hint of the security label next to the sender: a tap explains it.
  ///
  /// In en, this message translates to:
  /// **'Shows why'**
  String get conversationSecurityBadgeHint;

  /// No description provided for @conversationPhishingBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'This message looks like phishing'**
  String get conversationPhishingBannerTitle;

  /// Under “This message looks like phishing”, with the strongest sign first.
  ///
  /// In en, this message translates to:
  /// **'{reason}. Links and images are turned off.'**
  String conversationPhishingBannerReason(String reason);

  /// Under “This message looks like phishing”.
  ///
  /// In en, this message translates to:
  /// **'Links and images are turned off.'**
  String get conversationPhishingBannerText;

  /// Button in the phishing warning: explains it.
  ///
  /// In en, this message translates to:
  /// **'Why?'**
  String get conversationPhishingWhy;

  /// Button in the phishing warning: shows the message's links and images after all.
  ///
  /// In en, this message translates to:
  /// **'Show Anyway'**
  String get conversationPhishingShowAnyway;

  /// No description provided for @conversationSecurityPhishingTitle.
  ///
  /// In en, this message translates to:
  /// **'This looks like phishing'**
  String get conversationSecurityPhishingTitle;

  /// No description provided for @conversationSecurityPhishingText.
  ///
  /// In en, this message translates to:
  /// **'Several signs say this message isn\'t what it claims to be.'**
  String get conversationSecurityPhishingText;

  /// No description provided for @conversationSecurityCarefulTitle.
  ///
  /// In en, this message translates to:
  /// **'Be careful with this message'**
  String get conversationSecurityCarefulTitle;

  /// No description provided for @conversationSecurityCarefulText.
  ///
  /// In en, this message translates to:
  /// **'Something about it deserves a second look.'**
  String get conversationSecurityCarefulText;

  /// No description provided for @conversationSecurityVerifiedText.
  ///
  /// In en, this message translates to:
  /// **'The sender is verified and nothing looks suspicious.'**
  String get conversationSecurityVerifiedText;

  /// No description provided for @conversationSecurityUnverifiedText.
  ///
  /// In en, this message translates to:
  /// **'Nothing looks suspicious. Your mail server didn\'t say whether the sender is verified.'**
  String get conversationSecurityUnverifiedText;

  /// No description provided for @conversationSecurityNothingSuspicious.
  ///
  /// In en, this message translates to:
  /// **'Nothing looks suspicious.'**
  String get conversationSecurityNothingSuspicious;

  /// Header of the reasons in the security sheet. Shown in capitals.
  ///
  /// In en, this message translates to:
  /// **'Why'**
  String get conversationSecurityWhy;

  /// Header of the tracking report in the security sheet. Shown in capitals.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get conversationSecurityPrivacy;

  /// No description provided for @conversationSecurityNoTrackingPixels.
  ///
  /// In en, this message translates to:
  /// **'No tracking pixels'**
  String get conversationSecurityNoTrackingPixels;

  /// No description provided for @conversationSecurityTrackingPixels.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 tracking pixel removed} other{{count} tracking pixels removed}}'**
  String conversationSecurityTrackingPixels(int count);

  /// No description provided for @conversationSecurityTrackingPixelsText.
  ///
  /// In en, this message translates to:
  /// **'They would have told the sender when you opened this message.'**
  String get conversationSecurityTrackingPixelsText;

  /// No description provided for @conversationSecurityNoRemoteImages.
  ///
  /// In en, this message translates to:
  /// **'No remote images'**
  String get conversationSecurityNoRemoteImages;

  /// Images the message loads from the internet (blocked until the user allows them).
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 remote image} other{{count} remote images}}'**
  String conversationSecurityRemoteImages(int count);

  /// No description provided for @conversationSecurityRemoteImagesText.
  ///
  /// In en, this message translates to:
  /// **'Loading them tells the sender when you read this message, and your IP address.'**
  String get conversationSecurityRemoteImagesText;

  /// No description provided for @conversationSecurityNoClickTracking.
  ///
  /// In en, this message translates to:
  /// **'No click tracking'**
  String get conversationSecurityNoClickTracking;

  /// No description provided for @conversationSecurityTrackedLinks.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 link through click trackers} other{{count} links through click trackers}}'**
  String conversationSecurityTrackedLinks(int count);

  /// No description provided for @conversationSecurityTrackedLinksText.
  ///
  /// In en, this message translates to:
  /// **'{services} would record your click. Long-press a link to open its destination directly.'**
  String conversationSecurityTrackedLinksText(String services);

  /// No description provided for @conversationSecurityTechnicalDetails.
  ///
  /// In en, this message translates to:
  /// **'Technical Details'**
  String get conversationSecurityTechnicalDetails;

  /// No description provided for @conversationSecurityCheckedLocally.
  ///
  /// In en, this message translates to:
  /// **'Checked on this device. Nothing was sent anywhere.'**
  String get conversationSecurityCheckedLocally;

  /// Label in the security sheet's technical details, before the tracking pixels' hosts.
  ///
  /// In en, this message translates to:
  /// **'Trackers'**
  String get conversationSecurityTrackersLabel;

  /// Label in the security sheet's technical details, before the hosts the remote images come from.
  ///
  /// In en, this message translates to:
  /// **'Images from'**
  String get conversationSecurityImagesFrom;

  /// Label in the security sheet's technical details, before conversationSecuritySenderHistoryValue.
  ///
  /// In en, this message translates to:
  /// **'Sender history'**
  String get conversationSecuritySenderHistory;

  /// How many messages the user got from the sender and sent to them. Terse, like “received: 12, sent: 2”.
  ///
  /// In en, this message translates to:
  /// **'{received} received, {sent} sent'**
  String conversationSecuritySenderHistoryValue(int received, int sent);

  /// Label in the security sheet's technical details, before the hosts the message's links open.
  ///
  /// In en, this message translates to:
  /// **'Links lead to'**
  String get conversationSecurityLinksLeadTo;

  /// Label in the security sheet's technical details, before conversationSecurityHiddenValue: invisible parts removed from the message.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get conversationSecurityHidden;

  /// Invisible HTML elements removed from the message, and the characters of text in them.
  ///
  /// In en, this message translates to:
  /// **'{elements, plural, other{{elements} elements}}, {characters, plural, other{{characters} characters}}'**
  String conversationSecurityHiddenValue(int elements, int characters);

  /// No description provided for @conversationSecurityAuthFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sender not verified'**
  String get conversationSecurityAuthFailedTitle;

  /// No description provided for @conversationSecurityAuthFailedText.
  ///
  /// In en, this message translates to:
  /// **'Your mail server couldn\'t confirm that this message really comes from {domain}.'**
  String conversationSecurityAuthFailedText(String domain);

  /// No description provided for @conversationSecurityAuthFailedTextNoDomain.
  ///
  /// In en, this message translates to:
  /// **'Your mail server couldn\'t confirm that this message really comes from its sender.'**
  String get conversationSecurityAuthFailedTextNoDomain;

  /// No description provided for @conversationSecurityAuthFailedListText.
  ///
  /// In en, this message translates to:
  /// **'Your mail server couldn\'t confirm that this message comes from {domain}. Common for mailing lists.'**
  String conversationSecurityAuthFailedListText(String domain);

  /// No description provided for @conversationSecurityAuthFailedListTextNoDomain.
  ///
  /// In en, this message translates to:
  /// **'Your mail server couldn\'t confirm that this message comes from its sender. Common for mailing lists.'**
  String get conversationSecurityAuthFailedListTextNoDomain;

  /// No description provided for @conversationSecurityAuthFailedAdvice.
  ///
  /// In en, this message translates to:
  /// **'Don\'t act on it unless you expected it. If in doubt, contact the sender another way.'**
  String get conversationSecurityAuthFailedAdvice;

  /// No description provided for @conversationSecurityAuthUnalignedTitle.
  ///
  /// In en, this message translates to:
  /// **'Signed by another domain'**
  String get conversationSecurityAuthUnalignedTitle;

  /// No description provided for @conversationSecurityAuthUnalignedText.
  ///
  /// In en, this message translates to:
  /// **'The message is signed by {signer}, not {domain}. Mailing services do this, but it doesn\'t prove who wrote it.'**
  String conversationSecurityAuthUnalignedText(String signer, String domain);

  /// No description provided for @conversationSecurityAuthUnalignedTextNoSigner.
  ///
  /// In en, this message translates to:
  /// **'The message is signed by another domain, not {domain}. Mailing services do this, but it doesn\'t prove who wrote it.'**
  String conversationSecurityAuthUnalignedTextNoSigner(String domain);

  /// No description provided for @conversationSecurityNameShowsAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Name shows a different address'**
  String get conversationSecurityNameShowsAddressTitle;

  /// No description provided for @conversationSecurityNameShowsAddressText.
  ///
  /// In en, this message translates to:
  /// **'The sender\'s name reads “{shown}”, but the message comes from {email}.'**
  String conversationSecurityNameShowsAddressText(String shown, String email);

  /// No description provided for @conversationSecurityNameShowsAddressAdvice.
  ///
  /// In en, this message translates to:
  /// **'Trust the address, not the name.'**
  String get conversationSecurityNameShowsAddressAdvice;

  /// No description provided for @conversationSecurityReplyToTitle.
  ///
  /// In en, this message translates to:
  /// **'Replies go elsewhere'**
  String get conversationSecurityReplyToTitle;

  /// No description provided for @conversationSecurityReplyToText.
  ///
  /// In en, this message translates to:
  /// **'Replying would send your answer to {address}, not to {domain}.'**
  String conversationSecurityReplyToText(String address, String domain);

  /// No description provided for @conversationSecurityReplyToAdvice.
  ///
  /// In en, this message translates to:
  /// **'Check the address before you reply with anything personal.'**
  String get conversationSecurityReplyToAdvice;

  /// No description provided for @conversationSecurityImpersonationYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Uses your name'**
  String get conversationSecurityImpersonationYouTitle;

  /// No description provided for @conversationSecurityImpersonationTitle.
  ///
  /// In en, this message translates to:
  /// **'Uses the name of someone you know'**
  String get conversationSecurityImpersonationTitle;

  /// No description provided for @conversationSecurityImpersonationYouText.
  ///
  /// In en, this message translates to:
  /// **'It is signed “{name}”, like your own name, but comes from a new address: {email}.'**
  String conversationSecurityImpersonationYouText(String name, String email);

  /// A VIP is a person whose mail gets a star and its own mailbox.
  ///
  /// In en, this message translates to:
  /// **'It is signed “{name}”, like your VIP {knownName} ({knownEmail}), but comes from a new address: {email}.'**
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email);

  /// No description provided for @conversationSecurityImpersonationText.
  ///
  /// In en, this message translates to:
  /// **'It is signed “{name}”, like {knownName} ({knownEmail}), but comes from a new address: {email}.'**
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email);

  /// Follows the explanation of a borrowed name, after a space.
  ///
  /// In en, this message translates to:
  /// **'And replies would go to yet another address.'**
  String get conversationSecurityImpersonationRepliesElsewhere;

  /// No description provided for @conversationSecurityImpersonationAdvice.
  ///
  /// In en, this message translates to:
  /// **'If it asks for money, codes or files, check with them another way first.'**
  String get conversationSecurityImpersonationAdvice;

  /// Technical detail: the address the user knows the person by.
  ///
  /// In en, this message translates to:
  /// **'Known address: {address}'**
  String conversationSecurityKnownAddress(String address);

  /// Technical detail: the address the message comes from.
  ///
  /// In en, this message translates to:
  /// **'This address: {address}'**
  String conversationSecurityThisAddress(String address);

  /// No description provided for @conversationSecurityFirstTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'First message from this sender'**
  String get conversationSecurityFirstTimeTitle;

  /// No description provided for @conversationSecurityFirstTimeText.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t had mail from {email} before.'**
  String conversationSecurityFirstTimeText(String email);

  /// No description provided for @conversationSecurityFirstTimeAdvice.
  ///
  /// In en, this message translates to:
  /// **'Be careful with requests from people you don\'t know yet.'**
  String get conversationSecurityFirstTimeAdvice;

  /// No description provided for @conversationSecuritySenderHomographTitle.
  ///
  /// In en, this message translates to:
  /// **'Look-alike letters in the sender\'s address'**
  String get conversationSecuritySenderHomographTitle;

  /// No description provided for @conversationSecurityLinkHomographTitle.
  ///
  /// In en, this message translates to:
  /// **'Look-alike letters in a link'**
  String get conversationSecurityLinkHomographTitle;

  /// No description provided for @conversationSecurityHomographText.
  ///
  /// In en, this message translates to:
  /// **'{host} mixes letters from different alphabets to imitate another address.'**
  String conversationSecurityHomographText(String host);

  /// No description provided for @conversationSecurityHomographImitatesText.
  ///
  /// In en, this message translates to:
  /// **'{host} uses look-alike letters: it is not {real}.'**
  String conversationSecurityHomographImitatesText(String host, String real);

  /// No description provided for @conversationSecuritySenderHomographAdvice.
  ///
  /// In en, this message translates to:
  /// **'Delete it or report it as junk.'**
  String get conversationSecuritySenderHomographAdvice;

  /// No description provided for @conversationSecurityLinkHomographAdvice.
  ///
  /// In en, this message translates to:
  /// **'Don\'t open it.'**
  String get conversationSecurityLinkHomographAdvice;

  /// Technical detail: the sender's domain as written (international letters encoded).
  ///
  /// In en, this message translates to:
  /// **'Domain: {domain}'**
  String conversationSecurityDomainDetail(String domain);

  /// No description provided for @conversationSecurityLookalikeTitle.
  ///
  /// In en, this message translates to:
  /// **'Look-alike domain'**
  String get conversationSecurityLookalikeTitle;

  /// No description provided for @conversationSecurityFamiliarNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Uses a familiar name in its domain'**
  String get conversationSecurityFamiliarNameTitle;

  /// No description provided for @conversationSecurityLookalikeOwnText.
  ///
  /// In en, this message translates to:
  /// **'{domain} looks like your own domain, {real}, but it is a different domain.'**
  String conversationSecurityLookalikeOwnText(String domain, String real);

  /// No description provided for @conversationSecurityLookalikeText.
  ///
  /// In en, this message translates to:
  /// **'{domain} looks like {brand} ({real}), but it is a different domain.'**
  String conversationSecurityLookalikeText(String domain, String brand, String real);

  /// No description provided for @conversationSecurityFamiliarNameOwnText.
  ///
  /// In en, this message translates to:
  /// **'{domain} uses the name of your own domain, {real}, but doesn\'t belong to it.'**
  String conversationSecurityFamiliarNameOwnText(String domain, String real);

  /// No description provided for @conversationSecurityFamiliarNameText.
  ///
  /// In en, this message translates to:
  /// **'{domain} uses the name of {brand} ({real}), but doesn\'t belong to it.'**
  String conversationSecurityFamiliarNameText(String domain, String brand, String real);

  /// No description provided for @conversationSecurityLookalikeOwnAdvice.
  ///
  /// In en, this message translates to:
  /// **'Real messages from your organisation come from {real}.'**
  String conversationSecurityLookalikeOwnAdvice(String real);

  /// No description provided for @conversationSecurityLookalikeAdvice.
  ///
  /// In en, this message translates to:
  /// **'Real messages from {brand} come from {real}.'**
  String conversationSecurityLookalikeAdvice(String brand, String real);

  /// Technical detail of a look-alike domain.
  ///
  /// In en, this message translates to:
  /// **'Sender domain: {domain}'**
  String conversationSecuritySenderDomain(String domain);

  /// Technical detail of a look-alike domain: the real domain it imitates.
  ///
  /// In en, this message translates to:
  /// **'Imitates: {domain}'**
  String conversationSecurityImitates(String domain);

  /// No description provided for @conversationSecurityLinkMismatchTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{A link hides where it goes} other{{count} links hide where they go}}'**
  String conversationSecurityLinkMismatchTitle(int count);

  /// No description provided for @conversationSecurityLinkMismatchText.
  ///
  /// In en, this message translates to:
  /// **'A link shows {shown}, but it opens {host}.'**
  String conversationSecurityLinkMismatchText(String shown, String host);

  /// No description provided for @conversationSecurityLinkMismatchAdvice.
  ///
  /// In en, this message translates to:
  /// **'Don\'t sign in or pay through these links. Type the address yourself instead.'**
  String get conversationSecurityLinkMismatchAdvice;

  /// Technical detail: a link's text and where it really goes.
  ///
  /// In en, this message translates to:
  /// **'“{text}” → {url}'**
  String conversationSecurityLinkDetail(String text, String url);

  /// No description provided for @conversationSecurityLinkUncheckableTitle.
  ///
  /// In en, this message translates to:
  /// **'A link\'s destination can\'t be checked'**
  String get conversationSecurityLinkUncheckableTitle;

  /// No description provided for @conversationSecurityLinkUncheckableText.
  ///
  /// In en, this message translates to:
  /// **'A link shows {shown}, but goes through {host}, which records the click before passing it on.'**
  String conversationSecurityLinkUncheckableText(String shown, String host);

  /// No description provided for @conversationSecurityIpAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'A link points to a bare IP address'**
  String get conversationSecurityIpAddressTitle;

  /// No description provided for @conversationSecurityIpAddressText.
  ///
  /// In en, this message translates to:
  /// **'{hosts} isn\'t a named website. Real companies rarely link like this.'**
  String conversationSecurityIpAddressText(String hosts);

  /// No description provided for @conversationSecurityUserInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'A disguised link'**
  String get conversationSecurityUserInfoTitle;

  /// No description provided for @conversationSecurityUserInfoText.
  ///
  /// In en, this message translates to:
  /// **'A link starts with “{shown}@” to look like {shown}, but it opens {host}.'**
  String conversationSecurityUserInfoText(String shown, String host);

  /// No description provided for @conversationSecurityDataLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'A hidden page was disabled'**
  String get conversationSecurityDataLinkTitle;

  /// No description provided for @conversationSecurityDataLinkText.
  ///
  /// In en, this message translates to:
  /// **'A link would have opened a page packed inside the message, a way around link checks.'**
  String get conversationSecurityDataLinkText;

  /// No description provided for @conversationSecurityPasswordFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Asks for a password'**
  String get conversationSecurityPasswordFieldTitle;

  /// No description provided for @conversationSecurityPasswordFieldText.
  ///
  /// In en, this message translates to:
  /// **'The message contained a password field. Loupe removed it.'**
  String get conversationSecurityPasswordFieldText;

  /// No description provided for @conversationSecurityPasswordFieldAdvice.
  ///
  /// In en, this message translates to:
  /// **'Never type a password into an email.'**
  String get conversationSecurityPasswordFieldAdvice;

  /// No description provided for @conversationSecurityScriptLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'A link that runs code was disabled'**
  String get conversationSecurityScriptLinkTitle;

  /// No description provided for @conversationSecurityScriptLinkText.
  ///
  /// In en, this message translates to:
  /// **'Loupe never runs code from messages.'**
  String get conversationSecurityScriptLinkText;

  /// No description provided for @conversationSecurityShortenerTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{A shortened link} other{Shortened links}}'**
  String conversationSecurityShortenerTitle(int count);

  /// No description provided for @conversationSecurityShortenerText.
  ///
  /// In en, this message translates to:
  /// **'{hosts} hides the real destination until you open it.'**
  String conversationSecurityShortenerText(String hosts);

  /// No description provided for @conversationSecurityInternationalTitle.
  ///
  /// In en, this message translates to:
  /// **'International web address'**
  String get conversationSecurityInternationalTitle;

  /// No description provided for @conversationSecurityInternationalText.
  ///
  /// In en, this message translates to:
  /// **'{hosts} uses non-Latin letters. Normal for many languages; check it is the site you expect.'**
  String conversationSecurityInternationalText(String hosts);

  /// No description provided for @conversationSecurityLotsOfHiddenTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Lots of hidden text'**
  String get conversationSecurityLotsOfHiddenTextTitle;

  /// No description provided for @conversationSecurityLotsOfHiddenTextText.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} characters of invisible text were removed. Hidden text like this is meant to fool spam filters.}}'**
  String conversationSecurityLotsOfHiddenTextText(int count);

  /// No description provided for @conversationSecurityHiddenTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Hidden text removed'**
  String get conversationSecurityHiddenTextTitle;

  /// No description provided for @conversationSecurityHiddenTextText.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} characters of invisible text were removed.}}'**
  String conversationSecurityHiddenTextText(int count);

  /// No description provided for @exportDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t download the message. Check the connection and try again.'**
  String get exportDownloadFailed;

  /// Snack bar after saving a message or a folder as a file.
  ///
  /// In en, this message translates to:
  /// **'Saved “{name}”'**
  String exportSaved(String name);

  /// No description provided for @exportSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the message.'**
  String get exportSaveFailed;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t export “{folder}”.'**
  String exportFailed(String folder);

  /// No description provided for @exportEmpty.
  ///
  /// In en, this message translates to:
  /// **'“{folder}” has no messages to export.'**
  String exportEmpty(String folder);

  /// No description provided for @exportNothingDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t export “{folder}”: no message could be downloaded. Check the connection and try again.'**
  String exportNothingDownloaded(String folder);

  /// Snack bar after exporting a folder that had messages that couldn't be downloaded. formattedCount is count with the language's digit grouping.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Saved “{name}” without 1 message that couldn\'t be downloaded.} other{Saved “{name}” without {formattedCount} messages that couldn\'t be downloaded.}}'**
  String exportSavedWithout(int count, String formattedCount, String name);

  /// No description provided for @exportSaveFileFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save “{name}”.'**
  String exportSaveFileFailed(String name);

  /// Title of the sheet while a folder is exported.
  ///
  /// In en, this message translates to:
  /// **'Exporting “{folder}”'**
  String exportTitle(String folder);

  /// While an export lists the folder's messages.
  ///
  /// In en, this message translates to:
  /// **'Finding messages…'**
  String get exportListing;

  /// While a folder is exported: the message being downloaded.
  ///
  /// In en, this message translates to:
  /// **'Exporting {current} of {total}…'**
  String exportProgress(String current, String total);

  /// Under an export's progress. formattedCount is count with the language's digit grouping.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 message couldn\'t be downloaded} other{{formattedCount} messages couldn\'t be downloaded}}'**
  String exportFailedCount(int count, String formattedCount);

  /// Title of the first screen: every mailbox and folder.
  ///
  /// In en, this message translates to:
  /// **'Mailboxes'**
  String get mailboxesTitle;

  /// Screen reader label of a mailbox's check mark while editing Mailboxes: it is shown.
  ///
  /// In en, this message translates to:
  /// **'Shown'**
  String get mailboxesShown;

  /// Screen reader label of a mailbox's empty circle while editing Mailboxes: it is hidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get mailboxesHidden;

  /// Screen reader label of the arrow of a folder with subfolders.
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get mailboxesCollapse;

  /// Screen reader label of the arrow of a folder with subfolders.
  ///
  /// In en, this message translates to:
  /// **'Expand'**
  String get mailboxesExpand;

  /// Screen reader label of the ⓘ button on the VIP mailbox.
  ///
  /// In en, this message translates to:
  /// **'Manage VIPs'**
  String get mailboxesManageVips;

  /// Row on Mailboxes: newsletters and mailing lists.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get mailboxesSubscriptions;

  /// Screen reader label of a collapsed account's arrow on Mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Show {account}'**
  String mailboxesShowAccount(String account);

  /// Screen reader label of an account's arrow on Mailboxes: hides its folders.
  ///
  /// In en, this message translates to:
  /// **'Hide {account}'**
  String mailboxesHideAccount(String account);

  /// Menu item of a folder: saves all its messages as one mbox file.
  ///
  /// In en, this message translates to:
  /// **'Export Folder…'**
  String get mailboxesExportFolder;

  /// Screen reader label of the button that takes a mailing list off Mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Unpin'**
  String get mailboxesUnpin;

  /// Header of the mailing lists pinned on Mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get mailboxesLists;

  /// Header of the saved searches on Mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Smart Mailboxes'**
  String get mailboxesSmartMailboxes;

  /// No description provided for @mailboxesSmartMailboxesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Save a search to keep it here.'**
  String get mailboxesSmartMailboxesEmpty;

  /// Header of the tags on Mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get mailboxesTags;

  /// Title of the list of VIPs: people whose mail gets a star and its own mailbox.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get mailboxesVipTitle;

  /// No description provided for @mailboxesVipFooter.
  ///
  /// In en, this message translates to:
  /// **'You can also tap a sender’s name in a message and turn on VIP.'**
  String get mailboxesVipFooter;

  /// Row at the end of the VIP list: asks for an address.
  ///
  /// In en, this message translates to:
  /// **'Add VIP…'**
  String get mailboxesAddVip;

  /// Title of the dialog that asks for a VIP's address.
  ///
  /// In en, this message translates to:
  /// **'Add VIP'**
  String get mailboxesAddVipTitle;

  /// No description provided for @mailboxesAddVipText.
  ///
  /// In en, this message translates to:
  /// **'Mail from this address gets a star and appears in the VIP mailbox.'**
  String get mailboxesAddVipText;

  /// Example in the empty address field of “Add VIP”. Keep example.com.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get mailboxesAddVipPlaceholder;

  /// Filter of a message list: unread messages.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get messageListFilterUnread;

  /// Filter of a message list: flagged messages.
  ///
  /// In en, this message translates to:
  /// **'Flagged'**
  String get messageListFilterFlagged;

  /// Filter of a message list: messages addressed to the user.
  ///
  /// In en, this message translates to:
  /// **'To: Me'**
  String get messageListFilterToMe;

  /// Filter of a message list: messages with the user in Cc.
  ///
  /// In en, this message translates to:
  /// **'CC: Me'**
  String get messageListFilterCcMe;

  /// Filter of a message list.
  ///
  /// In en, this message translates to:
  /// **'With Attachments'**
  String get messageListFilterWithAttachments;

  /// Filter of a message list: messages the user hasn't answered.
  ///
  /// In en, this message translates to:
  /// **'Unreplied'**
  String get messageListFilterUnreplied;

  /// Filter of a message list: messages from VIPs (people whose mail gets a star).
  ///
  /// In en, this message translates to:
  /// **'From VIPs'**
  String get messageListFilterFromVips;

  /// No description provided for @messageListMarkedRead.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Marked 1 message as read} other{Marked {count} messages as read}}'**
  String messageListMarkedRead(int count);

  /// No description provided for @messageListLoadOlderFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t load older mail.'**
  String get messageListLoadOlderFailed;

  /// Title of a message list while selecting, before anything is selected.
  ///
  /// In en, this message translates to:
  /// **'Select Messages'**
  String get messageListSelectMessages;

  /// Title of a message list while selecting: how many conversations are selected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} Selected}}'**
  String messageListSelected(int count);

  /// No description provided for @messageListSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get messageListSelectAll;

  /// No description provided for @messageListDeselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get messageListDeselectAll;

  /// No description provided for @messageListLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t Load Mail'**
  String get messageListLoadFailed;

  /// Empty message list with the Unread filter on.
  ///
  /// In en, this message translates to:
  /// **'No Unread Mail'**
  String get messageListNoUnread;

  /// Empty message list with filters on.
  ///
  /// In en, this message translates to:
  /// **'No Matching Mail'**
  String get messageListNoMatches;

  /// Under “No Matching Mail”: the filters that are on.
  ///
  /// In en, this message translates to:
  /// **'Filtered by: {filters}'**
  String messageListFilteredByDetail(String filters);

  /// No description provided for @messageListTurnOffFilter.
  ///
  /// In en, this message translates to:
  /// **'Turn Off Filter'**
  String get messageListTurnOffFilter;

  /// An empty message list.
  ///
  /// In en, this message translates to:
  /// **'No Mail'**
  String get messageListEmpty;

  /// Toolbar button (tooltip) of a message list: shows only messages that match the filters.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get messageListFilter;

  /// Screen reader label of the filters in the toolbar; a tap changes them.
  ///
  /// In en, this message translates to:
  /// **'Filter criteria: {filters}'**
  String messageListFilterCriteria(String filters);

  /// In the toolbar of a message list, above the filters that are on.
  ///
  /// In en, this message translates to:
  /// **'Filtered by:'**
  String get messageListFilteredBy;

  /// In the toolbar of a message list. formattedCount is count with the language's digit grouping.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{formattedCount} Unread}}'**
  String messageListUnreadCount(int count, String formattedCount);

  /// Toolbar button while selecting: asks whether to mark as read, flag, snooze or move to junk.
  ///
  /// In en, this message translates to:
  /// **'Mark'**
  String get messageListMark;

  /// Toolbar button while selecting: moves the selection to the trash.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get messageListTrash;

  /// Title of the sheet that chooses the filters of message lists.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get messageListFilterTitle;

  /// Header of the filters in the Filter sheet, in capitals: show messages that match these.
  ///
  /// In en, this message translates to:
  /// **'INCLUDE'**
  String get messageListFilterInclude;

  /// Button (tooltip) on wide screens: hides the column of mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Hide Mailboxes'**
  String get panesHideMailboxes;

  /// Button (tooltip) on wide screens: shows the column of mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Show Mailboxes'**
  String get panesShowMailboxes;

  /// Screen reader label of the divider that resizes the column of mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Mailboxes width'**
  String get panesMailboxesWidth;

  /// Screen reader label of the divider that resizes the message list.
  ///
  /// In en, this message translates to:
  /// **'Message list width'**
  String get panesListWidth;

  /// Empty conversation column on wide screens.
  ///
  /// In en, this message translates to:
  /// **'No Message Selected'**
  String get panesNoMessageSelected;

  /// Follows the finger while dragging several conversations to a mailbox.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Message} other{{count} Messages}}'**
  String panesDragCount(int count);

  /// The mailbox of snoozed messages: its row on Mailboxes and its title.
  ///
  /// In en, this message translates to:
  /// **'Snoozed'**
  String get snoozeTitle;

  /// Title of the sheet that asks when a message should come back.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get snoozeSheetTitle;

  /// No description provided for @snoozeLaterToday.
  ///
  /// In en, this message translates to:
  /// **'Later Today'**
  String get snoozeLaterToday;

  /// No description provided for @snoozeThisEvening.
  ///
  /// In en, this message translates to:
  /// **'This Evening'**
  String get snoozeThisEvening;

  /// Snooze choice: tomorrow morning.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get snoozeTomorrow;

  /// No description provided for @snoozeThisWeekend.
  ///
  /// In en, this message translates to:
  /// **'This Weekend'**
  String get snoozeThisWeekend;

  /// Snooze choice: next Monday morning.
  ///
  /// In en, this message translates to:
  /// **'Next Week'**
  String get snoozeNextWeek;

  /// No description provided for @snoozePickDateTime.
  ///
  /// In en, this message translates to:
  /// **'Pick Date & Time…'**
  String get snoozePickDateTime;

  /// Menu item: asks when the message should come back.
  ///
  /// In en, this message translates to:
  /// **'Snooze…'**
  String get snoozeMenu;

  /// Action on a snoozed message: bring it back to the Inbox now.
  ///
  /// In en, this message translates to:
  /// **'Wake Now'**
  String get snoozeWakeNow;

  /// Menu item of a snoozed message: asks for another time.
  ///
  /// In en, this message translates to:
  /// **'Change Snooze Time…'**
  String get snoozeChangeTimeMenu;

  /// Swipe action on a snoozed message: asks for another time.
  ///
  /// In en, this message translates to:
  /// **'Change Time'**
  String get snoozeChangeTime;

  /// In place of the time a snoozed message comes back, when it has none.
  ///
  /// In en, this message translates to:
  /// **'No time set'**
  String get snoozeNoTime;

  /// No description provided for @snoozeFooter.
  ///
  /// In en, this message translates to:
  /// **'Snoozed messages come back to the Inbox, unread, at their time.'**
  String get snoozeFooter;

  /// No description provided for @snoozeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing Snoozed'**
  String get snoozeEmptyTitle;

  /// No description provided for @snoozeEmptyText.
  ///
  /// In en, this message translates to:
  /// **'Snooze a message to have it come back to the Inbox when you need it.'**
  String get snoozeEmptyText;

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

  /// Title of the screen shown instead of the app when the mail database can't be opened.
  ///
  /// In en, this message translates to:
  /// **'Your accounts couldn’t be opened'**
  String get appLiveGateTitle;

  /// No description provided for @appLiveGateUnavailableBuild.
  ///
  /// In en, this message translates to:
  /// **'Real accounts aren’t available in this build yet.'**
  String get appLiveGateUnavailableBuild;

  /// No description provided for @appLiveGateKeyUnreadable.
  ///
  /// In en, this message translates to:
  /// **'Loupe couldn’t read the key that protects your mail on this phone. This is often temporary: try again, or restart the phone.'**
  String get appLiveGateKeyUnreadable;

  /// No description provided for @appLiveGateKeyMissing.
  ///
  /// In en, this message translates to:
  /// **'The key that protects your mail on this phone is gone, which can happen after restoring a backup. Your mail is still on the server.'**
  String get appLiveGateKeyMissing;

  /// No description provided for @appLiveGateDatabaseDamaged.
  ///
  /// In en, this message translates to:
  /// **'The mail database on this phone can’t be read: it is damaged, or its key changed. Your mail is still on the server.'**
  String get appLiveGateDatabaseDamaged;

  /// Fallback explanation on the database error screen. The placeholder is the technical name of the error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while opening your accounts ({error}).'**
  String appLiveGateUnknownError(String error);

  /// No description provided for @appLiveGateResetWarning.
  ///
  /// In en, this message translates to:
  /// **'This deletes your accounts and the mail stored on this phone, including messages waiting in the Outbox. Mail on your servers is not affected; add your accounts again afterwards.'**
  String get appLiveGateResetWarning;

  /// Button: confirms deleting the accounts and mail stored on this phone.
  ///
  /// In en, this message translates to:
  /// **'Delete and Start Over'**
  String get appLiveGateDeleteAndStartOver;

  /// Button on the database error screen: opens the demo mailbox instead.
  ///
  /// In en, this message translates to:
  /// **'Use Demo Mail'**
  String get appLiveGateUseDemo;

  /// Button on the database error screen; asks for confirmation next.
  ///
  /// In en, this message translates to:
  /// **'Reset Mail on This Phone…'**
  String get appLiveGateReset;

  /// Title of an attachment that has no file name.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get attachmentsUntitled;

  /// Name shown on the details card of an attachment that has no file name.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get attachmentsUntitledFile;

  /// Button and menu item: hands the attachment to another app.
  ///
  /// In en, this message translates to:
  /// **'Open in…'**
  String get attachmentsOpenIn;

  /// Menu item: saves the attachment to the device's files (Downloads by default).
  ///
  /// In en, this message translates to:
  /// **'Save to Files'**
  String get attachmentsSaveToFiles;

  /// Menu item: opens the share sheet for the attachment.
  ///
  /// In en, this message translates to:
  /// **'Share…'**
  String get attachmentsShareMenu;

  /// No description provided for @attachmentsDownloadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t download the attachment. Check the connection and try again.'**
  String get attachmentsDownloadError;

  /// No description provided for @attachmentsShareError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t share the attachment.'**
  String get attachmentsShareError;

  /// Snack bar after Open in… found no app.
  ///
  /// In en, this message translates to:
  /// **'No app on this device opens this file ({type}). Try Share instead.'**
  String attachmentsNoApp(String type);

  /// No description provided for @attachmentsOpenInError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the attachment in another app.'**
  String get attachmentsOpenInError;

  /// Snack bar after saving an attachment.
  ///
  /// In en, this message translates to:
  /// **'Saved “{name}”'**
  String attachmentsSaved(String name);

  /// No description provided for @attachmentsSaveError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the attachment.'**
  String get attachmentsSaveError;

  /// No description provided for @attachmentsGone.
  ///
  /// In en, this message translates to:
  /// **'This attachment is no longer available.'**
  String get attachmentsGone;

  /// No description provided for @attachmentsDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'The attachment couldn\'t be downloaded.'**
  String get attachmentsDownloadFailed;

  /// Number of pages of a PDF, under its name.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 page} other{{count} pages}}'**
  String attachmentsPageCount(int count);

  /// Title: asks before downloading a large attachment on mobile data.
  ///
  /// In en, this message translates to:
  /// **'{size} on mobile data'**
  String attachmentsOnMobileData(String size);

  /// No description provided for @attachmentsLargeDownload.
  ///
  /// In en, this message translates to:
  /// **'This attachment is large. Download it now, or later on Wi-Fi.'**
  String get attachmentsLargeDownload;

  /// Button: downloads a large attachment on mobile data.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get attachmentsDownload;

  /// No description provided for @attachmentsDownloadingSize.
  ///
  /// In en, this message translates to:
  /// **'Downloading {size}…'**
  String attachmentsDownloadingSize(String size);

  /// No description provided for @attachmentsDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading…'**
  String get attachmentsDownloading;

  /// No description provided for @attachmentsTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Too large to preview here.'**
  String get attachmentsTooLarge;

  /// Above a long text attachment that is shown only in part.
  ///
  /// In en, this message translates to:
  /// **'Showing the first {shown} of {total}. Copy, share or save to get all of it.'**
  String attachmentsTruncated(String shown, String total);

  /// No description provided for @attachmentsPdfUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This PDF can\'t be shown here (it may be protected with a password).'**
  String get attachmentsPdfUnavailable;

  /// The PDF page indicator.
  ///
  /// In en, this message translates to:
  /// **'{page} of {count}'**
  String attachmentsPageOf(int page, int count);

  /// Switch between a CSV file's table and its text: the table.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get attachmentsModeTable;

  /// Switch between a CSV file's table and its text: the text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get attachmentsModeText;

  /// Switch between an attached message and its source: the message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get attachmentsModeMessage;

  /// Switch between an attached message and its source: the raw source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get attachmentsModeSource;

  /// No description provided for @attachmentsDontWrap.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Wrap Lines'**
  String get attachmentsDontWrap;

  /// No description provided for @attachmentsWrap.
  ///
  /// In en, this message translates to:
  /// **'Wrap Lines'**
  String get attachmentsWrap;

  /// Bottom bar of a text attachment: its character set and number of lines.
  ///
  /// In en, this message translates to:
  /// **'{charset} · {count, plural, =1{{lines} line} other{{lines} lines}}'**
  String attachmentsTextInfo(String charset, int count, String lines);

  /// No description provided for @attachmentsCopyAll.
  ///
  /// In en, this message translates to:
  /// **'Copy All'**
  String get attachmentsCopyAll;

  /// Snack bar after copying an attachment's text.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get attachmentsCopied;

  /// No description provided for @attachmentsImageUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This image can\'t be shown here. Try Open in….'**
  String get attachmentsImageUnavailable;

  /// Title of an attached message without a subject.
  ///
  /// In en, this message translates to:
  /// **'(No Subject)'**
  String get attachmentsEmlNoSubject;

  /// Header label of an attached message.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get attachmentsEmlFrom;

  /// Header label of an attached message.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get attachmentsEmlTo;

  /// Header label of an attached message (carbon copy).
  ///
  /// In en, this message translates to:
  /// **'Cc'**
  String get attachmentsEmlCc;

  /// Header label of an attached message.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get attachmentsEmlDate;

  /// No description provided for @attachmentsEmlNoText.
  ///
  /// In en, this message translates to:
  /// **'This message has no text.'**
  String get attachmentsEmlNoText;

  /// Below an attached message: the names of its own attachments.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Attachment: {names}} other{Attachments: {names}}}'**
  String attachmentsEmlAttachments(int count, String names);

  /// No description provided for @attachmentsEventOrganizer.
  ///
  /// In en, this message translates to:
  /// **'Organizer: {name}'**
  String attachmentsEventOrganizer(String name);

  /// Under the first event of a calendar file with several.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{And 1 more event} other{And {count} more events}}'**
  String attachmentsEventMore(int count);

  /// File type of an attachment.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get attachmentsTypeImage;

  /// File type of an attachment.
  ///
  /// In en, this message translates to:
  /// **'{format} Image'**
  String attachmentsTypeNamedImage(String format);

  /// No description provided for @attachmentsTypePdf.
  ///
  /// In en, this message translates to:
  /// **'PDF Document'**
  String get attachmentsTypePdf;

  /// No description provided for @attachmentsTypeTsv.
  ///
  /// In en, this message translates to:
  /// **'Tab-Separated Values'**
  String get attachmentsTypeTsv;

  /// No description provided for @attachmentsTypeCsv.
  ///
  /// In en, this message translates to:
  /// **'CSV Spreadsheet'**
  String get attachmentsTypeCsv;

  /// No description provided for @attachmentsTypeCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar Event'**
  String get attachmentsTypeCalendar;

  /// No description provided for @attachmentsTypeEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Message'**
  String get attachmentsTypeEmail;

  /// No description provided for @attachmentsTypeContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Card'**
  String get attachmentsTypeContact;

  /// No description provided for @attachmentsTypeLog.
  ///
  /// In en, this message translates to:
  /// **'Log File'**
  String get attachmentsTypeLog;

  /// File type of a plain text attachment.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get attachmentsTypeText;

  /// No description provided for @attachmentsTypeZip.
  ///
  /// In en, this message translates to:
  /// **'ZIP Archive'**
  String get attachmentsTypeZip;

  /// File type: a compressed archive (tar, 7z, rar).
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get attachmentsTypeArchive;

  /// No description provided for @attachmentsTypeWord.
  ///
  /// In en, this message translates to:
  /// **'Word Document'**
  String get attachmentsTypeWord;

  /// No description provided for @attachmentsTypeExcel.
  ///
  /// In en, this message translates to:
  /// **'Excel Spreadsheet'**
  String get attachmentsTypeExcel;

  /// No description provided for @attachmentsTypePowerPoint.
  ///
  /// In en, this message translates to:
  /// **'PowerPoint Presentation'**
  String get attachmentsTypePowerPoint;

  /// No description provided for @attachmentsTypeWebPage.
  ///
  /// In en, this message translates to:
  /// **'Web Page'**
  String get attachmentsTypeWebPage;

  /// No description provided for @attachmentsTypeVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get attachmentsTypeVideo;

  /// No description provided for @attachmentsTypeAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get attachmentsTypeAudio;

  /// File type of an attachment known only by its extension.
  ///
  /// In en, this message translates to:
  /// **'{extension} File'**
  String attachmentsTypeExtension(String extension);

  /// File type of an attachment of an unknown kind.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get attachmentsTypeFile;

  /// Title of a calendar event that has none.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get calendarUntitledEvent;

  /// No description provided for @calendarAllDay.
  ///
  /// In en, this message translates to:
  /// **'All day'**
  String get calendarAllDay;

  /// An event's times in the device's time zone, after its times in the organizer's zone.
  ///
  /// In en, this message translates to:
  /// **'{time} your time'**
  String calendarYourTime(String time);

  /// Line in the notes of an event added to the phone's calendar.
  ///
  /// In en, this message translates to:
  /// **'Join: {link}'**
  String calendarJoinNote(String link);

  /// First line of the email that answers an invitation, sent to the organizer.
  ///
  /// In en, this message translates to:
  /// **'{answer, select, accepted{{name} has accepted: {details}} tentative{{name} has tentatively accepted: {details}} declined{{name} has declined: {details}} delegated{{name} has delegated: {details}} other{{name} has not responded to: {details}}}'**
  String calendarReplyText(String answer, String name, String details);

  /// First line of the email that answers an invitation without a title or time, sent to the organizer.
  ///
  /// In en, this message translates to:
  /// **'{answer, select, accepted{{name} has accepted the invitation} tentative{{name} has tentatively accepted the invitation} declined{{name} has declined the invitation} delegated{{name} has delegated the invitation} other{{name} has not responded to the invitation}}'**
  String calendarReplyTextNoDetails(String answer, String name);

  /// Small button next to an event's location: opens it in a map app.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get calendarMap;

  /// Small button next to an event's meeting link.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get calendarJoin;

  /// No description provided for @calendarOnlineMeeting.
  ///
  /// In en, this message translates to:
  /// **'Online meeting'**
  String get calendarOnlineMeeting;

  /// No description provided for @calendarProviderMeeting.
  ///
  /// In en, this message translates to:
  /// **'{provider} meeting'**
  String calendarProviderMeeting(String provider);

  /// In place of the organizer's name when the user organizes the event.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get calendarOrganizerYou;

  /// After the organizer's name: “Sam Rivera · organizer”.
  ///
  /// In en, this message translates to:
  /// **'organizer'**
  String get calendarOrganizerLabel;

  /// Label by an invitation's title: the user's answer.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get calendarStatusAccepted;

  /// Label by an invitation's title: the user's answer.
  ///
  /// In en, this message translates to:
  /// **'Maybe'**
  String get calendarStatusMaybe;

  /// Label by an invitation's title: the user's answer.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get calendarStatusDeclined;

  /// On a reply to the user's invitation: what the attendee answered.
  ///
  /// In en, this message translates to:
  /// **'{answer, select, accepted{{name} accepted} tentative{{name} tentatively accepted} declined{{name} declined} delegated{{name} delegated} other{{name} not responded to}}'**
  String calendarAttendeeAnswer(String answer, String name);

  /// On a reply to the user's invitation: what the attendee answered, followed by their comment on the next line.
  ///
  /// In en, this message translates to:
  /// **'{answer, select, accepted{{name} accepted:} tentative{{name} tentatively accepted:} declined{{name} declined:} delegated{{name} delegated:} other{{name} not responded to:}}'**
  String calendarAttendeeAnswerWithComment(String answer, String name);

  /// An attendee's comment, quoted.
  ///
  /// In en, this message translates to:
  /// **'“{comment}”'**
  String calendarQuotedComment(String comment);

  /// No description provided for @calendarCounter.
  ///
  /// In en, this message translates to:
  /// **'{name} proposes a new time'**
  String calendarCounter(String name);

  /// No description provided for @calendarCounterUnknown.
  ///
  /// In en, this message translates to:
  /// **'An attendee proposes a new time'**
  String get calendarCounterUnknown;

  /// No description provided for @calendarDeclineCounter.
  ///
  /// In en, this message translates to:
  /// **'The organizer kept the time'**
  String get calendarDeclineCounter;

  /// No description provided for @calendarRefresh.
  ///
  /// In en, this message translates to:
  /// **'{name} asks for the latest version'**
  String calendarRefresh(String name);

  /// No description provided for @calendarRefreshUnknown.
  ///
  /// In en, this message translates to:
  /// **'An attendee asks for the latest version'**
  String get calendarRefreshUnknown;

  /// An event's state.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get calendarCancelled;

  /// No description provided for @calendarCancelledByOrganizer.
  ///
  /// In en, this message translates to:
  /// **'The organizer cancelled this event.'**
  String get calendarCancelledByOrganizer;

  /// No description provided for @calendarCancelledLater.
  ///
  /// In en, this message translates to:
  /// **'This event was cancelled later.'**
  String get calendarCancelledLater;

  /// No description provided for @calendarOutdated.
  ///
  /// In en, this message translates to:
  /// **'Out of date'**
  String get calendarOutdated;

  /// No description provided for @calendarOutdatedDetail.
  ///
  /// In en, this message translates to:
  /// **'This invitation was updated later; the newer one counts.'**
  String get calendarOutdatedDetail;

  /// No description provided for @calendarLocationRemoved.
  ///
  /// In en, this message translates to:
  /// **'Location removed (was {location})'**
  String calendarLocationRemoved(String location);

  /// No description provided for @calendarLocationRemovedNone.
  ///
  /// In en, this message translates to:
  /// **'Location removed (was none)'**
  String get calendarLocationRemovedNone;

  /// No description provided for @calendarLocationChanged.
  ///
  /// In en, this message translates to:
  /// **'Location changed to {location}'**
  String calendarLocationChanged(String location);

  /// In the list of what an updated invitation changed.
  ///
  /// In en, this message translates to:
  /// **'New title'**
  String get calendarNewTitle;

  /// In the list of what an updated invitation changed: how often the event repeats.
  ///
  /// In en, this message translates to:
  /// **'The repeat changed'**
  String get calendarRepeatChanged;

  /// Notice on an invitation that changed, above the list of changes.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get calendarUpdated;

  /// No description provided for @calendarUpdatedInvitation.
  ///
  /// In en, this message translates to:
  /// **'Updated invitation'**
  String get calendarUpdatedInvitation;

  /// No description provided for @calendarTimeChanged.
  ///
  /// In en, this message translates to:
  /// **'Time changed from {before} to {after}'**
  String calendarTimeChanged(String before, String after);

  /// No description provided for @calendarUnknownZone.
  ///
  /// In en, this message translates to:
  /// **'Time zone “{zone}” unknown: times as written'**
  String calendarUnknownZone(String zone);

  /// The next occurrence of a repeating event.
  ///
  /// In en, this message translates to:
  /// **'Next: {when}'**
  String calendarNext(String when);

  /// No description provided for @calendarGuestCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 guest} other{{count} guests}}'**
  String calendarGuestCount(int count);

  /// How many guests accepted, after the guest count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} accepted}}'**
  String calendarAcceptedCount(int count);

  /// How many guests answered maybe, after the guest count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} maybe}}'**
  String calendarMaybeCount(int count);

  /// How many guests declined, after the guest count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} declined}}'**
  String calendarDeclinedCount(int count);

  /// No description provided for @calendarAttendeeYou.
  ///
  /// In en, this message translates to:
  /// **'{name} (you)'**
  String calendarAttendeeYou(String name);

  /// After an attendee's name: their attendance is optional.
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get calendarAttendeeOptional;

  /// After an attendee's name: the attendee is a room, not a person.
  ///
  /// In en, this message translates to:
  /// **'room'**
  String get calendarAttendeeRoom;

  /// Above the answer buttons of an invitation that changed since the user answered.
  ///
  /// In en, this message translates to:
  /// **'{answer, select, accepted{You accepted an earlier version.} tentative{You tentatively accepted an earlier version.} declined{You declined an earlier version.} delegated{You delegated an earlier version.} other{You not responded to an earlier version.}}'**
  String calendarEarlierAnswer(String answer);

  /// Button: answers an invitation.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get calendarAccept;

  /// Button: answers an invitation.
  ///
  /// In en, this message translates to:
  /// **'Maybe'**
  String get calendarMaybe;

  /// Button: answers an invitation.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get calendarDecline;

  /// No description provided for @calendarCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Comment for the organizer (optional)'**
  String get calendarCommentHint;

  /// No description provided for @calendarReplyFrom.
  ///
  /// In en, this message translates to:
  /// **'Your reply goes to {organizer} from {address}.'**
  String calendarReplyFrom(String organizer, String address);

  /// No description provided for @calendarAddComment.
  ///
  /// In en, this message translates to:
  /// **'Add a Comment'**
  String get calendarAddComment;

  /// No description provided for @calendarAddToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Add to Calendar'**
  String get calendarAddToCalendar;

  /// No description provided for @calendarMoreEventsInFile.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{And 1 more event in the file} other{And {count} more events in the file}}'**
  String calendarMoreEventsInFile(int count);

  /// No description provided for @calendarNoCalendarApp.
  ///
  /// In en, this message translates to:
  /// **'There’s no calendar app to add the event to.'**
  String get calendarNoCalendarApp;

  /// No description provided for @calendarCantOpenCalendar.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t open the calendar.'**
  String get calendarCantOpenCalendar;

  /// No description provided for @calendarCantOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t open the link.'**
  String get calendarCantOpenLink;

  /// No description provided for @calendarJoinProviderTitle.
  ///
  /// In en, this message translates to:
  /// **'Join {provider} Meeting?'**
  String calendarJoinProviderTitle(String provider);

  /// No description provided for @calendarJoinTitle.
  ///
  /// In en, this message translates to:
  /// **'Join the Meeting?'**
  String get calendarJoinTitle;

  /// No description provided for @calendarJoinOpens.
  ///
  /// In en, this message translates to:
  /// **'Opens {host} in your browser.'**
  String calendarJoinOpens(String host);

  /// No description provided for @calendarJoinHomograph.
  ///
  /// In en, this message translates to:
  /// **'Careful: this address imitates {site} with look-alike letters.'**
  String calendarJoinHomograph(String site);

  /// No description provided for @calendarJoinHomographUnknown.
  ///
  /// In en, this message translates to:
  /// **'Careful: this address imitates another site with look-alike letters.'**
  String get calendarJoinHomographUnknown;

  /// Button: opens a meeting link in the browser.
  ///
  /// In en, this message translates to:
  /// **'Open {host}'**
  String calendarJoinOpen(String host);

  /// No description provided for @calendarNoOrganizer.
  ///
  /// In en, this message translates to:
  /// **'This invitation has no organizer to reply to.'**
  String get calendarNoOrganizer;

  /// No description provided for @calendarNoAccount.
  ///
  /// In en, this message translates to:
  /// **'There’s no account to reply from.'**
  String get calendarNoAccount;

  /// Snack bar after answering an invitation, while Undo is still possible.
  ///
  /// In en, this message translates to:
  /// **'{answer, select, accepted{Accepted} tentative{Maybe} other{Declined}} · sending reply to {name}…'**
  String calendarReplySending(String answer, String name);

  /// Snack bar after answering an invitation.
  ///
  /// In en, this message translates to:
  /// **'{answer, select, accepted{Accepted} tentative{Maybe} other{Declined}} · reply sent'**
  String calendarReplySent(String answer);

  /// No description provided for @calendarReplyAlreadySent.
  ///
  /// In en, this message translates to:
  /// **'The reply was already sent.'**
  String get calendarReplyAlreadySent;

  /// No description provided for @calendarReplyNotSent.
  ///
  /// In en, this message translates to:
  /// **'Reply not sent.'**
  String get calendarReplyNotSent;

  /// Why a message waiting in the Outbox wasn't sent in the background.
  ///
  /// In en, this message translates to:
  /// **'Your S/MIME certificate is on this device: open Loupe to sign and send this message.'**
  String get dataSmimeNeedsDevice;

  /// Why a message couldn't be sent. The placeholder is the error, in English.
  ///
  /// In en, this message translates to:
  /// **'Signing failed: {error}'**
  String dataSigningFailed(String error);

  /// Title of the list of keyboard shortcuts, and the command that shows it.
  ///
  /// In en, this message translates to:
  /// **'Keyboard Shortcuts'**
  String get keyboardShortcuts;

  /// Group of keyboard shortcuts.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get keyboardGroupGeneral;

  /// Group of keyboard shortcuts.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get keyboardGroupMessages;

  /// Group of keyboard shortcuts: writing a message.
  ///
  /// In en, this message translates to:
  /// **'Compose'**
  String get keyboardGroupCompose;

  /// No description provided for @keyboardCommandPalette.
  ///
  /// In en, this message translates to:
  /// **'Command Palette'**
  String get keyboardCommandPalette;

  /// What the Esc key does.
  ///
  /// In en, this message translates to:
  /// **'Back, Close'**
  String get keyboardBackClose;

  /// No description provided for @keyboardNextMessage.
  ///
  /// In en, this message translates to:
  /// **'Next Message'**
  String get keyboardNextMessage;

  /// No description provided for @keyboardPreviousMessage.
  ///
  /// In en, this message translates to:
  /// **'Previous Message'**
  String get keyboardPreviousMessage;

  /// No description provided for @keyboardOpenMessage.
  ///
  /// In en, this message translates to:
  /// **'Open Message'**
  String get keyboardOpenMessage;

  /// No description provided for @keyboardMoveToTrash.
  ///
  /// In en, this message translates to:
  /// **'Move to Trash'**
  String get keyboardMoveToTrash;

  /// No description provided for @keyboardToggleRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as Read or Unread'**
  String get keyboardToggleRead;

  /// No description provided for @keyboardToggleFlag.
  ///
  /// In en, this message translates to:
  /// **'Flag or Unflag'**
  String get keyboardToggleFlag;

  /// What the Esc key does while writing a message.
  ///
  /// In en, this message translates to:
  /// **'Close (Save or Delete Draft)'**
  String get keyboardCloseDraft;

  /// Between two key combinations that do the same.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get keyboardOr;

  /// The Control key, as printed on keyboards in your language.
  ///
  /// In en, this message translates to:
  /// **'Ctrl'**
  String get keyboardKeyCtrl;

  /// The Shift key, as printed on keyboards in your language.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get keyboardKeyShift;

  /// The Enter key, as printed on keyboards in your language.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get keyboardKeyEnter;

  /// The Escape key, as printed on keyboards in your language.
  ///
  /// In en, this message translates to:
  /// **'Esc'**
  String get keyboardKeyEsc;

  /// The Delete key, as printed on keyboards in your language.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get keyboardKeyDelete;

  /// The Backspace key, as printed on keyboards in your language.
  ///
  /// In en, this message translates to:
  /// **'Backspace'**
  String get keyboardKeyBackspace;

  /// No description provided for @mailingListsMuted.
  ///
  /// In en, this message translates to:
  /// **'Thread muted. New messages in it arrive read.'**
  String get mailingListsMuted;

  /// No description provided for @mailingListsUnmuted.
  ///
  /// In en, this message translates to:
  /// **'Thread unmuted.'**
  String get mailingListsUnmuted;

  /// No description provided for @mailingListsMuteThread.
  ///
  /// In en, this message translates to:
  /// **'Mute Thread'**
  String get mailingListsMuteThread;

  /// No description provided for @mailingListsUnmuteThread.
  ///
  /// In en, this message translates to:
  /// **'Unmute Thread'**
  String get mailingListsUnmuteThread;

  /// No description provided for @mailingListsPin.
  ///
  /// In en, this message translates to:
  /// **'Pin to Mailboxes'**
  String get mailingListsPin;

  /// No description provided for @mailingListsUnpin.
  ///
  /// In en, this message translates to:
  /// **'Unpin from Mailboxes'**
  String get mailingListsUnpin;

  /// No description provided for @mailingListsDefaultView.
  ///
  /// In en, this message translates to:
  /// **'Open in Default View'**
  String get mailingListsDefaultView;

  /// Menu item: messages of this list open as plain text in a monospaced font.
  ///
  /// In en, this message translates to:
  /// **'Open as Plain Text (Mono)'**
  String get mailingListsPlainText;

  /// No description provided for @mailingListsShowMuted.
  ///
  /// In en, this message translates to:
  /// **'Show Muted Threads'**
  String get mailingListsShowMuted;

  /// No description provided for @mailingListsHideMuted.
  ///
  /// In en, this message translates to:
  /// **'Hide Muted Threads'**
  String get mailingListsHideMuted;

  /// No description provided for @mailingListsTreatAsNewsletter.
  ///
  /// In en, this message translates to:
  /// **'Treat as Newsletter'**
  String get mailingListsTreatAsNewsletter;

  /// Tooltip of the button that opens a mailing list's menu.
  ///
  /// In en, this message translates to:
  /// **'List Options'**
  String get mailingListsOptions;

  /// Bottom bar of a mailing list: its unread messages.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{formatted} Unread}}'**
  String mailingListsUnreadCount(int count, String formatted);

  /// No description provided for @mailingListsNewMessage.
  ///
  /// In en, this message translates to:
  /// **'New Message to List'**
  String get mailingListsNewMessage;

  /// Screen reader: a thread has unread messages.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get mailingListsRowUnread;

  /// Screen reader: a thread is muted.
  ///
  /// In en, this message translates to:
  /// **'Muted'**
  String get mailingListsRowMuted;

  /// Screen reader: how many replies a thread has.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 reply} other{{count} replies}}'**
  String mailingListsReplyCount(int count);

  /// No description provided for @mailingListsNoThreads.
  ///
  /// In en, this message translates to:
  /// **'No Threads'**
  String get mailingListsNoThreads;

  /// No description provided for @mailingListsMutedHidden.
  ///
  /// In en, this message translates to:
  /// **'Muted threads are hidden.'**
  String get mailingListsMutedHidden;

  /// No description provided for @mailingListsTechnicalTitle.
  ///
  /// In en, this message translates to:
  /// **'Technical Lists'**
  String get mailingListsTechnicalTitle;

  /// No description provided for @mailingListsTechnicalEmpty.
  ///
  /// In en, this message translates to:
  /// **'Mailing lists appear here once their mail arrives.'**
  String get mailingListsTechnicalEmpty;

  /// No description provided for @mailingListsTechnicalFooter.
  ///
  /// In en, this message translates to:
  /// **'Messages from these lists open as plain text in a monospaced font, with patches shown as diffs. The Aa button still switches any message.'**
  String get mailingListsTechnicalFooter;

  /// No description provided for @paletteMoveToMailbox.
  ///
  /// In en, this message translates to:
  /// **'Move to Mailbox…'**
  String get paletteMoveToMailbox;

  /// No description provided for @paletteMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All as Read'**
  String get paletteMarkAllRead;

  /// No description provided for @paletteExportFolder.
  ///
  /// In en, this message translates to:
  /// **'Export Folder…'**
  String get paletteExportFolder;

  /// No description provided for @paletteGetNewMail.
  ///
  /// In en, this message translates to:
  /// **'Get New Mail'**
  String get paletteGetNewMail;

  /// The mailbox of snoozed messages.
  ///
  /// In en, this message translates to:
  /// **'Snoozed'**
  String get paletteSnoozed;

  /// The place listing newsletters and mailing lists.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get paletteSubscriptions;

  /// The tab of Subscriptions listing mailing lists.
  ///
  /// In en, this message translates to:
  /// **'Discussions'**
  String get paletteDiscussions;

  /// Kind of a command palette entry, under its name: a saved search.
  ///
  /// In en, this message translates to:
  /// **'Smart Mailbox'**
  String get paletteSmartMailbox;

  /// Kind of a command palette entry, under its name.
  ///
  /// In en, this message translates to:
  /// **'Mailing List'**
  String get paletteMailingList;

  /// Kind of a command palette entry, under its name.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get paletteTag;

  /// The settings page.
  ///
  /// In en, this message translates to:
  /// **'Swipe Actions'**
  String get paletteSwipeActions;

  /// The settings page.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get paletteNotifications;

  /// The settings page.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get paletteRules;

  /// The settings page.
  ///
  /// In en, this message translates to:
  /// **'End-to-End Encryption'**
  String get paletteEncryption;

  /// The settings page.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get paletteAdvanced;

  /// No description provided for @paletteAddAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get paletteAddAccount;

  /// Kind of a command palette entry, under an account's name: its settings.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get paletteAccount;

  /// The settings page listing an account's folders.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get paletteFolders;

  /// Kind of a command palette entry, under the search.
  ///
  /// In en, this message translates to:
  /// **'Recent Search'**
  String get paletteRecentSearch;

  /// No description provided for @paletteSearchMail.
  ///
  /// In en, this message translates to:
  /// **'Search mail for “{query}”'**
  String paletteSearchMail(String query);

  /// Placeholder of the command palette's search field.
  ///
  /// In en, this message translates to:
  /// **'Search actions, mailboxes, settings'**
  String get palettePlaceholder;

  /// No description provided for @paletteNothingFound.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get paletteNothingFound;

  /// Title of the prompt that names a saved search.
  ///
  /// In en, this message translates to:
  /// **'New Smart Mailbox'**
  String get searchNewSmartMailbox;

  /// No description provided for @searchNewSmartMailboxMessage.
  ///
  /// In en, this message translates to:
  /// **'Shows everything matching “{query}”.'**
  String searchNewSmartMailboxMessage(String query);

  /// No description provided for @searchSavedToMailboxes.
  ///
  /// In en, this message translates to:
  /// **'Saved “{name}” to Mailboxes'**
  String searchSavedToMailboxes(String name);

  /// No description provided for @searchMakeRule.
  ///
  /// In en, this message translates to:
  /// **'Make This a Rule'**
  String get searchMakeRule;

  /// No description provided for @searchSaveSmartMailbox.
  ///
  /// In en, this message translates to:
  /// **'Save as Smart Mailbox'**
  String get searchSaveSmartMailbox;

  /// Menu item on a search term: finds what doesn't match it instead.
  ///
  /// In en, this message translates to:
  /// **'Negate'**
  String get searchNegate;

  /// No description provided for @searchDontNegate.
  ///
  /// In en, this message translates to:
  /// **'Don’t Negate'**
  String get searchDontNegate;

  /// Search scope, next to the current mailbox's name.
  ///
  /// In en, this message translates to:
  /// **'All Mailboxes'**
  String get searchAllMailboxes;

  /// No description provided for @searchRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get searchRecent;

  /// Button: forgets the recent searches.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get searchClear;

  /// No description provided for @searchSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get searchSuggestions;

  /// No description provided for @searchUnreadMessages.
  ///
  /// In en, this message translates to:
  /// **'Unread Messages'**
  String get searchUnreadMessages;

  /// No description provided for @searchFlaggedMessages.
  ///
  /// In en, this message translates to:
  /// **'Flagged Messages'**
  String get searchFlaggedMessages;

  /// No description provided for @searchWithAttachments.
  ///
  /// In en, this message translates to:
  /// **'Messages with Attachments'**
  String get searchWithAttachments;

  /// No description provided for @searchUnrepliedMessages.
  ///
  /// In en, this message translates to:
  /// **'Unreplied Messages'**
  String get searchUnrepliedMessages;

  /// Section of search suggestions.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get searchTags;

  /// Section of search suggestions.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get searchPeople;

  /// Section of search suggestions.
  ///
  /// In en, this message translates to:
  /// **'Smart Mailboxes'**
  String get searchSmartMailboxes;

  /// Search suggestion: messages from this person.
  ///
  /// In en, this message translates to:
  /// **'From: {name}'**
  String searchFromPerson(String name);

  /// No description provided for @searchSearching.
  ///
  /// In en, this message translates to:
  /// **'Searching…'**
  String get searchSearching;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No Results'**
  String get searchNoResults;

  /// No description provided for @searchResultCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{formatted} Result} other{{formatted} Results}}'**
  String searchResultCount(int count, String formatted);

  /// Tooltip of the button that opens the search's menu.
  ///
  /// In en, this message translates to:
  /// **'Search Menu'**
  String get searchMenu;

  /// No description provided for @searchSearchingAccount.
  ///
  /// In en, this message translates to:
  /// **'Searching {account} on the server…'**
  String searchSearchingAccount(String account);

  /// No description provided for @searchSearchingUnknownAccount.
  ///
  /// In en, this message translates to:
  /// **'Searching account on the server…'**
  String get searchSearchingUnknownAccount;

  /// No description provided for @searchAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t search {account} on the server'**
  String searchAccountFailed(String account);

  /// No description provided for @searchUnknownAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t search account on the server'**
  String get searchUnknownAccountFailed;

  /// Screen reader: a term of the search, shown as a chip.
  ///
  /// In en, this message translates to:
  /// **'{term}. Double tap to edit.'**
  String searchChip(String term);

  /// Screen reader: a negated term of the search, shown as a chip.
  ///
  /// In en, this message translates to:
  /// **'Not {term}. Double tap to edit.'**
  String searchChipNegated(String term);

  /// Shown when someone searches for messages that are both read and unread. A joke on Schrödinger's cat.
  ///
  /// In en, this message translates to:
  /// **'Schrödinger\'s inbox: every message here is read and unread until you open it.'**
  String get searchReadAndUnread;

  /// Shown when a search contradicts itself.
  ///
  /// In en, this message translates to:
  /// **'No message can be both “{term}” and not.'**
  String searchContradiction(String term);

  /// Where a Smart Mailbox is kept.
  ///
  /// In en, this message translates to:
  /// **'On this device only'**
  String get searchSyncDeviceOnly;

  /// No description provided for @searchSyncUnsupported.
  ///
  /// In en, this message translates to:
  /// **'On this device only: {account} can’t keep it'**
  String searchSyncUnsupported(String account);

  /// No description provided for @searchSyncNewerFormat.
  ///
  /// In en, this message translates to:
  /// **'Not synced: {account} has a newer format'**
  String searchSyncNewerFormat(String account);

  /// No description provided for @searchSyncWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting to sync to {account}'**
  String searchSyncWaiting(String account);

  /// No description provided for @searchSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced to {account}'**
  String searchSynced(String account);

  /// No description provided for @searchRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get searchRename;

  /// No description provided for @searchEditSearch.
  ///
  /// In en, this message translates to:
  /// **'Edit Search'**
  String get searchEditSearch;

  /// No description provided for @searchDeleteSmartMailbox.
  ///
  /// In en, this message translates to:
  /// **'Delete Smart Mailbox'**
  String get searchDeleteSmartMailbox;

  /// No description provided for @searchRenameSmartMailbox.
  ///
  /// In en, this message translates to:
  /// **'Rename Smart Mailbox'**
  String get searchRenameSmartMailbox;

  /// No description provided for @searchSmartMailboxDeleted.
  ///
  /// In en, this message translates to:
  /// **'This smart mailbox was deleted.'**
  String get searchSmartMailboxDeleted;

  /// Title of the Smart Mailboxes settings page.
  ///
  /// In en, this message translates to:
  /// **'Smart Mailboxes'**
  String get searchSettingsTitle;

  /// No description provided for @searchSettingsLocalFooter.
  ///
  /// In en, this message translates to:
  /// **'Smart Mailboxes stay on this device.'**
  String get searchSettingsLocalFooter;

  /// Expression Search Reloaded is the name of a Thunderbird add-on.
  ///
  /// In en, this message translates to:
  /// **'Smart Mailboxes are kept on your mail server, so your other devices have them too, and so does Thunderbird with Expression Search Reloaded. Those that search every account are kept on {account}; those of one folder, on that folder’s account.'**
  String searchSettingsServerFooter(String account);

  /// Setting: the account whose mail server keeps the Smart Mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Sync via'**
  String get searchSyncVia;

  /// No description provided for @searchSyncViaFooter.
  ///
  /// In en, this message translates to:
  /// **'Choose the same account on every device.'**
  String get searchSyncViaFooter;

  /// No description provided for @searchGmailCantKeep.
  ///
  /// In en, this message translates to:
  /// **'Gmail can’t keep Smart Mailboxes'**
  String get searchGmailCantKeep;

  /// No description provided for @searchKeepOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Keep Smart Mailboxes on this device only'**
  String get searchKeepOnDevice;

  /// Section header: how each account keeps the Smart Mailboxes.
  ///
  /// In en, this message translates to:
  /// **'On the Server'**
  String get searchOnTheServer;

  /// “Loupe Settings” is the name of a folder on the server and stays as it is.
  ///
  /// In en, this message translates to:
  /// **'Server metadata (IMAP METADATA) doesn’t show in any mail app. Servers without it get a “Loupe Settings” folder holding one message; Loupe hides it from Mailboxes.'**
  String get searchServerFooter;

  /// No description provided for @searchSyncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get searchSyncNow;

  /// How an account keeps the Smart Mailboxes.
  ///
  /// In en, this message translates to:
  /// **'Not supported'**
  String get searchStateUnsupported;

  /// How an account keeps the Smart Mailboxes: another app stored them in a newer format.
  ///
  /// In en, this message translates to:
  /// **'Newer format'**
  String get searchStateNewerFormat;

  /// No description provided for @searchStateFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t sync'**
  String get searchStateFailed;

  /// No description provided for @searchStateSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing…'**
  String get searchStateSyncing;

  /// How an account keeps the Smart Mailboxes: not synced yet.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get searchStateWaiting;

  /// How an account keeps the Smart Mailboxes: in the server's IMAP METADATA.
  ///
  /// In en, this message translates to:
  /// **'Server metadata'**
  String get searchStateMetadata;

  /// How an account keeps the Smart Mailboxes: in a folder named “Loupe Settings” (that name stays as it is).
  ///
  /// In en, this message translates to:
  /// **'Loupe Settings folder'**
  String get searchStateFolder;

  /// No description provided for @searchStateNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing stored'**
  String get searchStateNothing;

  /// Screen reader: the back button of the top bar.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get sharedBack;

  /// Date of a message received yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get sharedYesterday;

  /// A message's full date and time.
  ///
  /// In en, this message translates to:
  /// **'{date} at {time}'**
  String sharedDateAtTime(String date, String time);

  /// A file size under one kilobyte.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} bytes}}'**
  String sharedBytes(int count);

  /// A file size in kilobytes.
  ///
  /// In en, this message translates to:
  /// **'{size} KB'**
  String sharedKilobytes(String size);

  /// A file size in megabytes.
  ///
  /// In en, this message translates to:
  /// **'{size} MB'**
  String sharedMegabytes(String size);

  /// No description provided for @sharedSyncNoAccounts.
  ///
  /// In en, this message translates to:
  /// **'No Accounts'**
  String get sharedSyncNoAccounts;

  /// No description provided for @sharedSyncChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking for Mail…'**
  String get sharedSyncChecking;

  /// No description provided for @sharedSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t check for mail'**
  String get sharedSyncFailed;

  /// Bottom bar: why checking an account for mail failed. The error may be in English.
  ///
  /// In en, this message translates to:
  /// **'{account}: {error}'**
  String sharedSyncAccountError(String account, String error);

  /// No description provided for @sharedSyncOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get sharedSyncOffline;

  /// No description provided for @sharedSyncJustNow.
  ///
  /// In en, this message translates to:
  /// **'Updated Just Now'**
  String get sharedSyncJustNow;

  /// No description provided for @sharedSyncMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =1{Updated 1 minute ago} other{Updated {minutes} minutes ago}}'**
  String sharedSyncMinutesAgo(int minutes);

  /// No description provided for @sharedSyncAtTime.
  ///
  /// In en, this message translates to:
  /// **'Updated at {time}'**
  String sharedSyncAtTime(String time);

  /// When the mail was last checked, on an earlier day.
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String sharedSyncOnDate(String date);

  /// No description provided for @sharedMailboxAllInboxes.
  ///
  /// In en, this message translates to:
  /// **'All Inboxes'**
  String get sharedMailboxAllInboxes;

  /// The mailbox of every unread message.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get sharedMailboxUnread;

  /// The mailbox of every flagged message.
  ///
  /// In en, this message translates to:
  /// **'Flagged'**
  String get sharedMailboxFlagged;

  /// The mailbox of messages from the user's VIPs.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get sharedMailboxVip;

  /// No description provided for @sharedMailboxAllDrafts.
  ///
  /// In en, this message translates to:
  /// **'All Drafts'**
  String get sharedMailboxAllDrafts;

  /// No description provided for @sharedMailboxAllSent.
  ///
  /// In en, this message translates to:
  /// **'All Sent'**
  String get sharedMailboxAllSent;

  /// Title of a mailbox that can't be found.
  ///
  /// In en, this message translates to:
  /// **'Mailbox'**
  String get sharedMailboxUntitled;

  /// Thunderbird's default tag.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get sharedTagImportant;

  /// Thunderbird's default tag.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get sharedTagWork;

  /// Thunderbird's default tag.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get sharedTagPersonal;

  /// Thunderbird's default tag.
  ///
  /// In en, this message translates to:
  /// **'To Do'**
  String get sharedTagToDo;

  /// Thunderbird's default tag.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get sharedTagLater;

  /// Title of the sheet that tags a message.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get sharedTags;

  /// Title of the sheet that picks the mailbox to move messages to.
  ///
  /// In en, this message translates to:
  /// **'Move to…'**
  String get sharedMoveTo;

  /// No description provided for @sharedNoRecipients.
  ///
  /// In en, this message translates to:
  /// **'No Recipients'**
  String get sharedNoRecipients;

  /// No description provided for @sharedUnknownSender.
  ///
  /// In en, this message translates to:
  /// **'Unknown Sender'**
  String get sharedUnknownSender;

  /// Screen reader: a search result found on the server only.
  ///
  /// In en, this message translates to:
  /// **'On server'**
  String get sharedOnServer;

  /// Screen reader: the message has an attachment.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get sharedAttachment;

  /// Small label on a message that came back from snooze.
  ///
  /// In en, this message translates to:
  /// **'Snoozed'**
  String get sharedSnoozedBadge;

  /// Screen reader: a message is unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get sharedRowUnread;

  /// Screen reader: a message came back from snooze.
  ///
  /// In en, this message translates to:
  /// **'Back from snooze'**
  String get sharedRowBackFromSnooze;

  /// Screen reader: a message is from a VIP.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get sharedRowVip;

  /// Screen reader: a message is flagged.
  ///
  /// In en, this message translates to:
  /// **'Flagged'**
  String get sharedRowFlagged;

  /// No description provided for @sharedArchived.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Archived 1 message} other{Archived {count} messages}}'**
  String sharedArchived(int count);

  /// No description provided for @sharedDeleted.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Deleted 1 message} other{Deleted {count} messages}}'**
  String sharedDeleted(int count);

  /// No description provided for @sharedMovedToInbox.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Moved 1 message to Inbox} other{Moved {count} messages to Inbox}}'**
  String sharedMovedToInbox(int count);

  /// No description provided for @sharedMovedToTrash.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Moved 1 message to Trash} other{Moved {count} messages to Trash}}'**
  String sharedMovedToTrash(int count);

  /// No description provided for @sharedMovedToJunk.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Moved 1 message to Junk} other{Moved {count} messages to Junk}}'**
  String sharedMovedToJunk(int count);

  /// No description provided for @sharedMovedToMailbox.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Moved 1 message to {mailbox}} other{Moved {count} messages to {mailbox}}}'**
  String sharedMovedToMailbox(int count, String mailbox);

  /// After moving messages to a mailbox whose name isn't known.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Moved 1 message to mailbox} other{Moved {count} messages to mailbox}}'**
  String sharedMovedToUnknownMailbox(int count);

  /// No description provided for @sharedSnoozedUntil.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Snoozed 1 message until {time}} other{Snoozed {count} messages until {time}}}'**
  String sharedSnoozedUntil(int count, String time);

  /// No description provided for @sharedSnoozedOnDeviceOnly.
  ///
  /// In en, this message translates to:
  /// **'Snoozed until {time} on this device only: the server can’t store snooze times.'**
  String sharedSnoozedOnDeviceOnly(String time);

  /// No description provided for @sharedMoveOneAccount.
  ///
  /// In en, this message translates to:
  /// **'Select messages from one account to move them.'**
  String get sharedMoveOneAccount;

  /// Title of the sheet that picks when a message comes back.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get sharedSnoozeTitle;

  /// Title of the sheet that picks when a snoozed message comes back.
  ///
  /// In en, this message translates to:
  /// **'Change Snooze Time'**
  String get sharedChangeSnoozeTimeTitle;

  /// No description provided for @sharedDeletePermanentlyQuestion.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Delete this message permanently?} other{Delete {count} messages permanently?}}'**
  String sharedDeletePermanentlyQuestion(int count);

  /// No description provided for @sharedCantBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This can’t be undone.'**
  String get sharedCantBeUndone;

  /// Button and menu item: deletes messages in the Trash for good.
  ///
  /// In en, this message translates to:
  /// **'Delete Permanently'**
  String get sharedDeletePermanently;

  /// Swipe action: marks the conversation as read. Keep it short.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get sharedSwipeRead;

  /// Swipe action: marks the conversation as unread. Keep it short.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get sharedSwipeUnread;

  /// Swipe action: moves an archived conversation back to the inbox. Keep it short.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get sharedSwipeInbox;

  /// Swipe action in the Trash: deletes the conversation for good. Keep it short.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get sharedSwipeDelete;

  /// Swipe action and menu item: moves the conversation to the Trash.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get sharedTrash;

  /// Swipe action: snoozes the conversation. Keep it short.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get sharedSwipeSnooze;

  /// Menu item: brings a snoozed message back now.
  ///
  /// In en, this message translates to:
  /// **'Wake Now'**
  String get sharedWakeNow;

  /// No description provided for @sharedChangeSnoozeTime.
  ///
  /// In en, this message translates to:
  /// **'Change Snooze Time…'**
  String get sharedChangeSnoozeTime;

  /// Menu item and command: asks when the message should come back.
  ///
  /// In en, this message translates to:
  /// **'Snooze…'**
  String get sharedSnooze;

  /// Menu item: opens the tag picker.
  ///
  /// In en, this message translates to:
  /// **'Tag…'**
  String get sharedTag;

  /// No description provided for @sharedMoveMessage.
  ///
  /// In en, this message translates to:
  /// **'Move Message…'**
  String get sharedMoveMessage;

  /// Menu item: moves a message out of Junk.
  ///
  /// In en, this message translates to:
  /// **'Not Junk'**
  String get sharedNotJunk;

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
