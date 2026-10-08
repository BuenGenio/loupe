import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/security/assessment.dart';
import 'package:loupe/features/conversation/security/security_badge.dart';
import 'package:loupe/features/conversation/security/security_sheet.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:loupe/router.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:loupe/theme/theme.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers.dart';
import '../fake_mail_repository.dart';
import '../test_app.dart';

const _finding = LinksFinding(
  FindingKind.linkMismatch,
  Severity.warning,
  links: [
    LinkFinding(
      LinkIssue.textMismatch,
      url: 'https://evil.example/login',
      text: 'www.bank.example',
      host: 'evil.example',
      detail: 'www.bank.example',
    ),
  ],
);

SecurityReport report(Verdict verdict, {bool verified = false, int trackers = 0, List<Finding> findings = const []}) =>
    SecurityReport(
      verdict: verdict,
      findings: findings,
      senderVerified: verified,
      privacy: PrivacyReport(trackers: trackers, trackerHosts: const ['pixel.example']),
      technical: const [('Authentication-Results', 'mx; dmarc=fail')],
    );

Future<void> pumpBadge(WidgetTester tester, SecurityReport r, {VoidCallback? onTap}) => tester.pumpWidget(
  MaterialApp(
    localizationsDelegates: loupeLocalizationsDelegates,
    theme: LoupeTheme.light(),
    home: Scaffold(
      body: Center(
        child: SecurityBadgeView(report: r, onTap: onTap ?? () {}),
      ),
    ),
  ),
);

/// A conversation of one message from [from] with [html] and [headers].
FakeMailRepository repoWith({
  required EmailAddress from,
  required String html,
  List<(String, String)> headers = const [],
  List<EmailAddress> replyTo = const [],
}) => FakeMailRepository(
  emails: [
    EmailSummary(
      id: 'p1',
      accountId: 'acc',
      mailboxId: 'acc|INBOX',
      threadId: 't9',
      receivedAt: DateTime(2026, 10, 4, 9),
      from: [from],
      replyTo: replyTo,
      to: const [me],
      subject: 'Your account',
      preview: 'Your account',
    ),
  ],
  contents: {'p1': EmailContent(emailId: 'p1', html: html, headers: headers)},
);

Future<void> openMessage(WidgetTester tester, FakeMailRepository repo, {Map<String, Object> prefs = const {}}) async {
  final router = await pumpTestApp(tester, repository: repo, prefs: prefs);
  unawaited(router.push('/message/p1'));
  await tester.pumpAndSettle();
}

ReadableMessageView body(WidgetTester tester) => tester.widget<ReadableMessageView>(find.byType(ReadableMessageView));

const _phish = EmailAddress('service@parcel-notice.example', 'Parcel Post');
const _phishHtml =
    '<p>Pay the fee at <a href="https://redelivery.example/login">https://www.parcelpost.example/track</a></p>'
    '<p><img src="https://cdn.redelivery.example/logo.png" width="300" height="80"></p>';
const _failing = [('Authentication-Results', 'mx.example.com; dkim=none; spf=softfail; dmarc=fail')];

void main() {
  group('badge', () {
    testWidgets('verified: a green seal, nothing else', (tester) async {
      await pumpBadge(tester, report(Verdict.noIssues, verified: true));
      expect(find.byIcon(LoupeIcons.verified), findsOneWidget);
      expect(find.byKey(const ValueKey('security-pill')), findsNothing);
      expect(find.byIcon(LoupeIcons.trackers), findsNothing);
    });

    testWidgets('be careful and possible phishing are labelled pills', (tester) async {
      await pumpBadge(tester, report(Verdict.beCareful));
      expect(find.text('Be careful'), findsOneWidget);
      await pumpBadge(tester, report(Verdict.likelyPhishing));
      expect(find.text('Possible phishing'), findsOneWidget);
      expect(find.byIcon(LoupeIcons.phishing), findsOneWidget);
    });

    testWidgets('very large text keeps only the icon, and the label for screen readers', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: loupeLocalizationsDelegates,
          theme: LoupeTheme.light(),
          home: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: Scaffold(
              body: Center(
                child: SecurityBadgeView(report: report(Verdict.likelyPhishing), onTap: () {}),
              ),
            ),
          ),
        ),
      );
      expect(find.text('Possible phishing'), findsNothing);
      expect(find.byIcon(LoupeIcons.phishing), findsOneWidget);
      expect(find.bySemanticsLabel('Possible phishing'), findsOneWidget);
    });

    testWidgets('a privacy shield counts trackers; tapping explains', (tester) async {
      var taps = 0;
      await pumpBadge(tester, report(Verdict.noIssues, trackers: 3), onTap: () => taps++);
      expect(find.byIcon(LoupeIcons.trackers), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.bySemanticsLabel('3 trackers'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('security-badge')));
      expect(taps, 1);
    });

    testWidgets('no issues, unverified, no trackers: nothing at all', (tester) async {
      await pumpBadge(tester, report(Verdict.noIssues));
      expect(find.byKey(const ValueKey('security-badge')), findsNothing);
    });
  });

  testWidgets('the sheet explains, worst first, with privacy and collapsed details', (tester) async {
    tester.view
      ..physicalSize = const Size(400, 1600)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: loupeLocalizationsDelegates,
        theme: LoupeTheme.light(),
        home: Scaffold(
          body: SecuritySheet(
            report: report(
              Verdict.likelyPhishing,
              trackers: 1,
              findings: const [
                _finding,
                FirstTimeSenderFinding(email: 'x@y.example'),
              ],
            ),
          ),
        ),
      ),
    );
    expect(find.text('This looks like phishing'), findsOneWidget);
    expect(find.text('WHY'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('A link hides where it goes')).dy,
      lessThan(tester.getTopLeft(find.text('First message from this sender')).dy),
    );
    expect(find.text('A link shows www.bank.example, but it opens evil.example.'), findsOneWidget);
    expect(find.text("Don't sign in or pay through these links. Type the address yourself instead."), findsOneWidget);
    expect(find.text("You haven't had mail from x@y.example before."), findsOneWidget);
    expect(find.text('1 tracking pixel removed'), findsOneWidget);
    expect(find.text('Checked on this device. Nothing was sent anywhere.'), findsOneWidget);

    expect(find.text('mx; dmarc=fail'), findsNothing);
    await tester.tap(find.text('Technical Details'));
    await tester.pumpAndSettle();
    expect(find.text('mx; dmarc=fail'), findsOneWidget);
    expect(find.text('pixel.example'), findsOneWidget);
    expect(find.text('“www.bank.example” → https://evil.example/login'), findsOneWidget);
  });

  group('in a conversation', () {
    testWidgets('likely phishing: a calm banner, an inert body, then Show Anyway', (tester) async {
      await openMessage(tester, repoWith(from: _phish, html: _phishHtml, headers: _failing));

      expect(find.byKey(const ValueKey('phishing-banner')), findsOneWidget);
      expect(find.text('This message looks like phishing'), findsOneWidget);
      expect(find.text('Possible phishing'), findsOneWidget);
      expect(body(tester).inert, isTrue);

      await tester.tap(find.byKey(const ValueKey('show-anyway')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('phishing-banner')), findsNothing);
      expect(body(tester).inert, isFalse);
      // The verdict stays in the header.
      expect(find.text('Possible phishing'), findsOneWidget);
    });

    testWidgets('Why? and the badge open the explanation', (tester) async {
      await openMessage(tester, repoWith(from: _phish, html: _phishHtml, headers: _failing));
      await tester.tap(find.text('Why?'));
      await tester.pumpAndSettle();
      expect(find.text('This looks like phishing'), findsOneWidget);
      expect(find.text('Sender not verified'), findsOneWidget);
      expect(find.text('A link hides where it goes'), findsOneWidget);
      Navigator.of(tester.element(find.byKey(const ValueKey('security-sheet')))).pop();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('security-badge')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('security-sheet')), findsOneWidget);
    });

    testWidgets('a verified newsletter: no banner, a seal and the tracker count', (tester) async {
      await openMessage(
        tester,
        repoWith(
          from: const EmailAddress('news@shop.example', 'Shop'),
          html:
              '<p>Our <a href="https://shop.us5.list-manage.com/track/click?u=1&id=2&e=3">autumn picks</a>.</p>'
              '<img src="https://shop.example/open.gif" width="1" height="1">',
          headers: const [
            ('Authentication-Results', 'mx; dkim=pass header.d=shop.example; spf=pass; dmarc=pass'),
            ('List-Unsubscribe', '<https://shop.example/u>'),
          ],
        ),
      );
      expect(find.byKey(const ValueKey('phishing-banner')), findsNothing);
      expect(find.byIcon(LoupeIcons.verified), findsOneWidget);
      expect(find.byIcon(LoupeIcons.trackers), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(body(tester).inert, isFalse);
      expect(body(tester).openLinksDirectly, isTrue);
    });

    testWidgets('Open Links Directly off is passed to the reader', (tester) async {
      await openMessage(
        tester,
        repoWith(from: alice, html: '<p>Hi</p>'),
        prefs: const {'settings.openLinksDirectly': false},
      );
      expect(body(tester).openLinksDirectly, isFalse);
    });
  });

  testWidgets('Settings: Open Links Directly is on by default and persists', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.settings);
    final row = find.byKey(const Key('open-links-directly'));
    await tester.scrollUntilVisible(row, 200, scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    final toggle = find.descendant(of: row, matching: find.byType(CupertinoSwitch));
    expect(tester.widget<CupertinoSwitch>(toggle).value, isTrue);

    await tester.tap(toggle);
    await tester.pumpAndSettle();
    expect(tester.widget<CupertinoSwitch>(toggle).value, isFalse);
    expect((await SharedPreferences.getInstance()).getBool('settings.openLinksDirectly'), isFalse);
  });
}
