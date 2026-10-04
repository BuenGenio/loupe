import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:test/test.dart';

import 'support/fake_server.dart';
import 'support/harness.dart';

Rule _rule(
  String id,
  String condition,
  List<RuleAction> actions, {
  bool stop = false,
  RuleLocation location = RuleLocation.device,
}) => Rule(id: id, name: id, condition: condition, actions: actions, stopProcessing: stop, location: location);

void main() {
  group('device rules on new mail', () {
    test('run once on new Inbox mail, in order, never on mail that was there', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()..deliver('INBOX', subject: 'Old newsletter', from: 'news@lists.example');
        final a = await h.add(server);
        await h.repo.rules.saveRule(_rule('tag', 'from:lists.example', [const AddTagAction(r'$label2')]));
        await h.repo.rules.saveRule(_rule('file', 'tag:work', [MoveToMailboxAction(h.mailbox(a, 'Work'))], stop: true));
        await h.repo.rules.saveRule(_rule('never', '', [const FlagAction()]));

        server
          ..deliver('INBOX', subject: 'New newsletter', from: 'news@lists.example')
          ..deliver('INBOX', subject: 'From a friend', from: 'friend@example.com');
        await h.repo.refresh();
        await settle();

        expect(await h.subjects(a, 'Work'), ['New newsletter']);
        expect(server.subjects('Work'), ['New newsletter']);
        expect(server.find('Work', 'New newsletter')!.keywords, {r'$label2'});
        // The rule that stopped kept the third rule away; the friend got it.
        expect(server.find('INBOX', 'From a friend')!.keywords, {Keywords.flagged});
        // Mail from before the rules existed is left alone.
        expect(server.find('INBOX', 'Old newsletter')!.keywords, isEmpty);

        // Another sync doesn't run the rules again on the same mail.
        await h.repo.rules.saveRule(_rule('again', '', [const AddTagAction('again')]));
        server.log.clear();
        await h.repo.refresh();
        await settle();
        expect(server.log.where((l) => l == 'setKeywords' || l == 'move'), isEmpty);
        await h.dispose();
      });
    });

    test('content is fetched only when a condition needs the body', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer();
        final a = await h.add(server);
        await h.repo.rules.saveRule(_rule('subject', 's:invoice', [const FlagAction()]));
        server.deliver('INBOX', subject: 'Invoice 7', text: 'short');
        await h.repo.refresh();
        await settle();
        expect(server.log, isNot(contains('content')));
        expect(server.find('INBOX', 'Invoice 7')!.keywords, {Keywords.flagged});

        await h.repo.rules.saveRule(_rule('body', 'b:"tracking number"', [const MarkReadAction()]));
        server.deliver('INBOX', subject: 'Parcel', text: '${'x' * 300} tracking number 42');
        server.deliver('INBOX', subject: 'Other', text: 'nothing here');
        await h.repo.refresh();
        await settle();
        // The bodies are loaded: "Parcel" has the words past its preview, and
        // a preview without them doesn't decide "Other".
        expect(server.log.where((l) => l == 'content'), hasLength(2));
        expect(server.find('INBOX', 'Parcel')!.keywords, {Keywords.seen});
        expect(server.find('INBOX', 'Other')!.keywords, isEmpty);
        expect((await h.email(a, 'INBOX', 'Parcel')).isSeen, isTrue);
        await h.dispose();
      });
    });

    test('older mail loaded later and a UIDVALIDITY reset are not new mail', () {
      fakeTime((async) async {
        final h = Harness(
          config: const SyncConfig(
            pollInterval: Duration(minutes: 5),
            reconnectBase: Duration(seconds: 5),
            reconnectMax: Duration(minutes: 1),
            initialWindow: 2,
          ),
        );
        final server = FakeServer();
        for (var i = 0; i < 4; i++) {
          server.deliver('INBOX', subject: 'Old $i');
        }
        final a = await h.add(server);
        await h.repo.rules.saveRule(_rule('flag', '', [const FlagAction()]));
        await h.repo.loadOlder(RealMailboxRef(h.mailbox(a, 'INBOX')));
        await settle();
        server.resetUidValidity('INBOX');
        await h.repo.refresh();
        await settle();
        expect(server.box('INBOX').messages.values.where((m) => m.keywords.isNotEmpty), isEmpty);
        server.deliver('INBOX', subject: 'Really new');
        await h.repo.refresh();
        await settle();
        expect(server.find('INBOX', 'Really new')!.keywords, {Keywords.flagged});
        expect(server.box('INBOX').messages.values.where((m) => m.keywords.isNotEmpty), hasLength(1));
        await h.dispose();
      });
    });

    test('Apply to existing finds exact matches and acts through the queue', () {
      fakeTime((async) async {
        final h = Harness();
        final server = FakeServer()
          ..deliver('INBOX', subject: 'Receipt 1', from: 'shop@store.example')
          ..deliver('INBOX', subject: 'Receipt 2', from: 'shop@store.example')
          ..deliver('INBOX', subject: 'Hello', from: 'friend@example.com');
        final a = await h.add(server);
        final rule = _rule('r', 'from:store.example', [MoveToMailboxAction(h.mailbox(a, 'Archive'))]);
        final found = await h.repo.rules.findMatches(
          rule,
          const MailboxScope(VirtualMailboxRef(VirtualMailbox.allInboxes)),
        );
        expect([for (final e in found) e.subject]..sort(), ['Receipt 1', 'Receipt 2']);
        expect(await h.repo.rules.applyRule(rule, [for (final e in found) e.id]), 2);
        await settle();
        expect(server.subjects('Archive')..sort(), ['Receipt 1', 'Receipt 2']);
        expect(server.subjects('INBOX'), ['Hello']);
        await h.dispose();
      });
    });

    test('forwarding can’t be a device rule; conditions must parse', () {
      fakeTime((async) async {
        final h = Harness();
        await expectLater(
          h.repo.rules.saveRule(_rule('f', '', [const ForwardAction('a@b.example')])),
          throwsA(isA<MailException>().having((e) => e.message, 'message', contains('server rules'))),
        );
        await expectLater(
          h.repo.rules.saveRule(_rule('c', 'before:nonsense', [const FlagAction()])),
          throwsA(isA<MailException>().having((e) => e.message, 'message', contains('condition'))),
        );
        expect(await h.repo.rules.watchRules().first, isEmpty);
        await h.dispose();
      });
    });
  });

  group('server rules', () {
    test('saving installs and activates Loupe’s script; deleting updates it', () {
      fakeTime((async) async {
        final h = Harness();
        final a = await h.add(FakeServer());
        final rule = _rule('lists', 'h:List-Id', [
          MoveToMailboxAction(h.mailbox(a, 'Work')),
        ], location: RuleLocation.server);
        await h.repo.rules.saveRule(rule);
        final server = h.sieve[a.id];
        expect(server.active, loupeScriptName);
        expect(
          server.log,
          containsAllInOrder([
            'HAVESPACE loupe ${server.scripts['loupe']!.length}',
            'CHECKSCRIPT',
            'PUTSCRIPT loupe',
            'SETACTIVE loupe',
          ]),
        );
        expect(server.scripts['loupe'], contains('if exists "List-Id" {\n  fileinto :create "Work";\n}'));
        expect(parseLoupeScript(server.scripts['loupe']!).single.id, 'lists');
        final status = await h.repo.rules.serverStatus(a.id);
        expect(status.state, ServerRulesState.active);
        expect(status.extensions, contains('fileinto'));

        await h.repo.rules.deleteRule('lists');
        expect(parseLoupeScript(server.scripts['loupe']!), isEmpty);
        await h.dispose();
      });
    });

    test('rules that can’t run on the server are refused with the reason', () {
      fakeTime((async) async {
        final h = Harness();
        final a = await h.add(FakeServer());
        final rule = _rule('u', 'is:unread from:x', [const FlagAction()], location: RuleLocation.server);
        final previews = await h.repo.rules.previewServerRule(rule);
        expect(previews.single.canRun, isFalse);
        expect(previews.single.problems.single, contains('“Unread”'));
        await expectLater(
          h.repo.rules.saveRule(rule),
          throwsA(isA<MailException>().having((e) => e.message, 'message', startsWith('Can’t run on the server: '))),
        );
        expect(await h.repo.rules.watchRules().first, isEmpty);
        expect(h.sieve[a.id].scripts, isEmpty);

        final ok = (await h.repo.rules.previewServerRule(rule.copyWith(condition: 'from:x'))).single;
        expect(ok.canRun, isTrue);
        expect(ok.script, contains('header :contains "from" "x"'));
        await h.dispose();
      });
    });

    test('another active script is never replaced; including Loupe’s is offered', () {
      fakeTime((async) async {
        final h = Harness();
        final a = await h.add(FakeServer());
        const sogo = 'require ["fileinto"];\nif header :contains "subject" "[SPAM]" {\n  fileinto "Junk";\n}\n';
        final server = h.sieve[a.id]
          ..scripts['sogo'] = sogo
          ..active = 'sogo';
        await h.repo.rules.saveRule(_rule('s', 's:x', [const FlagAction()], location: RuleLocation.server));
        expect(server.active, 'sogo');
        expect(server.scripts['sogo'], sogo);
        var status = await h.repo.rules.serverStatus(a.id);
        expect((status.state, status.activeScript), (ServerRulesState.inactive, 'sogo'));

        final proposal = (await h.repo.rules.proposeInclude(a.id))!;
        expect(proposal.scriptName, 'sogo');
        expect(proposal.before, sogo);
        expect(proposal.addedLines, ['require "include";', includeComment, 'include :personal "loupe";']);
        await h.repo.rules.applyInclude(proposal);
        expect(server.scripts['sogo'], proposal.after);
        expect(server.active, 'sogo');
        status = await h.repo.rules.serverStatus(a.id);
        expect((status.state, status.viaInclude), (ServerRulesState.active, true));
        expect(await h.repo.rules.proposeInclude(a.id), isNull);
        await h.dispose();
      });
    });

    test('an include proposal for a script that changed meanwhile is refused', () {
      fakeTime((async) async {
        final h = Harness();
        final a = await h.add(FakeServer());
        final server = h.sieve[a.id]
          ..scripts['sogo'] = 'keep;'
          ..active = 'sogo';
        final proposal = (await h.repo.rules.proposeInclude(a.id))!;
        server.scripts['sogo'] = 'discard;';
        await expectLater(h.repo.rules.applyInclude(proposal), throwsA(isA<MailException>()));
        expect(server.scripts['sogo'], 'discard;');
        await h.dispose();
      });
    });

    test('rules saved by another device are picked up; unavailable servers say why', () {
      fakeTime((async) async {
        final h = Harness();
        final a = await h.add(FakeServer());
        final elsewhere = generateLoupeScript([
          _rule('remote', 'from:boss@example.com', [const FlagAction()], location: RuleLocation.server),
        ], SieveTarget(account: a)).text;
        h.sieve[a.id]
          ..scripts['loupe'] = elsewhere
          ..active = 'loupe';
        await h.repo.rules.serverStatus(a.id, refresh: true);
        final rules = await h.repo.rules.watchRules().first;
        expect([for (final r in rules) (r.id, r.location)], [('remote', RuleLocation.server)]);

        h.sieve.unavailable[a.id] = 'No ManageSieve here.';
        final status = await h.repo.rules.serverStatus(a.id, refresh: true);
        expect((status.state, status.message), (ServerRulesState.unavailable, 'No ManageSieve here.'));
        await h.dispose();
      });
    });

    test('a failed upload after a delete is retried after the next sync', () {
      fakeTime((async) async {
        final h = Harness();
        final a = await h.add(FakeServer());
        await h.repo.rules.saveRule(_rule('s', 's:x', [const FlagAction()], location: RuleLocation.server));
        final server = h.sieve[a.id]..failure = const MailException(MailErrorKind.connection, 'Offline');
        await h.repo.rules.deleteRule('s');
        await settle(const Duration(milliseconds: 10));
        expect(h.errors.single.message, contains('Couldn’t update the server rules'));
        expect(parseLoupeScript(server.scripts['loupe']!), hasLength(1));
        server.failure = null;
        await h.repo.refresh();
        await settle();
        expect(parseLoupeScript(server.scripts['loupe']!), isEmpty);
        await h.dispose();
      });
    });
  });
}
