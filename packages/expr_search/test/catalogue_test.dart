import 'package:expr_search/expr_search.dart';
import 'package:test/test.dart';

void main() {
  final catalogue = operatorCatalogue();

  test('lists every operator once, by canonical name', () {
    final names = catalogue.map((o) => o.name).toList();
    expect(names.toSet(), hasLength(names.length));
    expect(names, containsAll(['from', 'to', 'subject', 'is', 'has', 'after', 'newer_than', 'account']));
  });

  test('names the fixed values of is: and has:', () {
    expect(catalogue.singleWhere((o) => o.name == 'is').values, containsAll(['unread', 'flagged', 'replied']));
    expect(catalogue.singleWhere((o) => o.name == 'has').values, ['attachment']);
    expect(catalogue.singleWhere((o) => o.name == 'from').values, isEmpty);
  });

  test('every example parses', () {
    for (final op in catalogue) {
      final parsed = parseQuery(op.example, now: DateTime.utc(2026, 10, 29));
      expect(parsed.isValid, isTrue, reason: '${op.name}: ${op.example} → ${parsed.errors}');
    }
  });

  test('aliases resolve to the same operator as the name', () {
    final now = DateTime.utc(2026, 10, 29);
    for (final op in catalogue.where((o) => o.aliases.isNotEmpty && o.values.isEmpty)) {
      final byName = parseQuery(op.example, now: now).expr;
      final byAlias = parseQuery(op.example.replaceFirst('${op.name}:', '${op.aliases.first}:'), now: now).expr;
      expect(byAlias, byName, reason: '${op.aliases.first}: should equal ${op.name}:');
    }
  });
}
