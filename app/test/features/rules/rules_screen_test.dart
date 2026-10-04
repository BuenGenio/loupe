import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';

import '../../helpers.dart';

Future<List<Rule>> _rules(DemoMailRepository repo) => repo.rules.watchRules().first;

void main() {
  testWidgets('Settings › Rules lists the rules with their place, and switches turn them off', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.settings);
    await tester.scrollTo(find.text('Rules'));
    await tester.ensureVisible(find.text('Rules'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rules'));
    await tester.pumpAndSettle();

    expect(find.text('Issue tracker'), findsOneWidget);
    expect(find.text('Receipts'), findsOneWidget);
    expect(find.text('Open Garden list'), findsOneWidget);
    expect(find.text('Device'), findsNWidgets(2));
    expect(find.text('Server'), findsOneWidget);
    expect(find.text('from:issues.northwind.example'), findsOneWidget);
    expect(find.text('Tag Work'), findsOneWidget);
    // Fastmail's server runs its own script, so Loupe's rules are off there.
    expect(find.text('SERVER RULES'), findsOneWidget);
    expect(find.text('Off'), findsOneWidget);
    expect(textContaining('“filters” is the active script'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Issue tracker on'));
    await tester.pumpAndSettle();
    expect((await _rules(repo)).first.enabled, isFalse);
  });

  testWidgets('dragging a rule by its handle reorders the rules', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.rules);
    final handle = find.byIcon(LoupeIcons.reorder).first;
    final gesture = await tester.startGesture(tester.getCenter(handle));
    await tester.pump(const Duration(milliseconds: 100));
    await gesture.moveBy(const Offset(0, 90));
    await tester.pump(const Duration(milliseconds: 100));
    await gesture.moveBy(const Offset(0, 90));
    await tester.pump(const Duration(milliseconds: 100));
    await gesture.up();
    await tester.pumpAndSettle();
    expect([for (final r in await _rules(repo)) r.name], ['Receipts', 'Issue tracker', 'Open Garden list']);
    expect(tester.getTopLeft(find.text('Receipts')).dy, lessThan(tester.getTopLeft(find.text('Issue tracker')).dy));

    // A rule added afterwards shows up too.
    await repo.rules.saveRule(const Rule(id: 'n', name: 'Newcomer', condition: 'f:x', actions: [FlagAction()]));
    await tester.pumpAndSettle();
    expect(find.text('Newcomer'), findsOneWidget);
  });

  testWidgets('turning server rules on shows the exact lines added to the active script', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.rules);
    await tester.tap(find.text('Fastmail'));
    await tester.pumpAndSettle();

    expect(find.text('Turn On Server Rules'), findsOneWidget);
    expect(textContaining('Loupe won’t replace it'), findsOneWidget);
    expect(textContaining('+ include :personal "loupe";'), findsOneWidget);
    await tester.tap(find.text('Add to “filters”'));
    await tester.pumpAndSettle();

    expect(find.text('Turn On Server Rules'), findsNothing);
    expect(find.text('On'), findsOneWidget);
    expect(textContaining('Run from “filters”'), findsOneWidget);
    expect(repo.rules.servers[DemoAccounts.fastmail].scripts['filters'], contains('include :personal "loupe";'));
  });

  testWidgets('a new rule from a query: accounts, actions, preview, save', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.newRule(condition: 'from:jordan.lee@example.com'));

    expect(find.text('New Rule'), findsOneWidget);
    expect(find.text('From: jordan.lee@example.com'), findsWidgets);

    await tester.tap(find.text('Accounts'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Personal'));
    await tester.tap(find.bySemanticsLabel('Back').last);
    await tester.pumpAndSettle();
    expect(find.text('Personal'), findsOneWidget);

    await tester.scrollTo(find.text('Add Action'));
    await tester.tap(find.text('Add Action'));
    await tester.pumpAndSettle();
    // Forwarding is for server rules only.
    expect(find.text('Forward To…'), findsNothing);
    await tester.tap(find.text('Flag'));
    await tester.pumpAndSettle();
    expect(find.text('Flag'), findsOneWidget);

    // The preview: Jordan's mail of the last 30 days.
    await tester.scrollTo(textContaining('MATCHING MESSAGE'));
    expect(textContaining('MATCHING MESSAGE'), findsOneWidget);
    expect(find.text('Jordan Lee'), findsWidgets);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final saved = (await _rules(repo)).last;
    expect(saved.name, 'From: jordan.lee@example.com');
    expect(saved.condition, 'from:jordan.lee@example.com');
    expect(saved.actions, [const FlagAction()]);
    expect(saved.accountIds, {DemoAccounts.personal});
    expect(saved.location, RuleLocation.device);
    expect(find.text('New Rule'), findsNothing);
  });

  testWidgets('a server rule that can’t run there says why and offers the device instead', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.newRule(condition: 'is:unread'));
    await tester.scrollTo(find.text('Server'));
    await tester.tap(find.text('Server'));
    await tester.pumpAndSettle();
    await tester.scrollTo(find.text('Run on This Device Instead'));
    expect(textContaining('Can’t run on the server of Personal: Gmail doesn’t offer server rules'), findsOneWidget);
    expect(textContaining('Can’t run on the server of Fastmail: “Unread”: new mail has no read'), findsOneWidget);
    await tester.tap(find.text('Run on This Device Instead'));
    await tester.pumpAndSettle();
    expect(find.text('Run on This Device Instead'), findsNothing);
  });

  testWidgets('a server rule shows its Sieve script and is installed on save', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.newRule(condition: 'from:@brandt.example'));
    await tester.tap(find.text('Accounts'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fastmail'));
    await tester.tap(find.bySemanticsLabel('Back').last);
    await tester.pumpAndSettle();
    await tester.scrollTo(find.text('Add Action'));
    await tester.tap(find.text('Add Action'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mark as Read'));
    await tester.pumpAndSettle();
    await tester.scrollTo(find.text('Server'));
    await tester.tap(find.text('Server'));
    await tester.pumpAndSettle();
    await tester.scrollTo(find.text('Show Script'));
    await tester.tap(find.text('Show Script'));
    await tester.pumpAndSettle();
    expect(textContaining('if address :domain :is "from" "brandt.example"'), findsOneWidget);
    expect(textContaining(r'addflag "\\Seen";'), findsOneWidget);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    // Fastmail's own script is active: Loupe offers the include, never replaces it.
    expect(find.text('Turn On Server Rules'), findsOneWidget);
    await tester.tap(find.text('Leave Off'));
    await tester.pumpAndSettle();
    final script = repo.rules.servers[DemoAccounts.fastmail].scripts[loupeScriptName]!;
    expect(script, contains('address :domain :is "from" "brandt.example"'));
    expect(repo.rules.servers[DemoAccounts.fastmail].active, 'filters');
  });

  testWidgets('editing: apply to existing messages after confirming the count, and delete', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.editRule('demo-receipts'));
    expect(find.text('Edit Rule'), findsOneWidget);
    await tester.scrollTo(find.text('Apply to Existing Messages…'));
    await tester.tap(find.text('Apply to Existing Messages…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('All Mailboxes'));
    await tester.pumpAndSettle();
    expect(textContaining('Apply “Receipts” to'), findsOneWidget);
    await tester.tap(find.textContaining(RegExp(r'^Apply to \d+ Messages?$')));
    await tester.pumpAndSettle();
    expect(textContaining('Applied “Receipts” to'), findsOneWidget);
    final receipts = await repo
        .watchList(RealMailboxRef(MailIds.mailbox(DemoAccounts.personal, 'Receipts')), threaded: false)
        .first;
    expect(receipts.where((t) => t.latest.from.first.email.endsWith('harborcoffee.example')), isNotEmpty);

    await tester.scrollTo(find.text('Delete Rule'));
    await tester.tap(find.text('Delete Rule'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Rule').last);
    await tester.pumpAndSettle();
    expect([for (final r in await _rules(repo)) r.id], isNot(contains('demo-receipts')));
    await drainTimers(tester);
  });

  testWidgets('Make This a Rule from the search menu fills in the query', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.search('lisbon'));
    await tester.tap(find.bySemanticsLabel('Search Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Make This a Rule'));
    await tester.pumpAndSettle();
    expect(find.text('New Rule'), findsOneWidget);
    final field = tester.widget<TextField>(find.byKey(const ValueKey('rule-condition')));
    expect(field.controller!.text, 'lisbon');
    expect(find.byType(CupertinoSlidingSegmentedControl<RuleLocation>), findsOneWidget);
  });

  testWidgets('a new rule can start with a name and actions (Subscriptions › Create Rule)', (tester) async {
    final repo = await pumpLoupe(tester);
    final archive = MailIds.mailbox(DemoAccounts.work, 'Archive');
    final location = Routes.newRule(
      condition: 'from:builds@ci.northwind.example',
      name: 'CI builds',
      actions: [MoveToMailboxAction(archive), const MarkReadAction()],
    );
    expect(Routes.ruleActionsFrom(Uri.parse(location).queryParameters['actions']), [
      MoveToMailboxAction(archive),
      const MarkReadAction(),
    ]);
    expect(Routes.ruleActionsFrom('not json'), isEmpty);
    expect(Routes.ruleActionsFrom('{"type": "flag"}'), isEmpty);
    await goTo(tester, location);
    expect(find.text('CI builds'), findsOneWidget);
    expect(find.text('Move to Archive'), findsOneWidget);
    expect(find.text('Mark as Read'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final saved = (await _rules(repo)).last;
    expect(saved.name, 'CI builds');
    expect(saved.condition, 'from:builds@ci.northwind.example');
    expect(saved.actions, [MoveToMailboxAction(archive), const MarkReadAction()]);
  });
}
