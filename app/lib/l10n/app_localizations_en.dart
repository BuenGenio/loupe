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
