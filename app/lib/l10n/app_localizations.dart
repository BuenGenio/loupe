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
