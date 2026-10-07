/// MIME helpers mail_jmap shares with the IMAP transport: choosing the body
/// and attachments from a message's structure, decoding header values and
/// charsets, and the message format of the documents folder.
library;

export 'src/compose/mime_composer.dart' show formatMailDate;
export 'src/imap/body_structure.dart'
    show BodyNode, DisplayParts, hasVisibleAttachment, isEncryptedStructure, listAttachments, selectDisplayParts;
export 'src/imap/message_mapping.dart' show planContentFetch, unflowText;
export 'src/imap/server_documents.dart'
    show buildDocumentMessage, findDocumentsFolder, maxDocumentMessages, maxDocumentSize, readDocumentMessage;
export 'src/mime/charsets.dart' show decodeCharset;
export 'src/mime/encoded_words.dart' show decodeEncodedWords, normalizeParameters;
export 'src/mime/headers.dart' show headerValue, parseHeaderBlock, parseMessageIds;
export 'src/mime/plain_text.dart' show makePreview;
