import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/brief/brief_calendar.dart';
import 'package:loupe/features/brief/brief_checklist.dart';
import 'package:loupe/features/brief/brief_input.dart';
import 'package:loupe/l10n/app_localizations_en.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

final _l10n = AppLocalizationsEn();
final _now = DateTime(2026, 10, 4, 12);

BriefItem _item({
  BriefItemKind kind = BriefItemKind.action,
  String text = 'Confirm the revised product',
  String quote = 'Please confirm by Saturday 10 October.',
  BriefOwner owner = BriefOwner.me,
  BriefDue due = BriefDue.none,
  String? channel,
}) => BriefItem(
  kind: kind,
  text: text,
  evidence: BriefEvidence(quote: quote, start: 0, end: quote.length),
  due: due,
  owner: owner,
  channel: channel,
);

final _message = EmailSummary(
  id: 'm1',
  accountId: 'acc',
  mailboxId: 'acc|INBOX',
  threadId: 't1',
  receivedAt: _now,
  from: const [EmailAddress('rhea@harbour.example', 'Rhea Patel')],
  to: const [],
  subject: 'Revised illustration',
  preview: '',
);

void main() {
  group('timing', () {
    test('is labelled for what it is, as written', () {
      expect(
        briefTiming(
          _l10n,
          _item(
            due: BriefDue(kind: DueKind.explicit, text: 'by Saturday 10 October', date: DateTime(2026, 10, 10)),
          ),
          now: _now,
        ),
        'Deadline: by Saturday 10 October',
      );
      expect(
        briefTiming(
          _l10n,
          _item(
            due: const BriefDue(kind: DueKind.suggested, text: 'ideally by Friday'),
          ),
          now: _now,
        ),
        'Target, not a deadline: ideally by Friday',
      );
      expect(
        briefTiming(
          _l10n,
          _item(
            due: const BriefDue(kind: DueKind.conditional, text: 'within 24 hours after submission to the lender'),
          ),
          now: _now,
        ),
        'Measured from an event: within 24 hours after submission to the lender',
      );
    });

    test('of a date is the stated date; with no wording, the date the message states', () {
      final valuation = _item(
        kind: BriefItemKind.date,
        owner: BriefOwner.them,
        due: BriefDue(kind: DueKind.explicit, text: 'for Thursday 15 October', date: DateTime(2026, 10, 15)),
      );
      expect(briefTiming(_l10n, valuation, now: _now), 'On Thursday, October 15');
      final noWords = _item(
        due: BriefDue(kind: DueKind.explicit, date: DateTime(2027, 1, 8)),
      );
      expect(briefTiming(_l10n, noWords, now: _now), 'Deadline: Friday, January 8, 2027');
    });

    test('says “no deadline stated” only for what the reader must do or send', () {
      expect(briefTiming(_l10n, _item(), now: _now), 'No deadline stated');
      expect(briefTiming(_l10n, _item(kind: BriefItemKind.document), now: _now), 'No deadline stated');
      expect(briefTiming(_l10n, _item(owner: BriefOwner.them), now: _now), isNull);
      expect(
        briefTiming(
          _l10n,
          _item(kind: BriefItemKind.next, owner: BriefOwner.them),
          now: _now,
        ),
        isNull,
      );
    });
  });

  test('Copy Checklist: groups, ticks, how and when; dismissed items left out', () {
    final id = _item(text: 'Complete the ID check', quote: 'ID check', channel: 'in the Harbour app');
    final statement = _item(kind: BriefItemKind.document, text: 'Bank statement', quote: 'statement');
    final next = _item(
      kind: BriefItemKind.next,
      owner: BriefOwner.them,
      text: 'A case manager is assigned',
      quote: 'a case manager',
      due: const BriefDue(kind: DueKind.conditional, text: 'within 24 hours after submission'),
    );
    final dismissed = _item(text: 'Fill in the form', quote: 'the form');
    final brief = Brief(
      summary: 'Rhea asks for three things.',
      items: [id, statement, next, dismissed],
      nothingToSummarise: false,
      partial: false,
    );
    final text = briefChecklistText(
      _l10n,
      message: _message,
      brief: brief,
      states: {briefItemKey(statement): BriefItemState.done, briefItemKey(dismissed): BriefItemState.dismissed},
      now: _now,
    );
    expect(
      text,
      'Revised illustration\n'
      'Rhea asks for three things.\n'
      '\n'
      'To Do\n'
      '☐ Complete the ID check\n'
      '   in the Harbour app · No deadline stated\n'
      '\n'
      'Documents to Send\n'
      '☑ Bank statement\n'
      '   No deadline stated\n'
      '\n'
      'What Happens Next\n'
      '☐ A case manager is assigned\n'
      '   Measured from an event: within 24 hours after submission',
    );
  });

  group('calendar', () {
    test('only an item with a stated date makes an event', () {
      expect(briefHasEvent(_item()), isFalse);
      expect(briefEventFor(_item(), message: _message, l10n: _l10n), isNull);
      expect(
        briefHasEvent(
          _item(
            due: const BriefDue(kind: DueKind.conditional, text: 'within 24 hours'),
          ),
        ),
        isFalse,
      );
    });

    test('is all day unless the passage states a time', () {
      final confirm = _item(
        due: BriefDue(kind: DueKind.explicit, text: 'by Saturday 10 October', date: DateTime(2026, 10, 10)),
      );
      final allDay = briefEventFor(confirm, message: _message, l10n: _l10n, timeZone: 'Europe/London')!;
      expect(allDay.allDay, isTrue);
      expect(allDay.start, DateTime(2026, 10, 10));
      expect(allDay.end, DateTime(2026, 10, 11));
      expect(allDay.timeZone, isNull);
      expect(allDay.title, 'Confirm the revised product');
      expect(allDay.description, 'Please confirm by Saturday 10 October.\n\nFrom “Revised illustration”, Rhea Patel');

      final valuation = _item(
        kind: BriefItemKind.date,
        quote: 'We have booked the valuation for Thursday 15 October at 10:00.',
        due: BriefDue(kind: DueKind.explicit, text: 'for Thursday 15 October', date: DateTime(2026, 10, 15)),
      );
      final timed = briefEventFor(valuation, message: _message, l10n: _l10n, timeZone: 'Europe/London')!;
      expect(timed.allDay, isFalse);
      expect(timed.start, DateTime(2026, 10, 15, 10));
      expect(timed.end, DateTime(2026, 10, 15, 11));
      expect(timed.timeZone, 'Europe/London');
    });

    test('takes a time only as the passage states it', () {
      expect(briefStatedTime('booked for Thursday at 10:00.'), (hour: 10, minute: 0));
      expect(briefStatedTime('The call is at 2.30pm'), (hour: 14, minute: 30));
      expect(briefStatedTime('Collection from 9 am'), (hour: 9, minute: 0));
      expect(briefStatedTime('Doors close at 12 a.m.'), (hour: 0, minute: 0));
      expect(briefStatedTime('Amount due: £450.00, by 25 October.'), isNull);
      expect(briefStatedTime('Monthly payment: £1,408.72'), isNull);
      expect(briefStatedTime('call 0300 555 0177 at least two working days before'), isNull);
      expect(briefStatedTime('within 24 hours'), isNull);
    });
  });

  group('source', () {
    test('plain text first, then HTML as text; the sender, the sent date and the attachment names', () {
      final sent = DateTime(2026, 10, 3, 9);
      final message = EmailSummary(
        id: 'm2',
        accountId: 'acc',
        mailboxId: 'acc|INBOX',
        threadId: 't1',
        receivedAt: _now,
        sentAt: sent,
        from: const [EmailAddress('rhea@harbour.example', 'Rhea Patel')],
        to: const [],
        subject: 'Forms',
        preview: '',
      );
      const html = EmailContent(
        emailId: 'm2',
        text: ' ',
        html: '<p>See <a href="https://forms.example/1">the form</a>.</p>',
        attachments: [
          Attachment(partId: '2', mimeType: 'application/pdf', filename: 'Form.pdf'),
          Attachment(partId: '3', mimeType: 'image/png', filename: 'logo.png', contentId: 'logo', isInline: true),
        ],
      );
      final source = briefSource(message, html) as BriefSource;
      expect(source.input.text, 'See the form <https://forms.example/1>.');
      expect(source.input.from, 'Rhea Patel <rhea@harbour.example>');
      expect(source.input.date, sent);
      expect(source.input.attachments, ['Form.pdf']);
      expect(source.cut, isFalse);

      const plain = EmailContent(emailId: 'm2', text: 'Please send it.', html: '<p>Something else</p>');
      expect((briefSource(message, plain) as BriefSource).input.text, 'Please send it.');
    });

    test('a message without text, or still encrypted, has no Brief', () {
      expect(briefReadable(_message, const EmailContent(emailId: 'm1', text: '  ')), isFalse);
      expect(briefReadable(_message, const EmailContent(emailId: 'm1', text: 'Hi')), isTrue);
      expect(
        briefReadable(
          _message,
          const EmailContent(emailId: 'm1', text: '-----BEGIN PGP MESSAGE-----\n\nhQEMA\n-----END PGP MESSAGE-----'),
        ),
        isFalse,
      );
    });
  });
}
