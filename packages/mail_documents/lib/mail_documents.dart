/// Documents for Loupe (docs/plan/PLAN-combined.md, "Documents: search and
/// key facts"): the text of downloaded attachments, page by page, and exact
/// search in it.
///
/// [readDocument] reads plain text, CSV and text-based PDFs within hard
/// limits ([ExtractionLimits]) and never throws: an encrypted, scanned,
/// damaged, huge or unsupported file comes back as an [ExtractionStatus],
/// with the pages it could read. A document's identity is its
/// [ExtractedDocument.contentHash], not its name. [findInDocument] finds a
/// phrase exactly and returns the page and the passage around it.
///
/// The PDF reader is Loupe's own and small: objects found by scanning,
/// FlateDecode, ASCIIHex and ASCII85, the page tree, the text operators,
/// standard, WinAnsi and MacRoman encodings with `/Differences`, and
/// ToUnicode maps. No OCR, no decryption, no layout analysis.
library;

export 'src/document.dart'
    show
        DocumentFormat,
        DocumentPage,
        ExtractedDocument,
        ExtractionLimit,
        ExtractionLimits,
        ExtractionStatus,
        extractorVersion;
export 'src/read.dart' show contentHash, decodeText, documentFormatOf, readDocument;
export 'src/search.dart' show DocumentMatch, FoldedText, findInDocument, locateOnPage;
