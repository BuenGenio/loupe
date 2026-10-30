import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:mail_model/mail_model.dart';

import 'demo_attachments.dart';
import 'demo_data.dart';

/// The people and conversations of the Private AI storyline: Sam is buying
/// 14 Quay Street. A mortgage adviser asks for five things (one only in an
/// app, two tax years that differ, a timing measured from submission, a
/// password in the text), Sam answers with two of them, the adviser confirms
/// and promises the valuation booking, then sends a revised illustration with
/// changed figures and a deadline. The solicitor, the lender and the removal
/// firm write separately about the same purchase, with different senders and
/// subjects. Everything here is invented (docs/plan/PLAN-combined.md,
/// "Acceptance fixtures"): synthetic people, domains, documents and secrets.
abstract final class DemoPrivateAi {
  static const adviser = EmailAddress('rhea.patel@harbourhomeloans.example', 'Rhea Patel');
  static const solicitor = EmailAddress('owen.marsh@marshvale.example', 'Owen Marsh');
  static const lender = EmailAddress('mortgages@calderbs.example', 'Calder Building Society');
  static const removals = EmailAddress('accounts@quaysideremovals.example', 'Quayside Removals');

  /// Thread keys given to [DemoSeed.add]; the conversation's thread id is
  /// `T-personal-<key>`.
  static const mortgageThread = 'harbour';
  static const solicitorThread = 'quay-street';
  static const valuationThread = 'valuation';
  static const removalsThread = 'removals';

  static String threadId(String key) => 'T-${DemoAccounts.personal}-$key';

  /// The storyline's thread ids, in the order the purchase unfolds.
  static List<String> get threadIds => [
    threadId(mortgageThread),
    threadId(solicitorThread),
    threadId(valuationThread),
    threadId(removalsThread),
  ];

  /// The temporary password in the adviser's first message. Nothing Loupe
  /// derives from the message may repeat it.
  static const password = '5523907';
}

extension DemoPrivateAiCases on DemoSeed {
  /// Adds the storyline to the personal inbox. Called last in the build, so
  /// the ids of the rest of the demo mailbox don't move.
  void privateAiCases() {
    const a = DemoAccounts.personal;
    const inbox = 'INBOX';
    const sent = '[Gmail]/Sent Mail';
    final me = DemoPeople.personal;
    final day = DateFormat('EEEE d MMMM', 'en_US');
    final shortDay = DateFormat('d MMMM', 'en_US');
    final confirmBy = DateTime(now.year, now.month, now.day + 6);
    final valuation = DateTime(now.year, now.month, now.day + 11, 10);
    final invoiceDue = DateTime(now.year, now.month, now.day + 21);

    // The adviser's requests ------------------------------------------------------

    add(
      account: a,
      box: inbox,
      at: at(6, 15, 10),
      from: DemoPrivateAi.adviser,
      subject: 'Your mortgage application: what we need next',
      thread: DemoPrivateAi.mortgageThread,
      answered: true,
      text:
          'Dear Sam,\n\n'
          'Good speaking to you earlier. Attached are your mortgage illustration and the payment schedule.\n\n'
          'The illustration in brief:\n'
          'Initial rate: 4.29% fixed for 5 years\n'
          'Arrangement fee: £999\n'
          'Monthly payment: £1,408.72\n'
          'Term: 30 years\n\n'
          'To proceed with your application we need the following:\n\n'
          "- A full month's bank statement showing your day-to-day spending and your salary coming in.\n"
          '- The ID check, completed in the Harbour app (passport or driving licence).\n'
          '- Your SA302 tax calculation for 2024/25.\n'
          '- Your tax year overview for 2025.\n'
          '- The affordability form at https://forms.harbourhomeloans.example/a/7k2q\n\n'
          'Once we have all of the above we can submit the application and secure the rate.\n\n'
          'You can download the Harbour app from the App Store or Google Play. Your login is your email address '
          'and your temporary password is ${DemoPrivateAi.password}.\n\n'
          'The ID check has to be done in the app; everything else can be emailed to me.\n\n'
          'Next steps: once the case has been submitted to the lender, a case manager will be assigned within 24 '
          'hours and will keep you updated. The lender will then review the case and arrange the valuation. If '
          'they are happy, they issue the offer to us and to your solicitor.\n\n'
          'Kind regards,\n'
          'Rhea Patel\n'
          'Mortgage adviser, Harbour Home Loans',
      attachments: [
        _pdf(
          '2',
          'Mortgage illustration.pdf',
          'Mortgage illustration',
          _illustration(rate: '4.29%', fee: '999', monthly: '1,408.72', total: '571,240'),
        ),
        _pdf('3', 'Payment schedule.pdf', 'Payment schedule', _schedule('1,408.72')),
      ],
    );

    add(
      account: a,
      box: sent,
      at: at(5, 21, 40),
      from: me,
      to: [DemoPrivateAi.adviser],
      subject: 'Re: Your mortgage application: what we need next',
      thread: DemoPrivateAi.mortgageThread,
      text:
          'Hi Rhea,\n\n'
          "Attached are my September bank statement and the SA302 for 2024/25. I'll do the ID check in the app "
          'tonight and fill in the affordability form at the weekend.\n\n'
          'One question: should the tax year overview be for 2024/25 or for 2025? I want to send the right one.\n\n'
          'Thanks,\n'
          'Sam',
      attachments: [
        _pdf('2', 'Bank statement - September.pdf', 'Lumen Bank statement', _statement()),
        _pdf('3', 'SA302 2024-25.pdf', 'SA302 tax calculation', _sa302()),
      ],
    );

    add(
      account: a,
      box: inbox,
      at: at(4, 9, 5),
      from: DemoPrivateAi.adviser,
      subject: 'Re: Your mortgage application: what we need next',
      thread: DemoPrivateAi.mortgageThread,
      text:
          'Hi Sam,\n\n'
          'Thanks, the bank statement and the SA302 have arrived. Just the ID check, the tax year overview and the '
          'affordability form to go now.\n\n'
          'The overview should be for 2025, as written: the lender asks for the latest one.\n\n'
          'I will send you the valuation booking once the case is with the lender, usually within a week.\n\n'
          'Rhea\n\n'
          '> One question: should the tax year overview be for 2024/25 or for 2025? I want to send the right one.',
    );

    add(
      account: a,
      box: inbox,
      at: at(2, 11, 30),
      from: DemoPrivateAi.adviser,
      subject: 'Re: Your mortgage application: what we need next',
      thread: DemoPrivateAi.mortgageThread,
      text:
          'Hi Sam,\n\n'
          "The lender has updated its rates, so I've attached a revised illustration.\n\n"
          'The illustration in brief:\n'
          'Initial rate: 4.19% fixed for 5 years\n'
          'Arrangement fee: £1,499\n'
          'Monthly payment: £1,392.01\n'
          'Term: 30 years\n\n'
          'Everything else stays as before. Please confirm by ${day.format(confirmBy)} whether you want to go ahead '
          'with the revised product.\n\n'
          'Rhea',
      attachments: [
        _pdf(
          '2',
          'Mortgage illustration.pdf',
          'Mortgage illustration',
          _illustration(rate: '4.19%', fee: '1,499', monthly: '1,392.01', total: '566,620'),
        ),
      ],
    );

    // The same purchase, other senders ---------------------------------------------------

    add(
      account: a,
      box: inbox,
      at: at(3, 16, 20),
      from: DemoPrivateAi.solicitor,
      subject: '14 Quay Street: client care letter and next steps',
      thread: DemoPrivateAi.solicitorThread,
      text:
          'Dear Sam,\n\n'
          'Thank you for instructing us on your purchase of 14 Quay Street. Please find our client care letter '
          'attached.\n\n'
          'To get started, please:\n\n'
          '1. Sign and return the client care letter.\n'
          '2. Pay £300 on account by bank transfer, using the reference QS-4471, so that we can order the searches.\n'
          '3. Send us a copy of your mortgage offer as soon as you receive it.\n\n'
          'Our account details are in the letter. We will never change our bank details by email; if you receive '
          'an email saying they have changed, call us on 0161 555 0142 before paying.\n\n'
          'We expect the searches to take two to three weeks from payment.\n\n'
          'Kind regards,\n'
          'Owen Marsh\n'
          'Conveyancing, Marsh & Vale Solicitors',
      attachments: [_pdf('2', 'Client care letter.pdf', 'Client care letter', _careLetter())],
    );

    add(
      account: a,
      box: inbox,
      at: at(1, 10, 2),
      from: DemoPrivateAi.lender,
      subject: 'Valuation booked: 14 Quay Street',
      thread: DemoPrivateAi.valuationThread,
      text:
          'Dear Sam Rivera,\n\n'
          'We have booked the valuation of 14 Quay Street for ${day.format(valuation)} at 10:00.\n\n'
          'The valuer, Priya Shah of Ashby Surveyors, will need access to every room and to the loft. The visit '
          "usually takes about 45 minutes. If the time doesn't suit, reply to this email or call 0300 555 0177 at "
          'least two working days before.\n\n'
          'Your application reference is CBS-208144.\n\n'
          'Calder Building Society',
      attachments: [_pdf('2', 'Valuation booking.pdf', 'Valuation booking', _booking(day.format(valuation)))],
    );

    add(
      account: a,
      box: inbox,
      at: at(1, 18, 45),
      from: DemoPrivateAi.removals,
      subject: 'Invoice INV-2207: deposit for your move',
      thread: DemoPrivateAi.removalsThread,
      text:
          'Hello Sam,\n\n'
          'Thank you for booking your move with Quayside Removals. Please find invoice INV-2207 attached for the '
          'deposit.\n\n'
          'Amount due: £450.00, by ${shortDay.format(invoiceDue)}.\n\n'
          'The balance of £1,400.00 is due a week before the move. You can pay by bank transfer using the invoice '
          'number as the reference.\n\n'
          'Best wishes,\n'
          'Mia Turner\n'
          'Quayside Removals',
      attachments: [_pdf('2', 'INV-2207.pdf', 'Invoice INV-2207', _invoice(shortDay.format(invoiceDue)))],
    );
  }

  static DemoAttachment _pdf(String partId, String name, String title, List<List<String>> pages) {
    final bytes = pagedPdf(title, pages);
    return DemoAttachment(
      Attachment(partId: partId, mimeType: 'application/pdf', filename: name, size: bytes.length),
      generate: () => Uint8List.fromList(bytes),
    );
  }

  // Documents. pagedPdf writes ASCII only, so amounts are in GBP, not £. ---------------------

  static List<List<String>> _illustration({
    required String rate,
    required String fee,
    required String monthly,
    required String total,
  }) => [
    [
      'Prepared for: Sam Rivera',
      'Lender: Calder Building Society',
      'Product: 5 year fixed rate, 75% LTV',
      'Loan amount: GBP 285,000',
      'Property value: GBP 380,000',
      'Term: 30 years, capital and interest',
      'Initial rate: $rate fixed for 5 years',
      'Then: the lender variable rate, currently 7.49%',
      'Monthly payment (initial period): GBP $monthly',
    ],
    [
      'Fees',
      'Arrangement fee: GBP $fee (payable on completion)',
      'Valuation fee: GBP 0',
      'Broker fee: GBP 0',
      'Early repayment charges',
      'Year 1: 5%, year 2: 4%, year 3: 3%, year 4: 2%, year 5: 1%',
      'Total amount payable: GBP $total',
    ],
  ];

  static List<List<String>> _schedule(String monthly) => [
    [
      'Loan amount: GBP 285,000 over 30 years',
      for (var m = 1; m <= 6; m++) 'Payment $m: GBP $monthly',
      'Payments 7 to 60: GBP $monthly each',
      'From payment 61: at the lender variable rate',
    ],
  ];

  static List<List<String>> _statement() => [
    [
      'Account holder: Sam Rivera',
      'Period: 1 to 30 September',
      'Opening balance: GBP 2,140.55',
      'Salary, Northwind Labs: GBP 3,912.40',
      'Card payments: GBP 1,286.10',
      'Rent, Harbourside Lettings: GBP 1,350.00',
      'Closing balance: GBP 3,416.85',
    ],
  ];

  static List<List<String>> _sa302() => [
    [
      'Tax calculation for the year 6 April 2024 to 5 April 2025',
      'Name: Sam Rivera',
      'Total income received: GBP 58,240.00',
      'Income tax due: GBP 10,348.00',
      'Class 4 National Insurance: GBP 1,120.20',
      'Total due for 2024/25: GBP 11,468.20',
    ],
  ];

  static List<List<String>> _careLetter() => [
    [
      'Client: Sam Rivera',
      'Matter: purchase of 14 Quay Street',
      'Fee: GBP 1,150 plus VAT',
      'Searches (estimate): GBP 300',
      'Payment on account: GBP 300, reference QS-4471',
      'Bank: demo account, sort code 00-00-00, account 00000000',
    ],
    ['Please sign below and return this letter to us.', 'Signed: ____________________', 'Date: ____________________'],
  ];

  static List<List<String>> _booking(String date) => [
    [
      'Booking reference: VAL-55021',
      'Application reference: CBS-208144',
      'Property: 14 Quay Street',
      'Date: $date',
      'Time: 10:00 (UK time)',
      'Valuer: Priya Shah, Ashby Surveyors',
      'Access needed: every room and the loft',
    ],
  ];

  static List<List<String>> _invoice(String due) => [
    [
      'Payee: Quayside Removals Ltd',
      'Customer: Sam Rivera',
      'Description: deposit for house move (2-bed flat)',
      'Subtotal: GBP 375.00',
      'VAT (20%): GBP 75.00',
      'Amount due: GBP 450.00',
      'Due date: $due',
      'Quote for the whole move: GBP 1,850.00, balance GBP 1,400.00 due later',
    ],
  ];
}
