import 'dart:convert';
import 'dart:io' show ZLibEncoder;
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_attachments.dart';
import 'package:loupe/features/documents/document_index.dart';
import 'package:mail_documents/mail_documents.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  var background = 0;
  late DocumentIndex index;
  setUp(() {
    background = 0;
    index = DocumentIndex(
      run: (work) async {
        background++;
        return work();
      },
    );
  });

  const pdf = Attachment(partId: '2', mimeType: 'application/pdf', filename: 'Mortgage illustration.pdf');

  test('the same bytes are read once, under any name or message', () async {
    final bytes = pagedPdf('Mortgage illustration', [
      ['Initial rate: 4.19% fixed for 5 years'],
    ]);
    final a = await index.read(const DocumentRef('m1', '2'), pdf, bytes);
    final b = await index.read(
      const DocumentRef('m2', '3'),
      const Attachment(partId: '3', mimeType: 'application/octet-stream', filename: 'renamed.pdf'),
      Uint8List.fromList(bytes),
    );
    expect(identical(a, b), isTrue);
    expect(a.status, ExtractionStatus.complete);
    expect(index.cached(const DocumentRef('m2', '3')), same(a));
    expect(index.cached(const DocumentRef('m3', '2')), isNull);
    expect(background, 0); // small: read at once
  });

  test('a large file is read in the background with the full limits', () async {
    final big = Uint8List.fromList(utf8.encode('Amount due: GBP 450.00\n${'filler line\n' * 8000}'));
    expect(big.length, greaterThan(ExtractionLimits.quick.maxBytes));
    final doc = await index.readBytes(big, mimeType: 'text/plain', fileName: 'big.txt');
    expect(background, 1);
    expect(doc.status, ExtractionStatus.complete);
    expect(await index.readBytes(big, mimeType: 'text/plain'), same(doc));
  });

  test('a small file that reaches the quick limits is read again in the background', () async {
    // 2 MB of text operators, Flate-compressed to a few kilobytes.
    final content = ZLibEncoder().convert(latin1.encode('BT /F1 12 Tf 72 700 Td (Amount due) Tj ET\n' * 50000));
    final head =
        '%PDF-1.4\n1 0 obj\n<< /Type /Catalog /Pages 2 0 R >>\nendobj\n'
        '2 0 obj\n<< /Type /Pages /Kids [3 0 R] /Count 1 >>\nendobj\n'
        '3 0 obj\n<< /Type /Page /Parent 2 0 R /Contents 4 0 R >>\nendobj\n'
        '4 0 obj\n<< /Length ${content.length} /Filter /FlateDecode >>\nstream\n';
    final bytes = Uint8List.fromList([
      ...latin1.encode(head),
      ...content,
      ...latin1.encode('\nendstream\nendobj\ntrailer\n<< /Root 1 0 R >>\n'),
    ]);
    expect(bytes.length, lessThan(ExtractionLimits.quick.maxBytes));
    final doc = await index.readBytes(bytes, mimeType: 'application/pdf');
    expect(background, 1);
    expect(doc.status, ExtractionStatus.complete);
    expect(doc.pages.single.text, startsWith('Amount due'));
  });
}
