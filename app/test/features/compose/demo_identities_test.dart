import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

Future<String> _idOf(DemoMailRepository repo, String subject) async {
  final list = await repo
      .watchList(RealMailboxRef(MailIds.mailbox('fastmail', 'INBOX')), threaded: false, limit: 1000)
      .first;
  return list.firstWhere((t) => t.latest.subject == subject).latest.id;
}

Future<void> _reply(WidgetTester tester, String emailId) async {
  final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
  unawaited(
    container
        .read(routerProvider)
        .push<void>(
          Routes.compose,
          extra: ComposeArgs(mode: ComposeMode.reply, sourceEmailId: emailId),
        ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('demo: a catch-all message offers to reply from its alias', (tester) async {
    final repo = await pumpLoupe(tester);
    await _reply(tester, await _idOf(repo, 'November pick: The Lantern Keepers'));
    expect(find.text('Cc/Bcc, From: sam@rivera.example'), findsOneWidget);
    await tester.tap(find.text('Reply from bookclub@rivera.example?'));
    await tester.pumpAndSettle();
    expect(find.text('Cc/Bcc, From: bookclub@rivera.example'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byKey(const Key('compose-body'))).controller!.text,
      startsWith('\n\n-- \n— Sam\n\nOn '),
    );
  });

  testWidgets('demo: mail to the plus-address identity replies from it, with its Reply-To', (tester) async {
    final repo = await pumpLoupe(tester);
    await _reply(tester, await _idOf(repo, 'Order #10482 confirmed — ready for pickup Thursday'));
    expect(find.text('Cc/Bcc, From: sam+shop@rivera.example'), findsOneWidget);
    expect(find.textContaining('Reply from'), findsNothing);
    await tester.tap(find.byKey(const Key('compose-ccbcc-from')));
    await tester.pumpAndSettle();
    expect(find.text('Reply-To: sam@rivera.example'), findsOneWidget);
  });
}
