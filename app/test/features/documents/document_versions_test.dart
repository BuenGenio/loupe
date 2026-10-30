import 'package:expr_search/expr_search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/documents/document_index.dart';
import 'package:loupe/features/documents/document_search_terms.dart';
import 'package:loupe/features/documents/document_versions.dart';
import 'package:loupe/features/search/search_session.dart' show queryTerms;
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_documents/mail_documents.dart';
import 'package:mail_model/mail_model.dart';

DocumentEntry copy(
  String id,
  DateTime at, {
  String? hash,
  String name = 'Mortgage illustration.pdf',
  int size = 1802,
}) => DocumentEntry(
  ref: DocumentRef(id, '2'),
  attachment: Attachment(partId: '2', mimeType: 'application/pdf', filename: name, size: size),
  email: EmailSummary(id: id, accountId: 'personal', mailboxId: 'personal|INBOX', receivedAt: at, threadId: 't'),
  document: hash == null
      ? null
      : ExtractedDocument(
          contentHash: hash,
          byteLength: size,
          format: DocumentFormat.pdf,
          status: ExtractionStatus.complete,
        ),
);

void main() {
  final monday = DateTime(2026, 10, 26), friday = DateTime(2026, 10, 30);

  test('same name and size, different bytes: different, never "the same"', () {
    final c = compareCopies(copy('b', friday, hash: 'b' * 64), [copy('a', monday, hash: 'a' * 64)])!;
    expect(c.relation, CopyRelation.different);
    expect(c.otherIsEarlier, isTrue);
    expect(c.other.ref.emailId, 'a');
  });

  test('equal bytes are the same, under any name', () {
    final c = compareCopies(copy('b', friday, hash: 'x' * 64, name: 'renamed.pdf'), [
      copy('a', monday, hash: 'x' * 64),
    ])!;
    expect(c.relation, CopyRelation.same);
  });

  test('a copy that isn’t downloaded is not compared, whatever its name and size', () {
    expect(compareCopies(copy('b', friday, hash: 'b' * 64), [copy('a', monday)])!.relation, CopyRelation.notCompared);
    expect(compareCopies(copy('b', friday), [copy('a', monday, hash: 'b' * 64)])!.relation, CopyRelation.notCompared);
  });

  test('the nearest earlier copy, else the nearest later one; none without copies', () {
    final first = copy('a', monday, hash: 'a' * 64);
    final c = compareCopies(first, [
      copy('c', friday, hash: 'c' * 64),
      copy('b', DateTime(2026, 10, 28), hash: 'b' * 64),
    ])!;
    expect(c.otherIsEarlier, isFalse);
    expect(c.other.ref.emailId, 'b');
    expect(compareCopies(first, const []), isNull);
  });

  test('a library pairs copies by name in one conversation and account only', () {
    final a = copy('a', monday, hash: 'a' * 64);
    final b = copy('b', friday, hash: 'b' * 64, name: 'mortgage  ILLUSTRATION.pdf');
    final other = copy('c', friday, hash: 'c' * 64, name: 'Payment schedule.pdf');
    final library = DocumentLibrary([b, other, a]);
    expect(library.copiesOf(b).map((e) => e.ref.emailId), ['a']);
    expect(library.copiesOf(other), isEmpty);
  });

  test('changed facts: only fields both copies state, with different values', () {
    DocumentFact fact(FactField f, String v) => DocumentFact(
      field: f,
      value: v,
      evidence: const FactEvidence(page: 1, quote: 'q', start: 0, end: 1),
    );
    final older = DocumentFacts(
      type: DocumentType.mortgageIllustration,
      facts: {
        FactField.initialRate: fact(FactField.initialRate, '4.29%'),
        FactField.term: fact(FactField.term, '30 years'),
        FactField.brokerFee: fact(FactField.brokerFee, 'GBP 0'),
      },
      partial: false,
    );
    final newer = DocumentFacts(
      type: DocumentType.mortgageIllustration,
      facts: {
        FactField.initialRate: fact(FactField.initialRate, '4.19%'),
        FactField.term: fact(FactField.term, '30 years'),
      },
      partial: false,
    );
    final changes = factChanges(older, newer);
    expect(changes.map((c) => (c.field, c.before, c.after)), [(FactField.initialRate, '4.29%', '4.19%')]);
    final invoice = DocumentFacts(type: DocumentType.invoice, facts: const {}, partial: false);
    expect(factChanges(older, invoice), isEmpty);
  });

  test('Search in Documents takes a query’s plain words, not its operators', () {
    List<SearchExpr> terms(String q) => queryTerms(parseQuery(q).expr);
    expect(documentWords(terms('arrangement fee')), 'arrangement fee');
    expect(documentWords(terms('is:unread 4.19%')), '4.19%');
    expect(documentWords(terms('from:dana is:unread')), isNull);
  });
}
