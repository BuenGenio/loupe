import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/shared/mail_actions.dart';
import 'package:mail_model/mail_model.dart';

import '../features/conversation/fake_mail_repository.dart';

void main() {
  testWidgets('actions finish after their screen is gone', (tester) async {
    final repo = FakeMailRepository();
    late MailActions actions;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [repositoryProvider.overrideWithValue(repo)],
        child: MaterialApp(
          home: Consumer(
            builder: (context, ref, _) {
              actions = MailActions(context, ref, scope: null, threaded: false);
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    // Back while a multi-select action is still running.
    await tester.pumpWidget(const SizedBox());
    final email = EmailSummary(id: 'e1', accountId: 'a', mailboxId: 'a|INBOX', receivedAt: DateTime(2026));
    await actions.setRead([ThreadSummary(threadId: 't', latest: email, messageCount: 1, unreadCount: 1)], read: true);
    expect(repo.keywordCalls.single.add, {Keywords.seen});
  });
}
