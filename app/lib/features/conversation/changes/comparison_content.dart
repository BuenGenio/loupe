import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

/// Whether [content] contains readable message content for a body comparison.
///
/// Loader outcomes take precedence over the summary and retained outer MIME
/// headers: decrypted mail keeps those encrypted headers, and opaque signed
/// S/MIME can have been provisionally classified as encrypted. A failed decrypt
/// may instead contain a friendly explanation, which must not be compared as
/// though it were the sender's message.
///
/// Without a loader outcome, inspect the actual envelope as well as the summary.
/// This catches inline OpenPGP missed by the summary and raw content returned
/// when the crypto service could not initialize.
bool comparisonContentAvailable(
  EmailContent content, {
  required bool summaryEncrypted,
  PgpMessageStatus? pgpStatus,
  SmimeMessageStatus? smimeStatus,
}) {
  if (pgpStatus != null && pgpStatus.encrypted && !pgpStatus.decrypted) return false;
  if (smimeStatus != null && smimeStatus.encrypted && !smimeStatus.decrypted) return false;
  if (pgpStatus != null || smimeStatus != null) return true;
  if (summaryEncrypted) return false;

  final pgpProtection = detectProtection(content.headers, text: content.text);
  if (pgpProtection == PgpProtection.pgpMimeEncrypted || pgpProtection == PgpProtection.inlineEncrypted) return false;
  final smimeProtection = detectSmime(content.headers);
  return smimeProtection != SmimeProtection.enveloped && smimeProtection != SmimeProtection.authEnveloped;
}
