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
