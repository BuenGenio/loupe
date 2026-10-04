import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_imap/src/imap/body_structure.dart';
import 'package:mail_imap/src/imap/mailbox_list.dart';
import 'package:mail_imap/src/imap/message_mapping.dart';
import 'package:mail_imap/src/imap/parsers.dart';
import 'package:mail_imap/src/imap/search_commands.dart';
import 'package:mail_imap/src/imap/sync_state.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/imap_fixtures.dart';

ListEntry entry(String name, {Set<String> flags = const {}, String? delimiter = '/'}) =>
    ListEntry(flags, delimiter, name);

void main() {
  group('mailbox list', () {
    test('special-use roles win; names fill the gaps', () {
      final boxes = buildRemoteMailboxes([
        entry('INBOX'),
        entry('[Gmail]', flags: {r'\noselect'}),
        entry('[Gmail]/Sent Mail', flags: {r'\sent'}),
        entry('[Gmail]/All Mail', flags: {r'\all'}),
        entry('[Gmail]/Starred', flags: {r'\flagged'}),
        entry('[Gmail]/Important', flags: {r'\important'}),
        entry('Sent'),
        entry('Deleted Items'),
        entry('Junk E-mail'),
        entry('Projects/Archive'),
        entry('Entw&APw-rfe'),
      ]);
      MailboxRole role(String path) => boxes.firstWhere((b) => b.path == path).role;
      expect(role('INBOX'), MailboxRole.inbox);
      expect(role('[Gmail]/Sent Mail'), MailboxRole.sent);
      expect(role('Sent'), MailboxRole.none);
      expect(role('[Gmail]/All Mail'), MailboxRole.all);
      expect(role('[Gmail]/Starred'), MailboxRole.flagged);
      expect(role('[Gmail]/Important'), MailboxRole.important);
      expect(role('Deleted Items'), MailboxRole.trash);
      expect(role('Junk E-mail'), MailboxRole.junk);
      expect(role('Projects/Archive'), MailboxRole.none);
      expect(role('Entwürfe'), MailboxRole.drafts);
      final gmail = boxes.firstWhere((b) => b.path == '[Gmail]');
      expect(gmail.isSelectable, isFalse);
      expect(boxes.firstWhere((b) => b.path == '[Gmail]/Sent Mail').parentPath, '[Gmail]');
      expect(boxes.firstWhere((b) => b.path == 'INBOX').name, 'Inbox');
    });

    test('one mailbox per role: "Archive" and "Archives" by name', () {
      final boxes = buildRemoteMailboxes([entry('INBOX'), entry('Archives'), entry('Archive'), entry('Sent')]);
      MailboxRole role(String path) => boxes.firstWhere((b) => b.path == path).role;
      expect(role('Archive'), MailboxRole.archive);
      expect(role('Archives'), MailboxRole.none);
      expect(role('Sent'), MailboxRole.sent);
    });

    test('one mailbox per role: several SPECIAL-USE flags (mailcow)', () {
      final boxes = buildRemoteMailboxes([
        entry('INBOX'),
        entry('Archives', flags: {r'\archive'}),
        entry('Archive', flags: {r'\archive'}),
        entry('Archiv', flags: {r'\archive'}),
        entry('Sent Messages', flags: {r'\sent'}),
        entry('Sent', flags: {r'\sent'}),
        entry('Other', flags: {r'\inbox'}),
      ]);
      final byRole = <MailboxRole, List<String>>{};
      for (final b in boxes) {
        byRole.putIfAbsent(b.role, () => []).add(b.path);
      }
      expect(byRole[MailboxRole.archive], ['Archive']);
      expect(byRole[MailboxRole.sent], ['Sent']);
      expect(byRole[MailboxRole.inbox], ['INBOX']);
      expect(byRole[MailboxRole.none], unorderedEquals(['Archives', 'Archiv', 'Sent Messages', 'Other']));
    });

    test('SPECIAL-USE beats a name match; the shortest path breaks ties', () {
      final boxes = buildRemoteMailboxes([
        entry('INBOX'),
        entry('Archive'),
        entry('Saved/Old', flags: {r'\archive'}),
        entry('Trash'),
        entry('INBOX/Trash'),
      ]);
      MailboxRole role(String path) => boxes.firstWhere((b) => b.path == path).role;
      expect(role('Saved/Old'), MailboxRole.archive);
      expect(role('Archive'), MailboxRole.none);
      expect(role('Trash'), MailboxRole.trash);
      expect(role('INBOX/Trash'), MailboxRole.none);
    });

    test('Gmail: each role once, labels named like roles stay folders', () {
      final boxes = buildRemoteMailboxes([
        entry('INBOX', flags: {r'\haschildren'}),
        entry('[Gmail]', flags: {r'\noselect', r'\haschildren'}),
        entry('[Gmail]/All Mail', flags: {r'\all', r'\hasnochildren'}),
        entry('[Gmail]/Drafts', flags: {r'\drafts', r'\hasnochildren'}),
        entry('[Gmail]/Important', flags: {r'\important', r'\hasnochildren'}),
        entry('[Gmail]/Sent Mail', flags: {r'\sent', r'\hasnochildren'}),
        entry('[Gmail]/Spam', flags: {r'\junk', r'\hasnochildren'}),
        entry('[Gmail]/Starred', flags: {r'\flagged', r'\hasnochildren'}),
        entry('[Gmail]/Trash', flags: {r'\trash', r'\hasnochildren'}),
        entry('Drafts'),
        entry('Sent'),
        entry('Trash'),
        entry('Receipts'),
      ]);
      final byRole = <MailboxRole, List<String>>{};
      for (final b in boxes) {
        byRole.putIfAbsent(b.role, () => []).add(b.path);
      }
      for (final MapEntry(key: role, value: paths) in byRole.entries) {
        if (role != MailboxRole.none) expect(paths, hasLength(1), reason: '$role');
      }
      expect(byRole[MailboxRole.all], ['[Gmail]/All Mail']);
      expect(byRole[MailboxRole.drafts], ['[Gmail]/Drafts']);
      expect(byRole[MailboxRole.sent], ['[Gmail]/Sent Mail']);
      expect(byRole[MailboxRole.junk], ['[Gmail]/Spam']);
      expect(byRole[MailboxRole.trash], ['[Gmail]/Trash']);
      expect(byRole[MailboxRole.flagged], ['[Gmail]/Starred']);
      expect(byRole[MailboxRole.important], ['[Gmail]/Important']);
      expect(byRole[MailboxRole.none], unorderedEquals(['[Gmail]', 'Drafts', 'Sent', 'Trash', 'Receipts']));
    });

    test('dot delimiter, INBOX children, missing parents', () {
      final boxes = buildRemoteMailboxes([
        entry('INBOX', delimiter: '.'),
        entry('INBOX.Sent', delimiter: '.'),
        entry('INBOX.Trash', delimiter: '.'),
        entry('Lists.Dart.Announce', delimiter: '.'),
      ]);
      final sent = boxes.firstWhere((b) => b.path == 'INBOX.Sent');
      expect(sent.role, MailboxRole.sent);
      expect(sent.parentPath, 'INBOX');
      expect(sent.name, 'Sent');
      expect(boxes.firstWhere((b) => b.path == 'INBOX.Trash').role, MailboxRole.trash);
      final lists = boxes.firstWhere((b) => b.path == 'Lists');
      expect(lists.isSelectable, isFalse);
      expect(boxes.firstWhere((b) => b.path == 'Lists.Dart').parentPath, 'Lists');
    });

    test('subscriptions from LIST-EXTENDED flags or LSUB', () {
      final extended = buildRemoteMailboxes([
        entry('INBOX'),
        entry('A', flags: {r'\subscribed'}),
        entry('B'),
      ]);
      expect({for (final b in extended) b.path: b.isSubscribed}, {'INBOX': true, 'A': true, 'B': false});
      final lsub = buildRemoteMailboxes([entry('INBOX'), entry('A'), entry('B')], subscribedRawNames: {'B'});
      expect({for (final b in lsub) b.path: b.isSubscribed}, {'INBOX': true, 'A': false, 'B': true});
      final unknown = buildRemoteMailboxes([entry('INBOX'), entry('A')]);
      expect(unknown.every((b) => b.isSubscribed), isTrue);
    });
  });

  group('sync state', () {
    test('round-trips through MailboxSyncState', () {
      final s = ImapSyncState(
        uidValidity: 3857529045,
        uidNext: 4392,
        highestModSeq: 715194045007,
        oldestUid: 4000,
        exists: 172,
        uids: [4005, 4001, 4002, 4003, 4390],
      );
      final back = ImapSyncState.fromState(s.toState())!;
      expect(back.uidValidity, 3857529045);
      expect(back.uidNext, 4392);
      expect(back.highestModSeq, 715194045007);
      expect(back.oldestUid, 4000);
      expect(back.exists, 172);
      expect(back.uids, [4001, 4002, 4003, 4005, 4390]);
      expect(s.toState().data['uids'], '4001:4003,4005,4390');
    });

    test('rejects missing or foreign state', () {
      expect(ImapSyncState.fromState(null), isNull);
      expect(ImapSyncState.fromState(const MailboxSyncState({'jmapState': 'x'})), isNull);
      expect(ImapSyncState.fromState(const MailboxSyncState({'v': 1, 'uidValidity': 'bad'})), isNull);
    });

    test('older messages and removals', () {
      final s = ImapSyncState(uidValidity: 1, uidNext: 11, oldestUid: 6, exists: 10, uids: [6, 7, 8, 9, 10]);
      expect(s.olderExist(10), isTrue);
      expect(s.olderExist(5), isFalse);
      expect(s.hasRemovals(serverExists: 12, newCount: 2), isFalse);
      expect(s.hasRemovals(serverExists: 11, newCount: 2), isTrue);
      expect(vanishedUids([6, 7, 8], [6, 8, 11]), [7]);
    });
  });

  group('summaries and content', () {
    test('summary from a fetched message', () {
      final header = crlf('References: <a@x> <b@x>\nIn-Reply-To: <b@x>\n\n');
      final m = runParser(
        FetchParser(),
        crlf(
          '* 3 FETCH (UID 42 FLAGS (\\Seen \\Flagged) INTERNALDATE "06-Oct-2025 10:00:00 +0000" RFC822.SIZE 900 '
          'X-GM-THRID 99 ENVELOPE ("Mon, 6 Oct 2025 09:59:00 +0000" "Hi" (("Ann" NIL "ann" "x.org")) NIL NIL '
          '((NIL NIL "me" "x.org")) NIL NIL "<b@x>" "<c@x>") '
          'BODYSTRUCTURE (("TEXT" "PLAIN" ("CHARSET" "utf-8") NIL NIL "7BIT" 10 1 NIL NIL NIL)'
          '("APPLICATION" "PDF" ("NAME" "a.pdf") NIL NIL "BASE64" 400 NIL ("ATTACHMENT" ("FILENAME" "a.pdf")) NIL) "MIXED") '
          'BODY[HEADER.FIELDS (REFERENCES IN-REPLY-TO LIST-ID)] ${literal(header)})\n',
        ),
      ).messages.single;
      final s = summaryFromFetch(m, accountId: 'acc', path: 'INBOX', uidValidity: 7, preview: 'Hello')!;
      expect(s.id, MailIds.imapEmail('acc', 'INBOX', 7, 42));
      expect(s.mailboxId, MailIds.mailbox('acc', 'INBOX'));
      expect(s.threadId, 'acc|gmthread|99');
      expect(s.subject, 'Hi');
      expect(s.from.single, const EmailAddress('ann@x.org', 'Ann'));
      expect(s.messageIdHeader, 'c@x');
      expect(s.inReplyTo, 'b@x');
      expect(s.references, ['a@x', 'b@x']);
      expect(s.keywords, {Keywords.seen, Keywords.flagged});
      expect(s.hasAttachment, isTrue);
      expect(s.size, 900);
      expect(s.receivedAt.toUtc(), DateTime.utc(2025, 10, 6, 10));
      expect(s.sentAt!.toUtc(), DateTime.utc(2025, 10, 6, 9, 59));
      expect(s.preview, 'Hello');
    });

    test('previews from truncated base64 and quoted-printable parts', () {
      final html = BodyNode(type: 'text', subtype: 'html', section: '1', encoding: 'base64');
      final encoded = base64.encode(utf8.encode('<p>Grüße <b>aus</b> Berlin</p>'));
      expect(previewFromPart(html, ascii.encode(encoded.substring(0, 40))), startsWith('Grüße aus Be'));
      final qp = BodyNode(
        type: 'text',
        subtype: 'plain',
        section: '1',
        encoding: 'quoted-printable',
        params: const {'charset': 'iso-8859-1'},
      );
      expect(previewFromPart(qp, ascii.encode('Gr=FC=DFe=\r\n Welt =E')), 'Grüße Welt');
    });

    test('content: html and text bodies, attachments, inline images, headers', () {
      final root = BodyNode(
        type: 'multipart',
        subtype: 'mixed',
        section: '',
        children: [
          BodyNode(
            type: 'multipart',
            subtype: 'alternative',
            section: '1',
            children: [
              BodyNode(
                type: 'text',
                subtype: 'plain',
                section: '1.1',
                encoding: 'quoted-printable',
                params: const {'charset': 'utf-8', 'format': 'flowed', 'delsp': 'yes'},
              ),
              BodyNode(
                type: 'multipart',
                subtype: 'related',
                section: '1.2',
                children: [
                  BodyNode(type: 'text', subtype: 'html', section: '1.2.1', params: const {'charset': 'utf-8'}),
                  BodyNode(type: 'image', subtype: 'png', section: '1.2.2', encoding: 'base64', id: '<img1>', size: 8),
                ],
              ),
            ],
          ),
          BodyNode(
            type: 'application',
            subtype: 'pdf',
            section: '2',
            encoding: 'base64',
            size: 40000,
            disposition: 'attachment',
            dispositionParams: const {'filename': 'a.pdf'},
          ),
        ],
      );
      final plan = planContentFetch(root);
      expect(plan.body.map((n) => n.section), unorderedEquals(['1.2.1', '1.1']));
      expect(plan.inline.map((a) => a.partId), ['1.2.2']);
      final content = buildContent(
        emailId: 'e1',
        root: root,
        header: utf8.encode('Subject: Hi\r\nX-Mailer: Test\r\n\r\n'),
        sections: {
          '1.1': Uint8List.fromList(ascii.encode('Hello wor \r\nld, how are =\r\nyou?\r\n> quo \r\n> ted\r\n')),
          '1.2.1': Uint8List.fromList(utf8.encode('<p>Hello <img src="cid:img1"></p>')),
          '1.2.2': Uint8List.fromList(ascii.encode(base64.encode([1, 2, 3]))),
        },
      );
      expect(content.html, '<p>Hello <img src="cid:img1"></p>');
      expect(content.text, 'Hello world, how are you?\n> quoted\n');
      expect(content.isFlowed, isFalse);
      expect(content.inlineData['img1'], [1, 2, 3]);
      expect(content.attachments.map((a) => a.partId), ['1.2.2', '2']);
      expect(content.visibleAttachments.map((a) => a.filename), ['a.pdf']);
      expect(content.headers, [('Subject', 'Hi'), ('X-Mailer', 'Test')]);
    });

    test('flowed text keeps DelSp=no form for the reader', () {
      expect(unflowText('one \r\ntwo\r\n>> a \r\n>> b', delSp: false), 'one two\n>> a b');
      expect(unflowText('-- \r\nsig', delSp: true), '-- \nsig');
    });
  });

  group('search commands', () {
    test('UTF-8 strings become literals', () {
      expect(literalize('UID SEARCH SUBJECT "plain"'), ['UID SEARCH SUBJECT "plain"']);
      expect(literalize('UID SEARCH CHARSET UTF-8 SUBJECT "Grüße" FROM "a\\"b"'), [
        'UID SEARCH CHARSET UTF-8 SUBJECT {7}',
        'Grüße FROM "a\\"b"',
      ]);
      expect(gmailRawSearchCommand('from:ann "big deal"'), r'UID SEARCH X-GM-RAW "from:ann \"big deal\""');
      expect(gmailRawSearchCommand('ü'), 'UID SEARCH CHARSET UTF-8 X-GM-RAW "ü"');
    });
  });
}
