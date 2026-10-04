/// The Loupe search language.
///
/// Parses what the user types (`f:alice and (s:invoice or b:"PO 123")`) into
/// a [SearchExpr] from mail_model, formats it back, and compiles it for each
/// place a search runs: locally ([matchesEmail]), IMAP ([compileImap]), Gmail
/// ([compileGmailRaw]) and JMAP ([compileJmapFilter]).
library;

export 'src/api.dart';
