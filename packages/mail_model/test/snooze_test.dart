import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  group('snooze keyword', () {
    test('encodes the wake time as UTC epoch minutes', () {
      final at = DateTime.utc(2026, 10, 5, 8);
      expect(
        Snooze.keyword(at),
        r'$snoozed-'
        '${at.millisecondsSinceEpoch ~/ 60000}',
      );
      expect(Snooze.keyword(DateTime.utc(2025, 5, 23, 18)), r'$snoozed-29133720');
      expect(Snooze.keyword(DateTime.utc(1970)), r'$snoozed-0');
    });

    test('a local time encodes the same instant', () {
      final local = DateTime(2026, 10, 5, 8);
      expect(Snooze.keyword(local), Snooze.keyword(local.toUtc()));
      expect(Snooze.parseKeyword(Snooze.keyword(local)), local.toUtc());
    });

    test('seconds round up, so a message never wakes early', () {
      final at = DateTime.utc(2026, 10, 5, 8, 0, 1);
      expect(Snooze.parseKeyword(Snooze.keyword(at)), DateTime.utc(2026, 10, 5, 8, 1));
      expect(Snooze.parseKeyword(Snooze.keyword(DateTime.utc(2026, 10, 5, 8))), DateTime.utc(2026, 10, 5, 8));
    });

    test('round-trips', () {
      for (final at in [DateTime.utc(2026, 3, 29, 1, 30), DateTime.utc(2030, 12, 31, 23, 59), DateTime.utc(2100)]) {
        final k = Snooze.keyword(at);
        expect(Snooze.parseKeyword(k), at, reason: k);
        expect(Snooze.parseKeyword(k)!.isUtc, isTrue);
      }
    });

    test('is a valid IMAP flag-keyword (an atom) and a JMAP keyword', () {
      // RFC 9051 atom: no atom-specials (CTL, SP, ( ) { % * " \ ]), and JMAP
      // allows the same characters minus a few more ([ ] too).
      final atom = RegExp(r'^[^\x00-\x20\x7f(){%*"\\\[\]]+$');
      final k = Snooze.keyword(DateTime.utc(2026, 10, 5, 8));
      expect(atom.hasMatch(k), isTrue);
      expect(k, k.toLowerCase());
      expect(k.length, lessThan(50), reason: 'Dovecot limits keywords to 50 characters');
    });

    test('parses case-insensitively', () {
      expect(Snooze.parseKeyword(r'$Snoozed-29133720'), DateTime.utc(2025, 5, 23, 18));
      expect(Snooze.parseKeyword(r'$SNOOZED-29133720'), DateTime.utc(2025, 5, 23, 18));
    });

    test('ignores invalid and foreign keywords', () {
      for (final k in [
        r'$snoozed',
        r'$snoozed-',
        r'$snoozed-abc',
        r'$snoozed-+29133720',
        r'$snoozed--5',
        r'$snoozed-2913.5',
        r'$snoozed-29133720x',
        r'$snoozed-12345678901',
        r'$snoozed- 1',
        r'$snoozeduntil-29133720',
        r'snoozed-29133720',
        r'$label1',
        Keywords.seen,
        '',
      ]) {
        expect(Snooze.parseKeyword(k), isNull, reason: k);
      }
    });

    test('isSnoozeKeyword covers the whole namespace, valid or not', () {
      expect(Snooze.isSnoozeKeyword(r'$snoozed-29133720'), isTrue);
      expect(Snooze.isSnoozeKeyword(r'$Snoozed-garbage'), isTrue);
      expect(Snooze.isSnoozeKeyword(r'$snoozed'), isFalse);
      expect(Snooze.isSnoozeKeyword(Keywords.flagged), isFalse);
    });

    test('the earliest valid keyword wins', () {
      expect(Snooze.wakeAtOf({Keywords.seen, r'$label1'}), isNull);
      expect(
        Snooze.wakeAtOf({r'$snoozed-200', r'$snoozed-100', r'$snoozed-x', r'$snoozed-50x'}),
        DateTime.utc(1970).add(const Duration(minutes: 100)),
      );
      expect(Snooze.keywordsIn({r'$snoozed-200', r'$Snoozed-100', r'$snoozed-x', Keywords.seen}), {
        r'$snoozed-200',
        r'$snoozed-100',
      });
    });
  });

  group('snooze folder', () {
    test('Snoozed at the top level, or right under INBOX', () {
      for (final p in ['Snoozed', 'snoozed', 'SNOOZED', 'INBOX.Snoozed', 'INBOX/Snoozed', 'Inbox.snoozed']) {
        expect(Snooze.isFolderPath(p), isTrue, reason: p);
      }
      for (final p in ['Snoozed2', 'Archive/Snoozed', 'INBOX', 'INBOX-Snoozed', 'Lists.Snoozed', 'Snoozed/Old', '']) {
        expect(Snooze.isFolderPath(p), isFalse, reason: p);
      }
    });

    test('a container is not the folder', () {
      Mailbox box(String path, {bool selectable = true}) =>
          Mailbox(id: 'a|$path', accountId: 'a', name: path, path: path, isSelectable: selectable);
      expect(Snooze.isFolder(box('Snoozed')), isTrue);
      expect(Snooze.isFolder(box('Snoozed', selectable: false)), isFalse);
    });
  });

  group('EmailSummary', () {
    EmailSummary email(Set<String> keywords) =>
        EmailSummary(id: 'e', accountId: 'a', mailboxId: 'a|INBOX', receivedAt: DateTime.utc(2026), keywords: keywords);

    test('snooze keywords and \$new are state, not tags', () {
      final e = email({r'$snoozed-29133720', r'$snoozed-junk', Keywords.newAgain, r'$label2', Keywords.seen});
      expect(e.tags, [r'$label2']);
      expect(e.snoozedUntil, DateTime.utc(2025, 5, 23, 18));
    });

    test('isNewAgain: \$new on an unread message', () {
      expect(email({Keywords.newAgain}).isNewAgain, isTrue);
      expect(email({Keywords.newAgain, Keywords.seen}).isNewAgain, isFalse);
      expect(email({}).isNewAgain, isFalse);
    });
  });
}
