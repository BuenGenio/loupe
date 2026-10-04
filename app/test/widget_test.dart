import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';

void main() {
  testWidgets('app starts on the mailboxes screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: LoupeApp()));
    await tester.pumpAndSettle();
    expect(find.text('Mailboxes'), findsWidgets);
  });
}
