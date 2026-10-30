import 'package:mail_documents/mail_documents.dart';
import 'package:mail_documents/src/pdf/encodings.dart';
import 'package:test/test.dart';

ExtractedDocument doc(List<String> pages) => ExtractedDocument(
  contentHash: 'h',
  byteLength: 0,
  format: DocumentFormat.pdf,
  status: ExtractionStatus.complete,
  pages: [for (final (i, t) in pages.indexed) DocumentPage(i + 1, t)],
  pageCount: pages.length,
);

void main() {
  final illustration = doc([
    'Mortgage illustration\nLoan amount: GBP 285,000\nInitial rate: 4.19% fixed for 5 years\n'
        'Monthly payment (initial period): GBP 1,392.01',
    'Fees\nArrangement fee: GBP 1,499 (payable on completion)\nValuation fee: GBP 0',
  ]);

  test('finds a phrase with its page, line and passage, the match marked', () {
    final m = findInDocument(illustration, 'arrangement FEE').single;
    expect(m.page, 2);
    expect(m.line, 2);
    expect(illustration.pages[1].text.substring(m.start, m.end), 'Arrangement fee');
    expect(m.passage.substring(m.passageStart, m.passageEnd), 'Arrangement fee');
    expect(m.passage, contains('GBP 1,499'));
  });

  test('spacing and line breaks don’t matter; words and their order do', () {
    expect(findInDocument(illustration, '4.19%   fixed\nfor'), hasLength(1));
    expect(findInDocument(illustration, '285,000 initial rate'), hasLength(1)); // across a line break
    expect(findInDocument(illustration, 'fixed 4.19%'), isEmpty);
    expect(findInDocument(illustration, '4.29%'), isEmpty);
    expect(findInDocument(illustration, '   '), isEmpty);
  });

  test('typographic quotes, dashes and ligatures match their plain forms', () {
    final d = doc(['Sam’s ﬁxed rate – “early repayment”']);
    expect(findInDocument(d, "sam's fixed rate - \"early"), hasLength(1));
    final m = findInDocument(d, 'fixed').single;
    expect(d.pages.single.text.substring(m.start, m.end), 'ﬁxed');
  });

  test('every match, in page order, up to the limit; long passages are cut with an ellipsis', () {
    final d = doc(['GBP 1 and GBP 2', 'and GBP 3 ${'word ' * 40}']);
    expect(findInDocument(d, 'gbp').map((m) => m.page), [1, 1, 2]);
    expect(findInDocument(d, 'gbp', maxMatches: 2), hasLength(2));
    final long = findInDocument(doc(['${'lead ' * 30}needle${' tail' * 30}']), 'needle').single;
    expect(long.passage, startsWith('…'));
    expect(long.passage, endsWith('…'));
    expect(long.passage.substring(long.passageStart, long.passageEnd), 'needle');
  });

  test('unread pages are not searched', () {
    final d = ExtractedDocument(
      contentHash: 'h',
      byteLength: 0,
      format: DocumentFormat.pdf,
      status: ExtractionStatus.partial,
      pages: const [DocumentPage(1, 'visible'), DocumentPage(2, '', readable: false)],
      pageCount: 3,
    );
    expect(findInDocument(d, 'visible'), hasLength(1));
    expect(d.pagesNotRead, 2);
  });

  test('locateOnPage finds a quote in the original text', () {
    final page = illustration.pages.first.text;
    final (start, end) = locateOnPage(page, 'Initial rate: 4.19%  fixed for 5 years')!;
    expect(page.substring(start, end), 'Initial rate: 4.19% fixed for 5 years');
    expect(locateOnPage(page, 'Initial rate: 4.29%'), isNull);
  });

  test('the encoding tables have 256 entries and agree on ASCII letters', () {
    for (final table in [winAnsiEncoding, standardEncoding, macRomanEncoding]) {
      expect(table, hasLength(256));
      expect(table[0x41], 'A');
      expect(table[0x7A], 'z');
    }
    expect(winAnsiEncoding[0x80], '€');
    expect(standardEncoding[0x27], '’');
    expect(macRomanEncoding[0x80], 'Ä');
    expect(macRomanEncoding[0xFF], 'ˇ');
    expect(glyphToUnicode('eacute'), 'é');
    expect(glyphToUnicode('uni20AC'), '€');
    expect(glyphToUnicode('u1F600'), '😀');
    expect(glyphToUnicode('a.sc'), 'a');
    expect(glyphToUnicode('nonsense'), '');
  });
}
