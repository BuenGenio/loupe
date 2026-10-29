import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/changes/email_diff.dart';
import 'package:mail_model/mail_model.dart';

EmailContent _mail(String text, {List<Attachment> attachments = const []}) =>
    EmailContent(emailId: 'message', text: text, attachments: attachments);

void main() {
  group('email body comparison', () {
    test('keeps equal context, counts changed lines and refines changed words', () {
      final diff = compareEmailContent(
        _mail('Mortgage application\nThe fee is £295.\nSend your statement.'),
        _mail('Mortgage application\nThe fee is £395.\nSend your statement.\nComplete the ID check.'),
      );
      expect(diff.body.lines.map((line) => line.kind), [
        EmailDiffKind.equal,
        EmailDiffKind.removed,
        EmailDiffKind.added,
        EmailDiffKind.equal,
        EmailDiffKind.added,
      ]);
      expect(diff.body.removedLineCount, 1);
      expect(diff.body.addedLineCount, 2);
      expect(diff.body.lines[1].beforeLineNumber, 2);
      expect(diff.body.lines[1].afterLineNumber, isNull);
      expect(diff.body.lines[2].beforeLineNumber, isNull);
      expect(diff.body.lines[2].afterLineNumber, 2);
      expect(diff.body.lines[1].spans.map((span) => (span.kind, span.text)), [
        (EmailDiffKind.equal, 'The fee is '),
        (EmailDiffKind.removed, '£295.'),
      ]);
      expect(diff.body.lines[2].spans.map((span) => (span.kind, span.text)), [
        (EmailDiffKind.equal, 'The fee is '),
        (EmailDiffKind.added, '£395.'),
      ]);
      expect(diff.body.usedFallback, isFalse);
      expect(diff.body.isTruncated, isFalse);
      _expectLossless(diff.body);
    });

    test('normalizes line endings and nonbreaking spaces', () {
      final diff = compareEmailContent(_mail('One\r\nTwo\rThree\u00a0four'), _mail('One\nTwo\nThree four'));
      expect(diff.hasChanges, isFalse);
      expect(diff.body.beforeText, 'One\nTwo\nThree four');
      _expectLossless(diff.body);
    });

    test('preserves quoted material and signatures without guessing authorship', () {
      final diff = compareEmailContent(
        _mail('Please sign.\n> Deadline: Friday\n-- \nRaul'),
        _mail('Please sign.\n> Deadline: Monday\n-- \nRuth'),
      );
      expect(diff.body.beforeText, contains('> Deadline: Friday'));
      expect(diff.body.afterText, contains('-- \nRuth'));
      expect(diff.body.removedLineCount, 2);
      expect(diff.body.addedLineCount, 2);
      _expectLossless(diff.body);
    });

    test('uses available plain text in preference to HTML', () {
      final diff = compareEmailContent(
        const EmailContent(emailId: 'before', text: 'Plain text', html: '<p>HTML before</p>'),
        const EmailContent(emailId: 'after', text: 'Plain text', html: '<p>HTML after</p>'),
      );
      expect(diff.hasChanges, isFalse);
      expect(diff.body.beforeUsedHtml, isFalse);
      expect(diff.body.afterUsedHtml, isFalse);
    });

    test('HTML fallback decodes entities, separates blocks, and preserves link targets', () {
      final diff = compareEmailContent(
        const EmailContent(
          emailId: 'before',
          html:
              '<html><head><style>hidden style</style></head><body><p>Dear &Eacute;va</p>'
              '<div>Bank &amp; salary</div><p><a href="https://example.com/old">Upload</a></p>'
              '<script>hidden script</script><img alt="Mortgage illustration"></body></html>',
        ),
        const EmailContent(
          emailId: 'after',
          text: ' \n',
          html:
              '<p>Dear &Eacute;va</p><div>Bank &amp; salary</div>'
              '<p><a href="https://example.com/new">Upload</a></p><img alt="Mortgage illustration">',
        ),
      );
      expect(diff.body.beforeUsedHtml, isTrue);
      expect(diff.body.afterUsedHtml, isTrue);
      expect(diff.body.beforeText, contains('Dear Éva\n'));
      expect(diff.body.beforeText, contains('Bank & salary'));
      expect(diff.body.beforeText, contains('Upload <https://example.com/old>'));
      expect(diff.body.afterText, contains('Upload <https://example.com/new>'));
      expect(diff.body.beforeText, contains('[Mortgage illustration]'));
      expect(diff.body.beforeText, isNot(contains('hidden')));
      expect(diff.body.hasChanges, isTrue);
      _expectLossless(diff.body);
    });

    test('handles empty, all-added and all-removed messages', () {
      final equal = compareEmailContent(_mail(''), _mail(''));
      expect(equal.body.lines, isEmpty);
      expect(equal.hasChanges, isFalse);
      final added = compareEmailContent(_mail(''), _mail('One\nTwo'));
      expect(added.body.lines.map((line) => line.kind), [EmailDiffKind.added, EmailDiffKind.added]);
      final removed = compareEmailContent(_mail('One\nTwo'), _mail(''));
      expect(removed.body.lines.map((line) => line.kind), [EmailDiffKind.removed, EmailDiffKind.removed]);
      _expectLossless(added.body);
      _expectLossless(removed.body);
    });

    test('keeps Unicode text and emoji intact in word highlights', () {
      final diff = compareEmailContent(_mail('Привіт 👩🏽‍💻 café 旧'), _mail('Привіт 👩🏽‍🚀 café 新'));
      expect(diff.body.lines.first.spans.map((span) => span.text), ['Привіт ', '👩🏽‍💻', ' café ', '旧']);
      expect(diff.body.lines.last.spans.map((span) => span.text), ['Привіт ', '👩🏽‍🚀', ' café ', '新']);
      _expectLossless(diff.body);
    });

    test('reconstructs both messages for repeated lines and ambiguous matches', () {
      final random = Random(43);
      const words = ['same', 'one', 'two', 'three', '💌', ''];
      for (var sample = 0; sample < 200; sample++) {
        String body() => List.generate(random.nextInt(15), (_) => words[random.nextInt(words.length)]).join('\n');
        final before = body();
        final after = body();
        final diff = compareEmailContent(_mail(before), _mail(after));
        expect(diff.body.beforeText, before);
        expect(diff.body.afterText, after);
        _expectLossless(diff.body);
      }
    });
  });

  group('bounded comparison', () {
    test('source and text caps are explicit and never split surrogate pairs', () {
      final source = compareEmailContent(
        _mail('💌💌💌 before'),
        _mail('💌💌💌 after'),
        limits: const EmailDiffLimits(maxSourceCharacters: 2),
      );
      expect(source.body.beforeText, '💌💌');
      expect(source.body.beforeTruncated, isTrue);
      expect(source.body.afterTruncated, isTrue);
      expect(source.body.hasChanges, isFalse); // Only the included prefix matches.
      final text = compareEmailContent(
        _mail('one two'),
        _mail('one'),
        limits: const EmailDiffLimits(maxTextCharacters: 3),
      );
      expect(text.body.beforeText, 'one');
      expect(text.body.beforeTruncated, isTrue);
      expect(text.body.afterTruncated, isFalse);
      _expectLossless(source.body);
      _expectLossless(text.body);
    });

    test('does not flag a Unicode source that fits the scalar cap', () {
      final diff = compareEmailContent(
        _mail('💌💌'),
        _mail('💌💌'),
        limits: const EmailDiffLimits(maxSourceCharacters: 2, maxTextCharacters: 2),
      );
      expect(diff.body.beforeText, '💌💌');
      expect(diff.body.isTruncated, isFalse);
    });

    test('limits HTML before parsing and reports omitted source', () {
      final diff = compareEmailContent(
        const EmailContent(emailId: 'before', html: '<p>One two three</p>'),
        const EmailContent(emailId: 'after', html: '<p>One two four</p>'),
        limits: const EmailDiffLimits(maxSourceCharacters: 10),
      );
      expect(diff.body.beforeUsedHtml, isTrue);
      expect(diff.body.isTruncated, isTrue);
      _expectLossless(diff.body);
    });

    test('line cap reports truncation per message', () {
      final diff = compareEmailContent(
        _mail('one\ntwo\nthree'),
        _mail('one'),
        limits: const EmailDiffLimits(maxLines: 2),
      );
      expect(diff.body.beforeText, 'one\ntwo');
      expect(diff.body.beforeTruncated, isTrue);
      expect(diff.body.afterTruncated, isFalse);
      _expectLossless(diff.body);
    });

    test('line alignment fallback includes every bounded line', () {
      final diff = compareEmailContent(
        _mail('context\na\nb\nc\nend'),
        _mail('context\nx\ny\nz\nend'),
        limits: const EmailDiffLimits(maxLineDiffCells: 1),
      );
      expect(diff.body.usedFallback, isTrue);
      expect(diff.body.isTruncated, isFalse);
      expect(diff.body.lines.first.kind, EmailDiffKind.equal);
      expect(diff.body.lines.last.kind, EmailDiffKind.equal);
      _expectLossless(diff.body);
    });

    test('long unchanged messages use prefix/suffix without exceeding alignment budget', () {
      final before = List.generate(300, (i) => 'line $i');
      final after = [...before]..[150] = 'changed line';
      final diff = compareEmailContent(
        _mail(before.join('\n')),
        _mail(after.join('\n')),
        limits: const EmailDiffLimits(maxLineDiffCells: 4),
      );
      expect(diff.body.usedFallback, isFalse);
      expect(diff.body.addedLineCount, 1);
      _expectLossless(diff.body);
    });

    test('word/refinement caps keep all text and expose coarser comparison', () {
      for (final limits in [
        const EmailDiffLimits(maxWordsPerLine: 1),
        const EmailDiffLimits(maxWordDiffCells: 1),
        const EmailDiffLimits(maxRefinements: 0),
      ]) {
        final diff = compareEmailContent(_mail('old words here'), _mail('new tokens there'), limits: limits);
        expect(diff.body.usedFallback, isTrue);
        expect(diff.body.isTruncated, isFalse);
        _expectLossless(diff.body);
      }
    });
  });

  group('attachment metadata comparison', () {
    test('reports additions, removals and changed sizes without reading bytes', () {
      const keptBefore = Attachment(partId: '2', filename: 'statement.pdf', mimeType: 'application/pdf', size: 100);
      const keptAfter = Attachment(
        partId: 'blob-new',
        filename: 'statement.pdf',
        mimeType: 'application/pdf',
        size: 100,
      );
      const changedBefore = Attachment(partId: '3', filename: 'offer.pdf', mimeType: 'application/pdf', size: 200);
      const changedAfter = Attachment(partId: '4', filename: 'offer.pdf', mimeType: 'application/pdf', size: 210);
      const extra = Attachment(partId: '5', filename: 'overview.pdf', mimeType: 'application/pdf', size: 50);
      final diff = compareEmailContent(
        _mail('Body', attachments: [keptBefore, changedBefore]),
        _mail('Body', attachments: [keptAfter, changedAfter, extra]),
      );
      expect(diff.attachments.removed, [changedBefore]);
      expect(diff.attachments.added, [changedAfter, extra]);
      expect(diff.attachments.matchingMetadata.single.before, same(keptBefore));
      expect(diff.attachments.matchingMetadata.single.after, same(keptAfter));
      expect(diff.attachments.bytesCompared, isFalse);
      expect(diff.attachments.hasMetadataChanges, isTrue);
      expect(diff.hasChanges, isTrue);
    });

    test('identical name and size is metadata-only, never confirmed content equality', () {
      const oldAttachment = Attachment(partId: '2', filename: 'report.pdf', mimeType: 'application/pdf', size: 100);
      const newAttachment = Attachment(partId: '2', filename: 'report.pdf', mimeType: 'application/pdf', size: 100);
      final diff = compareEmailContent(
        _mail('', attachments: [oldAttachment]),
        _mail('', attachments: [newAttachment]),
      );
      expect(diff.attachments.matchingMetadata, hasLength(1));
      expect(diff.attachments.hasMetadataChanges, isFalse);
      expect(diff.attachments.bytesCompared, isFalse);
    });

    test('counts duplicate filenames and excludes only hidden inline parts', () {
      const file = Attachment(partId: '2', filename: 'report.pdf', mimeType: 'application/pdf');
      const inline = Attachment(partId: '3', mimeType: 'image/png', isInline: true, contentId: 'logo');
      const visibleInline = Attachment(partId: '4', filename: 'photo.png', mimeType: 'image/png', isInline: true);
      final diff = compareEmailContent(
        _mail('', attachments: [file, file, inline]),
        _mail('', attachments: [file, visibleInline]),
      );
      expect(diff.attachments.matchingMetadata, hasLength(1));
      expect(diff.attachments.removed, [file]);
      expect(diff.attachments.added, [visibleInline]);
    });
  });
}

void _expectLossless(EmailBodyDiff body) {
  expect(
    body.lines.where((line) => line.kind != EmailDiffKind.added).map((line) => line.text).join('\n'),
    body.beforeText,
  );
  expect(
    body.lines.where((line) => line.kind != EmailDiffKind.removed).map((line) => line.text).join('\n'),
    body.afterText,
  );
  for (final line in body.lines) {
    expect(line.spans.map((span) => span.text).join(), line.text);
    expect(line.spans.every((span) => span.kind == EmailDiffKind.equal || span.kind == line.kind), isTrue);
  }
}
