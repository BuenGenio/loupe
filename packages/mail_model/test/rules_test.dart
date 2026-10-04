import 'dart:convert';

import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  test('rules round-trip through JSON', () {
    const rule = Rule(
      id: 'r1',
      name: 'Receipts',
      condition: 'from:@shop.example s:receipt',
      actions: [
        MoveToMailboxAction('acc|Receipts'),
        AddTagAction(r'$label2'),
        RemoveTagAction(r'$label1'),
        FlagAction(),
        MarkReadAction(),
        MarkJunkAction(),
        KeepInInboxAction(),
        ForwardAction('me@example.org', keepCopy: false),
      ],
      enabled: false,
      accountIds: {'acc'},
      stopProcessing: true,
      location: RuleLocation.server,
      order: 3,
    );
    final back = Rule.fromJson((jsonDecode(jsonEncode(rule.toJson())) as Map).cast());
    expect(back, rule);
    expect(back.actions, rule.actions);
  });

  test('unknown actions and missing fields are tolerated', () {
    final rule = Rule.fromJson({
      'id': 'x',
      'actions': [
        {'type': 'teleport'},
        {'type': 'flag'},
        {'type': 'move'},
      ],
    });
    expect(rule.actions, [const FlagAction()]);
    expect(rule.enabled, isTrue);
    expect(rule.location, RuleLocation.device);
    expect(rule.accountIds, isEmpty);
    expect(rule.appliesTo('any'), isTrue);
  });

  test('forwarding runs only on the server; keeping stops later rules', () {
    expect(const ForwardAction('a@b.c').runsOn(RuleLocation.device), isFalse);
    expect(const ForwardAction('a@b.c').runsOn(RuleLocation.server), isTrue);
    expect(const FlagAction().runsOn(RuleLocation.device), isTrue);
    expect(const Rule(id: 'a', name: '', condition: '', actions: [KeepInInboxAction()]).stops, isTrue);
    expect(const Rule(id: 'a', name: '', condition: '', accountIds: {'x'}).appliesTo('y'), isFalse);
  });
}
