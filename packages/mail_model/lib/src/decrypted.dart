import 'email.dart';

/// What the device keeps of encrypted mail once it was decrypted: in the
/// encrypted store only, never on the server. Implemented by repositories
/// that can (`repository is DecryptedMail`).
abstract interface class DecryptedMail {
  /// Remembers [subject] as the protected subject of the encrypted message
  /// [emailId] (sent with a placeholder such as `...`), and of its copies in
  /// other mailboxes. The list, search and notifications show it from then
  /// on ([EmailSummary.hasDecryptedSubject]).
  Future<void> rememberProtectedSubject(String emailId, String subject);
}

/// Placeholders that encrypted mail is sent with instead of its subject
/// (Thunderbird, K-9 Mail and Delta Chat write `...`, Enigmail
/// `Encrypted Message`); the real subject is inside.
bool isProtectedSubjectPlaceholder(String subject) =>
    const {'...', '…', 'encrypted message', ''}.contains(subject.trim().toLowerCase());
