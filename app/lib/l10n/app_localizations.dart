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
