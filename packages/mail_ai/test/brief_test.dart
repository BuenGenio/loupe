import 'dart:convert';

import 'package:mail_ai/mail_ai.dart';
import 'package:test/test.dart';

import 'fixtures/brief_fixtures.dart';

void main() {
  final now = DateTime.utc(2026, 10, 29, 16);
  BriefTask task([BriefInput? message]) => BriefTask(message ?? mortgageMessage(), now: now, timeZone: 'Europe/London');
  Future<AiRun<Brief>> run(BriefTask t, List<Object> answers) =>
      AiRunner(FakeProvider(answers: [for (final a in answers) a is String ? a : jsonEncode(a)])).run(t);
  String reasonOf(AiRun<Brief> r) => (r as AiFailure<Brief>).message;

  group('instructions and input', () {
    test('state the rules the parser enforces', () {
      final i = task().instructions;
      expect(i, contains('exact passage copied from the email'));
      expect(i, contains('Lines starting with ">" are quoted earlier mail'));
      expect(i, contains('Never repeat passwords'));
      expect(i, contains('"within 24 hours after submission" is conditional'));
      expect(i, contains('never their contents'));
      expect(i, contains('Today is 2026-10-29 in the Europe/London time zone'));
    });

    test('send the text, the headers that matter and attachment names only', () {
      final input = jsonDecode(task().input) as Map<String, Object?>;
      expect(input.keys, containsAll(['subject', 'from', 'date', 'attachments', 'text', 'text_cut_short']));
      expect(input['attachments'], ['Mortgage illustration.pdf', 'SA302 example.pdf']);
      expect(input['text_cut_short'], isFalse);
      expect(input['text'], contains('8841209')); // the model sees the mail; the output may not repeat it
    });

    test('cut a long message short and say so', () {
      final long = BriefInput(subject: 's', from: 'f', date: now, text: 'word ' * 5000);
      final t = BriefTask(long, now: now, maxCharacters: 1000);
      expect(t.inputTruncated, isTrue);
      final input = jsonDecode(t.input) as Map<String, Object?>;
      expect((input['text'] as String).length, 1000);
      expect(input['text_cut_short'], isTrue);
    });

    test('are a long task, versioned, with a schema', () {
      final t = task();
      expect(t.type, 'brief.message');
      expect(t.size, TaskSize.long);
      expect((t.schema['required'] as List<Object?>), containsAll(['summary', 'nothing_to_summarise', 'items']));
    });
  });

  group('a good answer', () {
    test('is accepted with every item located in the message', () async {
      final result = await run(task(), [goodMortgageAnswer]);
      expect(result, isA<AiSuccess<Brief>>(), reason: result is AiFailure<Brief> ? result.message : '');
      final brief = (result as AiSuccess<Brief>).value;
      expect(brief.nothingToSummarise, isFalse);
      expect(brief.partial, isFalse);
      expect(brief.items, hasLength(7));
      final text = mortgageMessage().normalisedText;
      for (final item in brief.items) {
        expect(item.evidence.isAttachmentName, isFalse);
        expect(text.substring(item.evidence.start, item.evidence.end), item.evidence.quote);
      }
    });

    test('keeps the channel, the tax years and the conditional timings as written', () async {
      final brief = ((await run(task(), [goodMortgageAnswer])) as AiSuccess<Brief>).value;
      final id = brief.items.singleWhere((i) => i.text.startsWith('Complete the ID check'));
      expect(id.channel, 'in the Harbour app');
      expect(brief.items.map((i) => i.text), contains('SA302 tax calculation for 2024/25'));
      expect(brief.items.map((i) => i.text), contains('Tax year overview for 2025'));
      final caseManager = brief.items.singleWhere((i) => i.kind == BriefItemKind.next);
      expect(caseManager.due.kind, DueKind.conditional);
      expect(caseManager.due.date, isNull);
      expect(caseManager.due.text, contains('after submission'));
      expect(caseManager.owner, BriefOwner.them);
    });

    test('may quote an attachment name for a document item', () async {
      final answer = mortgageAnswerWith({
        'kind': 'document',
        'text': 'The mortgage illustration is attached',
        'quote': 'Mortgage illustration.pdf',
        'channel': null,
        'owner': 'them',
        'due': {'kind': 'none', 'text': null, 'date': null},
      });
      final brief = ((await run(task(), [answer])) as AiSuccess<Brief>).value;
      expect(brief.items.last.evidence.isAttachmentName, isTrue);
    });

    test('is accepted with a date when the quote states that date', () async {
      final message = BriefInput(
        subject: 'Valuation',
        from: 'dana@harbour.example',
        date: now,
        text: 'The valuation is booked for Thursday 5 November; someone needs to be at the property.',
      );
      final answer = {
        'summary': 'The valuation is on 5 November.',
        'nothing_to_summarise': false,
        'items': [
          {
            'kind': 'date',
            'text': 'Valuation: Thursday 5 November, someone must be at the property',
            'quote': 'The valuation is booked for Thursday 5 November',
            'channel': null,
            'owner': 'me',
            'due': {'kind': 'explicit', 'text': 'Thursday 5 November', 'date': '2026-11-05'},
          },
        ],
      };
      final brief = ((await run(task(message), [answer])) as AiSuccess<Brief>).value;
      expect(brief.items.single.due.date, DateTime.parse('2026-11-05'));
    });
  });

  group('the parser rejects', () {
    test('an invented request: its quote is not in the email', () async {
      final answer = mortgageAnswerWith({
        'kind': 'document',
        'text': 'Three months of payslips',
        'quote': 'Please also send three months of payslips.',
        'channel': 'by email',
        'owner': 'me',
        'due': {'kind': 'none', 'text': null, 'date': null},
      });
      final result = await run(task(), [answer, answer]);
      expect(result, isA<AiFailure<Brief>>());
      expect(
        reasonOf(result),
        contains('Item 8: the quote "Please also send three months of payslips." is not in the email'),
      );
    });

    test('a figure "from the attachment", for the same reason', () async {
      final answer = mortgageAnswerWith({
        'kind': 'date',
        'text': 'Initial rate 4.29%',
        'quote': 'Initial rate: 4.29%',
        'channel': null,
        'owner': 'unknown',
        'due': {'kind': 'none', 'text': null, 'date': null},
      });
      expect(reasonOf(await run(task(), [answer, answer])), contains('not in the email'));
    });

    test('a paraphrased quote', () async {
      final answer = mortgageAnswerWith({
        'kind': 'document',
        'text': 'Bank statement',
        'quote': 'A full month of bank statements showing your spending',
        'channel': null,
        'owner': 'me',
        'due': {'kind': 'none', 'text': null, 'date': null},
      }, replacing: 0);
      expect(reasonOf(await run(task(), [answer, answer])), contains('Item 1: the quote'));
    });

    test('the password, wherever it appears', () async {
      final inText = mortgageAnswerWith({
        'kind': 'action',
        'text': 'Log in to the Harbour app with password 8841209',
        'quote': 'Your login is your email address',
        'channel': 'in the Harbour app',
        'owner': 'me',
        'due': {'kind': 'none', 'text': null, 'date': null},
      });
      expect(reasonOf(await run(task(), [inText, inText])), contains('repeats sign-in details'));

      final inQuote = mortgageAnswerWith({
        'kind': 'action',
        'text': 'Log in to the Harbour app',
        'quote': 'your password is 8841209',
        'channel': 'in the Harbour app',
        'owner': 'me',
        'due': {'kind': 'none', 'text': null, 'date': null},
      });
      expect(reasonOf(await run(task(), [inQuote, inQuote])), contains('repeats sign-in details'));

      final inSummary = {...goodMortgageAnswer, 'summary': 'Log in with 8841209 and send five things.'};
      expect(reasonOf(await run(task(), [inSummary, inSummary])), contains('"summary" repeats sign-in details'));
    });

    test('a date the quote does not state, and a date on a conditional timing', () async {
      final invented = mortgageAnswerWith({
        'kind': 'next',
        'text': 'Case manager assigned by tomorrow',
        'quote': 'a case manager will be assigned within 24 hours',
        'channel': null,
        'owner': 'them',
        'due': {'kind': 'explicit', 'text': 'within 24 hours', 'date': '2026-10-30'},
      }, replacing: 6);
      expect(reasonOf(await run(task(), [invented, invented])), contains('does not state that date'));

      final conditionalWithDate = mortgageAnswerWith({
        'kind': 'next',
        'text': 'Case manager assigned',
        'quote': 'a case manager will be assigned within 24 hours',
        'channel': null,
        'owner': 'them',
        'due': {'kind': 'conditional', 'text': 'within 24 hours', 'date': '2026-10-30'},
      }, replacing: 6);
      expect(reasonOf(await run(task(), [conditionalWithDate, conditionalWithDate])), contains('cannot carry a date'));
    });

    test('a request found only in quoted earlier mail', () async {
      final answer = {
        'summary': 'The statement arrived; the ID check is still to do.',
        'nothing_to_summarise': false,
        'items': [
          {
            'kind': 'document',
            'text': 'SA302 tax calculation for 2024/25',
            'quote': 'Your SA302 tax calculation for 2024/25',
            'channel': null,
            'owner': 'me',
            'due': {'kind': 'none', 'text': null, 'date': null},
          },
        ],
      };
      final reason = reasonOf(await run(task(quotingReply()), [answer, answer]));
      expect(reason, contains('quotes earlier mail'));
    });

    test('an apparently complete answer with no items, and an empty flag with items', () async {
      final empty = {'summary': 'Nothing to do.', 'nothing_to_summarise': false, 'items': <Object?>[]};
      expect(reasonOf(await run(task(), [empty, empty])), contains('"items" is empty'));
      final both = {...goodMortgageAnswer, 'nothing_to_summarise': true};
      expect(reasonOf(await run(task(), [both, both])), contains('one of them is wrong'));
    });

    test('wrong shapes, naming the field', () async {
      final badKind = mortgageAnswerWith({
        'kind': 'todo',
        'text': 'x',
        'quote': 'Dear Sam',
        'channel': null,
        'owner': 'me',
        'due': {'kind': 'none', 'text': null, 'date': null},
      }, replacing: 0);
      expect(reasonOf(await run(task(), [badKind, badKind])), contains('Item 1: "kind"'));
      final badDate = mortgageAnswerWith({
        'kind': 'date',
        'text': 'x',
        'quote': 'Dear Sam',
        'channel': null,
        'owner': 'me',
        'due': {'kind': 'explicit', 'text': 'soon', 'date': 'tomorrow'},
      }, replacing: 0);
      expect(reasonOf(await run(task(), [badDate, badDate])), contains('"due.date" must be YYYY-MM-DD'));
      final prose = 'Here is what you need to do: send the statement.';
      expect(reasonOf(await run(task(), [prose, prose])), contains('not valid JSON'));
    });
  });

  group('short mail', () {
    test('"Thanks, all received" has nothing to summarise', () async {
      final answer = {
        'summary': 'Dana confirms everything arrived.',
        'nothing_to_summarise': true,
        'items': <Object?>[],
      };
      final brief = ((await run(task(thanksReply()), [answer])) as AiSuccess<Brief>).value;
      expect(brief.nothingToSummarise, isTrue);
      expect(brief.items, isEmpty);
    });

    test('a reply that quotes old requests can still list what it itself asks', () async {
      final answer = {
        'summary': 'The statement arrived; the ID check is still to do.',
        'nothing_to_summarise': false,
        'items': [
          {
            'kind': 'action',
            'text': 'Complete the ID check',
            'quote': 'Just the ID check to go now.',
            'channel': null,
            'owner': 'me',
            'due': {'kind': 'none', 'text': null, 'date': null},
          },
        ],
      };
      final brief = ((await run(task(quotingReply()), [answer])) as AiSuccess<Brief>).value;
      expect(brief.items.single.evidence.start, greaterThanOrEqualTo(0));
    });
  });

  test('a rejected answer is repaired once, with the reason', () async {
    final invented = mortgageAnswerWith({
      'kind': 'document',
      'text': 'Payslips',
      'quote': 'three months of payslips',
      'channel': null,
      'owner': 'me',
      'due': {'kind': 'none', 'text': null, 'date': null},
    });
    final fake = FakeProvider(answers: [jsonEncode(invented), jsonEncode(goodMortgageAnswer)]);
    final result = await AiRunner(fake).run(task());
    expect(result, isA<AiSuccess<Brief>>());
    expect(fake.requests, hasLength(2));
    expect(fake.requests[1].input, contains('is not in the email'));
  });

  test('a long message yields a partial Brief', () async {
    final long = BriefInput(
      subject: 'Long',
      from: 'f',
      date: now,
      text: 'Please send the statement.\n${'Filler sentence. ' * 2000}',
    );
    final t = BriefTask(long, now: now, maxCharacters: 500);
    final answer = {
      'summary': 'Send the statement.',
      'nothing_to_summarise': false,
      'items': [
        {
          'kind': 'document',
          'text': 'The statement',
          'quote': 'Please send the statement.',
          'channel': null,
          'owner': 'me',
          'due': {'kind': 'none', 'text': null, 'date': null},
        },
      ],
    };
    final brief = ((await run(t, [answer])) as AiSuccess<Brief>).value;
    expect(brief.partial, isTrue);
  });

  test('quotes are matched with whitespace normalised', () async {
    final message = BriefInput(subject: 's', from: 'f', date: now, text: 'Please  send\tthe\r\nstatement by Friday.');
    final answer = {
      'summary': 'Send the statement.',
      'nothing_to_summarise': false,
      'items': [
        {
          'kind': 'document',
          'text': 'The statement, by Friday',
          'quote': 'Please send the\nstatement by Friday.',
          'channel': null,
          'owner': 'me',
          'due': {'kind': 'suggested', 'text': 'by Friday', 'date': null},
        },
      ],
    };
    final brief = ((await run(task(message), [answer])) as AiSuccess<Brief>).value;
    expect(brief.items.single.evidence.start, 0);
  });
}
