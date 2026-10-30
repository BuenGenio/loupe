import 'package:mail_model/mail_model.dart';

import 'demo_attachments.dart';

/// Documents on Sam's phone in the demo, offered by compose's paper clip so
/// Reply Check can be tried on the mortgage adviser's requests
/// (demo_private_ai.dart): the right ones, a tax calculation and an overview
/// for another year, half a month's statement, a tax calculation whose name
/// doesn't say the year, and a passport scan for an ID check that is only
/// done in an app. Invented, like the rest of the storyline. Their text is
/// real PDF text, so a document reader sees what the names claim (or don't).
abstract final class DemoFiles {
  static List<OutgoingAttachment> all() => [
    _pdf('Bank statement - September.pdf', 'Lumen Bank statement', [
      'Account holder: Sam Rivera',
      'Period: 1 to 30 September',
      'Opening balance: GBP 2,140.55',
      'Salary, Northwind Labs: GBP 3,912.40',
      'Card payments: GBP 1,286.10',
      'Rent, Harbourside Lettings: GBP 1,350.00',
      'Closing balance: GBP 3,416.85',
    ]),
    _pdf('Bank statement - 1 to 14 October.pdf', 'Lumen Bank statement', [
      'Account holder: Sam Rivera',
      'Period: 1 to 14 October',
      'Opening balance: GBP 3,416.85',
      'Card payments: GBP 512.30',
      'Closing balance: GBP 2,904.55',
    ]),
    _pdf('SA302 2024-25.pdf', 'SA302 tax calculation', _sa302(2024, income: '58,240.00', due: '11,468.20')),
    _pdf('SA302 2023-24.pdf', 'SA302 tax calculation', _sa302(2023, income: '54,910.00', due: '10,322.60')),
    // The name doesn't say the year; inside, it is 2023/24.
    _pdf('Tax calculation.pdf', 'SA302 tax calculation', _sa302(2023, income: '54,910.00', due: '10,322.60')),
    _pdf('Tax year overview 2024-25.pdf', 'Tax year overview', [
      'Name: Sam Rivera',
      'Tax year: 2024 to 2025',
      'Tax paid: GBP 11,468.20',
      'Nothing left to pay',
    ]),
    _pdf('Tax year overview 2025.pdf', 'Tax year overview', [
      'Name: Sam Rivera',
      'Overview for 2025',
      'Tax paid: GBP 11,904.75',
      'Nothing left to pay',
    ]),
    _pdf('Passport scan.pdf', 'Passport (scan)', [
      'Name: Sam Rivera',
      'Passport number: 000000000 (demo)',
      'Expires: 2031',
    ]),
  ];

  static List<String> _sa302(int year, {required String income, required String due}) => [
    'Tax calculation for the year 6 April $year to 5 April ${year + 1}',
    'Name: Sam Rivera',
    'Total income received: GBP $income',
    'Total due for $year/${(year + 1) % 100}: GBP $due',
  ];

  static OutgoingAttachment _pdf(String name, String title, List<String> lines) =>
      OutgoingAttachment(filename: name, mimeType: 'application/pdf', data: pagedPdf(title, [lines]));
}
