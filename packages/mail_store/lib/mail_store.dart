/// Local encrypted mail store: drift on SQLite3MultipleCiphers with an FTS5
/// index, reactive list queries, the outbox and the offline operation queue.
library;

export 'src/records.dart';
export 'src/store.dart' show MailStore, maxInlineBytesPerMessage, maxInlinePartBytes;
