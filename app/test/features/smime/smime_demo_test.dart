import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/smime/smime_revocation.dart';
import 'package:loupe/router.dart';

import '../../helpers.dart';
import '../openpgp/openpgp_test_support.dart';
import '../openpgp/reading_test.dart' show demoId;

/// The demo's S/MIME mail: its header states without real certificates.
void main() {
  testWidgets('Aisha’s signed message: signed by her, vouched for by the demo CA', (tester) async {
    final repo = await pumpLoupe(tester, overrides: [inlinePgp]);
    final id = await demoId(repo, (e) => e.subject == 'Q4 budget, signed off');
    await goTo(tester, Routes.message(id));
    expect(textContaining('Signed by Aisha Karimi ✓ (Northwind Traders (demo))'), findsOneWidget);
    expect(textContaining('I signed off the Q4 budget'), findsWidgets);
    await tester.tap(find.byKey(ValueKey('smime-status-$id')));
    await tester.pumpAndSettle();
    expect(textContaining('Revocation isn’t checked'), findsOneWidget);
  });

  testWidgets('her encrypted message: decrypted with Sam’s certificate, its subject protected', (tester) async {
    final repo = await pumpLoupe(tester, overrides: [inlinePgp]);
    final id = await demoId(repo, (e) => e.sender?.email == 'aisha.karimi@northwind.example' && e.subject == '...');
    expect((await repo.getEmail(id))!.isEncrypted, isTrue);
    await goTo(tester, Routes.message(id));
    expect(find.text('Salary review dates (confidential)'), findsWidgets);
    expect(textContaining('The salary reviews are on 2 and 3 December.'), findsWidgets);
    expect(textContaining('Subject: Salary review'), findsNothing);
    expect(textContaining('Encrypted (S/MIME)'), findsOneWidget);
    expect(textContaining('Signed by Aisha Karimi ✓'), findsOneWidget);
    final remembered = (await repo.getEmail(id))!;
    expect((remembered.subject, remembered.hasDecryptedSubject), ('Salary review dates (confidential)', true));
  });

  testWidgets('Hana’s: ✓ until revocation is checked, then revoked (answered offline by the demo)', (tester) async {
    final repo = await pumpLoupe(tester, overrides: [inlinePgp]);
    final id = await demoId(repo, (e) => e.subject == 'New bank details for the Fabrikam invoice');
    await goTo(tester, Routes.message(id));
    expect(textContaining('Signed by Hana Sato ✓'), findsOneWidget);

    final checking = await pumpLoupe(tester, overrides: [inlinePgp], prefs: {CheckRevocation.key: true});
    final again = await demoId(checking, (e) => e.subject == 'New bank details for the Fabrikam invoice');
    await goTo(tester, Routes.message(again));
    expect(textContaining('Signed by Hana Sato · certificate revoked'), findsOneWidget);
    await tester.tap(find.byKey(ValueKey('smime-status-$again')));
    await tester.pumpAndSettle();
    expect(find.text('Revoked'), findsOneWidget);
    expect(textContaining('key compromise'), findsWidgets);
  });
}
