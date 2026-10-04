import 'package:flutter_test/flutter_test.dart';
import 'package:readable/src/model/document.dart';
import 'package:readable/src/pipeline/html_to_plain.dart';
import 'package:readable/src/pipeline/links.dart';
import 'package:readable/src/pipeline/pipeline.dart';
import 'package:readable/src/pipeline/plain_text.dart';

String paragraphText(Block b) => inlineText((b as ParagraphBlock).inlines);

void main() {
  group('format=flowed', () {
    test('joins soft line breaks, keeps hard ones', () {
      final doc = parsePlainText('This is a long \nflowed line.\nHard break.\n\nNext para.', flowed: true);
      expect(doc.blocks.map(paragraphText), ['This is a long flowed line.\nHard break.', 'Next para.']);
    });

    test('removes space-stuffing', () {
      final doc = parsePlainText(' From the start\n >not a quote', flowed: true);
      expect(paragraphText(doc.blocks.single), 'From the start\n>not a quote');
    });

    test('quoted flowed lines join only within the same depth', () {
      final doc = parsePlainText('> quoted \n> text\nreply', flowed: true);
      final quote = doc.blocks.first as QuoteBlock;
      expect(paragraphText(quote.children.single), 'quoted text');
      expect(paragraphText(doc.blocks.last), 'reply');
    });

    test('the signature separator is never joined', () {
      final doc = parsePlainText('Bye \n-- \nAlex', flowed: true);
      expect(doc.blocks.map(paragraphText), ['Bye', '--\nAlex']);
    });
  });

  group('quotes', () {
    test('nest by level, including "> >" spacing', () {
      final doc = parsePlainText('top\n> one\n> > two\n>>> three\n> back\nend');
      expect(doc.blocks, hasLength(3));
      final q1 = doc.blocks[1] as QuoteBlock;
      expect(paragraphText(q1.children[0]), 'one');
      final q2 = q1.children[1] as QuoteBlock;
      expect(paragraphText(q2.children[0]), 'two');
      expect(paragraphText((q2.children[1] as QuoteBlock).children.single), 'three');
      expect(paragraphText(q1.children[2]), 'back');
    });
  });

  test('the signature is muted', () {
    final doc = parsePlainText('Hello\n\nThanks\n-- \nAlex Example\nexample.org');
    final last = doc.blocks.last as ParagraphBlock;
    expect(last.muted, isTrue);
    expect(inlineText(last.inlines), '--\nAlex Example\nexample.org');
    expect((doc.blocks.first as ParagraphBlock).muted, isFalse);
  });

  test('tabs expand to 8 columns', () {
    expect(paragraphText(parsePlainText('a\tb\nabcdefgh\tc').blocks.single), 'a       b\nabcdefgh        c');
  });

  group('linkify', () {
    test('URLs, www and addresses', () {
      final doc = parsePlainText('See https://example.org/a_(b). Or www.example.com, mail me@example.net!');
      expect(doc.links.map((l) => l.url), [
        'https://example.org/a_(b)',
        'https://www.example.com',
        'mailto:me@example.net',
      ]);
    });

    test('trailing punctuation and angle brackets are not part of the URL', () {
      final found = findLinks('<https://example.org/x>, (https://example.org/y).');
      expect(found.map((m) => m.url), ['https://example.org/x', 'https://example.org/y']);
    });
  });

  group('plain text from HTML', () {
    test('links become numbered footnotes', () {
      final readable = runPipeline(
        const PipelineInput(
          mode: PipelineMode.readable,
          html:
              '<p>Read <a href="https://x.example/a">the post</a> and <a href="https://x.example/a">again</a>.</p>'
              '<p><a href="https://y.example">https://y.example</a></p><ul><li>one</li><li>two</li></ul>',
        ),
      ).document;
      final plain = toPlainDocument(readable);
      final texts = plain.blocks.whereType<ParagraphBlock>().map((b) => inlineText(b.inlines)).toList();
      expect(texts[0], 'Read the post [1] and again [1].');
      expect(texts[1], 'https://y.example');
      expect(texts[2], '•  one');
      expect(texts[3], '•  two');
      expect(texts.last, '[1] https://x.example/a');
    });

    test('plain mode prefers the text part', () {
      final out = runPipeline(const PipelineInput(mode: PipelineMode.plain, html: '<p>html</p>', text: 'text'));
      expect(paragraphText(out.document.blocks.single), 'text');
    });

    test('readable mode of a text-only message is the plain document', () {
      final out = runPipeline(const PipelineInput(mode: PipelineMode.readable, text: '> q\nhi'));
      expect(out.document.blocks.first, isA<QuoteBlock>());
    });
  });

  test('markers', () {
    expect([1, 26, 27].map(alphaMarker), ['a', 'z', 'aa']);
    expect([4, 9, 14, 1994].map(romanMarker), ['iv', 'ix', 'xiv', 'mcmxciv']);
  });
}
