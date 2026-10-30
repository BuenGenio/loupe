import 'dart:convert';

import 'package:mail_ai/mail_ai.dart';
import 'package:test/test.dart';

void main() {
  final day = DateTime.utc(2026, 10, 29, 9);

  /// Three messages of a house purchase, oldest first as a matter has them.
  List<MatterStatusMessage> messages() => [
    MatterStatusMessage(
      emailId: 'personal/INBOX/1',
      conversation: 'harbour',
      from: 'Rhea Patel <rhea.patel@harbourhomeloans.example>',
      date: day,
      subject: 'Your mortgage application',
      text:
          'Hi Sam,\n\nYour login is your email address and your temporary password is 5523907.\n\n'
          'Please send your bank statement.\n\nRhea',
    ),
    MatterStatusMessage(
      emailId: 'personal/INBOX/2',
      conversation: 'quay',
      from: 'Owen Marsh <owen.marsh@marshvale.example>',
      date: day.add(const Duration(days: 1)),
      subject: '14 Quay Street: client care letter',
      text: 'Dear Sam,\n\n2. Pay £300 on account by bank transfer, using the reference QS-4471.\n\nOwen',
    ),
    MatterStatusMessage(
      emailId: 'personal/INBOX/3',
      conversation: 'harbour',
      from: 'Rhea Patel <rhea.patel@harbourhomeloans.example>',
      date: day.add(const Duration(days: 2)),
      subject: 'Re: Your mortgage application',
      text:
          'Thanks, the bank statement has arrived.   Please confirm by Thursday 5 November.\n\n'
          '> Please send your bank statement.',
    ),
  ];

  MatterStatusTask task({List<MatterStatusMessage>? input, int maxMessages = 12, int maxPerMessage = 2500}) =>
      MatterStatusTask(
        matterName: 'Buying 14 Quay Street',
        messages: input ?? messages(),
        language: 'en-GB',
        maxMessages: maxMessages,
        maxPerMessage: maxPerMessage,
      );

  Future<AiRun<MatterStatus>> run(MatterStatusTask t, Object answer) =>
      AiRunner(FakeProvider(answers: [answer is String ? answer : jsonEncode(answer)])).run(t);
  Map<String, Object?> statement(String text, String message, String quote) => {
    'text': text,
    'message': message,
    'quote': quote,
  };
  String reasonOf(AiRun<MatterStatus> r) => (r as AiFailure<MatterStatus>).message;

  group('input', () {
    test('newest first, each message’s own text with short ids, no local ids and no date in the instructions', () {
      final t = task();
      final input = jsonDecode(t.input) as Map<String, Object?>;
      final sent = (input['messages'] as List<Object?>).cast<Map<String, Object?>>();
      expect(sent.map((m) => m['id']), ['m1', 'm2', 'm3']);
      expect(sent.map((m) => m['subject']), [
        'Re: Your mortgage application',
        '14 Quay Street: client care letter',
        'Your mortgage application',
      ]);
      expect(sent.first['text'], 'Thanks, the bank statement has arrived. Please confirm by Thursday 5 November.');
      expect(t.input, isNot(contains('personal/INBOX')));
      expect(input['matter'], 'Buying 14 Quay Street');
      expect(t.instructions, contains('exact passage copied from that message'));
      expect(t.instructions, contains('Never repeat passwords'));
      expect(t.instructions, contains('"en-GB"'));
      expect(t.instructions, isNot(contains('2026')));
      expect(t.type, 'matters.status');
      expect(t.partial, isFalse);
    });

    test('is bounded: older messages left out and long ones cut short, and the status says so', () {
      final few = task(maxMessages: 2);
      expect(few.sent.map((s) => s.message.emailId), ['personal/INBOX/3', 'personal/INBOX/2']);
      expect(few.partial, isTrue);
      expect((jsonDecode(few.input) as Map<String, Object?>)['messages_left_out'], 1);
      final short = task(maxPerMessage: 20);
      expect(short.sent.first.text, hasLength(20));
      expect(short.partial, isTrue);
    });

    test('the same messages give the same input hash; a new message changes it', () {
      expect(inputHash(task()), inputHash(task()));
      final more = [
        ...messages(),
        MatterStatusMessage(
          emailId: 'personal/INBOX/4',
          conversation: 'valuation',
          from: 'Calder Building Society',
          date: day.add(const Duration(days: 3)),
          subject: 'Valuation booked',
          text: 'We have booked the valuation.',
        ),
      ];
      expect(inputHash(task(input: more)), isNot(inputHash(task())));
    });
  });

  group('the parser', () {
    test('accepts statements that quote their own message, newest first', () async {
      final result = await run(task(), {
        'statements': [
          statement('Rhea asks you to confirm by Thursday 5 November.', 'm1', 'Please confirm by Thursday 5 November.'),
          statement(
            'Owen asks for £300 on account with the reference QS-4471.',
            'm2',
            'Pay £300 on account by bank transfer, using the reference QS-4471.',
          ),
        ],
      });
      expect(result, isA<AiSuccess<MatterStatus>>(), reason: result is AiFailure<MatterStatus> ? result.message : '');
      final status = (result as AiSuccess<MatterStatus>).value;
      expect(status.statements.map((s) => s.emailId), ['personal/INBOX/3', 'personal/INBOX/2']);
      expect(status.statements.first.quote, 'Please confirm by Thursday 5 November.');
      expect(status.partial, isFalse);
    });

    test('rejects a quote from another message, or from quoted earlier mail', () async {
      final elsewhere = await run(task(), {
        'statements': [statement('Pay £300.', 'm1', 'Pay £300 on account by bank transfer')],
      });
      expect(reasonOf(elsewhere), contains('not in message m1'));
      final quoted = await run(task(), {
        'statements': [statement('Rhea wants the statement.', 'm1', 'Please send your bank statement.')],
      });
      expect(reasonOf(quoted), contains('not in message m1'));
    });

    test('rejects figures the quote doesn’t have, unknown messages, and too many statements', () async {
      final invented = await run(task(), {
        'statements': [statement('Confirm by Thursday 6 November.', 'm1', 'Please confirm by Thursday 5 November.')],
      });
      expect(reasonOf(invented), contains('"6"'));
      final unknown = await run(task(), {
        'statements': [statement('Confirm.', 'personal/INBOX/3', 'Please confirm by Thursday 5 November.')],
      });
      expect(reasonOf(unknown), contains('"id" of one of the messages'));
      final many = await run(task(), {
        'statements': [for (var i = 0; i < 7; i++) statement('Confirm.', 'm1', 'Please confirm')],
      });
      expect(reasonOf(many), contains('at most 6'));
      final empty = await run(task(), {'statements': <Object?>[]});
      expect(reasonOf(empty), contains('empty'));
      final long = await run(task(), {
        'statements': [statement('x' * 300, 'm1', 'Please confirm')],
      });
      expect(reasonOf(long), contains('too long'));
    });

    test('never lets a password through, in the quote or the text', () async {
      final inQuote = await run(task(), {
        'statements': [statement('Sign in with the temporary password.', 'm3', 'your temporary password is 5523907')],
      });
      expect(reasonOf(inQuote), contains('sign-in details'));
      final inText = await run(task(), {
        'statements': [
          statement('Send the statement; the password is 5523907.', 'm3', 'Please send your bank statement.'),
        ],
      });
      expect(reasonOf(inText), contains('sign-in details'));
    });

    test('one repair attempt with the reason, then a clean failure', () async {
      final provider = FakeProvider(answers: ['not json', '{"statements": "no"}']);
      final result = await AiRunner(provider).run(task());
      expect(result, isA<AiFailure<MatterStatus>>());
      expect((result as AiFailure<MatterStatus>).reason, AiFailureReason.invalidOutput);
      expect(provider.requests, hasLength(2));
      expect(provider.requests.last.input, contains('not valid JSON'));
    });
  });
}
