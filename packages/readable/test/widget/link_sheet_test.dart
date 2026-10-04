import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readable/readable.dart';
import 'package:readable/src/render/link_actions.dart';

import 'helpers.dart';

const _ses =
    'https://x1.r.us-east-1.awstrack.me/L0/https:%2F%2Fshop.example%2Fsale%3Futm_source=news%26id=12/1/0100-000000/Xy=1';
const _safeLinks = 'https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fshop.example%2Ffaq&reserved=0';
const _mailchimp = 'https://shop.us5.list-manage.com/track/click?u=1a2b&id=3c4d&e=5e6f';

Future<void> longPress(WidgetTester tester, String text) async {
  final gesture = await tester.startGesture(textCenter(text));
  await tester.pump(const Duration(milliseconds: 600));
  await gesture.up();
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the sheet shows where a tracked link really goes, with Open directly and Open original', (tester) async {
    final opened = <Uri>[];
    await pumpReader(tester, email(html: '<p><a href="$_ses">Shop the sale</a></p>'), onOpen: opened.add);
    await longPress(tester, 'Shop the sale');

    expect(find.text('shop.example'), findsOneWidget);
    expect(find.byKey(const ValueKey('link-opens')), findsOneWidget);
    expect(richText('Opens: https://shop.example/sale?id=12'), findsOneWidget);
    expect(find.text('Through Amazon SES'), findsOneWidget);
    expect(find.text('Open original'), findsOneWidget);

    await tester.tap(find.text('Open directly'));
    await tester.pumpAndSettle();
    expect(opened, [Uri.parse('https://shop.example/sale?id=12')]);

    await longPress(tester, 'Shop the sale');
    await tester.tap(find.text('Open original'));
    await tester.pumpAndSettle();
    expect(opened.last, Uri.parse(_ses));
  });

  testWidgets('an opaque tracker says the destination is hidden', (tester) async {
    await pumpReader(tester, email(html: '<p><a href="$_mailchimp">Read more</a></p>'), onOpen: (_) {});
    await longPress(tester, 'Read more');
    expect(find.byKey(const ValueKey('link-hidden')), findsOneWidget);
    expect(find.textContaining("Mailchimp's click tracker"), findsOneWidget);
    expect(find.text('Open directly'), findsNothing);
    expect(find.text('Open'), findsOneWidget);
  });

  group('tapping a link', () {
    testWidgets('openLinksDirectly skips a known click tracker', (tester) async {
      Uri? opened;
      await pumpReader(
        tester,
        email(html: '<p><a href="$_ses">Shop the sale</a></p>'),
        onOpen: (u) => opened = u,
        openLinksDirectly: true,
      );
      await tester.tapOnText(find.textRange.ofSubstring('Shop the sale'));
      await tester.pumpAndSettle();
      expect(opened, Uri.parse('https://shop.example/sale?id=12'));
    });

    testWidgets('without it the original link opens', (tester) async {
      Uri? opened;
      await pumpReader(tester, email(html: '<p><a href="$_ses">Shop the sale</a></p>'), onOpen: (u) => opened = u);
      await tester.tapOnText(find.textRange.ofSubstring('Shop the sale'));
      await tester.pumpAndSettle();
      expect(opened, Uri.parse(_ses));
    });

    testWidgets("the recipient's link protection is never skipped silently", (tester) async {
      Uri? opened;
      await pumpReader(
        tester,
        email(html: '<p>Read the <a href="$_safeLinks">FAQ</a></p>'),
        onOpen: (u) => opened = u,
        openLinksDirectly: true,
      );
      await tester.tapOnText(find.textRange.ofSubstring('FAQ'));
      await tester.pumpAndSettle();
      expect(opened, Uri.parse(_safeLinks));
    });

    testWidgets('a look-alike host warns first', (tester) async {
      Uri? opened;
      await pumpReader(
        tester,
        email(html: '<p><a href="https://xn--pple-43d.com/verify">Verify your account</a></p>'),
        onOpen: (u) => opened = u,
      );
      await tester.tapOnText(find.textRange.ofSubstring('Verify your account'));
      await tester.pumpAndSettle();
      expect(find.byType(LinkMismatchDialog), findsOneWidget);
      expect(find.textContaining('it is not apple.com'), findsOneWidget);
      expect(opened, isNull);
    });

    testWidgets('inert links show where they lead instead of opening', (tester) async {
      Uri? opened;
      await pumpReader(
        tester,
        email(html: '<p><a href="https://evil.example/login">Sign in</a></p>'),
        onOpen: (u) => opened = u,
        inert: true,
      );
      await tester.tapOnText(find.textRange.ofSubstring('Sign in'));
      await tester.pumpAndSettle();
      expect(opened, isNull);
      expect(find.byKey(const ValueKey('link-inert')), findsOneWidget);
      expect(find.text('Open'), findsNothing);
      expect(find.text('Copy'), findsOneWidget);
    });
  });

  testWidgets('inert keeps remote images blocked and hides the banner', (tester) async {
    const html = '<p>Hi</p><img src="https://cdn.example/photo.jpg" width="400" height="300">';
    await pumpReader(tester, email(html: html), remote: RemoteContentPolicy.allow, inert: true);
    expect(find.byType(Image), findsNothing);
    expect(find.text('Load images'), findsNothing);

    await pumpReader(tester, email(html: html), inert: true);
    expect(find.text('Load images'), findsNothing);
  });
}
