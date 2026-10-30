/// The extractor's version. A cached result is reused only when its version
/// is this one: a reader that changed may read the same bytes differently.
const extractorVersion = 1;

/// What a reader can do with a file, from its MIME type and name.
enum DocumentFormat { pdf, text, csv }

/// How far a document could be read.
enum ExtractionStatus {
  /// Every page was read.
  complete,

  /// Some pages were read and others weren't: a limit was reached
  /// ([ExtractedDocument.limit]) or a page's content couldn't be decoded.
  partial,

  /// The pages have no text: most likely a scan or photographs, which need
  /// OCR.
  noText,

  /// Password protected or otherwise encrypted. Nothing was read.
  encrypted,

  /// Not a format the extractor reads (a Word document, an image).
  unsupported,

  /// Larger than [ExtractionLimits.maxBytes]. Nothing was read.
  tooLarge,

  /// Not a valid document of its format, or damaged beyond reading.
  damaged,
}

/// The limit that stopped a read early.
enum ExtractionLimit { pages, decodedBytes, operators, characters, time }

/// Bounds on one extraction, so hostile or huge files stay cheap. A limit
/// that is reached ends the read with what was read so far
/// ([ExtractionStatus.partial]); nothing is ever thrown at the caller.
final class ExtractionLimits {
  const ExtractionLimits({
    this.maxBytes = 32 << 20,
    this.maxPages = 500,
    this.maxObjects = 200000,
    this.maxDecodedBytes = 64 << 20,
    this.maxOperators = 2000000,
    this.maxCharacters = 2000000,
    this.maxDuration = const Duration(seconds: 10),
  });

  /// The size of the file itself; above it nothing is read.
  final int maxBytes;
  final int maxPages;

  /// Objects of a PDF.
  final int maxObjects;

  /// Everything decompressed and decoded, together.
  final int maxDecodedBytes;

  /// Content stream operators, together.
  final int maxOperators;

  /// Text kept, together.
  final int maxCharacters;
  final Duration maxDuration;

  /// For small files read on the UI isolate: a few milliseconds of work at
  /// most. A file that reaches one of these is read again in the background
  /// with the defaults.
  static const quick = ExtractionLimits(
    maxBytes: 64 << 10,
    maxPages: 100,
    maxObjects: 5000,
    maxDecodedBytes: 1 << 20,
    maxOperators: 50000,
    maxCharacters: 200000,
    maxDuration: Duration(milliseconds: 150),
  );
}

/// One page's text, in reading order as far as the content stream gives it.
/// Lines are separated by `\n`. A text file is one page.
final class DocumentPage {
  const DocumentPage(this.number, this.text, {this.readable = true});

  /// 1-based.
  final int number;
  final String text;

  /// False when the page's content couldn't be decoded (an unsupported
  /// compression, a damaged stream): its text is missing, not empty.
  final bool readable;
}

/// What the extractor made of one file. Identity is [contentHash], never the
/// file name: two attachments called `illustration.pdf` may differ, and two
/// differently named ones may be the same bytes.
final class ExtractedDocument {
  const ExtractedDocument({
    required this.contentHash,
    required this.byteLength,
    required this.format,
    required this.status,
    this.pages = const [],
    this.pageCount,
    this.limit,
    this.version = extractorVersion,
  });

  /// Hex SHA-256 of the file's bytes.
  final String contentHash;
  final int byteLength;

  /// Null when the format isn't one the extractor reads.
  final DocumentFormat? format;
  final ExtractionStatus status;

  /// The pages that were read, in order. Pages after a limit are absent.
  final List<DocumentPage> pages;

  /// How many pages the document has, when known.
  final int? pageCount;

  /// What stopped the read early, if anything did.
  final ExtractionLimit? limit;

  /// The [extractorVersion] that read it.
  final int version;

  /// Has text to search.
  bool get searchable => pages.any((p) => p.text.isNotEmpty);

  /// Pages that were read and could be decoded.
  int get pagesRead => pages.where((p) => p.readable).length;

  /// Pages of the document that weren't read or couldn't be decoded.
  int get pagesNotRead => (pageCount ?? pages.length) - pagesRead;

  /// The text of page [number], or null when it wasn't read.
  String? pageText(int number) {
    for (final p in pages) {
      if (p.number == number) return p.readable ? p.text : null;
    }
    return null;
  }
}
