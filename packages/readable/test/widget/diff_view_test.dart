// The diff widgets: file header, hunk header, line numbers, colours that
// work in light and dark, sideways scrolling, the collapsible diffstat and
// quoted hunks in review replies.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readable/readable.dart';
import 'package:readable/src/cache.dart';
import 'package:readable/src/color/color_adapter.dart';
import 'package:readable/src/render/diff.dart';

import 'helpers.dart';

final _long = 'x' * 300;

final patch =
    '''Make the frobnicator faster.

Signed-off-by: A <a@example.org>
---
 frob.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/frob.c b/frob.c
index 1111111..2222222 100644
--- a/frob.c
+++ b/frob.c
@@ -10,3 +10,4 @@ int main(void)
 int a;
-int b;
+int b = 1; /* $_long */
+int c;
 return 0;
--
2.43.0
''';

void main() {
  setUpAll(() => ReadableMessageView.debugSynchronous = true);
  tearDownAll(() => ReadableMessageView.debugSynchronous = false);
  setUp(PipelineCache.instance.clear);

  testWidgets('a patch: prose, collapsed diffstat, file header, hunk header, numbered lines', (tester) async {
    await pumpReader(tester, email(text: patch));
    expect(richText('Make the frobnicator faster.'), findsOneWidget);
    expect(find.byType(DiffView), findsOneWidget);
    expect(find.text('frob.c'), findsOneWidget);
    expect(find.text(' +2'), findsOneWidget);
    expect(find.text(' −1'), findsOneWidget);
    expect(find.text('@@ -10,3 +10,4 @@ int main(void)'), findsOneWidget);
    expect(richText(' -int b;'), findsOneWidget);
    expect(richText(' +int c;'), findsOneWidget);
    // Old and new line numbers in the gutter.
    expect(find.text('10 10\n11   \n   11\n   12\n12 13'), findsOneWidget);
    // The diffstat starts collapsed.
    expect(richText('1 file changed'), findsOneWidget);
    expect(find.text('frob.c', findRichText: true), findsOneWidget);
    await tester.tap(richText('1 file changed'));
    await tester.pump();
    expect(find.textContaining('frob.c', findRichText: true), findsNWidgets(2));
  });

  testWidgets('long lines scroll sideways inside the hunk instead of wrapping', (tester) async {
    await pumpReader(tester, email(text: patch));
    final scroll = find.descendant(of: find.byType(HunkBody), matching: find.byType(SingleChildScrollView));
    expect(scroll, findsOneWidget);
    expect(tester.widget<SingleChildScrollView>(scroll).scrollDirection, Axis.horizontal);
    final code = find.descendant(of: scroll, matching: find.byType(RichText));
    final paragraph = tester.renderObject<RenderParagraph>(code);
    final viewport = tester.getSize(scroll).width;
    expect(paragraph.size.width, greaterThan(viewport));
    expect(paragraph.text.toPlainText().split('\n'), hasLength(5), reason: 'one row per line');
    // The gutter keeps its place while the code scrolls.
    final gutterBefore = tester.getTopLeft(find.text('10 10\n11   \n   11\n   12\n12 13'));
    await tester.drag(scroll, const Offset(-200, 0));
    await tester.pump();
    expect(tester.getTopLeft(find.text('10 10\n11   \n   11\n   12\n12 13')), gutterBefore);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Plain mode in Mono shows the same diff', (tester) async {
    await pumpReader(
      tester,
      email(text: patch),
      settings: const ReaderSettings(mode: ReaderMode.plain, plainFont: PlainTextFont.mono),
    );
    expect(find.byType(DiffView), findsOneWidget);
    expect(find.byType(DiffStatView), findsOneWidget);
  });

  testWidgets('quoted hunks of a review reply show as diffs inside the quote bar', (tester) async {
    const review = 'Alice wrote:\n> @@ -1,2 +1,2 @@\n>  keep\n> -old\n> +new\n\nWhy?\n\n> +more\n';
    await pumpReader(tester, email(text: review));
    expect(find.byType(DiffView), findsNWidgets(2));
    expect(richText('Why?'), findsOneWidget);
    // No file header for an excerpt.
    expect(find.text('diff'), findsNothing);
  });

  testWidgets('binary files and pure renames say so', (tester) async {
    await pumpReader(
      tester,
      email(
        text:
            'diff --git a/x.png b/x.png\nindex 1..2 100644\nBinary files a/x.png and b/x.png differ\n'
            'diff --git a/a.md b/b.md\nsimilarity index 100%\nrename from a.md\nrename to b.md\n',
      ),
    );
    expect(find.text('Binary file, not shown'), findsOneWidget);
    expect(find.text('Renamed without changes'), findsOneWidget);
    expect(find.text('renamed from a.md'), findsOneWidget);
  });

  testWidgets('very long hunks show their start and a button for the rest', (tester) async {
    final lines = List.generate(600, (i) => '+line $i').join('\n');
    await pumpReader(tester, email(text: '@@ -0,0 +1,600 @@\n$lines\n'));
    expect(find.text('Show all 600 lines'), findsOneWidget);
    final code = find.descendant(
      of: find.descendant(of: find.byType(HunkBody), matching: find.byType(SingleChildScrollView)),
      matching: find.byType(RichText),
    );
    expect(tester.renderObject<RenderParagraph>(code).text.toPlainText().split('\n'), hasLength(HunkBody.initialLines));
    await tester.ensureVisible(find.text('Show all 600 lines'));
    await tester.tap(find.text('Show all 600 lines'));
    await tester.pump();
    expect(find.text('Show all 600 lines'), findsNothing);
  });

  testWidgets('added and removed lines stay readable in light and dark', (tester) async {
    for (final brightness in Brightness.values) {
      late BuildContext captured;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: brightness),
          home: Builder(
            builder: (context) {
              captured = context;
              return const SizedBox();
            },
          ),
        ),
      );
      final scheme = Theme.of(captured).colorScheme;
      final palette = DiffPalette.of(captured);
      final page = scheme.surface;
      for (final band in [palette.addedLine, palette.removedLine, palette.addedGutter, palette.removedGutter]) {
        final behind = Color.alphaBlend(band, page);
        expect(contrastRatio(scheme.onSurface.toARGB32(), behind.toARGB32()), greaterThan(7), reason: '$brightness');
        expect(behind, isNot(page));
      }
      for (final mark in [palette.addedMark, palette.removedMark]) {
        expect(contrastRatio(mark.toARGB32(), page.toARGB32()), greaterThan(3.5), reason: '$brightness');
      }
    }
  });
}
