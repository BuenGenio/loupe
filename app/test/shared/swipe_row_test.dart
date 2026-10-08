import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:loupe/shared/swipe_row.dart';

/// A list of rows that archive themselves on a full swipe to the left,
/// like the message list (keys by id, findChildIndexCallback).
class _List extends StatefulWidget {
  const _List({super.key, required this.archived});

  final List<String> archived;

  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  List<String> ids = ['a', 'b', 'c'];

  void update(List<String> next) => setState(() => ids = next);

  @override
  Widget build(BuildContext context) {
    final indexOf = {for (final (i, id) in ids.indexed) id: i};
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: ids.length,
          findChildIndexCallback: (key) => key is ValueKey<String> ? indexOf[key.value] : null,
          itemBuilder: (context, i) {
            final id = ids[i];
            return SwipeActionRow(
              key: ValueKey(id),
              trailing: [
                SwipeActionSpec(
                  icon: Icons.archive,
                  label: 'Archive',
                  color: Colors.blue,
                  removesRow: true,
                  onTriggered: () => widget.archived.add(id),
                ),
              ],
              child: SizedBox(height: 60, width: double.infinity, child: Text('row $id')),
            );
          },
        ),
      ],
    );
  }
}

void main() {
  Future<GlobalKey<_ListState>> pumpList(WidgetTester tester, List<String> archived) async {
    tester.view
      ..physicalSize = const Size(390, 844) * 3
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final key = GlobalKey<_ListState>();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: loupeLocalizationsDelegates,
        home: Scaffold(
          body: _List(key: key, archived: archived),
        ),
      ),
    );
    return key;
  }

  Future<void> fullSwipe(WidgetTester tester, String id) async {
    await tester.drag(find.text('row $id'), const Offset(-300, 0));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
  }

  testWidgets('a full swipe archives', (tester) async {
    final archived = <String>[];
    await pumpList(tester, archived);
    await fullSwipe(tester, 'b');
    await tester.pumpAndSettle();
    expect(archived, ['b']);
  });

  testWidgets('a full swipe still archives when sync changes the list mid-slide', (tester) async {
    final archived = <String>[];
    final list = await pumpList(tester, archived);
    await fullSwipe(tester, 'b');
    // New mail arrives above while the row slides away.
    list.currentState!.update(['new', 'a', 'b', 'c']);
    await tester.pumpAndSettle();
    expect(archived, ['b']);
  });

  testWidgets('a full swipe still archives when its row goes away mid-slide', (tester) async {
    final archived = <String>[];
    final list = await pumpList(tester, archived);
    await fullSwipe(tester, 'b');
    // Sync removed it (moved on another device) before the slide ended.
    list.currentState!.update(['a', 'c']);
    await tester.pumpAndSettle();
    expect(archived, ['b']);
  });
}
