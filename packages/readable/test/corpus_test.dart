// Snapshot tests of the document model for every corpus message.
//
// Update the snapshots after an intended change with:
//   UPDATE_SNAPSHOTS=1 flutter test test/corpus_test.dart
// and review the diff of test/snapshots/ like any other change.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:readable/src/model/document.dart';
import 'package:readable/src/pipeline/original_html.dart';
import 'package:readable/src/pipeline/pipeline.dart';
import 'package:readable/src/pipeline/sanitizer.dart' show isTrackerHost;

import 'corpus_loader.dart';

final _update = const {'1', 'true', 'yes'}.contains(Platform.environment['UPDATE_SNAPSHOTS']?.toLowerCase());
const _encoder = JsonEncoder.withIndent('  ');

PipelineInput input(CorpusEntry e, PipelineMode mode) =>
    PipelineInput(mode: mode, html: e.html, text: e.text, isFlowed: e.isFlowed, contentIds: e.contentIds);

Map<String, Object?> _summary(ReaderDocument d) => {
  'stats': d.stats.toJson(),
  'blockCount': d.blocks.length,
  'firstBlocks': [for (final b in d.blocks.take(4)) b.toJson()],
};

Map<String, Object?> snapshotOf(CorpusEntry e) {
  final readable = runPipeline(input(e, PipelineMode.readable)).document;
  final plain = runPipeline(input(e, PipelineMode.plain)).document;
  final original = e.html == null ? null : prepareOriginalHtml(e.html!);
  return {
    'readable': e.summary ? _summary(readable) : readable.toJson(),
    'plain': e.summary ? _summary(plain) : plain.toJson(),
    if (original != null)
      'original': {
        'remoteImages': original.remoteImages,
        'contentIds': original.contentIds.toList()..sort(),
        if (original.truncated) 'truncated': true,
      },
  };
}

void main() {
  final corpus = loadCorpus();

  test('the corpus has at least 30 messages', () {
    expect(corpus.length, greaterThanOrEqualTo(30));
  });

  group('snapshots', () {
    for (final entry in corpus) {
      test(entry.name, () {
        final actual = '${_encoder.convert(snapshotOf(entry))}\n';
        final file = File('test/snapshots/${entry.name}.json');
        if (_update) {
          file.writeAsStringSync(actual);
          return;
        }
        expect(file.existsSync(), isTrue, reason: 'No snapshot; run with UPDATE_SNAPSHOTS=1 to create it.');
        expect(actual, file.readAsStringSync(), reason: 'Snapshot changed; review and run with UPDATE_SNAPSHOTS=1.');
      });
    }
  });

  group('corpus-wide invariants', () {
    for (final entry in corpus) {
      test(entry.name, () {
        final doc = runPipeline(input(entry, PipelineMode.readable)).document;
        final json = jsonEncode(doc.toJson());
        // Nothing active or hidden leaks through.
        for (final banned in ['steal(', 'alert(', '<script', 'javascript:', 'vbscript:', 'preheader text']) {
          expect(json.contains(banned), isFalse, reason: '$banned in ${entry.name}');
        }
        // No tracking pixels.
        for (final image in doc.images) {
          final source = image.source;
          if (source is RemoteImageSource) {
            expect(isTrackerHost(Uri.parse(source.url).host), isFalse);
            expect((image.width ?? 99) > 2 && (image.height ?? 99) > 2, isTrue);
          }
        }
        // Only openable links.
        for (final link in doc.links) {
          expect(RegExp(r'^(https?|mailto|tel):').hasMatch(link.url), isTrue, reason: link.url);
        }
      });
    }
  });

  group('corpus expectations', () {
    ReaderDocument readable(String name) =>
        runPipeline(input(corpus.firstWhere((e) => e.name.startsWith(name)), PipelineMode.readable)).document;
    List<Block> flatten(List<Block> blocks) => [
      for (final b in blocks) ...[
        b,
        if (b is QuoteBlock) ...flatten(b.children),
        if (b is ListBlock)
          for (final i in b.items) ...flatten(i),
      ],
    ];
    String text(ReaderDocument d) => jsonEncode(d.toJson());

    test('newsletter: linearised, preheader and pixel gone, button and icon row kept', () {
      final d = readable('01_');
      expect(d.blocks.whereType<TableBlock>(), isEmpty);
      expect(d.blocks.whereType<ButtonBlock>().single.text, 'Shop proofing baskets');
      expect(d.blocks.whereType<HeadingBlock>().map((h) => inlineText(h.inlines)), contains('Issue 42: Rye, at last'));
      expect(text(d), isNot(contains('Sourdough secrets')));
      expect(text(d), isNot(contains('Swipe for more recipes')));
      expect(d.stats.trackers, 1);
      final icons = d.images.where((i) => i.icon).length;
      expect(icons, 3);
    });

    test('Outlook: MsoNormal lines are tight, the reply header has a rule', () {
      final d = readable('02_');
      expect(d.blocks.whereType<ParagraphBlock>().where((p) => p.tight), isNotEmpty);
      expect(d.blocks.whereType<RuleBlock>(), isNotEmpty);
      expect(d.images.single.source, isA<CidImageSource>());
      expect(text(d), isNot(contains('OfficeDocumentSettings')));
    });

    test('receipt: a data table with colspans', () {
      final t = readable('05_').blocks.whereType<TableBlock>().single;
      expect(t.columns, 3);
      expect(t.rows.first.every((c) => c.header), isTrue);
      expect(t.rows.last.first.colspan, 2);
    });

    test('inline cid images become one carousel', () {
      final c = readable('06_').blocks.whereType<CarouselBlock>().single;
      expect(c.images, hasLength(3));
    });

    test('RTL paragraphs keep their direction', () {
      final d = readable('08_');
      expect(flatten(d.blocks).whereType<ParagraphBlock>().where((p) => p.dir == TextDir.rtl), hasLength(5));
    });

    test('tiny fonts are floored at 0.85', () {
      final runs = flatten(readable('09_').blocks)
          .whereType<ParagraphBlock>()
          .expand((p) => p.inlines)
          .whereType<TextRun>()
          .map((r) => r.style.scale);
      expect(runs.every((s) => s >= 0.85), isTrue);
    });

    test('preheaders and every kind of tracker are removed', () {
      final d = readable('12_');
      expect(d.stats.trackers, greaterThanOrEqualTo(4));
      expect(d.stats.hiddenElements, greaterThanOrEqualTo(2));
      expect(d.images.single.alt, 'Delivery van');
    });

    test('link mismatches are flagged, honest links are not', () {
      final links = readable('13_').links;
      expect(links.where((l) => l.isMismatch).map((l) => l.namedDomain), [
        'www.mybank.example',
        'www.mybank.example',
        'shop.example.com',
      ]);
      expect(links.where((l) => !l.isMismatch), hasLength(2));
    });

    test('image-only promo and hidden spam suggest the Original view', () {
      expect(readable('14_').stats.suggestOriginal, isTrue);
      expect(readable('14_').blocks.whereType<CarouselBlock>(), isEmpty);
      expect(readable('32_').stats.suggestOriginal, isTrue);
      expect(readable('01_').stats.suggestOriginal, isFalse);
    });

    test('limits: the 1 MB monster and 5000-deep nesting are truncated, not fatal', () {
      final monster = corpus.firstWhere((e) => e.name.startsWith('18_'));
      expect(monster.html!.length, greaterThan(1000000));
      final m = readable('18_');
      expect(m.stats.truncated, isTrue);
      expect(m.blocks, isNotEmpty);
      final deep = readable('19_');
      expect(deep.stats.truncated, isTrue);
      expect(text(deep), contains('Deep'));
    });

    test('active content is gone but form text stays', () {
      final t = text(readable('28_'));
      expect(t, contains('Send answers'));
      expect(t, contains('Very satisfied'));
      expect(t, isNot(contains('Iframe fallback')));
      expect(t, isNot(contains('svg text')));
    });

    test('buttons: bulletproof, border-built and inline-block', () {
      final buttons = readable('34_').blocks.whereType<ButtonBlock>().map((b) => b.text);
      expect(buttons, ['Register now', 'See the agenda']);
      final calendar = readable('25_');
      expect(calendar.blocks.whereType<TableBlock>(), hasLength(1));
    });

    test('social icons and footer links become single lines', () {
      final d = readable('33_');
      final lines = d.blocks.whereType<ParagraphBlock>().map((p) => inlineText(p.inlines)).toList();
      expect(lines, contains('Preferences | Unsubscribe | Archive'));
      expect(
        d.blocks.whereType<ParagraphBlock>().where((p) => p.inlines.whereType<InlineImage>().length == 3),
        hasLength(1),
      );
    });
  });
}
