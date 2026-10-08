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
