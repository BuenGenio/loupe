import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/features/ai/demo_ai_provider.dart';
import 'package:loupe/features/compose/reply_check.dart';
import 'package:mail_ai/mail_ai.dart';

/// A request as a Brief would have it, its quote the same as its text.
BriefItem request(
  String text, {
  BriefItemKind kind = BriefItemKind.document,
  String? channel,
  String? quote,
  BriefDue due = BriefDue.none,
  BriefOwner owner = BriefOwner.me,
}) => BriefItem(
  kind: kind,
  text: text,
  evidence: BriefEvidence(quote: quote ?? text, start: 0, end: (quote ?? text).length),
  due: due,
  owner: owner,
  channel: channel,
);

ReplyAttachment file(String name, [AttachmentText text = const AttachmentText.notRead()]) =>
    ReplyAttachment(filename: name, mimeType: 'application/pdf', size: 1000, text: text);

ReplyCheckItem one(BriefItem r, {String draft = '', List<ReplyAttachment> files = const []}) =>
    ReplyCheck.check([r], draft: draft, attachments: files).single;

void main() {
  final sa302 = request('Your SA302 tax calculation for 2024/25', channel: 'by email');
  final overview = request('Your tax year overview for 2025', channel: 'by email');
  final statement = request(
    "A full month's bank statement showing your day-to-day spending and your salary coming in",
    channel: 'by email',
  );
  final idCheck = request(
    'The ID check, completed in the Harbour app (passport or driving licence)',
    kind: BriefItemKind.action,
    channel: 'in the Harbour app',
  );

  group('the adviser’s requests, from the demo’s Brief', () {
    final now = DateTime(2026, 10, 30, 16);
    late List<BriefItem> requests;

    setUpAll(() async {
      final seed = DemoSeed.build(now);
      final m = seed.messages.firstWhere((m) => m.summary.subject == 'Your mortgage application: what we need next');
      final input = BriefInput(
        subject: m.summary.subject,
        from: '${m.summary.from.first}',
        date: m.summary.receivedAt,
        text: m.text!,
        attachments: [for (final a in m.attachments) a.attachment.filename!],
      );
      final run = await AiRunner(DemoAiProvider(now: () => now)).run(BriefTask(input, now: now));
      requests = ReplyCheck.requestsIn((run as AiSuccess<Brief>).value);
    });

    ReplyCheckItem about(List<ReplyCheckItem> items, String words) =>
        items.singleWhere((i) => i.request.text.contains(words));

    test('nothing attached: three documents missing, two steps outside email', () {
      expect(requests, hasLength(5));
      final items = ReplyCheck.check(requests, draft: '', attachments: const []);
      expect(about(items, 'bank statement').status, ReplyCheckStatus.missing);
      expect(about(items, 'SA302').status, ReplyCheckStatus.missing);
      expect(about(items, 'SA302').asked, '2024/25');
      expect(about(items, 'overview').status, ReplyCheckStatus.missing);
      final id = about(items, 'ID check');
      expect(id.status, ReplyCheckStatus.external);
      expect(id.channel, 'in the Harbour app');
      final form = about(items, 'affordability form');
      expect(form.status, ReplyCheckStatus.external);
      expect(form.channel, 'https://forms.harbourhomeloans.example/a/7k2q');

      final summary = ReplyCheckSummary(items);
      expect((summary.attachable, summary.included, summary.outside), (3, 0, 2));
    });

    test('Sam’s reply: two files matched by name, the app check and the form promised, the overview missing', () {
      const draft =
          "Hi Rhea,\n\nAttached are my September bank statement and the SA302 for 2024/25. I'll do the ID check in "
          'the app tonight and fill in the affordability form at the weekend.\n\nOne question: should the tax year '
          'overview be for 2024/25 or for 2025? I want to send the right one.\n\nThanks,\nSam';
      final items = ReplyCheck.check(
        requests,
        draft: draft,
        attachments: [file('Bank statement - September.pdf'), file('SA302 2024-25.pdf')],
      );
      final bank = about(items, 'bank statement');
      expect(bank.status, ReplyCheckStatus.included);
      expect(bank.basis, ReplyCheckBasis.fileName);
      expect(bank.file, 'Bank statement - September.pdf');
      // "September" doesn't say it is the whole month.
      expect(bank.asked, 'a full month');
      expect(bank.periodConfirmed, isFalse);
      final tax = about(items, 'SA302');
      expect(tax.status, ReplyCheckStatus.included);
      expect(tax.basis, ReplyCheckBasis.fileName);
      expect(tax.periodConfirmed, isTrue);
      // A question about it is not a promise.
      expect(about(items, 'overview').status, ReplyCheckStatus.missing);
      final id = about(items, 'ID check');
      expect(id.status, ReplyCheckStatus.mentioned);
      expect(id.wrote, contains("I'll do the ID check"));
      expect(id.channel, 'in the Harbour app');
      expect(about(items, 'affordability form').status, ReplyCheckStatus.mentioned);

      final summary = ReplyCheckSummary(items);
      expect((summary.attachable, summary.included, summary.mentioned, summary.outside), (3, 2, 2, 0));
      expect(summary.byFileName, isTrue);
    });
  });

  group('periods', () {
    test('a tax calculation for another year doesn’t pass on its name’s keyword', () {
      final item = one(sa302, files: [file('SA302 2023-24.pdf')]);
      expect(item.status, ReplyCheckStatus.wrongPeriod);
      expect(item.basis, ReplyCheckBasis.fileName);
      expect(item.asked, '2024/25');
      expect(item.found, '2023-24');
    });

    test('the contents win over the name: the right name with another year inside is the wrong period', () {
      final item = one(
        sa302,
        files: [
          file(
            'SA302 2024-25.pdf',
            const AttachmentText.read(
              'SA302 tax calculation\nTax calculation for the year 6 April 2023 to 5 April 2024',
            ),
          ),
        ],
      );
      expect(item.status, ReplyCheckStatus.wrongPeriod);
      expect(item.basis, ReplyCheckBasis.contents);
      expect(item.found, '6 April 2023 to 5 April 2024');
    });

    test('contents that state the year confirm it; contents alone can match a file with any name', () {
      const text = 'SA302 tax calculation\nTax calculation for the year 6 April 2024 to 5 April 2025';
      final named = one(sa302, files: [file('SA302 2024-25.pdf', const AttachmentText.read(text))]);
      expect(
        (named.status, named.basis, named.periodConfirmed),
        (ReplyCheckStatus.included, ReplyCheckBasis.contents, true),
      );
      final scan = one(sa302, files: [file('scan_0042.pdf', const AttachmentText.read(text))]);
      expect(
        (scan.status, scan.basis, scan.file),
        (ReplyCheckStatus.included, ReplyCheckBasis.contents, 'scan_0042.pdf'),
      );
    });

    test('a name without a year is a tentative match that doesn’t confirm the year', () {
      final item = one(sa302, files: [file('Tax calculation.pdf')]);
      expect(
        (item.status, item.basis, item.periodConfirmed),
        (ReplyCheckStatus.included, ReplyCheckBasis.fileName, false),
      );
    });

    test('a file that was read but shows nothing (a scan) falls back to its name', () {
      final item = one(sa302, files: [file('SA302 2024-25.pdf', const AttachmentText.read('   '))]);
      expect((item.status, item.basis), (ReplyCheckStatus.included, ReplyCheckBasis.fileName));
    });

    test('tax years are the same however they are written', () {
      for (final name in [
        'SA302 2024-25.pdf',
        'SA302 2024_25.pdf',
        'SA302 24-25.pdf',
        'SA302 2024 to 2025.pdf',
        'SA302 2024-2025.pdf',
        'SA302 2024–25.pdf',
      ]) {
        expect(one(sa302, files: [file(name)]).status, ReplyCheckStatus.included, reason: name);
      }
      for (final r in ['SA302 for 24/25', 'SA302 for the 2024 to 2025 tax year', 'SA302 (2024-25)']) {
        expect(one(request(r), files: [file('SA302 2024-25.pdf')]).status, ReplyCheckStatus.included, reason: r);
      }
      for (final name in ['SA302 2025-26.pdf', 'SA302 2023-2024.pdf', 'SA302 2025.pdf']) {
        expect(one(sa302, files: [file(name)]).status, ReplyCheckStatus.wrongPeriod, reason: name);
      }
    });

    test('an overview “for 2025” and one named 2024-25 may not be the same', () {
      final wrong = one(overview, files: [file('Tax year overview 2024-25.pdf')]);
      expect((wrong.status, wrong.asked, wrong.found), (ReplyCheckStatus.wrongPeriod, '2025', '2024-25'));
      expect(one(overview, files: [file('Tax year overview 2025.pdf')]).status, ReplyCheckStatus.included);
    });

    test('months: another month is the wrong period; a numeric month counts', () {
      final september = request('Your September bank statement');
      expect(one(september, files: [file('Statement October.pdf')]).status, ReplyCheckStatus.wrongPeriod);
      expect(one(september, files: [file('Statement Sept.pdf')]).status, ReplyCheckStatus.included);
      final numeric = one(september, files: [file('statement 2026-09.pdf')]);
      expect((numeric.status, numeric.periodConfirmed), (ReplyCheckStatus.included, true));
    });

    test('a full month: half a month is the wrong period, the contents can show a whole one', () {
      final half = one(statement, files: [file('Bank statement - 1 to 14 October.pdf')]);
      expect((half.status, half.found), (ReplyCheckStatus.wrongPeriod, '1 to 14 October'));
      final whole = one(
        statement,
        files: [file('Statement.pdf', const AttachmentText.read('Lumen Bank statement\nPeriod: 1 to 30 September'))],
      );
      expect(
        (whole.status, whole.basis, whole.periodConfirmed),
        (ReplyCheckStatus.included, ReplyCheckBasis.contents, true),
      );
    });

    test('a deadline in a request is not the period of the document', () {
      final r = request(
        'Send your payslip by 30 November',
        kind: BriefItemKind.action,
        due: const BriefDue(kind: DueKind.explicit, text: 'by 30 November'),
      );
      final item = one(r, files: [file('Payslip October.pdf')]);
      expect((item.status, item.asked), (ReplyCheckStatus.included, null));
    });
  });

  group('unreadable files', () {
    test('stay unknown when a content claim would be needed', () {
      final item = one(sa302, files: [file('SA302 2024-25.pdf', const AttachmentText.unreadable())]);
      expect((item.status, item.file), (ReplyCheckStatus.unknown, 'SA302 2024-25.pdf'));
      expect(ReplyCheckSummary([item]).unknown, 1);
    });

    test('still show a name that states another year', () {
      final item = one(sa302, files: [file('SA302 2023-24.pdf', const AttachmentText.unreadable())]);
      expect((item.status, item.basis), (ReplyCheckStatus.wrongPeriod, ReplyCheckBasis.fileName));
    });

    test('the right file among several wins over an unreadable or wrong one', () {
      final item = one(
        sa302,
        files: [
          file('SA302 2023-24.pdf'),
          file('SA302 copy.pdf', const AttachmentText.unreadable()),
          file('SA302 2024-25.pdf'),
        ],
      );
      expect((item.status, item.file), (ReplyCheckStatus.included, 'SA302 2024-25.pdf'));
    });
  });

  group('steps outside email', () {
    test('an ID check done in an app is never something to attach', () {
      final item = one(idCheck, files: [file('Passport scan.pdf'), file('Driving licence.jpg')]);
      expect(item.way, ReplyCheckWay.outside);
      expect(item.status, ReplyCheckStatus.external);
      expect(item.file, isNull);
      expect(item.attachedAnyway, ['Passport scan.pdf', 'Driving licence.jpg']);
    });

    test('a form at a link, a bank transfer and an appointment in person are outside email', () {
      for (final (text, channel) in [
        ('The affordability form at https://forms.example/a/1', null),
        ('Pay £300 on account by bank transfer, using the reference QS-4471', 'by bank transfer'),
        ('Bring your passport to the branch', 'in person'),
        ('Upload your payslips to the portal', 'online'),
      ]) {
        final item = one(request(text, kind: BriefItemKind.action, channel: channel));
        expect(item.status, ReplyCheckStatus.external, reason: text);
        expect(item.channel, isNotNull, reason: text);
      }
    });

    test('a document that may be emailed is not outside email', () {
      final passport = request('A copy of your passport', channel: 'by email');
      final item = one(passport, files: [file('Passport scan.pdf')]);
      expect((item.way, item.status), (ReplyCheckWay.attach, ReplyCheckStatus.included));
    });
  });

  group('the draft’s own words', () {
    test('a promise or a done step is mentioned; “attached” and a question are not', () {
      expect(one(overview, draft: "I'll send the tax year overview tomorrow.").status, ReplyCheckStatus.mentioned);
      expect(one(overview, draft: 'The overview is on its way.').status, ReplyCheckStatus.mentioned);
      expect(one(overview, draft: 'I don’t have the overview yet.').status, ReplyCheckStatus.mentioned);
      expect(one(overview, draft: 'Should the overview be for 2025?').status, ReplyCheckStatus.missing);
      expect(one(overview, draft: 'Attached is the overview.').status, ReplyCheckStatus.missing);
      expect(one(idCheck, draft: 'Done the ID check this morning.').status, ReplyCheckStatus.mentioned);
      expect(one(idCheck, draft: 'Thanks for the update.').status, ReplyCheckStatus.external);
    });

    test('quoted lines are not the draft', () {
      expect(one(overview, draft: "> I'll send the overview tomorrow.").status, ReplyCheckStatus.missing);
    });

    test('a confirmation is answered in the text', () {
      final confirm = request(
        'Confirm by Thursday 5 November whether you want to go ahead with the revised product',
        kind: BriefItemKind.action,
        due: const BriefDue(kind: DueKind.explicit, text: 'by Thursday 5 November'),
      );
      final unanswered = one(confirm);
      expect(
        (unanswered.way, unanswered.status, unanswered.asked),
        (ReplyCheckWay.answer, ReplyCheckStatus.missing, null),
      );
      expect(ReplyCheckSummary([unanswered]).toAnswer, 1);
      final answered = one(confirm, draft: 'Yes, I’d like to go ahead with the revised product.');
      expect(answered.status, ReplyCheckStatus.mentioned);
    });

    test('a question asking for a document is answered by attaching it', () {
      final p60 = request('Could you send your P60?', kind: BriefItemKind.action);
      expect(one(p60).way, ReplyCheckWay.attach);
      expect(one(p60, files: [file('P60 2025.pdf')]).status, ReplyCheckStatus.included);
    });
  });

  test('requestsIn keeps what the reader must do or provide', () {
    final brief = Brief(
      summary: '',
      nothingToSummarise: false,
      partial: false,
      items: [
        sa302,
        idCheck,
        request('A case manager will be assigned', kind: BriefItemKind.next, owner: BriefOwner.them),
        request('Once we have all of the above', kind: BriefItemKind.condition, owner: BriefOwner.them),
        request('The lender reviews the case', kind: BriefItemKind.action, owner: BriefOwner.them),
      ],
    );
    expect(ReplyCheck.requestsIn(brief), [sa302, idCheck]);
  });

  test('the ordinary attachment reminder', () {
    for (final yes in [
      'Please find attached my statement.',
      'I’ve attached the form.',
      'Two attachments follow.',
      'Enclosed is the letter.',
      'Anbei die Unterlagen.',
      'Vous trouverez ci-joint le document.',
      'Te adjunto el contrato.',
    ]) {
      expect(ReplyCheck.mentionsAttachment(yes), isTrue, reason: yes);
    }
    for (final no in ['Thanks, see you Thursday.', '> Attached are your documents.', 'An unattached garage.', '']) {
      expect(ReplyCheck.mentionsAttachment(no), isFalse, reason: no);
    }
  });
}
