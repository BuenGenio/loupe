import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_imap/mbox.dart';
import 'package:test/test.dart';

final _date = DateTime.utc(2026, 10, 8, 14, 3, 5);

String _entry(String raw, {String? sender, DateTime? date}) =>
    utf8.decode(mboxrdEntry(utf8.encode(raw), date: date ?? _date, sender: sender));

/// An mboxrd reader as Thunderbird and Python's `mailbox` read it: split at
/// separator lines, drop the empty line ending each message, take one `>`
/// off quoted `From ` lines.
List<String> _read(String mbox) {
  if (mbox.isEmpty) return const [];
  final messages = <List<String>>[];
  // Every line ends in LF: without the last one, splitting gives the lines.
  for (final line in mbox.substring(0, mbox.length - 1).split('\n')) {
    if (line.startsWith('From ')) {
      messages.add([]);
    } else if (messages.isNotEmpty) {
      messages.last.add(RegExp(r'^>+From ').hasMatch(line) ? line.substring(1) : line);
    }
  }
  return [
    // Without the empty line that ends each message.
    for (final lines in messages) '${lines.sublist(0, lines.length - 1).join('\n')}\n',
  ];
}

void main() {
  group('separator lines', () {
    test('have the sender and the date in UTC, as asctime', () {
      expect(mboxFromLine('alice@example.org', _date), 'From alice@example.org Thu Oct  8 14:03:05 2026\n');
      expect(mboxDate(DateTime.utc(2026, 1, 31, 9, 5, 0)), 'Sat Jan 31 09:05:00 2026');
      // Two-digit days aren't padded; local times are converted.
      expect(mboxDate(DateTime.utc(2025, 12, 24, 23, 59, 59)), 'Wed Dec 24 23:59:59 2025');
      final local = DateTime.utc(2026, 3, 1, 12).toLocal();
      expect(mboxDate(local), 'Sun Mar  1 12:00:00 2026');
    });

    test('never have spaces in the sender, nor an empty one', () {
      expect(mboxFromLine('odd sender@example.org', _date), startsWith('From oddsender@example.org Thu'));
      expect(mboxFromLine('  ', _date), startsWith('From MAILER-DAEMON Thu'));
    });

    test('start every entry, with the given sender', () {
      final entry = _entry('Subject: Hi\r\n\r\nHello\r\n', sender: 'bob@example.org');
      expect(entry, startsWith('From bob@example.org Thu Oct  8 14:03:05 2026\nSubject: Hi\n'));
    });

    test('take the envelope sender from Return-Path, else From', () {
      List<int> raw(String headers) => utf8.encode('$headers\r\n\r\nBody\r\n');
      expect(
        envelopeSender(raw('Return-Path: <bounce+x@lists.example.org>\r\nFrom: Alice <alice@example.org>')),
        'bounce+x@lists.example.org',
      );
      expect(envelopeSender(raw('From: "Smith, Alice <boss>" <alice@example.org>')), 'alice@example.org');
      expect(envelopeSender(raw('From: alice@example.org (Alice)')), 'alice@example.org');
      expect(envelopeSender(raw('Sender: list@example.org\r\nSubject: No From')), 'list@example.org');
      // A bounce has an empty envelope sender.
      expect(envelopeSender(raw('Return-Path: <>\r\nFrom: Mail Delivery <postmaster@example.org>')), 'MAILER-DAEMON');
      expect(envelopeSender(raw('Subject: Nobody')), 'MAILER-DAEMON');
      // Only the header block counts.
      expect(envelopeSender(raw('Subject: Hi\r\n\r\nFrom: someone@example.org')), 'MAILER-DAEMON');
      expect(_entry('From: Alice <alice@example.org>\r\n\r\nHi\r\n'), startsWith('From alice@example.org Thu'));
    });
  });

  group('From quoting (mboxrd)', () {
    test('adds a > to lines matching ^>*From ', () {
      final entry = _entry(
        'Subject: Quotes\r\n'
        '\r\n'
        'From the start\r\n'
        '>From a quote\r\n'
        '>>From deeper\r\n'
        ' From indented\r\n'
        'From: a header-like line\r\n'
        'from lower case\r\n'
        'Fromage\r\n'
        'From\r\n'
        'From ',
      );
      expect(entry.split('\n').skip(3).toList(), [
        '>From the start',
        '>>From a quote',
        '>>>From deeper',
        ' From indented',
        'From: a header-like line',
        'from lower case',
        'Fromage',
        'From',
        '>From ',
        '',
        '',
      ]);
    });

    test('round-trips: a reader gets every message back as it was', () {
      const messages = [
        'Subject: One\n\nFrom here on\n>From there\n>>>From afar\n',
        'Subject: Two\n\nFrom\n\nFrom \n\n',
        'Subject: Three\n\n>From the start\n',
      ];
      final mbox = utf8.decode(
        mboxrdFile([
          for (final m in messages) (raw: utf8.encode(m.replaceAll('\n', '\r\n')), date: _date, sender: null),
        ]),
      );
      expect(_read(mbox), messages);
    });
  });

  group('line ends', () {
    test('CRLF becomes LF', () {
      final entry = _entry('Subject: Hi\r\nTo: bob@example.org\r\n\r\nLine one\r\nLine two\r\n');
      expect(entry, isNot(contains('\r')));
      expect(entry.split('\n').skip(1).toList(), [
        'Subject: Hi',
        'To: bob@example.org',
        '',
        'Line one',
        'Line two',
        '',
        '',
      ]);
    });

    test('LF and mixed line ends stay single LFs; a lone CR inside a line stays', () {
      final entry = _entry('Subject: Mixed\n\nunix\r\ndos\nkeep\rthis\r\n');
      expect(entry.split('\n').skip(1).toList(), ['Subject: Mixed', '', 'unix', 'dos', 'keep\rthis', '', '']);
    });

    test('8-bit bytes in other charsets pass through unchanged', () {
      final raw = Uint8List.fromList([
        ...latin1.encode('Subject: Caf'),
        0xe9,
        0x0d,
        0x0a,
        0x0d,
        0x0a,
        0xe9,
        0x0d,
        0x0a,
      ]);
      final entry = mboxrdEntry(raw, date: _date, sender: 'a@example.org');
      final body = entry.sublist(entry.indexOf(0x0a) + 1);
      expect(body, [...latin1.encode('Subject: Caf'), 0xe9, 0x0a, 0x0a, 0xe9, 0x0a, 0x0a]);
    });
  });

  group('trailing newline', () {
    test('a message ending in a line end gets just the empty line after it', () {
      expect(
        _entry('Subject: A\r\n\r\nBody\r\n', sender: 'a@example.org'),
        'From a@example.org Thu Oct  8 14:03:05 2026\nSubject: A\n\nBody\n\n',
      );
    });

    test('a message without a final line end gets one, then the empty line', () {
      expect(
        _entry('Subject: A\r\n\r\nBody', sender: 'a@example.org'),
        'From a@example.org Thu Oct  8 14:03:05 2026\nSubject: A\n\nBody\n\n',
      );
      expect(
        _entry('Subject: A\r\n\r\nBody\r', sender: 'a@example.org'),
        'From a@example.org Thu Oct  8 14:03:05 2026\nSubject: A\n\nBody\n\n',
      );
    });

    test('blank lines at the end of a message are kept', () {
      expect(
        _entry('Subject: A\r\n\r\nBody\r\n\r\n\r\n', sender: 'a@example.org'),
        'From a@example.org Thu Oct  8 14:03:05 2026\nSubject: A\n\nBody\n\n\n\n',
      );
    });

    test('an empty message is a separator line and the empty line', () {
      expect(_entry('', sender: 'a@example.org'), 'From a@example.org Thu Oct  8 14:03:05 2026\n\n');
    });
  });

  group('files', () {
    test('an empty folder is an empty file', () {
      expect(mboxrdFile(const []), isEmpty);
    });

    test('messages follow one another in order, each after its separator line', () {
      final mbox = utf8.decode(
        mboxrdFile([
          (
            raw: utf8.encode('Subject: First\r\n\r\nOne\r\n'),
            date: DateTime.utc(2020, 1, 2, 3, 4, 5),
            sender: 'a@x.org',
          ),
          (raw: utf8.encode('Subject: Second\r\n\r\nTwo'), date: DateTime.utc(2021, 6, 7, 8, 9, 10), sender: 'b@x.org'),
        ]),
      );
      expect(
        mbox,
        'From a@x.org Thu Jan  2 03:04:05 2020\nSubject: First\n\nOne\n\n'
        'From b@x.org Mon Jun  7 08:09:10 2021\nSubject: Second\n\nTwo\n\n',
      );
    });
  });
}
