import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import 'openpgp_test_support.dart';

/// Ids of what the demo's local search finds for [query].
Future<List<String>> searchIds(DemoMailRepository repo, String query) async {
  final results = await repo
      .search(SearchRequest(expr: TextTerm(SearchField.body, query), scope: const AllMailboxesScope()))
      .first;
  return [for (final e in results.items) e.id];
}

Future<String> danaId(DemoMailRepository repo) async {
  final rows = await repo
      .watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes), threaded: false, limit: 1000)
      .first;
  return rows
      .map((t) => t.latest)
      .firstWhere((e) => e.isEncrypted && e.sender?.email == 'dana.okafor@northwind.example')
      .id;
}

void main() {
  testWidgets('off (the default): an encrypted message is found by its headers only, even once read', (tester) async {
    final repo = await pumpLoupe(tester, overrides: [inlinePgp]);
    final id = await danaId(repo);
    await goTo(tester, Routes.message(id));
    expect(textContaining('Lighthouse Lodge'), findsWidgets);
    expect(await searchIds(repo, 'lighthouse'), isNot(contains(id)));
  });

  testWidgets('on: its text is found once decrypted; turning it off takes the text out', (tester) async {
    final repo = await pumpLoupe(tester, prefs: {'e2ee.indexForSearch': true}, overrides: [inlinePgp]);
    final id = await danaId(repo);
    expect(await searchIds(repo, 'lighthouse'), isNot(contains(id)), reason: 'not before it was decrypted');
    await goTo(tester, Routes.message(id));
    expect(await searchIds(repo, 'lighthouse'), contains(id));
    expect(await searchIds(repo, 'offsite-budget'), contains(id), reason: 'attachment names too');

    await goTo(tester, Routes.encryption);
    final row = find.byKey(const ValueKey('index-decrypted'));
    await tester.scrollTo(row);
    expect(textContaining('Search finds encrypted messages by their sender'), findsOneWidget);
    await tester.tap(row);
    await tester.pumpAndSettle();
    expect(await searchIds(repo, 'lighthouse'), isNot(contains(id)));
  });
}
