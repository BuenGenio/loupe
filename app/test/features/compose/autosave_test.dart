import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/compose/compose_recovery.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';
import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';

final _subject = find.byKey(const Key('compose-subject'));
final _body = find.byKey(const Key('compose-body'));

Future<void> _openCompose(
  WidgetTester tester,
  FakeMailRepository repo, [
  ComposeArgs args = const ComposeArgs(),
]) async {
  final router = await pumpTestApp(
    tester,
    repository: repo,
    composeBuilder: (args) => ComposeScreen(args: args),
  );
  unawaited(router.push('/compose', extra: args));
  await tester.pumpAndSettle();
}

Future<ComposeRecord?> _localCopy() async {
  final json = (await SharedPreferences.getInstance()).getString(ComposeRecoveryStore.key);
  return json == null ? null : ComposeRecord.decode(json);
}

const _jordan = EmailAddress('jordan.lee@example.com', 'Jordan Lee');

void main() {
  group('autosave', () {
    testWidgets('saves to Drafts 3 s after the last edit, replacing the previous save', (tester) async {
      final repo = FakeMailRepository();
      await _openCompose(tester, repo, const ComposeArgs(to: [bob]));
      await tester.enterText(_subject, 'Plan');
      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(_body, 'First');
      await tester.pump(const Duration(milliseconds: 2900));
      expect(repo.drafts, isEmpty, reason: 'debounced from the last edit');
      await tester.pump(const Duration(milliseconds: 200));
      expect(repo.drafts.single.subject, 'Plan');
      expect(repo.drafts.single.text, 'First');
      expect(repo.drafts.single.draftId, isNull);

      await tester.enterText(_body, 'Second');
      await tester.pump(ComposeScreen.autosaveDelay);
      expect(repo.drafts, hasLength(2));
      expect(repo.drafts.last.draftId, 'draft-1', reason: 'replaces the first save');

      // Moving the cursor isn't an edit.
      final field = tester.widget<TextField>(_body);
      field.controller!.selection = const TextSelection.collapsed(offset: 2);
      await tester.pump(const Duration(seconds: 5));
      expect(repo.drafts, hasLength(2));
    });

    testWidgets('keeps a local copy with the draft id; Delete Draft deletes both', (tester) async {
      final repo = FakeMailRepository();
      await _openCompose(tester, repo, const ComposeArgs(to: [bob]));
      await tester.enterText(_subject, 'Keep me');
      await tester.pump(ComposeScreen.localCopyDelay);
      var copy = (await _localCopy())!;
      expect(copy.message.subject, 'Keep me');
      expect(copy.message.to.single.email, bob.email);
      expect(copy.message.draftId, isNull);

      await tester.pump(ComposeScreen.autosaveDelay);
      copy = (await _localCopy())!;
      expect(copy.message.draftId, 'draft-1');

      await tester.tap(find.byKey(const Key('compose-cancel')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete Draft'));
      await tester.pumpAndSettle();
      expect(repo.log, contains('deleteDraft draft-1'));
      expect(await _localCopy(), isNull);
      expect(find.text('home'), findsOneWidget);
    });

    testWidgets('Send uses the autosaved draft and forgets the local copy', (tester) async {
      final repo = FakeMailRepository();
      await _openCompose(tester, repo, const ComposeArgs(to: [bob]));
      await tester.enterText(_subject, 'Final');
      await tester.pump(ComposeScreen.autosaveDelay);
      expect(await _localCopy(), isNotNull);
      await tester.tap(find.byKey(const Key('compose-send')));
      await tester.pumpAndSettle();
      expect(repo.sent.single.draftId, 'draft-1', reason: 'sending deletes the draft');
      expect(await _localCopy(), isNull);
      await drainTimers(tester);
    });

    testWidgets('Save Draft after an autosave saves nothing twice', (tester) async {
      final repo = FakeMailRepository();
      await _openCompose(tester, repo, const ComposeArgs(to: [bob]));
      await tester.enterText(_subject, 'Saved already');
      await tester.pump(ComposeScreen.autosaveDelay);
      await tester.tap(find.byKey(const Key('compose-cancel')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save Draft'));
      await tester.pumpAndSettle();
      expect(repo.drafts, hasLength(1));
      expect(await _localCopy(), isNull);
      expect(find.text('Draft saved'), findsOneWidget);
    });

    testWidgets('edits undone before closing delete the autosaved draft', (tester) async {
      final repo = FakeMailRepository();
      await _openCompose(tester, repo, const ComposeArgs(to: [bob], subject: 'Hi'));
      await tester.enterText(_subject, 'Hi there');
      await tester.pump(ComposeScreen.autosaveDelay);
      await tester.enterText(_subject, 'Hi');
      await tester.pump();
      await tester.tap(find.byKey(const Key('compose-cancel')));
      await tester.pumpAndSettle();
      expect(find.text('Delete Draft'), findsNothing, reason: 'unchanged: asks nothing');
      expect(repo.log, contains('deleteDraft draft-1'));
      expect(await _localCopy(), isNull);
    });

    testWidgets('editing an Outbox message autosaves nothing', (tester) async {
      final repo = FakeMailRepository();
      const message = OutgoingMessage(accountId: 'acc', identityId: 'acc/me', to: [bob], subject: 'Later');
      await _openCompose(tester, repo, ComposeArgs.restore(message, outboxId: 'outbox-3'));
      await tester.enterText(_subject, 'Later, edited');
      await tester.pump(const Duration(seconds: 10));
      expect(repo.drafts, isEmpty);
      expect(await _localCopy(), isNull);
    });
  });

  group('crash recovery', () {
    testWidgets('a message being written when the app died is offered on the next launch', (tester) async {
      await pumpLoupe(tester);
      await tester.tap(find.byTooltip('New Message'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('recipients-To:')), 'jordan.lee@example.com,');
      await tester.enterText(_subject, 'Half-written');
      await tester.enterText(_body, 'Dear Jordan,');
      await tester.pump(ComposeScreen.localCopyDelay);
      final left = (await SharedPreferences.getInstance()).getString(ComposeRecoveryStore.key);
      expect(left, isNotNull);

      // The process dies: nothing is closed properly. Next launch:
      await tester.pumpWidget(const SizedBox());
      await pumpLoupe(tester, prefs: {ComposeRecoveryStore.key: left!});
      expect(find.text('Continue editing your draft?'), findsOneWidget);
      expect(textContaining('“Half-written” to jordan.lee'), findsOneWidget);
      await tester.tap(find.text('Continue Editing'));
      await tester.pumpAndSettle();
      expect(find.byType(ComposeScreen), findsOneWidget);
      expect(tester.widget<TextField>(_subject).controller!.text, 'Half-written');
      expect(tester.widget<TextField>(_body).controller!.text, 'Dear Jordan,');
      expect(find.text('jordan.lee'), findsOneWidget);
      await drainTimers(tester);
    });

    testWidgets('Discard deletes the autosaved draft and the local copy; Save to Drafts keeps it', (tester) async {
      final repo = DemoMailRepository.instant(clock: () => testNow);
      const message = OutgoingMessage(
        accountId: DemoAccounts.personal,
        identityId: 'personal/default',
        to: [_jordan],
        subject: 'Unfinished',
        text: 'Hello',
      );
      final draft = await repo.saveDraft(message);
      final record = ComposeRecord(
        session: 'gone',
        message: message.copyWith(draftId: draft),
        savedAt: testNow,
      );
      await pumpLoupe(tester, repository: repo, prefs: {ComposeRecoveryStore.key: record.encode()});
      await tester.tap(find.text('Discard'));
      await tester.pumpAndSettle();
      expect(await repo.getEmail(draft), isNull);
      expect(await _localCopy(), isNull);

      // Save to Drafts, on another launch.
      final again = ComposeRecord(session: 'gone2', message: message, savedAt: testNow);
      await tester.pumpWidget(const SizedBox());
      await pumpLoupe(tester, repository: repo, prefs: {ComposeRecoveryStore.key: again.encode()});
      await tester.tap(find.text('Save to Drafts'));
      await tester.pumpAndSettle();
      expect(find.text('Saved to Drafts'), findsOneWidget);
      final drafts = await repo.watchList(const VirtualMailboxRef(VirtualMailbox.allDrafts), threaded: false).first;
      expect(drafts.where((t) => t.latest.subject == 'Unfinished'), hasLength(1));
      expect(await _localCopy(), isNull);
      await drainTimers(tester);
    });

    test('the local copy round-trips, without attachments over the limit', () {
      final small = OutgoingAttachment(filename: 'a.txt', mimeType: 'text/plain', data: Uint8List.fromList([1, 2, 3]));
      final big = OutgoingAttachment(
        filename: 'big.bin',
        mimeType: 'application/octet-stream',
        data: Uint8List(ComposeRecoveryStore.maxAttachmentBytes + 1),
      );
      final at = DateTime(2026, 10, 5, 8);
      final message = OutgoingMessage(
        accountId: 'acc',
        identityId: 'acc/me',
        to: const [bob],
        cc: const [EmailAddress('carol@example.org')],
        subject: 'Re: Plans',
        text: 'Body',
        attachments: [small],
        inReplyTo: 'x@y',
        references: const ['w@y', 'x@y'],
        mode: ComposeMode.reply,
        sourceEmailId: 'm1',
        draftId: 'd1',
      );
      final back = ComposeRecord.decode(
        ComposeRecord(session: 's', message: message, savedAt: at, sendAt: at).encode(),
      )!;
      expect(back.message.to.single, bob);
      expect(back.message.cc.single.email, 'carol@example.org');
      expect(back.message.attachments.single.data, [1, 2, 3]);
      expect(back.message.mode, ComposeMode.reply);
      expect(back.message.references, ['w@y', 'x@y']);
      expect(back.message.draftId, 'd1');
      expect(back.sendAt, at);
      expect(back.attachmentsOmitted, 0);

      final heavy = ComposeRecord.decode(
        ComposeRecord(
          session: 's',
          message: message.copyWith(attachments: [small, big]),
          savedAt: at,
        ).encode(),
      )!;
      expect(heavy.message.attachments, isEmpty);
      expect(heavy.attachmentsOmitted, 2);
      expect(ComposeRecord.decode('not json'), isNull);
    });
  });
}
