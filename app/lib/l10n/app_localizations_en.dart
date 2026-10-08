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
  String get appLiveGateTitle => 'Your accounts couldn’t be opened';

  @override
  String get appLiveGateUnavailableBuild => 'Real accounts aren’t available in this build yet.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe couldn’t read the key that protects your mail on this phone. This is often temporary: try again, or restart the phone.';

  @override
  String get appLiveGateKeyMissing =>
      'The key that protects your mail on this phone is gone, which can happen after restoring a backup. Your mail is still on the server.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'The mail database on this phone can’t be read: it is damaged, or its key changed. Your mail is still on the server.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Something went wrong while opening your accounts ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'This deletes your accounts and the mail stored on this phone, including messages waiting in the Outbox. Mail on your servers is not affected; add your accounts again afterwards.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Delete and Start Over';

  @override
  String get appLiveGateUseDemo => 'Use Demo Mail';

  @override
  String get appLiveGateReset => 'Reset Mail on This Phone…';

  @override
  String get attachmentsUntitled => 'Attachment';

  @override
  String get attachmentsUntitledFile => 'Untitled';

  @override
  String get attachmentsOpenIn => 'Open in…';

  @override
  String get attachmentsSaveToFiles => 'Save to Files';

  @override
  String get attachmentsShareMenu => 'Share…';

  @override
  String get attachmentsDownloadError => 'Couldn\'t download the attachment. Check the connection and try again.';

  @override
  String get attachmentsShareError => 'Couldn\'t share the attachment.';

  @override
  String attachmentsNoApp(String type) {
    return 'No app on this device opens this file ($type). Try Share instead.';
  }

  @override
  String get attachmentsOpenInError => 'Couldn\'t open the attachment in another app.';

  @override
  String attachmentsSaved(String name) {
    return 'Saved “$name”';
  }

  @override
  String get attachmentsSaveError => 'Couldn\'t save the attachment.';

  @override
  String get attachmentsGone => 'This attachment is no longer available.';

  @override
  String get attachmentsDownloadFailed => 'The attachment couldn\'t be downloaded.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pages', one: '1 page');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size on mobile data';
  }

  @override
  String get attachmentsLargeDownload => 'This attachment is large. Download it now, or later on Wi-Fi.';

  @override
  String get attachmentsDownload => 'Download';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Downloading $size…';
  }

  @override
  String get attachmentsDownloading => 'Downloading…';

  @override
  String get attachmentsTooLarge => 'Too large to preview here.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Showing the first $shown of $total. Copy, share or save to get all of it.';
  }

  @override
  String get attachmentsPdfUnavailable => 'This PDF can\'t be shown here (it may be protected with a password).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page of $count';
  }

  @override
  String get attachmentsModeTable => 'Table';

  @override
  String get attachmentsModeText => 'Text';

  @override
  String get attachmentsModeMessage => 'Message';

  @override
  String get attachmentsModeSource => 'Source';

  @override
  String get attachmentsDontWrap => 'Don\'t Wrap Lines';

  @override
  String get attachmentsWrap => 'Wrap Lines';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines lines', one: '$lines line');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Copy All';

  @override
  String get attachmentsCopied => 'Copied';

  @override
  String get attachmentsImageUnavailable => 'This image can\'t be shown here. Try Open in….';

  @override
  String get attachmentsEmlNoSubject => '(No Subject)';

  @override
  String get attachmentsEmlFrom => 'From';

  @override
  String get attachmentsEmlTo => 'To';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Date';

  @override
  String get attachmentsEmlNoText => 'This message has no text.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Attachments: $names',
      one: 'Attachment: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organizer: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'And $count more events',
      one: 'And 1 more event',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Image';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format Image';
  }

  @override
  String get attachmentsTypePdf => 'PDF Document';

  @override
  String get attachmentsTypeTsv => 'Tab-Separated Values';

  @override
  String get attachmentsTypeCsv => 'CSV Spreadsheet';

  @override
  String get attachmentsTypeCalendar => 'Calendar Event';

  @override
  String get attachmentsTypeEmail => 'Email Message';

  @override
  String get attachmentsTypeContact => 'Contact Card';

  @override
  String get attachmentsTypeLog => 'Log File';

  @override
  String get attachmentsTypeText => 'Text';

  @override
  String get attachmentsTypeZip => 'ZIP Archive';

  @override
  String get attachmentsTypeArchive => 'Archive';

  @override
  String get attachmentsTypeWord => 'Word Document';

  @override
  String get attachmentsTypeExcel => 'Excel Spreadsheet';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint Presentation';

  @override
  String get attachmentsTypeWebPage => 'Web Page';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension File';
  }

  @override
  String get attachmentsTypeFile => 'File';

  @override
  String get calendarUntitledEvent => 'Event';

  @override
  String get calendarAllDay => 'All day';

  @override
  String calendarYourTime(String time) {
    return '$time your time';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Join: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name has accepted: $details',
      'tentative': '$name has tentatively accepted: $details',
      'declined': '$name has declined: $details',
      'delegated': '$name has delegated: $details',
      'other': '$name has not responded to: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name has accepted the invitation',
      'tentative': '$name has tentatively accepted the invitation',
      'declined': '$name has declined the invitation',
      'delegated': '$name has delegated the invitation',
      'other': '$name has not responded to the invitation',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Map';

  @override
  String get calendarJoin => 'Join';

  @override
  String get calendarOnlineMeeting => 'Online meeting';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider meeting';
  }

  @override
  String get calendarOrganizerYou => 'You';

  @override
  String get calendarOrganizerLabel => 'organizer';

  @override
  String get calendarStatusAccepted => 'Accepted';

  @override
  String get calendarStatusMaybe => 'Maybe';

  @override
  String get calendarStatusDeclined => 'Declined';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name accepted',
      'tentative': '$name tentatively accepted',
      'declined': '$name declined',
      'delegated': '$name delegated',
      'other': '$name not responded to',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name accepted:',
      'tentative': '$name tentatively accepted:',
      'declined': '$name declined:',
      'delegated': '$name delegated:',
      'other': '$name not responded to:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '“$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name proposes a new time';
  }

  @override
  String get calendarCounterUnknown => 'An attendee proposes a new time';

  @override
  String get calendarDeclineCounter => 'The organizer kept the time';

  @override
  String calendarRefresh(String name) {
    return '$name asks for the latest version';
  }

  @override
  String get calendarRefreshUnknown => 'An attendee asks for the latest version';

  @override
  String get calendarCancelled => 'Cancelled';

  @override
  String get calendarCancelledByOrganizer => 'The organizer cancelled this event.';

  @override
  String get calendarCancelledLater => 'This event was cancelled later.';

  @override
  String get calendarOutdated => 'Out of date';

  @override
  String get calendarOutdatedDetail => 'This invitation was updated later; the newer one counts.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Location removed (was $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Location removed (was none)';

  @override
  String calendarLocationChanged(String location) {
    return 'Location changed to $location';
  }

  @override
  String get calendarNewTitle => 'New title';

  @override
  String get calendarRepeatChanged => 'The repeat changed';

  @override
  String get calendarUpdated => 'Updated';

  @override
  String get calendarUpdatedInvitation => 'Updated invitation';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Time changed from $before to $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Time zone “$zone” unknown: times as written';
  }

  @override
  String calendarNext(String when) {
    return 'Next: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count guests', one: '1 guest');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count accepted');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count maybe');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count declined');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (you)';
  }

  @override
  String get calendarAttendeeOptional => 'optional';

  @override
  String get calendarAttendeeRoom => 'room';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'You accepted an earlier version.',
      'tentative': 'You tentatively accepted an earlier version.',
      'declined': 'You declined an earlier version.',
      'delegated': 'You delegated an earlier version.',
      'other': 'You not responded to an earlier version.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Accept';

  @override
  String get calendarMaybe => 'Maybe';

  @override
  String get calendarDecline => 'Decline';

  @override
  String get calendarCommentHint => 'Comment for the organizer (optional)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Your reply goes to $organizer from $address.';
  }

  @override
  String get calendarAddComment => 'Add a Comment';

  @override
  String get calendarAddToCalendar => 'Add to Calendar';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'And $count more events in the file',
      one: 'And 1 more event in the file',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'There’s no calendar app to add the event to.';

  @override
  String get calendarCantOpenCalendar => 'Couldn’t open the calendar.';

  @override
  String get calendarCantOpenLink => 'Couldn’t open the link.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Join $provider Meeting?';
  }

  @override
  String get calendarJoinTitle => 'Join the Meeting?';

  @override
  String calendarJoinOpens(String host) {
    return 'Opens $host in your browser.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Careful: this address imitates $site with look-alike letters.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Careful: this address imitates another site with look-alike letters.';

  @override
  String calendarJoinOpen(String host) {
    return 'Open $host';
  }

  @override
  String get calendarNoOrganizer => 'This invitation has no organizer to reply to.';

  @override
  String get calendarNoAccount => 'There’s no account to reply from.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Accepted', 'tentative': 'Maybe', 'other': 'Declined'});
    return '$_temp0 · sending reply to $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Accepted', 'tentative': 'Maybe', 'other': 'Declined'});
    return '$_temp0 · reply sent';
  }

  @override
  String get calendarReplyAlreadySent => 'The reply was already sent.';

  @override
  String get calendarReplyNotSent => 'Reply not sent.';

  @override
  String get dataSmimeNeedsDevice =>
      'Your S/MIME certificate is on this device: open Loupe to sign and send this message.';

  @override
  String dataSigningFailed(String error) {
    return 'Signing failed: $error';
  }

  @override
  String get keyboardShortcuts => 'Keyboard Shortcuts';

  @override
  String get keyboardGroupGeneral => 'General';

  @override
  String get keyboardGroupMessages => 'Messages';

  @override
  String get keyboardGroupCompose => 'Compose';

  @override
  String get keyboardCommandPalette => 'Command Palette';

  @override
  String get keyboardBackClose => 'Back, Close';

  @override
  String get keyboardNextMessage => 'Next Message';

  @override
  String get keyboardPreviousMessage => 'Previous Message';

  @override
  String get keyboardOpenMessage => 'Open Message';

  @override
  String get keyboardMoveToTrash => 'Move to Trash';

  @override
  String get keyboardToggleRead => 'Mark as Read or Unread';

  @override
  String get keyboardToggleFlag => 'Flag or Unflag';

  @override
  String get keyboardCloseDraft => 'Close (Save or Delete Draft)';

  @override
  String get keyboardOr => 'or';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Shift';

  @override
  String get keyboardKeyEnter => 'Enter';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Delete';

  @override
  String get keyboardKeyBackspace => 'Backspace';

  @override
  String get mailingListsMuted => 'Thread muted. New messages in it arrive read.';

  @override
  String get mailingListsUnmuted => 'Thread unmuted.';

  @override
  String get mailingListsMuteThread => 'Mute Thread';

  @override
  String get mailingListsUnmuteThread => 'Unmute Thread';

  @override
  String get mailingListsPin => 'Pin to Mailboxes';

  @override
  String get mailingListsUnpin => 'Unpin from Mailboxes';

  @override
  String get mailingListsDefaultView => 'Open in Default View';

  @override
  String get mailingListsPlainText => 'Open as Plain Text (Mono)';

  @override
  String get mailingListsShowMuted => 'Show Muted Threads';

  @override
  String get mailingListsHideMuted => 'Hide Muted Threads';

  @override
  String get mailingListsTreatAsNewsletter => 'Treat as Newsletter';

  @override
  String get mailingListsOptions => 'List Options';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$formatted Unread');
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'New Message to List';

  @override
  String get mailingListsRowUnread => 'Unread';

  @override
  String get mailingListsRowMuted => 'Muted';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count replies', one: '1 reply');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'No Threads';

  @override
  String get mailingListsMutedHidden => 'Muted threads are hidden.';

  @override
  String get mailingListsTechnicalTitle => 'Technical Lists';

  @override
  String get mailingListsTechnicalEmpty => 'Mailing lists appear here once their mail arrives.';

  @override
  String get mailingListsTechnicalFooter =>
      'Messages from these lists open as plain text in a monospaced font, with patches shown as diffs. The Aa button still switches any message.';

  @override
  String get paletteMoveToMailbox => 'Move to Mailbox…';

  @override
  String get paletteMarkAllRead => 'Mark All as Read';

  @override
  String get paletteExportFolder => 'Export Folder…';

  @override
  String get paletteGetNewMail => 'Get New Mail';

  @override
  String get paletteSnoozed => 'Snoozed';

  @override
  String get paletteSubscriptions => 'Subscriptions';

  @override
  String get paletteDiscussions => 'Discussions';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Mailing List';

  @override
  String get paletteTag => 'Tag';

  @override
  String get paletteSwipeActions => 'Swipe Actions';

  @override
  String get paletteNotifications => 'Notifications';

  @override
  String get paletteRules => 'Rules';

  @override
  String get paletteEncryption => 'End-to-End Encryption';

  @override
  String get paletteAdvanced => 'Advanced';

  @override
  String get paletteAddAccount => 'Add Account';

  @override
  String get paletteAccount => 'Account';

  @override
  String get paletteFolders => 'Folders';

  @override
  String get paletteRecentSearch => 'Recent Search';

  @override
  String paletteSearchMail(String query) {
    return 'Search mail for “$query”';
  }

  @override
  String get palettePlaceholder => 'Search actions, mailboxes, settings';

  @override
  String get paletteNothingFound => 'Nothing found';

  @override
  String get searchNewSmartMailbox => 'New Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Shows everything matching “$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return 'Saved “$name” to Mailboxes';
  }

  @override
  String get searchMakeRule => 'Make This a Rule';

  @override
  String get searchSaveSmartMailbox => 'Save as Smart Mailbox';

  @override
  String get searchNegate => 'Negate';

  @override
  String get searchDontNegate => 'Don’t Negate';

  @override
  String get searchAllMailboxes => 'All Mailboxes';

  @override
  String get searchRecent => 'Recent Searches';

  @override
  String get searchClear => 'Clear';

  @override
  String get searchSuggestions => 'Suggestions';

  @override
  String get searchUnreadMessages => 'Unread Messages';

  @override
  String get searchFlaggedMessages => 'Flagged Messages';

  @override
  String get searchWithAttachments => 'Messages with Attachments';

  @override
  String get searchUnrepliedMessages => 'Unreplied Messages';

  @override
  String get searchTags => 'Tags';

  @override
  String get searchPeople => 'People';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'From: $name';
  }

  @override
  String get searchSearching => 'Searching…';

  @override
  String get searchNoResults => 'No Results';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted Results',
      one: '$formatted Result',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Search Menu';

  @override
  String searchSearchingAccount(String account) {
    return 'Searching $account on the server…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Searching account on the server…';

  @override
  String searchAccountFailed(String account) {
    return 'Couldn’t search $account on the server';
  }

  @override
  String get searchUnknownAccountFailed => 'Couldn’t search account on the server';

  @override
  String searchChip(String term) {
    return '$term. Double tap to edit.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Not $term. Double tap to edit.';
  }

  @override
  String get searchReadAndUnread => 'Schrödinger\'s inbox: every message here is read and unread until you open it.';

  @override
  String searchContradiction(String term) {
    return 'No message can be both “$term” and not.';
  }

  @override
  String get searchSyncDeviceOnly => 'On this device only';

  @override
  String searchSyncUnsupported(String account) {
    return 'On this device only: $account can’t keep it';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Not synced: $account has a newer format';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Waiting to sync to $account';
  }

  @override
  String searchSynced(String account) {
    return 'Synced to $account';
  }

  @override
  String get searchRename => 'Rename';

  @override
  String get searchEditSearch => 'Edit Search';

  @override
  String get searchDeleteSmartMailbox => 'Delete Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Rename Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'This smart mailbox was deleted.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes stay on this device.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes are kept on your mail server, so your other devices have them too, and so does Thunderbird with Expression Search Reloaded. Those that search every account are kept on $account; those of one folder, on that folder’s account.';
  }

  @override
  String get searchSyncVia => 'Sync via';

  @override
  String get searchSyncViaFooter => 'Choose the same account on every device.';

  @override
  String get searchGmailCantKeep => 'Gmail can’t keep Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Keep Smart Mailboxes on this device only';

  @override
  String get searchOnTheServer => 'On the Server';

  @override
  String get searchServerFooter =>
      'Server metadata (IMAP METADATA) doesn’t show in any mail app. Servers without it get a “Loupe Settings” folder holding one message; Loupe hides it from Mailboxes.';

  @override
  String get searchSyncNow => 'Sync Now';

  @override
  String get searchStateUnsupported => 'Not supported';

  @override
  String get searchStateNewerFormat => 'Newer format';

  @override
  String get searchStateFailed => 'Couldn’t sync';

  @override
  String get searchStateSyncing => 'Syncing…';

  @override
  String get searchStateWaiting => 'Waiting';

  @override
  String get searchStateMetadata => 'Server metadata';

  @override
  String get searchStateFolder => 'Loupe Settings folder';

  @override
  String get searchStateNothing => 'Nothing stored';

  @override
  String get sharedBack => 'Back';

  @override
  String get sharedYesterday => 'Yesterday';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date at $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bytes');
    return '$_temp0';
  }

  @override
  String sharedKilobytes(String size) {
    return '$size KB';
  }

  @override
  String sharedMegabytes(String size) {
    return '$size MB';
  }

  @override
  String get sharedSyncNoAccounts => 'No Accounts';

  @override
  String get sharedSyncChecking => 'Checking for Mail…';

  @override
  String get sharedSyncFailed => 'Couldn’t check for mail';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Updated Just Now';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Updated $minutes minutes ago',
      one: 'Updated 1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Updated at $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Updated $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'All Inboxes';

  @override
  String get sharedMailboxUnread => 'Unread';

  @override
  String get sharedMailboxFlagged => 'Flagged';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'All Drafts';

  @override
  String get sharedMailboxAllSent => 'All Sent';

  @override
  String get sharedMailboxUntitled => 'Mailbox';

  @override
  String get sharedTagImportant => 'Important';

  @override
  String get sharedTagWork => 'Work';

  @override
  String get sharedTagPersonal => 'Personal';

  @override
  String get sharedTagToDo => 'To Do';

  @override
  String get sharedTagLater => 'Later';

  @override
  String get sharedTags => 'Tags';

  @override
  String get sharedMoveTo => 'Move to…';

  @override
  String get sharedNoRecipients => 'No Recipients';

  @override
  String get sharedUnknownSender => 'Unknown Sender';

  @override
  String get sharedOnServer => 'On server';

  @override
  String get sharedAttachment => 'Attachment';

  @override
  String get sharedSnoozedBadge => 'Snoozed';

  @override
  String get sharedRowUnread => 'Unread';

  @override
  String get sharedRowBackFromSnooze => 'Back from snooze';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Flagged';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archived $count messages',
      one: 'Archived 1 message',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Deleted $count messages',
      one: 'Deleted 1 message',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Moved $count messages to Inbox',
      one: 'Moved 1 message to Inbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Moved $count messages to Trash',
      one: 'Moved 1 message to Trash',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Moved $count messages to Junk',
      one: 'Moved 1 message to Junk',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Moved $count messages to $mailbox',
      one: 'Moved 1 message to $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Moved $count messages to mailbox',
      one: 'Moved 1 message to mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Snoozed $count messages until $time',
      one: 'Snoozed 1 message until $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Snoozed until $time on this device only: the server can’t store snooze times.';
  }

  @override
  String get sharedMoveOneAccount => 'Select messages from one account to move them.';

  @override
  String get sharedSnoozeTitle => 'Snooze';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Change Snooze Time';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Delete $count messages permanently?',
      one: 'Delete this message permanently?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'This can’t be undone.';

  @override
  String get sharedDeletePermanently => 'Delete Permanently';

  @override
  String get sharedSwipeRead => 'Read';

  @override
  String get sharedSwipeUnread => 'Unread';

  @override
  String get sharedSwipeInbox => 'Inbox';

  @override
  String get sharedSwipeDelete => 'Delete';

  @override
  String get sharedTrash => 'Trash';

  @override
  String get sharedSwipeSnooze => 'Snooze';

  @override
  String get sharedWakeNow => 'Wake Now';

  @override
  String get sharedChangeSnoozeTime => 'Change Snooze Time…';

  @override
  String get sharedSnooze => 'Snooze…';

  @override
  String get sharedTag => 'Tag…';

  @override
  String get sharedMoveMessage => 'Move Message…';

  @override
  String get sharedNotJunk => 'Not Junk';

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
