import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/conversation/security/assessment.dart';
import 'package:loupe/features/conversation/security/sender_facts.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

import '../fake_mail_repository.dart';

const shop = EmailAddress('news@shop.example', 'Shop News');
const pass = ('Authentication-Results', 'mx.example.net; dkim=pass header.d=shop.example; spf=pass; dmarc=pass');
const fail = ('Authentication-Results', 'mx.example.net; dkim=none; spf=softfail; dmarc=fail header.from=x');

EmailSummary summary({EmailAddress from = shop, List<EmailAddress> replyTo = const []}) => EmailSummary(
  id: 'm1',
  accountId: 'acc',
  mailboxId: 'acc|INBOX',
  receivedAt: DateTime(2026, 10, 4),
  from: [from],
  replyTo: replyTo,
  subject: 'Hello',
);

const known = SenderFacts(history: SenderHistory(received: 12, sent: 2), ownDomains: {'example.com'});
const firstTime = SenderFacts(history: SenderHistory(received: 1), ownDomains: {'example.com'});

LinkFinding mismatch({bool viaTracker = false}) => LinkFinding(
  LinkIssue.textMismatch,
  url: 'https://login.evil.example/x',
  text: 'www.bank.example',
  host: 'login.evil.example',
  detail: 'www.bank.example',
  viaTracker: viaTracker,
);

Set<FindingKind> kinds(SecurityReport r) => {for (final f in r.findings) f.kind};

Future<SecurityReport> assessDemo(DemoMailRepository repo, bool Function(EmailSummary) where) async {
  final boxes = await repo.watchMailboxes().first;
  final lists = [for (final b in boxes) await repo.watchList(RealMailboxRef(b.id), threaded: false, limit: 1000).first];
  final message = lists.expand((l) => l).map((t) => t.latest).firstWhere(where);
  final content = await repo.loadContent(message.id);
  return assessMessage(
    message: message,
    headers: content.headers,
    analysis: await analyzeContent(content),
    facts: await gatherSenderFacts(repo, message),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('verdicts', () {
    test('a normal newsletter: tracking is privacy, not suspicion', () {
      final r = assessMessage(
        message: summary(replyTo: const [EmailAddress('help@shop-support.example')]),
        headers: const [pass, ('List-Unsubscribe', '<https://shop.example/u>'), ('Precedence', 'bulk')],
        facts: firstTime,
        analysis: ReadableAnalysis(
          links: [mismatch(viaTracker: true)],
          hiddenElements: 1,
          hiddenTextLength: 60,
          privacy: const PrivacyReport(trackers: 2, trackedLinks: 5, trackingServices: ['Mailchimp']),
        ),
      );
      expect(r.verdict, Verdict.noIssues);
      expect(r.concerns, isEmpty);
      expect(r.verified, isTrue);
      expect(r.privacy.total, 7);
      expect(kinds(r), {FindingKind.firstTimeSender, FindingKind.linkUncheckable, FindingKind.replyToDiffers});
    });

    test('an unverified sender with a deceptive link is likely phishing', () {
      final r = assessMessage(
        message: summary(),
        headers: const [fail],
        analysis: ReadableAnalysis(links: [mismatch()]),
      );
      expect(r.verdict, Verdict.likelyPhishing);
      expect(r.findings.first.kind, FindingKind.authFailed);
      expect(r.verified, isFalse);
    });

    test('a deceptive link alone, sender unknown: be careful', () {
      final r = assessMessage(
        message: summary(),
        headers: const [],
        analysis: ReadableAnalysis(links: [mismatch()]),
      );
      expect(r.verdict, Verdict.beCareful);
      expect(r.findings.single.kind, FindingKind.linkMismatch);
    });

    test('a failed check alone: be careful', () {
      expect(assessMessage(message: summary(), headers: const [fail], facts: known).verdict, Verdict.beCareful);
    });

    test('a look-alike link host or sender domain is likely phishing on its own', () {
      final homograph = assessMessage(
        message: summary(),
        headers: const [pass],
        facts: known,
        analysis: const ReadableAnalysis(
          links: [
            LinkFinding(LinkIssue.homograph, url: 'https://xn--pple-43d.com/', host: 'аpple.com', detail: 'apple.com'),
          ],
        ),
      );
      expect(homograph.verdict, Verdict.likelyPhishing);
      expect(homograph.findings.first.explanation, contains('it is not apple.com'));

      final lookalike = assessMessage(
        message: summary(from: const EmailAddress('service@paypa1.com', 'PayPal')),
        headers: const [('Authentication-Results', 'mx; dkim=pass header.d=paypa1.com; dmarc=pass')],
        facts: known,
      );
      expect(lookalike.verdict, Verdict.likelyPhishing);
      expect(kinds(lookalike), contains(FindingKind.lookalikeSender));
      expect(lookalike.verified, isFalse);
    });

    test('a brand name with a phishing word: be careful', () {
      final r = assessMessage(
        message: summary(from: const EmailAddress('alerts@paypal-secure.example', 'PayPal')),
        headers: const [pass],
        facts: known,
      );
      expect(r.verdict, Verdict.beCareful);
      expect(r.findings.single.severity, Severity.warning);
    });

    test("a look-alike of the user's own domain", () {
      final r = assessMessage(
        message: summary(from: const EmailAddress('it@examp1e.com', 'IT')),
        headers: const [pass],
        facts: known,
      );
      expect(r.verdict, Verdict.likelyPhishing);
      expect(r.findings.first.explanation, contains('your own domain, example.com'));
    });

    test('findings are sorted worst first', () {
      final r = assessMessage(
        message: summary(),
        headers: const [fail],
        facts: firstTime,
        analysis: const ReadableAnalysis(
          passwordFields: 1,
          links: [
            LinkFinding(LinkIssue.shortener, url: 'https://bit.ly/x', host: 'bit.ly'),
            LinkFinding(LinkIssue.homograph, url: 'https://xn--80ak6aa92e.com/', host: 'аррӏе.com'),
          ],
        ),
      );
      final severities = r.findings.map((f) => f.severity.index).toList();
      expect(severities, [...severities]..sort((a, b) => b.compareTo(a)));
      expect(r.findings.first.kind, FindingKind.linkHomograph);
    });
  });

  group('sender signals', () {
    const dana = EmailAddress('dana@corp.example', 'Dana Okafor');
    const impostor = EmailAddress('dana.okafor@freemail.example', 'Dana Okafor');

    test('a VIP\'s name from a new address, replies elsewhere: likely phishing', () {
      final r = assessMessage(
        message: summary(from: impostor, replyTo: const [EmailAddress('d.okafor@other.example')]),
        headers: const [('Authentication-Results', 'mx; dkim=pass header.d=freemail.example; dmarc=pass')],
        facts: const SenderFacts(history: SenderHistory(received: 1), namesakes: [Namesake(dana, vip: true)]),
      );
      expect(r.verdict, Verdict.likelyPhishing);
      final impersonation = r.findings.firstWhere((f) => f.kind == FindingKind.impersonation);
      expect(impersonation.severity, Severity.danger);
      expect(impersonation.explanation, contains('your VIP Dana Okafor (dana@corp.example)'));
      expect(kinds(r), containsAll({FindingKind.replyToDiffers, FindingKind.firstTimeSender}));
    });

    test('a known name from a new address alone: be careful', () {
      final r = assessMessage(
        message: summary(from: impostor),
        headers: const [],
        facts: const SenderFacts(history: SenderHistory.none, namesakes: [Namesake(dana)]),
      );
      expect(r.verdict, Verdict.beCareful);
    });

    test('a sender the user knows is not impersonating anyone', () {
      final r = assessMessage(
        message: summary(from: impostor),
        headers: const [],
        facts: const SenderFacts(history: SenderHistory(received: 4), namesakes: [Namesake(dana)]),
      );
      expect(r.findings, isEmpty);
    });

    test('a display name that shows another address', () {
      final r = assessMessage(
        message: summary(from: const EmailAddress('x@mailer.example', 'service@bank.example')),
        headers: const [],
        facts: known,
      );
      expect(r.findings.single.kind, FindingKind.nameShowsOtherAddress);
      expect(r.verdict, Verdict.beCareful);
      // Google Groups rewrites senders like this; that's fine.
      final group = assessMessage(
        message: summary(from: const EmailAddress('list@groups.example', "'bob@example.org' via Hikers")),
        headers: const [],
        facts: known,
      );
      expect(group.findings, isEmpty);
    });

    test('a DKIM signature of another domain is not "Verified"', () {
      final r = assessMessage(
        message: summary(),
        headers: const [('Authentication-Results', 'mx; dkim=pass header.d=esp-mailer.example; spf=pass')],
        facts: known,
      );
      expect(r.verdict, Verdict.noIssues);
      expect(r.verified, isFalse);
      expect(r.findings.single.kind, FindingKind.authUnaligned);
    });

    test('mailing lists may set Reply-To', () {
      final r = assessMessage(
        message: summary(replyTo: const [EmailAddress('hikers@lists.example')]),
        headers: const [('List-Id', '<hikers.lists.example>')],
        facts: known,
      );
      expect(r.findings, isEmpty);
    });
  });

  group('demo mailbox', () {
    late DemoMailRepository repo;
    setUp(() => repo = DemoMailRepository.instant());
    tearDown(() => repo.dispose());

    test('the phishing message is a clear positive', () async {
      final r = await assessDemo(repo, (m) => m.subject.contains('PP-88213-US'));
      expect(r.verdict, Verdict.likelyPhishing);
      expect(kinds(r), containsAll({FindingKind.authFailed, FindingKind.linkMismatch, FindingKind.impersonation}));
    });

    test('newsletters have no issues', () async {
      final trailhead = await assessDemo(repo, (m) => m.sender?.email == 'news@trailhead.example');
      expect(trailhead.verdict, Verdict.noIssues);
      expect(trailhead.verified, isTrue);
      final fieldNotes = await assessDemo(repo, (m) => m.sender?.email == 'hello@fieldnotes.example');
      expect(fieldNotes.verdict, Verdict.noIssues);
      expect(fieldNotes.privacy.trackers, 1);
    });

    test('the redirect-wrapped newsletter is privacy, not suspicion', () async {
      final r = await assessDemo(repo, (m) => m.subject.startsWith('Race recap'));
      expect(r.verdict, Verdict.noIssues);
      expect(r.verified, isTrue);
      expect(r.privacy.trackers, 1);
      expect(r.privacy.trackedLinks, 3);
      expect(r.privacy.trackingServices, containsAll(['Amazon SES', 'Google']));
    });

    test("an impostor using a VIP's name: be careful", () async {
      final r = await assessDemo(repo, (m) => m.subject == 'Quick favour');
      expect(r.verdict, Verdict.beCareful);
      final impersonation = r.findings.firstWhere((f) => f.kind == FindingKind.impersonation);
      expect(impersonation.explanation, contains('your VIP Dana Okafor'));
    });

    test('a look-alike of the work domain is likely phishing', () async {
      final r = await assessDemo(repo, (m) => m.sender?.email == 'it-help@northwlnd.example');
      expect(r.verdict, Verdict.likelyPhishing);
      expect(r.findings.first.kind, FindingKind.lookalikeSender);
      expect(r.findings.first.explanation, contains('your own domain, northwind.example'));
      expect(kinds(r), containsAll({FindingKind.replyToDiffers, FindingKind.impersonation}));
    });

    test('a message from a friend has no findings at all', () async {
      final r = await assessDemo(repo, (m) => m.sender?.email == 'jordan.lee@example.com');
      expect(r.findings, isEmpty);
      expect(r.verified, isTrue);
    });
  });

  group('gatherSenderFacts', () {
    test('finds known namesakes, the user\'s own name and the history', () async {
      final repo = FakeMailRepository()
        ..vips.add('alice@example.com')
        ..senderHistories['alice@example.com'] = const SenderHistory(received: 9);
      final facts = await gatherSenderFacts(
        repo,
        summary(from: const EmailAddress('a.example@evil.example', 'Alice Example')),
      );
      expect(facts.namesakes.single.address.email, 'alice@example.com');
      expect(facts.namesakes.single.vip, isTrue);
      expect(facts.history, SenderHistory.none);
      expect(facts.ownDomains, {'example.com'});

      final me = await gatherSenderFacts(repo, summary(from: const EmailAddress('me@elsewhere.example', 'Me Myself')));
      expect(me.namesakes.single.you, isTrue);
    });

    test('unknown namesakes and generic names are ignored', () async {
      final repo = FakeMailRepository();
      // Bob is in the address book but was never written to or heard from twice.
      final bob = await gatherSenderFacts(repo, summary(from: const EmailAddress('bob@else.example', 'Bob Builder')));
      expect(bob.namesakes, isEmpty);
      final support = await gatherSenderFacts(repo, summary(from: const EmailAddress('x@y.example', 'Support')));
      expect(support.namesakes, isEmpty);
    });
  });
}
