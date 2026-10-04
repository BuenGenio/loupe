import 'package:flutter_test/flutter_test.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:readable/src/pipeline/pipeline.dart';

import '../corpus_loader.dart';

ReadableAnalysis analyze({String? html, String? text}) =>
    runPipeline(PipelineInput(mode: PipelineMode.readable, html: html, text: text)).analysis!;

ReadableAnalysis corpus(String name) {
  final entry = loadCorpus().firstWhere((e) => e.name == name);
  return analyze(html: entry.html, text: entry.text);
}

Iterable<LinkIssue> issues(ReadableAnalysis a) => a.links.map((f) => f.issue);

void main() {
  group('a newsletter with click tracking', () {
    late ReadableAnalysis a;
    setUpAll(() => a = corpus('40_click_tracking'));

    test('privacy report: pixels with their hosts, remote images, tracked links', () {
      expect(a.privacy.trackers, 2);
      expect(a.privacy.trackerHosts, ['pixel.esp-mail.example', 'shop.us5.list-manage.com']);
      expect(a.privacy.remoteImages, 1);
      expect(a.privacy.remoteImageHosts, ['cdn.shop.example']);
      // Mailchimp ×2, Amazon SES, Google; Safe Links is the reader's own protection.
      expect(a.privacy.trackedLinks, 4);
      expect(a.privacy.trackingServices, unorderedEquals(['Mailchimp', 'Amazon SES', 'Google']));
      expect(a.privacy.total, 6);
    });

    test('a domain shown through an opaque tracker is flagged as uncheckable, nothing else', () {
      expect(issues(a), [LinkIssue.textMismatch]);
      final mismatch = a.links.single;
      expect(mismatch.detail, 'www.shop.example');
      expect(mismatch.viaTracker, isTrue);
    });

    test('destinations of known redirects are the link hosts', () {
      expect(a.linkCount, 6);
      expect(a.linkHosts, containsAll(['shop.example', 'docs.example.com', 'shop.us5.list-manage.com']));
      expect(a.linkHosts, isNot(contains('nam12.safelinks.protection.outlook.com')));
    });

    test('the preheader counts as hidden text', () {
      expect(a.hiddenElements, 1);
      expect(a.hiddenTextLength, greaterThan(20));
    });
  });

  group('a phishing message', () {
    late ReadableAnalysis a;
    setUpAll(() => a = corpus('41_phishing_tricks'));

    test('finds every trick', () {
      expect(
        issues(a).toSet(),
        containsAll({
          LinkIssue.textMismatch,
          LinkIssue.homograph,
          LinkIssue.ipAddress,
          LinkIssue.shortener,
          LinkIssue.userInfo,
          LinkIssue.script,
          LinkIssue.dataUrl,
        }),
      );
      expect(a.passwordFields, 1);
      expect(a.hiddenTextLength, greaterThan(700));
    });

    test('details', () {
      LinkFinding of(LinkIssue issue) => a.links.firstWhere((f) => f.issue == issue);
      expect(of(LinkIssue.homograph).host, 'аpple.com');
      expect(of(LinkIssue.homograph).detail, 'apple.com');
      expect(of(LinkIssue.ipAddress).host, '192.0.2.44');
      expect(of(LinkIssue.shortener).host, 'bit.ly');
      expect(of(LinkIssue.userInfo).detail, 'www.paypal.com');
      expect(of(LinkIssue.userInfo).host, 'account-review.example');
      expect(of(LinkIssue.script).url, 'javascript:');
      final mismatches = a.links.where((f) => f.issue == LinkIssue.textMismatch).map((f) => f.detail);
      expect(mismatches, containsAll(['www.apple.com', 'www.paypal.com']));
      // javascript:void(0) is template noise, not a finding.
      expect(a.links.where((f) => f.issue == LinkIssue.script), hasLength(1));
    });
  });

  test('a matching link through a known redirect is no mismatch', () {
    final a = analyze(
      html:
          '<p><a href="https://www.google.com/url?q=https://www.example.com/x&sa=D">www.example.com</a></p>'
          '<p><a href="https://evil.example/r?url=https://www.bank.example/">www.bank.example</a></p>',
    );
    // The generic ?url= could be a decoy: still checked against the real host.
    expect(a.links.map((f) => (f.issue, f.detail)), [(LinkIssue.textMismatch, 'www.bank.example')]);
  });

  test('plain text links are checked too', () {
    final a = analyze(text: 'Sign in at https://xn--80ak6aa92e.com/login today.\nOr https://example.org/.');
    expect(issues(a), [LinkIssue.homograph]);
    expect(a.links.single.detail, 'apple.com');
    expect(a.linkCount, 2);
  });

  test('an international name is noted, not alarmed', () {
    final a = analyze(html: '<p><a href="https://xn--mnchen-3ya.example/">Stadt</a></p>');
    expect(issues(a), [LinkIssue.international]);
    expect(a.links.single.host, 'münchen.example');
  });

  test('ordinary mail has no findings', () {
    final a = analyze(html: '<p>Hi! The <a href="https://example.com/agenda">agenda</a> is ready.</p>');
    expect(a.links, isEmpty);
    expect(a.privacy.isEmpty, isTrue);
  });

  test('analyzeContent shares the Readable run and its cache', () async {
    ReadableMessageView.debugSynchronous = true;
    addTearDown(() => ReadableMessageView.debugSynchronous = false);
    const content = EmailContent(
      emailId: 'analysis-1',
      html: '<p><a href="http://203.0.113.9/x">Log in</a></p><img src="https://t.example/o.gif" width="1" height="1">',
    );
    final a = await analyzeContent(content);
    expect(issues(a), [LinkIssue.ipAddress]);
    expect(a.privacy.trackers, 1);
    expect(identical(await analyzeContent(content), a), isTrue);
  });
}
