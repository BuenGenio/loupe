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
  String get conversationSomethingWentWrong => 'Something went wrong. Try again.';

  @override
  String get conversationReplyToList => 'Reply to List';

  @override
  String get conversationReplyList => 'Reply List';

  @override
  String get conversationThreadMuted => 'Thread muted. New messages in it arrive read.';

  @override
  String get conversationThreadUnmuted => 'Thread unmuted.';

  @override
  String get conversationLinkFailed => 'Couldn\'t open the link.';

  @override
  String get conversationGoneTitle => 'No Message';

  @override
  String get conversationGoneText => 'This message was moved or deleted.';

  @override
  String get conversationMuted => 'Muted';

  @override
  String get conversationReaderOptions => 'Reader Options';

  @override
  String get conversationReaderOptionsHint => 'Text size and view';

  @override
  String get conversationTrash => 'Trash';

  @override
  String get conversationReplyHint => 'Long-press for Reply All and Forward';

  @override
  String get conversationOfflineTitle => 'You\'re Offline';

  @override
  String get conversationOfflineText =>
      'This conversation isn\'t downloaded yet. It will load when you\'re back online.';

  @override
  String get conversationErrorTitle => 'Can\'t Show This Message';

  @override
  String get conversationErrorText => 'Something went wrong.';

  @override
  String get conversationOfflineBanner => 'You\'re offline';

  @override
  String get conversationNotUpdated => 'Not updated';

  @override
  String get conversationMe => 'me';

  @override
  String get conversationNoSender => '(no sender)';

  @override
  String get conversationNoRecipients => 'no recipients';

  @override
  String conversationRecipients(String names) {
    return 'to $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'to $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'From';

  @override
  String get conversationHeaderTo => 'To';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Reply-To';

  @override
  String get conversationHeaderDate => 'Date';

  @override
  String get conversationHeaderSecurity => 'Security';

  @override
  String get conversationVerifiedSender => 'Verified sender';

  @override
  String get conversationUnverifiedSender => 'Unverified sender';

  @override
  String get conversationLoadingMessage => 'Loading message';

  @override
  String get conversationBodyError => 'This message couldn\'t be loaded.';

  @override
  String get conversationBodyOffline => 'You\'re offline. The message will load when you\'re back online.';

  @override
  String get conversationOriginalHint => 'Looks better in Original view';

  @override
  String get conversationShowOriginal => 'Show Original';

  @override
  String get conversationScrollToTop => 'Scroll to the top';

  @override
  String get conversationTagsMenu => 'Tags…';

  @override
  String get conversationMuteThread => 'Mute Thread';

  @override
  String get conversationUnmuteThread => 'Unmute Thread';

  @override
  String get conversationMoveMenu => 'Move…';

  @override
  String get conversationDeletePermanently => 'Delete Permanently';

  @override
  String get conversationMoveToTrash => 'Move to Trash';

  @override
  String get conversationNotJunk => 'Not Junk';

  @override
  String get conversationShowAllHeaders => 'Show All Headers';

  @override
  String get conversationViewSource => 'View Source';

  @override
  String get conversationSaveAsFile => 'Save as File…';

  @override
  String get conversationShareAsFile => 'Share as File…';

  @override
  String get conversationSearchFromMessageMenu => 'Search from This Message…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Copy Address';

  @override
  String get conversationAddressCopied => 'Address copied';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Search Messages from $name';
  }

  @override
  String get conversationTags => 'Tags';

  @override
  String get conversationAllHeaders => 'All Headers';

  @override
  String get conversationCopyAll => 'Copy All';

  @override
  String get conversationHeadersCopied => 'Headers copied';

  @override
  String get conversationNoHeaders => 'No headers';

  @override
  String get conversationSearchFromMessageTitle => 'Search from This Message';

  @override
  String conversationSearchFrom(String name) {
    return 'From $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'To $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Subject “$subject”';
  }

  @override
  String get conversationSourceTitle => 'Source';

  @override
  String get conversationSourceCopied => 'Source copied';

  @override
  String get conversationShareFailed => 'Couldn\'t share the message.';

  @override
  String get conversationWrapLines => 'Wrap Lines';

  @override
  String get conversationDontWrapLines => 'Don\'t Wrap Lines';

  @override
  String get conversationSourceError => 'The source couldn\'t be loaded.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Showing the first $shown of $total. Copy or share to get all of it.';
  }

  @override
  String get conversationAttachmentUntitled => 'Untitled';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'More actions for $name';
  }

  @override
  String get conversationMoveTo => 'Move to…';

  @override
  String get conversationMailboxesError => 'Couldn\'t load mailboxes.';

  @override
  String get conversationReaderReadable => 'Readable';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Plain';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Keep original colours';

  @override
  String get conversationReaderRemember => 'Remember for this sender';

  @override
  String get conversationSecurityPossiblePhishing => 'Possible phishing';

  @override
  String get conversationSecurityBeCareful => 'Be careful';

  @override
  String get conversationSecurityVerified => 'Verified';

  @override
  String get conversationSecurityNoIssues => 'No issues found';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count trackers', one: '1 tracker');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Shows why';

  @override
  String get conversationPhishingBannerTitle => 'This message looks like phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Links and images are turned off.';
  }

  @override
  String get conversationPhishingBannerText => 'Links and images are turned off.';

  @override
  String get conversationPhishingWhy => 'Why?';

  @override
  String get conversationPhishingShowAnyway => 'Show Anyway';

  @override
  String get conversationSecurityPhishingTitle => 'This looks like phishing';

  @override
  String get conversationSecurityPhishingText => 'Several signs say this message isn\'t what it claims to be.';

  @override
  String get conversationSecurityCarefulTitle => 'Be careful with this message';

  @override
  String get conversationSecurityCarefulText => 'Something about it deserves a second look.';

  @override
  String get conversationSecurityVerifiedText => 'The sender is verified and nothing looks suspicious.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nothing looks suspicious. Your mail server didn\'t say whether the sender is verified.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nothing looks suspicious.';

  @override
  String get conversationSecurityWhy => 'Why';

  @override
  String get conversationSecurityPrivacy => 'Privacy';

  @override
  String get conversationSecurityNoTrackingPixels => 'No tracking pixels';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tracking pixels removed',
      one: '1 tracking pixel removed',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'They would have told the sender when you opened this message.';

  @override
  String get conversationSecurityNoRemoteImages => 'No remote images';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count remote images',
      one: '1 remote image',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Loading them tells the sender when you read this message, and your IP address.';

  @override
  String get conversationSecurityNoClickTracking => 'No click tracking';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count links through click trackers',
      one: '1 link through click trackers',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services would record your click. Long-press a link to open its destination directly.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Technical Details';

  @override
  String get conversationSecurityCheckedLocally => 'Checked on this device. Nothing was sent anywhere.';

  @override
  String get conversationSecurityTrackersLabel => 'Trackers';

  @override
  String get conversationSecurityImagesFrom => 'Images from';

  @override
  String get conversationSecuritySenderHistory => 'Sender history';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received received, $sent sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Links lead to';

  @override
  String get conversationSecurityHidden => 'Hidden';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements elements');
    String _temp1 = intl.Intl.pluralLogic(characters, locale: localeName, other: '$characters characters');
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Sender not verified';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Your mail server couldn\'t confirm that this message really comes from $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Your mail server couldn\'t confirm that this message really comes from its sender.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Your mail server couldn\'t confirm that this message comes from $domain. Common for mailing lists.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Your mail server couldn\'t confirm that this message comes from its sender. Common for mailing lists.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Don\'t act on it unless you expected it. If in doubt, contact the sender another way.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Signed by another domain';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'The message is signed by $signer, not $domain. Mailing services do this, but it doesn\'t prove who wrote it.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'The message is signed by another domain, not $domain. Mailing services do this, but it doesn\'t prove who wrote it.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Name shows a different address';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'The sender\'s name reads “$shown”, but the message comes from $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Trust the address, not the name.';

  @override
  String get conversationSecurityReplyToTitle => 'Replies go elsewhere';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Replying would send your answer to $address, not to $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Check the address before you reply with anything personal.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Uses your name';

  @override
  String get conversationSecurityImpersonationTitle => 'Uses the name of someone you know';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'It is signed “$name”, like your own name, but comes from a new address: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'It is signed “$name”, like your VIP $knownName ($knownEmail), but comes from a new address: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'It is signed “$name”, like $knownName ($knownEmail), but comes from a new address: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'And replies would go to yet another address.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'If it asks for money, codes or files, check with them another way first.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Known address: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'This address: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'First message from this sender';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'You haven\'t had mail from $email before.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Be careful with requests from people you don\'t know yet.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Look-alike letters in the sender\'s address';

  @override
  String get conversationSecurityLinkHomographTitle => 'Look-alike letters in a link';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host mixes letters from different alphabets to imitate another address.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host uses look-alike letters: it is not $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Delete it or report it as junk.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Don\'t open it.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domain: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Look-alike domain';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Uses a familiar name in its domain';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain looks like your own domain, $real, but it is a different domain.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain looks like $brand ($real), but it is a different domain.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain uses the name of your own domain, $real, but doesn\'t belong to it.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain uses the name of $brand ($real), but doesn\'t belong to it.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Real messages from your organisation come from $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Real messages from $brand come from $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Sender domain: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imitates: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count links hide where they go',
      one: 'A link hides where it goes',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'A link shows $shown, but it opens $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Don\'t sign in or pay through these links. Type the address yourself instead.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '“$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'A link\'s destination can\'t be checked';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'A link shows $shown, but goes through $host, which records the click before passing it on.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'A link points to a bare IP address';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts isn\'t a named website. Real companies rarely link like this.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'A disguised link';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'A link starts with “$shown@” to look like $shown, but it opens $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'A hidden page was disabled';

  @override
  String get conversationSecurityDataLinkText =>
      'A link would have opened a page packed inside the message, a way around link checks.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Asks for a password';

  @override
  String get conversationSecurityPasswordFieldText => 'The message contained a password field. Loupe removed it.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Never type a password into an email.';

  @override
  String get conversationSecurityScriptLinkTitle => 'A link that runs code was disabled';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe never runs code from messages.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Shortened links', one: 'A shortened link');
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts hides the real destination until you open it.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'International web address';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts uses non-Latin letters. Normal for many languages; check it is the site you expect.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Lots of hidden text';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count characters of invisible text were removed. Hidden text like this is meant to fool spam filters.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Hidden text removed';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count characters of invisible text were removed.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Couldn\'t download the message. Check the connection and try again.';

  @override
  String exportSaved(String name) {
    return 'Saved “$name”';
  }

  @override
  String get exportSaveFailed => 'Couldn\'t save the message.';

  @override
  String exportFailed(String folder) {
    return 'Couldn\'t export “$folder”.';
  }

  @override
  String exportEmpty(String folder) {
    return '“$folder” has no messages to export.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Couldn\'t export “$folder”: no message could be downloaded. Check the connection and try again.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Saved “$name” without $formattedCount messages that couldn\'t be downloaded.',
      one: 'Saved “$name” without 1 message that couldn\'t be downloaded.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Couldn\'t save “$name”.';
  }

  @override
  String exportTitle(String folder) {
    return 'Exporting “$folder”';
  }

  @override
  String get exportListing => 'Finding messages…';

  @override
  String exportProgress(String current, String total) {
    return 'Exporting $current of $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount messages couldn\'t be downloaded',
      one: '1 message couldn\'t be downloaded',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Mailboxes';

  @override
  String get mailboxesShown => 'Shown';

  @override
  String get mailboxesHidden => 'Hidden';

  @override
  String get mailboxesCollapse => 'Collapse';

  @override
  String get mailboxesExpand => 'Expand';

  @override
  String get mailboxesManageVips => 'Manage VIPs';

  @override
  String get mailboxesSubscriptions => 'Subscriptions';

  @override
  String mailboxesShowAccount(String account) {
    return 'Show $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Hide $account';
  }

  @override
  String get mailboxesExportFolder => 'Export Folder…';

  @override
  String get mailboxesUnpin => 'Unpin';

  @override
  String get mailboxesLists => 'Lists';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Save a search to keep it here.';

  @override
  String get mailboxesTags => 'Tags';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'You can also tap a sender’s name in a message and turn on VIP.';

  @override
  String get mailboxesAddVip => 'Add VIP…';

  @override
  String get mailboxesAddVipTitle => 'Add VIP';

  @override
  String get mailboxesAddVipText => 'Mail from this address gets a star and appears in the VIP mailbox.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Unread';

  @override
  String get messageListFilterFlagged => 'Flagged';

  @override
  String get messageListFilterToMe => 'To: Me';

  @override
  String get messageListFilterCcMe => 'CC: Me';

  @override
  String get messageListFilterWithAttachments => 'With Attachments';

  @override
  String get messageListFilterUnreplied => 'Unreplied';

  @override
  String get messageListFilterFromVips => 'From VIPs';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Marked $count messages as read',
      one: 'Marked 1 message as read',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Couldn’t load older mail.';

  @override
  String get messageListSelectMessages => 'Select Messages';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Selected');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Select All';

  @override
  String get messageListDeselectAll => 'Deselect All';

  @override
  String get messageListLoadFailed => 'Couldn’t Load Mail';

  @override
  String get messageListNoUnread => 'No Unread Mail';

  @override
  String get messageListNoMatches => 'No Matching Mail';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtered by: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Turn Off Filter';

  @override
  String get messageListEmpty => 'No Mail';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filter criteria: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtered by:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$formattedCount Unread');
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Mark';

  @override
  String get messageListTrash => 'Trash';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'INCLUDE';

  @override
  String get panesHideMailboxes => 'Hide Mailboxes';

  @override
  String get panesShowMailboxes => 'Show Mailboxes';

  @override
  String get panesMailboxesWidth => 'Mailboxes width';

  @override
  String get panesListWidth => 'Message list width';

  @override
  String get panesNoMessageSelected => 'No Message Selected';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Messages', one: '1 Message');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Snoozed';

  @override
  String get snoozeSheetTitle => 'Snooze';

  @override
  String get snoozeLaterToday => 'Later Today';

  @override
  String get snoozeThisEvening => 'This Evening';

  @override
  String get snoozeTomorrow => 'Tomorrow';

  @override
  String get snoozeThisWeekend => 'This Weekend';

  @override
  String get snoozeNextWeek => 'Next Week';

  @override
  String get snoozePickDateTime => 'Pick Date & Time…';

  @override
  String get snoozeMenu => 'Snooze…';

  @override
  String get snoozeWakeNow => 'Wake Now';

  @override
  String get snoozeChangeTimeMenu => 'Change Snooze Time…';

  @override
  String get snoozeChangeTime => 'Change Time';

  @override
  String get snoozeNoTime => 'No time set';

  @override
  String get snoozeFooter => 'Snoozed messages come back to the Inbox, unread, at their time.';

  @override
  String get snoozeEmptyTitle => 'Nothing Snoozed';

  @override
  String get snoozeEmptyText => 'Snooze a message to have it come back to the Inbox when you need it.';

  @override
  String get appLockUnlock => 'Unlock';

  @override
  String get appLockFailed => 'Loupe couldn’t confirm it’s you.';

  @override
  String get appLockLockedOut => 'Too many attempts. Try again later.';

  @override
  String get appLockPromptError => 'The prompt couldn’t be shown. Try again.';

  @override
  String get appLockNoScreenLock => 'This phone has no screen lock.';

  @override
  String get appLockUnlockPromptTitle => 'Unlock Loupe';

  @override
  String get appLockUnlockPromptReason => 'Confirm it’s you to see your mail.';

  @override
  String get appLockTurnOnPromptTitle => 'Turn On App Lock';

  @override
  String get appLockTurnOnPromptReason => 'Confirm it’s you to turn on App Lock.';

  @override
  String get appLockScreenLockRemoved =>
      'App Lock is off: this phone has no screen lock any more. Set one up to turn App Lock on again.';

  @override
  String get appLockAfterImmediately => 'Immediately';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Minutes', one: '1 Minute');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Hours', one: '1 Hour');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Encrypted';

  @override
  String get openpgpEncryptedInPart => 'Encrypted in part';

  @override
  String get openpgpEncryptedLocked => 'Encrypted · locked';

  @override
  String get openpgpEncryptedNoKey => 'Encrypted · no key';

  @override
  String get openpgpEncryptedDamaged => 'Encrypted · damaged';

  @override
  String get openpgpEncryptedUnsupported => 'Encrypted · unsupported';

  @override
  String get openpgpUnknownSigner => 'unknown';

  @override
  String get openpgpUnknownKey => 'Unknown key';

  @override
  String get openpgpSignatureInvalid => 'Signature invalid';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Signed by $name, not the sender';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Signed in part by $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Signed by $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Signed with a rejected key';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Signed by $name · key not accepted';
  }

  @override
  String get openpgpUnlock => 'Unlock';

  @override
  String get openpgpCantDecrypt => 'Can’t decrypt this message';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Encrypted with OpenPGP';

  @override
  String get openpgpEncryption => 'Encryption';

  @override
  String get openpgpDecryptedHere => 'Decrypted on this device';

  @override
  String get openpgpNotDecrypted => 'Not decrypted';

  @override
  String get openpgpKeyLocked => 'Your key is locked.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'For keys $keys', one: 'For key $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Protected subject';

  @override
  String get openpgpUnlockKey => 'Unlock Key';

  @override
  String get openpgpSignature => 'Signature';

  @override
  String get openpgpFingerprint => 'Fingerprint';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Key id $id';
  }

  @override
  String get openpgpSigned => 'Signed';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Acceptance';

  @override
  String get openpgpChangeAcceptance => 'Change Acceptance…';

  @override
  String get openpgpCheckedFooter => 'Checked on this device with OpenPGP, compatible with Thunderbird.';

  @override
  String get openpgpSummaryLocked => 'Your key is locked. Unlock it with its passphrase to read this message.';

  @override
  String get openpgpSummaryNoSecretKey => 'It was encrypted to a key that isn’t on this device.';

  @override
  String get openpgpSummaryDamaged => 'The encrypted data is damaged or was changed on the way.';

  @override
  String get openpgpSummaryUnsupported => 'It uses an algorithm Loupe doesn’t support.';

  @override
  String get openpgpSummaryEncrypted => 'Only you and the other recipients can read it.';

  @override
  String get openpgpSummaryNotSigned => 'It isn’t signed, so the sender isn’t confirmed.';

  @override
  String get openpgpSummaryUnknownKey =>
      'It is signed, but with a key you don’t have, so the signature can’t be checked.';

  @override
  String get openpgpSummaryBadSignature => 'The signature doesn’t match: the message may have been changed.';

  @override
  String get openpgpSummaryMismatch =>
      'The signature is valid, but the key belongs to another address than the sender’s.';

  @override
  String get openpgpSummaryPartial =>
      'Only part of the message is signed. Text outside the signature (a mailing list footer, for example) is shown below the “Unsigned content” line, and other parts of the message, such as attachments, aren’t covered either.';

  @override
  String get openpgpSummaryOwnKey => 'Signed with your own key.';

  @override
  String get openpgpSummaryVerified => 'The signature is valid, and you verified the key’s fingerprint.';

  @override
  String get openpgpSummaryUnverified =>
      'The signature is valid. You accepted the key without checking its fingerprint.';

  @override
  String get openpgpSummaryRejected => 'The signature is valid, but you rejected this key.';

  @override
  String get openpgpSummaryUndecided =>
      'The signature is valid, but you haven’t accepted this key yet. Compare its fingerprint with the sender.';

  @override
  String get openpgpAcceptanceRejected => 'Rejected';

  @override
  String get openpgpAcceptanceUndecided => 'Not accepted';

  @override
  String get openpgpAcceptanceUnverified => 'Accepted';

  @override
  String get openpgpAcceptanceVerified => 'Accepted and verified';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Accept $name’s key?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Fingerprint $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Yes, I verified the fingerprint';

  @override
  String get openpgpAcceptUnverified => 'Yes, without checking';

  @override
  String get openpgpAcceptLater => 'Not yet';

  @override
  String get openpgpRejectKey => 'Reject this key';

  @override
  String get openpgpNoSubject => '(no subject)';

  @override
  String get openpgpEncryptionTitle => 'End-to-End Encryption';

  @override
  String get openpgpMyKeys => 'My OpenPGP Keys';

  @override
  String get openpgpMyKeysFooter =>
      'With a key, you can read encrypted mail and sign and encrypt your own. Using Thunderbird? Export your key there (Account Settings › End-To-End Encryption › Export Secret Key) and import it here.';

  @override
  String get openpgpAddKey => 'Add Key…';

  @override
  String get openpgpAddresses => 'Addresses';

  @override
  String get openpgpAddressesFooter => 'Which key each address uses, and when it encrypts and signs.';

  @override
  String get openpgpCorrespondentsKeys => 'Correspondents’ OpenPGP Keys';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Accept a key once you trust it belongs to its owner; compare the fingerprint with them to mark it verified.';

  @override
  String get openpgpImportPublicKey => 'Import Public Key…';

  @override
  String get openpgpCollected => 'Collected from Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Keys that arrived with messages. Loupe can encrypt to them when both sides ask for it.';

  @override
  String get openpgpOnThisDevice => 'On This Device';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Encrypted messages hide their subject. Loupe keeps the subject of each message you open in its encrypted database on this device, so the list, search and notifications show it. In the background, Loupe can also decrypt the subjects of new messages with keys that have no passphrase; it downloads each message (up to 1 MB) to do so.';

  @override
  String get openpgpDecryptSubjects => 'Decrypt Subjects in the Background';

  @override
  String get openpgpIndexFooter =>
      'Search finds encrypted messages by their sender, recipients and subject. With this on, Loupe also adds the text of each encrypted message it decrypts to the search index in its encrypted database on this device, so search finds it by its text too. Turning it off removes that text from the index.';

  @override
  String get openpgpIndexDecrypted => 'Index Decrypted Messages for Search';

  @override
  String get openpgpPassphrases => 'Passphrases';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP keys and S/MIME certificates you protect with a passphrase are unlocked when needed. Without \"Remember\", they are locked again two minutes after each use.';

  @override
  String get openpgpRememberPassphrases => 'Remember Passphrases';

  @override
  String get openpgpRememberPassphrasesDetail => 'Until Loupe closes';

  @override
  String get openpgpLockKeysNow => 'Lock Keys Now';

  @override
  String get openpgpKeysLocked => 'Keys locked.';

  @override
  String get openpgpKeyStateRevoked => 'revoked';

  @override
  String get openpgpKeyStateExpired => 'expired';

  @override
  String get openpgpKeyStateNeverExpires => 'never expires';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'expires $date';
  }

  @override
  String get openpgpNoKey => 'No Key';

  @override
  String get openpgpAlwaysEncrypt => 'Always Encrypt';

  @override
  String get openpgpAddKeyTitle => 'Add an OpenPGP Key';

  @override
  String get openpgpAddKeyMessage => 'Import the key you use in Thunderbird, or make a new one.';

  @override
  String get openpgpImportFromClipboard => 'Import from Clipboard';

  @override
  String get openpgpImportFromFile => 'Import from File';

  @override
  String get openpgpGenerateNewKey => 'Generate New Key';

  @override
  String get openpgpImportPublicKeyTitle => 'Import a Public Key';

  @override
  String get openpgpFromClipboard => 'From Clipboard';

  @override
  String get openpgpFromFile => 'From File';

  @override
  String get openpgpClipboardEmpty => 'The clipboard is empty. Copy the key first.';

  @override
  String get openpgpKey => 'Key';

  @override
  String get openpgpValidityRevoked => 'Revoked';

  @override
  String openpgpValidityExpired(String date) {
    return 'Expired $date';
  }

  @override
  String get openpgpNeverExpires => 'Never expires';

  @override
  String openpgpValidUntil(String date) {
    return 'Valid until $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Fingerprint copied.';

  @override
  String get openpgpAlgorithm => 'Algorithm';

  @override
  String get openpgpCreated => 'Created';

  @override
  String get openpgpValidity => 'Validity';

  @override
  String get openpgpProtection => 'Protection';

  @override
  String get openpgpProtectionPassphrase => 'Passphrase';

  @override
  String get openpgpProtectionKeychain => 'Keychain only';

  @override
  String get openpgpKeyDetailsFooter =>
      'Share your public key so others can encrypt to you. The backup is your secret key, protected by its passphrase if it has one: keep it private.';

  @override
  String get openpgpSharePublicKey => 'Share Public Key';

  @override
  String get openpgpCopyPublicKey => 'Copy Public Key';

  @override
  String get openpgpPublicKeyCopied => 'Public key copied.';

  @override
  String get openpgpBackUpSecretKey => 'Back Up Secret Key';

  @override
  String get openpgpDeleteKey => 'Delete Key';

  @override
  String get openpgpRemoveKey => 'Remove Key';

  @override
  String get openpgpBackUpTitle => 'Back Up Secret Key?';

  @override
  String get openpgpBackUpProtected =>
      'The backup is protected by your key’s passphrase. Anyone with both can read your mail.';

  @override
  String get openpgpBackUpUnprotected =>
      'This key has no passphrase: anyone with the backup can read your mail and sign as you.';

  @override
  String get openpgpBackUp => 'Back Up';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Delete your key $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Remove $name’s key?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Mail encrypted to this key can’t be read on this device anymore, unless you import it again.';

  @override
  String get openpgpRemoveKeyMessage => 'You can import it again later.';

  @override
  String get openpgpKeyHeader => 'OpenPGP Key';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Add a key in End-to-End Encryption to encrypt and sign mail from this address.';

  @override
  String get openpgpGenerateAKey => 'Generate a Key…';

  @override
  String get openpgpSending => 'Sending';

  @override
  String get openpgpSendingFooter =>
      'Automatic encryption turns on when every recipient has an accepted key or a trusted certificate, or when Autocrypt says both sides want it. Encrypted mail is always signed.';

  @override
  String get openpgpEncryptAutomatically => 'Encrypt Automatically';

  @override
  String get openpgpAlwaysEncryptDetail => 'Refuses to send when a recipient has no key';

  @override
  String get openpgpSignUnencrypted => 'Sign Unencrypted Mail';

  @override
  String get openpgpAttachPublicKey => 'Attach My Public Key';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt sends your public key along with every message, so other apps can encrypt to you without any setup.';

  @override
  String get openpgpSendMyKey => 'Send My Key with Mail';

  @override
  String get openpgpPreferEncryption => 'Prefer Encryption';

  @override
  String get openpgpPreferEncryptionDetail => 'Ask others to encrypt when they can';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count years', one: '1 year');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'The passphrases don’t match.';

  @override
  String openpgpKeyReady(String id) {
    return 'Your key $id is ready.';
  }

  @override
  String get openpgpNewKey => 'New Key';

  @override
  String get openpgpNewKeyFor => 'For';

  @override
  String get openpgpYourName => 'Your name';

  @override
  String get openpgpAddress => 'Address';

  @override
  String get openpgpPassphrase => 'Passphrase';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Optional. Without one, your phone’s keychain alone protects the key and Loupe never asks. With one, Loupe asks for it when the key is needed.';

  @override
  String get openpgpRepeatPassphrase => 'Repeat';

  @override
  String get openpgpExpires => 'Expires';

  @override
  String get openpgpExpiresFooter => 'You can make a new key before it expires. Thunderbird uses three years too.';

  @override
  String get openpgpGenerateKey => 'Generate Key';

  @override
  String get openpgpKeyFor => 'Key for';

  @override
  String get openpgpCantEncrypt => 'Can’t Encrypt';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'There is no OpenPGP key for $names, and this address always encrypts. Remove the recipient, or import their key in Settings › End-to-End Encryption.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'There is no valid S/MIME certificate for $names, and this address always encrypts. Remove the recipient, or import their certificate in Settings › End-to-End Encryption.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'There is no OpenPGP key for $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'There is no valid S/MIME certificate for $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Send Unencrypted';

  @override
  String get openpgpCantSign => 'Can’t Sign';

  @override
  String get openpgpCantSignMessage =>
      'The private key of your S/MIME certificate isn’t on this device. Import the certificate again (a .p12 or .pfx file) in Settings › End-to-End Encryption.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'No key for $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'No certificate for $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Keys from Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Everyone has a key';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Everyone has a certificate';

  @override
  String get openpgpComposeEncrypt => 'Encrypt';

  @override
  String get openpgpComposeSign => 'Sign';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, switch';
  }

  @override
  String get openpgpNoKeyFound => 'No OpenPGP key found.';

  @override
  String get openpgpImportSecretKeyTitle => 'Import a Secret Key?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'This attachment holds a secret key ($names). Import it as your own key only if you exported it yourself, from Thunderbird for example.';
  }

  @override
  String get openpgpImportAsMyKey => 'Import as My Key';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'your key $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Import $count keys ($names)?',
      one: 'Import $names’s key?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Import and Accept';

  @override
  String get openpgpImportDecideLater => 'Import, Decide Later';

  @override
  String openpgpImportedPublicKey(String name) {
    return '$name’s key';
  }

  @override
  String openpgpImported(String keys) {
    return 'Imported $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP keys are attached.',
      one: 'An OpenPGP key is attached.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Import';

  @override
  String get openpgpUnlockKeyTitle => 'Unlock OpenPGP Key';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Enter the passphrase of $name’s key ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'That passphrase is wrong. Try again.';

  @override
  String get openpgpExplainLocked => 'This message is encrypted. Unlock your OpenPGP key to read it.';

  @override
  String get openpgpExplainNoKey =>
      'This message is encrypted, but not to any OpenPGP key on this device. If you read it in Thunderbird, import your key from there: Settings › End-to-End Encryption.';

  @override
  String get openpgpExplainDamaged => 'This encrypted message is damaged, so it can’t be decrypted safely.';

  @override
  String get openpgpExplainUnsupported => 'This message uses encryption that Loupe can’t read yet.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'This message is encrypted with S/MIME, but not to any certificate on this device. Import your certificate (a .p12 or .pfx file) in Settings › End-to-End Encryption.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'This message is encrypted. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Unlock your S/MIME certificate to read it.';

  @override
  String get openpgpAttachmentGone => 'This attachment is no longer available.';

  @override
  String get smimeEncrypted => 'Encrypted (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Encrypted (S/MIME) · no certificate';

  @override
  String get smimeEncryptedDamaged => 'Encrypted (S/MIME) · damaged';

  @override
  String get smimeEncryptedUnsupported => 'Encrypted (S/MIME) · unsupported';

  @override
  String get smimeEncryptedLocked => 'Encrypted (S/MIME) · locked';

  @override
  String get smimeUnknownSigner => 'unknown';

  @override
  String get smimeSignatureModified => 'Signature invalid: message modified';

  @override
  String get smimeSignatureWeak => 'Signature insecure: outdated algorithm';

  @override
  String get smimeSignatureUncheckable => 'Signature can’t be checked';

  @override
  String get smimeSignedCertificateMissing => 'Signed · certificate missing';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Signed by $name · certificate revoked';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Signed by $name · at another date';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Signed by $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Signed by $name · invalid certificate';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Signed by $name · not trusted';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Signed by $name · certificate expired';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Signed by $name · certificate not yet valid';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Signed by $name · certificate not for mail';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Signed by $name, not the sender';
  }

  @override
  String get smimeCantDecrypt => 'Can’t decrypt this message';

  @override
  String get smimeEncryptedWithSmime => 'Encrypted with S/MIME';

  @override
  String get smimeEncryption => 'Encryption';

  @override
  String get smimeDecryptedHere => 'Decrypted on this device';

  @override
  String get smimeNotDecrypted => 'Not decrypted';

  @override
  String get smimeAuthenticated => 'authenticated';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'for $count certificates',
      one: 'for 1 certificate',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Signature';

  @override
  String get smimeIssuedBy => 'Issued by';

  @override
  String get smimeValid => 'Valid';

  @override
  String smimeValidRange(String from, String to) {
    return '$from to $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 fingerprint';

  @override
  String get smimeSigned => 'Signed';

  @override
  String get smimeProblem => 'Problem';

  @override
  String get smimeCheckingRevocation => 'Checking revocation…';

  @override
  String get smimeNotRevoked => 'Not revoked';

  @override
  String get smimeRevoked => 'Revoked';

  @override
  String get smimeRevocationUnknown => 'Revocation unknown';

  @override
  String smimeRevokedSince(String date) {
    return 'Since $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Asked the authority (its revocation list), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Asked the authority (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Trust “$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Trust This Certificate…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Checked on this device with S/MIME, compatible with Outlook and Thunderbird; revocation with the certificate authority.';

  @override
  String get smimeCheckedFooter =>
      'Checked on this device with S/MIME, compatible with Outlook and Thunderbird. Revocation isn’t checked (Settings › End-to-End Encryption).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Trust $name for mail?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Trust $name’s certificate?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Every certificate this authority issues will be trusted, like your company’s CA. Compare the fingerprint with its owner first:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Compare the fingerprint with its owner first:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Trust';

  @override
  String get smimeSummaryNoKey => 'It was encrypted to a certificate that isn’t on this device.';

  @override
  String get smimeSummaryDamaged => 'The encrypted data is damaged or was changed on the way.';

  @override
  String get smimeSummaryUnsupported => 'It uses an algorithm Loupe doesn’t support.';

  @override
  String get smimeSummaryLocked => 'Your S/MIME certificate is locked.';

  @override
  String get smimeSummaryEncrypted => 'Only you and the other recipients can read it.';

  @override
  String get smimeSummaryNotSigned => 'It isn’t signed, so the sender isn’t confirmed.';

  @override
  String get smimeSummaryModified => 'The signature doesn’t match: the message was changed after it was signed.';

  @override
  String get smimeSummaryUncheckable => 'The signature can’t be checked.';

  @override
  String get smimeSummaryNoCertificate => 'The signer’s certificate isn’t in the message, so it can’t be checked.';

  @override
  String get smimeSummaryRevoked =>
      'The certificate authority revoked the signer’s certificate: the signature can’t be trusted.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'The certificate authority revoked the signer’s certificate ($reason): the signature can’t be trusted.';
  }

  @override
  String get smimeDateMismatch =>
      'It was signed more than an hour away from the message’s date: it may be an old message sent again.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'The signature is valid, and $issuer vouches that the certificate belongs to the sender.';
  }

  @override
  String get smimeProblemInvalidChain => 'The certificate or one of its issuers is invalid.';

  @override
  String get smimeProblemUntrusted => 'The certificate comes from an authority Loupe doesn’t trust.';

  @override
  String get smimeProblemExpired => 'The certificate had expired.';

  @override
  String get smimeProblemNotYetValid => 'The certificate wasn’t valid yet.';

  @override
  String get smimeProblemWrongUsage => 'The certificate isn’t meant for mail.';

  @override
  String get smimeProblemWrongAddress => 'The certificate belongs to another address than the sender’s.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Trusted · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Not trusted · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Expired $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Valid from $date';
  }

  @override
  String get smimeTrustInvalid => 'Invalid';

  @override
  String get smimeTrustNotForMail => 'Not for mail';

  @override
  String get smimeTrustAnotherAddress => 'Another address';

  @override
  String get smimeMyCertificates => 'My S/MIME Certificates';

  @override
  String get smimeMyCertificatesFooter =>
      'For S/MIME, as Outlook and many companies use it. Import your certificate with its private key (a .p12 or .pfx file), exported from Outlook, Windows, macOS or Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'For S/MIME, as Outlook and many companies use it. Import your certificate with its private key (a .p12 or .pfx file), exported from Outlook, Windows, macOS or Thunderbird, or use one your company or you installed on this device.';

  @override
  String get smimeCertificateExpired => 'expired';

  @override
  String smimeCertificateUntil(String date) {
    return 'until $date';
  }

  @override
  String get smimeCertificateOnDevice => 'on this device';

  @override
  String get smimeImportCertificateEllipsis => 'Import Certificate…';

  @override
  String get smimeUseDeviceCertificate => 'Use a Certificate from This Device…';

  @override
  String get smimeCorrespondentsCertificates => 'Correspondents’ Certificates';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Collected from signed mail, as Outlook and Thunderbird do. Mail is encrypted only to trusted certificates: Loupe trusts the authorities Mozilla trusts for email, and those you add.';

  @override
  String get smimeRevocation => 'Revocation';

  @override
  String get smimeRevocationFooter =>
      'When you open signed mail, Loupe asks the authority that issued the signer’s certificate whether it was revoked (its OCSP responder, or its revocation list). The authority can then see when someone at your internet address reads mail signed with that certificate. Answers are kept on this device until they expire. A revoked certificate shows as \"Revoked\" in the message header.';

  @override
  String get smimeCheckRevocation => 'Check Certificate Revocation Online';

  @override
  String get smimeTrustedAuthorities => 'Trusted Authorities';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Trusted by you, besides the $count that Mozilla trusts for email.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Certificate authority';

  @override
  String get smimeImportACertificate => 'Import a Certificate';

  @override
  String get smimeImportContactMessage =>
      'A correspondent’s certificate (.cer, .crt, .pem) or a certificate authority’s.';

  @override
  String get smimeFromClipboard => 'From Clipboard';

  @override
  String get smimeFromFile => 'From File';

  @override
  String get smimeClipboardEmpty => 'The clipboard is empty. Copy the certificate first.';

  @override
  String get smimeCertificate => 'Certificate';

  @override
  String get smimeOnDeviceFooter =>
      'Its private key stays in Android’s credential storage, where your company or you installed it: Loupe asks Android to sign and decrypt with it. Signed mail is signed when you send it.';

  @override
  String get smimeAddresses => 'Addresses';

  @override
  String get smimeUsage => 'For';

  @override
  String get smimeUsageNone => 'Nothing Loupe uses';

  @override
  String get smimeUsageSigning => 'Signing';

  @override
  String get smimeUsageEncryption => 'Encryption';

  @override
  String get smimeUsageCertificates => 'Certificates';

  @override
  String get smimeAlgorithm => 'Algorithm';

  @override
  String get smimeSerialNumber => 'Serial number';

  @override
  String get smimeFingerprintCopied => 'Fingerprint copied.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 thumbprint';

  @override
  String get smimePrivateKey => 'Private key';

  @override
  String get smimeKeyOnDevice => 'On this device';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'In Loupe, with a passphrase';

  @override
  String get smimeKeyInLoupe => 'In Loupe';

  @override
  String get smimeSource => 'From';

  @override
  String get smimeSourceSignedMail => 'Signed mail';

  @override
  String get smimeSourceImported => 'Imported';

  @override
  String get smimeTrustHeader => 'Trust';

  @override
  String get smimeTrustedRoot => 'Trusted root';

  @override
  String get smimeIssuer => 'Issuer';

  @override
  String smimeTrustNamed(String name) {
    return 'Trust “$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Trust This Authority';

  @override
  String get smimeTrustThisCertificate => 'Trust This Certificate';

  @override
  String get smimeStopTrusting => 'Stop Trusting';

  @override
  String get smimePassphrase => 'Passphrase';

  @override
  String get smimePassphraseFooter =>
      'Optional. With a passphrase, the private key is also encrypted on this device (Argon2id and AES-256), and Loupe asks for it to sign and decrypt; Remember Passphrases says for how long. Mail you send is signed as you send it; background work can’t use the key.';

  @override
  String get smimeChangePassphrase => 'Change Passphrase…';

  @override
  String get smimeSetPassphraseEllipsis => 'Set Passphrase…';

  @override
  String get smimeRemovePassphrase => 'Remove Passphrase';

  @override
  String get smimeShareCertificate => 'Share Certificate';

  @override
  String get smimeDeleteCertificate => 'Delete Certificate';

  @override
  String get smimeRemoveCertificate => 'Remove Certificate';

  @override
  String get smimePassphraseChanged => 'Passphrase changed.';

  @override
  String get smimePassphraseSet => 'Passphrase set.';

  @override
  String get smimeRemovePassphraseTitle => 'Remove the Passphrase?';

  @override
  String get smimeRemovePassphraseMessage =>
      'The private key is then protected by the keychain only, as without a passphrase: Loupe no longer asks for it, and background work can use it.';

  @override
  String get smimePassphraseRemoved => 'Passphrase removed.';

  @override
  String smimeTrustTitle(String name) {
    return 'Trust $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Every certificate it issues will be trusted for mail. Compare the fingerprint with its owner first:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Delete your certificate $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Remove $name’s certificate?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe stops using it: mail encrypted to it can’t be read in Loupe anymore. The certificate stays on this device (Settings › Security › Encryption & credentials).';

  @override
  String get smimeDeleteOwnMessage =>
      'Its private key is deleted from this device: mail encrypted to it can’t be read here anymore, unless you import it again.';

  @override
  String get smimeRemoveContactMessage => 'It comes back with their next signed message.';

  @override
  String get smimeAddressImportFooter =>
      'Import a certificate for this address to sign and encrypt with S/MIME, as Outlook does.';

  @override
  String get smimeImportACertificateEllipsis => 'Import a Certificate…';

  @override
  String get smimePreferFooter =>
      'When both could protect a message, the preferred one is used, unless only the other has a key or certificate for every recipient.';

  @override
  String get smimePreferSmime => 'Prefer S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Rather than OpenPGP';

  @override
  String get smimeCertificatePassword => 'Certificate Password';

  @override
  String get smimeCertificatePasswordPrompt => 'Enter the password the certificate file was exported with.';

  @override
  String get smimeImport => 'Import';

  @override
  String get smimeWrongPassword => 'That password is wrong. Try again.';

  @override
  String get smimeNoCertificateFound => 'No certificate found.';

  @override
  String smimeCertificateOf(String name) {
    return '$name’s certificate';
  }

  @override
  String get smimeNothingNew => 'Nothing new to import.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Imported $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imported $count trusted authorities.',
      one: 'Imported a trusted authority.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imported $certificates and $count trusted authorities.',
      one: 'Imported $certificates and a trusted authority.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'This file has no private key. Export your certificate with its private key.';

  @override
  String get smimeImportAsYoursTitle => 'Import as Your Certificate?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'This attachment holds a certificate with its private key: $names. Import it only if you exported it yourself, from Outlook or Thunderbird for example.';
  }

  @override
  String get smimeImportAsMine => 'Import as My Certificate';

  @override
  String smimeImportedOwn(String names) {
    return 'Imported your certificate $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Added your certificate $name ($addresses) from this device.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Trust “$name” for Mail?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe doesn’t know this certificate authority (a company’s own, perhaps). Trust it to check the certificates it issues. Compare its fingerprint with your IT department first:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count certificates are attached.',
      one: 'A certificate is attached.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Import Certificate';

  @override
  String get smimeUnlockTitle => 'Unlock S/MIME Certificate';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Enter the passphrase of $name’s certificate ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'That passphrase is wrong. Try again.';

  @override
  String get smimeUnlock => 'Unlock';

  @override
  String get smimeEnterAPassphrase => 'Enter a passphrase.';

  @override
  String get smimePassphrasesDiffer => 'The two passphrases differ.';

  @override
  String get smimeSetPassphraseTitle => 'Set Passphrase';

  @override
  String get smimeSetPassphraseText =>
      'Loupe will ask for it to sign and decrypt. If you forget it, import the certificate again from its .p12 file.';

  @override
  String get smimePassphraseAgain => 'Again';

  @override
  String get smimeSetPassphraseButton => 'Set';

  @override
  String get smimeLockedOpenAgain => 'Your S/MIME certificate is locked. Open the message again to unlock it.';

  @override
  String get smimeDeviceHasNoCertificates => 'This device doesn’t offer its certificates.';

  @override
  String get smimeCantReadCertificate => 'Loupe can’t read this certificate.';

  @override
  String get smimeCertificateNotForMail =>
      'This certificate isn’t for mail: it has no email address, or isn’t meant for signing or encrypting.';

  @override
  String get smimeDeviceCertificateGone =>
      'The certificate isn’t on this device anymore, or Loupe may no longer use it. Choose it again in Settings › End-to-End Encryption.';

  @override
  String get smimeDeviceCertificateAppOnly => 'The certificate on this device can only be used while Loupe is open.';

  @override
  String get smimeDeviceKeyDamaged => 'The encrypted key is damaged.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'The certificate on this device can’t do this: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'not supported';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'The certificate on this device failed: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'The authority’s address isn’t a web address.';

  @override
  String get smimeAuthorityTimeout => 'The certificate authority didn’t answer in time.';

  @override
  String get smimeAuthorityUnreachable => 'The certificate authority couldn’t be reached.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'The certificate authority answered $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'The certificate authority’s answer is too large.';

  @override
  String get smimeRevocationNotChecked => 'Not checked: only certificates from an authority Loupe trusts are checked.';

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
  String get accountSetupTitle => 'Add Account';

  @override
  String get accountSetupTitleDone => 'Account Added';

  @override
  String get accountSetupAddressTitle => 'Add a Mail Account';

  @override
  String get accountSetupAddressText => 'Loupe finds the settings for most providers.';

  @override
  String get accountSetupNameHint => 'Your name';

  @override
  String get accountSetupEmail => 'Email';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Continue';

  @override
  String get accountSetupLookingUp => 'Looking up settings…';

  @override
  String get accountSetupImport => 'Import from Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Enter a valid email address.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Couldn\'t find settings for $domain. Enter them below.';
  }

  @override
  String get accountSetupCheckServers => 'Check the server names and ports.';

  @override
  String get accountSetupEnterPassword => 'Enter your password.';

  @override
  String get accountSetupConnecting => 'Connecting…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Waiting for $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Couldn\'t open the page.';

  @override
  String get accountSetupCouldNotSaveName => 'Couldn’t save the name.';

  @override
  String get accountSetupTrustCertificate => 'Trust This Certificate';

  @override
  String get accountSetupPasswordRequired => 'Required';

  @override
  String get accountSetupShowPassword => 'Show password';

  @override
  String get accountSetupHidePassword => 'Hide password';

  @override
  String get accountSetupAppPassword => 'App Password';

  @override
  String get accountSetupApiToken => 'API Token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Incoming · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Outgoing · SMTP';

  @override
  String get accountSetupSignIn => 'Sign In';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Sign in with $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Use an App Password';

  @override
  String get accountSetupUseAppPasswordInstead => 'Use an App Password Instead';

  @override
  String get accountSetupUseDifferentAddress => 'Use a Different Address';

  @override
  String get accountSetupHowToCreateAppPassword => 'How to Create an App Password';

  @override
  String get accountSetupHowToCreateOne => 'How to Create One';

  @override
  String get accountSetupGoogleNote =>
      'You sign in on Google’s page, and Loupe never sees your password. Allow Loupe to read, send and organise your mail.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '“Sign in with Google” isn\'t available in this build yet. You can connect with an app password instead (it needs 2-Step Verification on your Google account).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Create an app password in your Google account and paste it below.';

  @override
  String get accountSetupMicrosoftNote =>
      'You sign in on Microsoft’s page, and Loupe never sees your password. This works for Outlook.com and Hotmail, and for work or school accounts on Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Microsoft sign-in arrives in a later build. Outlook, Hotmail and Microsoft 365 accounts need it: they no longer accept passwords from mail apps.';

  @override
  String get accountSetupICloudNote => 'iCloud Mail needs an app-specific password, not your Apple Account password.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail needs an app password, not your account password.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe connects to Fastmail over JMAP with an API token: Settings › Privacy & Security › Manage API tokens, for JMAP, with access to email and sending.';

  @override
  String get accountSetupFastmailNote => 'Fastmail needs an app password for mail apps.';

  @override
  String get accountSetupServerSettings => 'Server Settings';

  @override
  String get accountSetupSettingsNotFound => 'Not found automatically';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Found via $source';
  }

  @override
  String get accountSetupEditSettings => 'Edit Settings';

  @override
  String get accountSetupSyncing => 'Your mail is syncing.';

  @override
  String get accountSetupDescription => 'Description';

  @override
  String get accountSetupDescriptionHint => 'Work, Personal…';

  @override
  String get accountSetupColour => 'Colour';

  @override
  String accountSetupColourNumber(int number) {
    return 'Colour $number';
  }

  @override
  String get accountSetupSaving => 'Saving…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe couldn’t open its mail database on this phone. Close Loupe, open it again and retry.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Something went wrong ($error). Try again.';
  }

  @override
  String get accountSetupSecurityNone => 'None';

  @override
  String get accountSetupProtocol => 'Protocol';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Security';

  @override
  String get accountSetupUsername => 'Username';

  @override
  String get accountSetupUsernameHint => 'Your email address';

  @override
  String get accountSetupNoEncryptionTitle => 'Connect Without Encryption?';

  @override
  String get accountSetupNoEncryptionText =>
      'Your password and every message would travel as plain text. Anyone on the network, such as public Wi-Fi, could read them. Only use this for a server on your own network.';

  @override
  String get accountSetupUseWithoutEncryption => 'Use Without Encryption';

  @override
  String get accountSetupApiTokenRejected =>
      'API token rejected. Create a Fastmail API token for JMAP with access to email, and paste it.';

  @override
  String get accountSetupAppPasswordRejected => 'Password rejected. Use an app password, not your account password.';

  @override
  String get accountSetupPasswordRejected => 'Password rejected. Check it and try again.';

  @override
  String get accountSetupServerUnreachable => 'Can\'t reach server. Check the server settings and your connection.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'The server\'s certificate isn\'t trusted. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Sign-in was cancelled. Tap “Sign in with $provider” to try again.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe needs permission to read and send your Gmail. Sign in again and allow access, with the Gmail box ticked.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe needs permission to read and send your mail. Sign in again and accept the permissions.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Your organisation must approve Loupe before you can use it with this account. Ask your IT administrator to grant admin consent for Loupe in Microsoft Entra ID, then try again.';

  @override
  String get accountSetupOAuthBlocked =>
      'Your organisation’s sign-in rules don’t allow Loupe on this device. Ask your IT administrator.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Couldn’t reach $provider. Check your internet connection and try again.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Sign-in with $provider isn’t set up correctly in this version of Loupe. Please report this.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Sign-in with $provider didn’t work. Try again.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider signed you in, but Gmail refused access for this address. Choose the same account when signing in. Work or school accounts may have IMAP turned off by their administrator.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider signed you in, but the mail server refused access for this address. Choose the same account when signing in. Work or school accounts may have IMAP turned off by their administrator.';
  }

  @override
  String get accountSetupOAuthServerUnreachable => 'Can\'t reach the mail server. Check your connection and try again.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Sign-in with $provider isn’t available in this version.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Signed in again. $account is syncing.';
  }

  @override
  String get accountSetupSignInAgain => 'Sign In Again';

  @override
  String get accountSetupSigningIn => 'Signing In…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider no longer accepts Loupe’s sign-in for $email, so $account isn’t syncing. Sign in again to get its mail.';
  }

  @override
  String get accountImportTitle => 'Import from Thunderbird';

  @override
  String get accountImportPointCamera => 'Point the camera at the QR code Thunderbird shows.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Scanned $scanned of $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(total, locale: localeName, other: 'Scanned $scanned of $total codes');
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts so far',
      one: '1 account so far',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'On your computer, open Thunderbird and choose Tools › Export for Mobile. Select your accounts, then scan each code it shows. Codes can be scanned in any order.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continue with $count Accounts',
      one: 'Continue with 1 Account',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Paste Text Instead';

  @override
  String get accountImportStartOver => 'Start Over';

  @override
  String get accountImportDuplicateCode => 'That code was already added.';

  @override
  String get accountImportRestarted => 'This code is from a new export, so the codes scanned before were set aside.';

  @override
  String get accountImportNotThunderbird => 'This isn\'t a Thunderbird account code.';

  @override
  String get accountImportNewerVersion => 'This code comes from a newer Thunderbird. Update Loupe to import it.';

  @override
  String get accountImportDamaged => 'This Thunderbird code couldn\'t be read.';

  @override
  String get accountImportTooLarge => 'This code is too large to be a Thunderbird export.';

  @override
  String get accountImportCouldNotOpenSettings => 'Couldn’t open Settings.';

  @override
  String get accountImportCameraOffTitle => 'Camera Access Is Off';

  @override
  String get accountImportCameraOffText =>
      'Allow Loupe to use the camera in Settings to scan the code, or paste the code’s text instead.';

  @override
  String get accountImportNoCameraTitle => 'No Camera';

  @override
  String get accountImportNoCameraText => 'Loupe can’t use a camera here. Paste the code’s text instead.';

  @override
  String get accountImportCameraFailedTitle => 'The Camera Didn’t Start';

  @override
  String get accountImportCameraFailedText => 'Try again, or paste the code’s text instead.';

  @override
  String get accountImportOpenSettings => 'Open Settings';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Found $count Accounts',
      one: 'Found 1 Account',
      zero: 'No Accounts Found',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'None of the accounts in these codes could be read.';

  @override
  String get accountImportChoose => 'Choose the accounts to add to Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Codes $codes of $total weren’t scanned, so their accounts aren’t listed.',
      one: 'Code $codes of $total wasn’t scanned, so its accounts aren’t listed.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes and $last';
  }

  @override
  String get accountImportScanMore => 'Scan More Codes';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts in the codes couldn’t be read. They may use settings from a newer Thunderbird.',
      one: '1 account in the codes couldn’t be read. They may use settings from a newer Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Scan Again';

  @override
  String get accountImportAlreadyAdded => 'An account with this address is already in Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'You’ll sign in with $provider when it’s added, as in Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword => 'Add the account with an app password (it needs 2-Step Verification).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird signs in to Gmail with Google. “Sign in with Google” arrives in a later build; until then, add the account with an app password (it needs 2-Step Verification).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird signs in to this account in the browser. Loupe can’t do that yet: use an app password if your provider offers one.';

  @override
  String get accountImportUnencrypted => 'Connects without encryption. Use this only on your own network.';

  @override
  String get accountImportEnterAgain => 'Enter it again';

  @override
  String get accountImportAdded => 'Added';

  @override
  String accountImportAdding(int index, int total) {
    return 'Adding $index of $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Add $count Accounts',
      one: 'Add 1 Account',
      zero: 'Add Accounts',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Paste Export Text';

  @override
  String get accountImportPasteText => 'Paste the text of a Thunderbird export code, one code per line.';

  @override
  String get accountImportPop3 => 'POP3 accounts aren’t supported. Loupe keeps mail on the server with IMAP.';

  @override
  String get accountImportKerberos => 'This account signs in with Kerberos, which Loupe doesn’t support.';

  @override
  String get accountImportNtlm => 'This account signs in with NTLM, which Loupe doesn’t support.';

  @override
  String get accountImportClientCertificate =>
      'This account signs in with a client certificate, which Loupe doesn’t support yet.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Microsoft sign-in arrives in a later build. Outlook and Microsoft 365 accounts no longer accept passwords from mail apps.';

  @override
  String get accountImportEnterPassword => 'Enter the password.';

  @override
  String get accountImportEnterAppPassword => 'Enter the app password.';

  @override
  String get accountImportEnterApiToken => 'Enter the API token.';

  @override
  String get accountImportStorageFailed => 'Loupe couldn’t open its account storage. Try again later.';

  @override
  String get accountImportFailed => 'The account couldn’t be added. Try again, or add it manually.';

  @override
  String get composeNewMessageTitle => 'New Message';

  @override
  String get composeAttach => 'Attach';

  @override
  String get composeSendLater => 'Send Later';

  @override
  String composeSendAt(String time) {
    return 'Send $time';
  }

  @override
  String get composeSendHint => 'Long-press to send later';

  @override
  String get composeNoAccount => 'Add an account to send mail.';

  @override
  String get composeTo => 'To:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, From: $email';
  }

  @override
  String get composeFromLabel => 'From:';

  @override
  String get composeSubjectLabel => 'Subject:';

  @override
  String composeReplyTo(String address) {
    return 'Reply-To: $address';
  }

  @override
  String get composeFrom => 'From';

  @override
  String composeReplyFrom(String email) {
    return 'Reply from $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Send from $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Reply from $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Send from $email?';
  }

  @override
  String get composeDismiss => 'Dismiss';

  @override
  String composeAliasNotSaved(String account) {
    return 'Not saved as an identity · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Save as Identity';

  @override
  String composeAliasSaved(String email) {
    return '$email is saved as an identity.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Invalid address $address';
  }

  @override
  String get composeOriginalNotFound => 'Couldn\'t find the original message.';

  @override
  String get composeDraftNotFound => 'Couldn\'t find the draft.';

  @override
  String get composeAttachmentsLost => 'The attachments couldn’t be recovered. Add them again.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Some attachments couldn\'t be added: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Attachments total $size; some servers refuse messages this large.';
  }

  @override
  String get composeAttachFailed => 'Couldn\'t attach the file.';

  @override
  String get composeInvalidAddressTitle => 'Invalid Address';

  @override
  String composeInvalidAddress(String address) {
    return '“$address” isn\'t a valid email address.';
  }

  @override
  String get composeNoSubjectTitle => 'No Subject';

  @override
  String get composeNoSubjectText => 'This message has no subject. Send it anyway?';

  @override
  String get composeSentBeforeChanges => 'It was sent before your changes, which are saved in Drafts.';

  @override
  String composeScheduled(String time) {
    return 'Scheduled for $time';
  }

  @override
  String get composeSending => 'Sending…';

  @override
  String get composeSent => 'Sent';

  @override
  String get composeSendFailed => 'Couldn’t send. Try again.';

  @override
  String get composeAlreadySent => 'Already sent.';

  @override
  String get composeDiscardChanges => 'Discard Changes';

  @override
  String get composeSaveChanges => 'Save Changes';

  @override
  String get composeDeleteDraft => 'Delete Draft';

  @override
  String get composeSaveDraft => 'Save Draft';

  @override
  String get composeDraftSaved => 'Draft saved';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'On $date at $time, $name wrote:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'On $date at $time, someone wrote:';
  }

  @override
  String get composeForwardHeader => '---------- Forwarded message ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'From: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Date: $date at $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Subject: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'To: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Later Today';

  @override
  String get composeTomorrowMorning => 'Tomorrow Morning';

  @override
  String get composeMondayMorning => 'Monday Morning';

  @override
  String get composePickDateTime => 'Pick Date & Time…';

  @override
  String get composeSendWithoutDelay => 'Send Without Delay';

  @override
  String composeSendTimeToday(String time) {
    return 'Today at $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Tomorrow at $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day at $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Today $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Tomorrow $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Continue editing your draft?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'A message wasn’t sent when Loupe closed.',
      'one': 'A message to $name wasn’t sent when Loupe closed.',
      'other': 'A message to $name and others wasn’t sent when Loupe closed.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '“$subject” wasn’t sent when Loupe closed.',
      'one': '“$subject” to $name wasn’t sent when Loupe closed.',
      'other': '“$subject” to $name and others wasn’t sent when Loupe closed.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Continue Editing';

  @override
  String get composeRecoverySave => 'Save to Drafts';

  @override
  String get composeRecoveryDiscard => 'Discard';

  @override
  String get composeRecoverySaved => 'Saved to Drafts';

  @override
  String get outboxSectionFailed => 'Not Sent';

  @override
  String get outboxSectionSending => 'Sending';

  @override
  String get outboxSectionScheduled => 'Scheduled';

  @override
  String get outboxStatusQueued => 'Sending soon';

  @override
  String get outboxStatusSending => 'Sending…';

  @override
  String get outboxStatusFailed => 'Not sent';

  @override
  String get outboxNoRecipients => 'No Recipients';

  @override
  String get outboxNoSubject => '(No Subject)';

  @override
  String get outboxSendingFailed => 'Sending failed.';

  @override
  String get outboxEmptyTitle => 'Nothing to Send';

  @override
  String get outboxEmptyText => 'Messages you send later wait here until it’s time.';

  @override
  String get outboxSendNow => 'Send Now';

  @override
  String get outboxReschedule => 'Reschedule';

  @override
  String get outboxRescheduleMenu => 'Reschedule…';

  @override
  String get outboxRescheduleTitle => 'Reschedule';

  @override
  String outboxRescheduled(String time) {
    return 'Rescheduled for $time';
  }

  @override
  String get outboxCancel => 'Cancel';

  @override
  String get outboxCancelSending => 'Cancel Sending…';

  @override
  String get outboxCancelTitle => 'Cancel Sending?';

  @override
  String get outboxMoveToDrafts => 'Move to Drafts';

  @override
  String get outboxDiscard => 'Discard Message';

  @override
  String get outboxMovedToDrafts => 'Moved to Drafts';

  @override
  String get outboxDiscarded => 'Message discarded';

  @override
  String get outboxAlreadySent => 'Already sent.';

  @override
  String get outboxBeingSent => 'This message is being sent.';

  @override
  String get outboxActionFailed => 'That didn’t work. The message is still in the Outbox.';

  @override
  String get notificationsBadgeInboxes => 'Unread in Inboxes';

  @override
  String get notificationsBadgeVip => 'Unread in VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'New mail from your VIPs, in any account';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'New mail in $email';
  }

  @override
  String get notificationsUnknownSender => 'Unknown Sender';

  @override
  String get notificationsNoSubject => '(No Subject)';

  @override
  String get notificationsEncryptedMessage => 'Encrypted message';

  @override
  String notificationsHiddenMessage(String account) {
    return 'New message from $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count new messages',
      one: '1 new message',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'New messages in $account';
  }

  @override
  String get platformInstantChannel => 'Instant Delivery';

  @override
  String get platformInstantChannelDescription => 'Shows while Loupe watches your inboxes for new mail';

  @override
  String get platformInstantTitle => 'Watching for new mail';

  @override
  String get platformInstantText => 'Instant Delivery is on';

  @override
  String get platformErrorBox => 'Something went wrong showing this. Go back and try again.';

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
