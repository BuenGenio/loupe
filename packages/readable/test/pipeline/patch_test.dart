import 'package:flutter_test/flutter_test.dart';
import 'package:readable/src/model/document.dart';
import 'package:readable/src/pipeline/html_to_plain.dart';
import 'package:readable/src/pipeline/limits.dart';
import 'package:readable/src/pipeline/patch.dart';
import 'package:readable/src/pipeline/pipeline.dart';
import 'package:readable/src/pipeline/plain_text.dart';

/// Every block of [blocks], quotes opened.
List<Block> flatten(List<Block> blocks) => [
  for (final b in blocks) ...[b, if (b is QuoteBlock) ...flatten(b.children)],
];

List<DiffBlock> diffs(ReaderDocument d) => flatten(d.blocks).whereType<DiffBlock>().toList();

String text(Block b) => inlineText((b as ParagraphBlock).inlines);

const patch = '''Fix the frobnicator.

Signed-off-by: A <a@example.org>
---
 frob.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/frob.c b/frob.c
index 1111111..2222222 100644
--- a/frob.c
+++ b/frob.c
@@ -1,3 +1,4 @@ int main(void)
 int a;
-int b;
+int b = 1;
+int c;
 return 0;
--
2.43.0
''';

void main() {
  group('detection', () {
    test('diffs, hunks and diffstats, quoted or not', () {
      expect(looksLikePatch(patch), isTrue);
      expect(looksLikePatch('> > @@ -1 +1 @@\n> > -a\n> > +b'), isTrue);
      expect(looksLikePatch(' 2 files changed, 3 insertions(+)'), isTrue);
      expect(looksLikePatch('Hi,\n\n- one\n- two\n+ three\n\n---\nAlex'), isFalse);
      expect(looksLikePatch('Use `diff --git` to compare.'), isFalse);
    });

    test('ordinary mail is left alone: lists, "---", tables with pipes', () {
      const mail = 'Agenda:\n- one\n- two\n+ extra\n\n---\nname | 12 ++\nother | 3 --\n\n-- \nAlex';
      final d = parsePlainText(mail);
      expect(diffs(d), isEmpty);
      expect(flatten(d.blocks).whereType<DiffStatBlock>(), isEmpty);
      expect(flatten(d.blocks).whereType<RuleBlock>(), isEmpty);
    });
  });

  group('format-patch', () {
    test('commit message stays prose; rule, diffstat, diff and signature follow', () {
      final d = parsePlainText(patch);
      expect(d.blocks.map((b) => b.runtimeType), [
        ParagraphBlock,
        ParagraphBlock,
        RuleBlock,
        DiffStatBlock,
        DiffBlock,
        ParagraphBlock,
      ]);
      expect(text(d.blocks.first), 'Fix the frobnicator.');
      expect((d.blocks.last as ParagraphBlock).muted, isTrue);
      final stat = d.blocks[3] as DiffStatBlock;
      expect((stat.filesChanged, stat.insertions, stat.deletions), (1, 2, 1));
      expect(stat.files.single.graph, '++-');
    });

    test('line numbers come from the hunk header; counts end the hunk', () {
      final file = diffs(parsePlainText(patch)).single.file;
      expect((file.oldPath, file.newPath, file.added, file.removed), ('frob.c', 'frob.c', 2, 1));
      final hunk = file.hunks.single;
      expect(hunk.header, '@@ -1,3 +1,4 @@ int main(void)');
      expect(
        [for (final l in hunk.lines) l.toJson()],
        ['1:1  int a;', '2: -int b;', ':2 +int b = 1;', ':3 +int c;', '3:4  return 0;'],
      );
    });

    test('an empty context line whose space a mailer stripped', () {
      final d = parsePlainText('@@ -1,3 +1,3 @@\n a\n\n-b\n+c\n');
      expect(
        [for (final l in diffs(d).single.file.hunks.single.lines) l.kind],
        [DiffLineKind.context, DiffLineKind.context, DiffLineKind.removed, DiffLineKind.added],
      );
    });

    test('lines past the counts are prose again', () {
      final d = parsePlainText('@@ -1 +1 @@\n-a\n+b\n+not part of it');
      expect(diffs(d).single.file.hunks.single.lines, hasLength(2));
      expect(text(d.blocks.last), '+not part of it');
    });

    test('plain unified diffs, timestamps and quoted paths', () {
      final d = parsePlainText(
        '--- old/notes.txt\t2026-01-01 10:00:00\n+++ new/notes.txt\t2026-01-02 10:00:00\n@@ -1 +1 @@\n-x\n+y\n'
        'diff --git "a/my file.txt" "b/my file.txt"\nindex 1..2 100644\n--- "a/my file.txt"\n+++ "b/my file.txt"\n'
        '@@ -1 +1 @@\n-x\n+y\n',
      );
      expect(diffs(d).map((b) => (b.file.oldPath, b.file.newPath)), [
        ('old/notes.txt', 'new/notes.txt'),
        ('my file.txt', 'my file.txt'),
      ]);
    });

    test('renames, mode changes and binary files have no hunks to show', () {
      final d = parsePlainText(
        'diff --git a/a.txt b/b.txt\nsimilarity index 100%\nrename from a.txt\nrename to b.txt\n'
        'diff --git a/x.png b/x.png\nindex 1..2 100644\nBinary files a/x.png and b/x.png differ\n'
        'diff --git a/run.sh b/run.sh\nold mode 100644\nnew mode 100755\n',
      );
      final files = diffs(d).map((b) => b.file).toList();
      expect(files.map((f) => (f.isRename, f.binary, f.hunks.length)), [
        (true, false, 0),
        (false, true, 0),
        (false, false, 0),
      ]);
      expect(files.first.path, 'b.txt');
      expect(files.last.headers, contains('new mode 100755'));
    });

    test('CR CR LF of a CRLF file sent with CRLF lines', () {
      final d = parsePlainText('@@ -1,2 +1,2 @@\r\n a\r\r\n-b\r\r\n+c\r\r\n');
      expect([for (final l in diffs(d).single.file.hunks.single.lines) l.toJson()], ['1:1  a', '2: -b', ':2 +c']);
    });

    test('a flowed patch keeps its lines and loses its space-stuffing', () {
      final d = parsePlainText('Intro that is \nflowed.\n\n@@ -1,2 +1,2 @@\n  a \n-b\n+c\n', flowed: true);
      expect(text(d.blocks.first), 'Intro that is flowed.');
      expect([for (final l in diffs(d).single.file.hunks.single.lines) l.toJson()], ['1:1  a ', '2: -b', ':2 +c']);
    });

    test('too many blocks: truncated, not fatal', () {
      final many = List.generate(30, (i) => 'diff --git a/f$i b/f$i\nold mode 100644\nnew mode 100755').join('\n');
      final d = parsePlainText(many, limits: const PipelineLimits(maxBlocks: 10));
      expect(diffs(d), hasLength(10));
      expect(d.stats.truncated, isTrue);
    });
  });

  group('review replies', () {
    const review = '''Alice wrote:
> diff --git a/f.c b/f.c
> --- a/f.c
> +++ b/f.c
> @@ -10,4 +10,4 @@
>  keep
> -old
> +new

Why?

> +another
>  context

> - a quoted list item
> - and another

> > - item at depth two
''';

    test('quoted hunks and later excerpts of them get diff blocks inside the quotes', () {
      final d = parsePlainText(review);
      final quotes = d.blocks.whereType<QuoteBlock>().toList();
      expect(quotes, hasLength(4));
      final first = quotes[0].children.single as DiffBlock;
      expect(first.fragment, isTrue);
      expect(first.file.path, 'f.c');
      expect([for (final l in first.file.hunks.single.lines) l.toJson()], ['10:10  keep', '11: -old', ':11 +new']);
      final excerpt = quotes[1].children.single as DiffBlock;
      expect(excerpt.file.hunks.single.header, isEmpty);
      expect([for (final l in excerpt.file.hunks.single.lines) l.toJson()], [': +another', ':  context']);
      // At depth one, after a diff, even a list reads as an excerpt; one
      // level deeper nothing showed a diff.
      expect(quotes[2].children.single, isA<DiffBlock>());
      expect((quotes[3].children.single as QuoteBlock).children.single, isA<ParagraphBlock>());
    });

    test('without a quoted diff before them, quoted +/- lines stay text', () {
      final d = parsePlainText('> - one\n> + two\n');
      expect(diffs(d), isEmpty);
    });

    test('a quoted signature ends an excerpt', () {
      final d = parsePlainText('> @@ -1 +1 @@\n> -a\n> +b\n>\n> -- \n> Alice\n');
      expect(diffs(d).single.file.hunks.single.lines, hasLength(2));
    });
  });

  test('Readable and Plain modes both show diffs; the HTML plain view passes them on', () {
    for (final mode in [PipelineMode.readable, PipelineMode.plain]) {
      final out = runPipeline(PipelineInput(mode: mode, text: patch));
      expect(diffs(out.document), hasLength(1), reason: mode.name);
    }
    final doc = parsePlainText(patch);
    expect(toPlainDocument(doc).blocks.whereType<DiffBlock>(), hasLength(1));
  });
}
