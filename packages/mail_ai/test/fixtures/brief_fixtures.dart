// Synthetic mail for the Brief tests (docs/plan/PLAN-combined.md, "Acceptance
// fixtures"). Invented people, domains, documents and secrets that keep the
// shape of the real thing: several independent requests, one that must be done
// in an app, a tax year and a tax-overview year that differ, a timing measured
// from an event, a password, and an attachment whose figures are not in the
// text. Nothing here is a real person's message.

import 'package:mail_ai/mail_ai.dart';

final mortgageDate = DateTime.utc(2026, 10, 29, 15, 10);

const mortgageText = '''
Dear Sam,

Good speaking to you earlier. Attached is your mortgage illustration and the payment schedule.

To proceed with your application we need the following:

- A full month's bank statement showing your day-to-day spending and your salary coming in.
- The ID check, completed in the Harbour app (passport or driving licence).
- Your SA302 tax calculation for 2024/25 (see the example attached).
- Your tax year overview for 2025.
- The affordability form at https://forms.harbour.example/a/9f2c

Once we have all of the above we can submit the application and secure the rate.

You can download the Harbour app from the App Store or Google Play. Your login is your email address and your password is 8841209.

The ID check has to be done in the app; everything else can be emailed to me.

Next steps: once the case has been submitted to the lender, a case manager will be assigned within 24 hours and will keep you updated. The lender will then review the case and arrange the valuation. If they are happy, they issue the offer to us and to your solicitor.

Kind regards,
Dana
''';

BriefInput mortgageMessage() => BriefInput(
  subject: 'Your application: what we need next',
  from: 'Dana Whitfield <dana@harbour.example>',
  date: mortgageDate,
  text: mortgageText,
  attachments: const ['Mortgage illustration.pdf', 'SA302 example.pdf'],
);

/// A later reply that quotes the requests. The quoted lines are not new asks.
BriefInput quotingReply() => BriefInput(
  subject: 'Re: Your application: what we need next',
  from: 'Dana Whitfield <dana@harbour.example>',
  date: DateTime.utc(2026, 10, 30, 9),
  text: '''
Thanks Sam, the bank statement has arrived. Just the ID check to go now.

> - A full month's bank statement showing your day-to-day spending and your salary coming in.
> - The ID check, completed in the Harbour app (passport or driving licence).
> - Your SA302 tax calculation for 2024/25 (see the example attached).
''',
);

BriefInput thanksReply() => BriefInput(
  subject: 'Re: Documents',
  from: 'Dana Whitfield <dana@harbour.example>',
  date: DateTime.utc(2026, 10, 30, 9),
  text: 'Thanks, all received.',
);

/// The answer a good model gives for [mortgageMessage]: five requests, the
/// app-only channel kept, the tax years as written, the conditional timing
/// marked conditional, and no password anywhere.
const Map<String, Object?> goodMortgageAnswer = {
  'summary': 'Harbour needs five things to submit your application and secure the rate.',
  'nothing_to_summarise': false,
  'items': [
    {
      'kind': 'document',
      'text': "A full month's bank statement",
      'quote': "A full month's bank statement showing your day-to-day spending and your salary coming in.",
      'channel': 'by email',
      'owner': 'me',
      'due': {'kind': 'none', 'text': null, 'date': null},
    },
    {
      'kind': 'action',
      'text': 'Complete the ID check (passport or driving licence)',
      'quote': 'The ID check has to be done in the app',
      'channel': 'in the Harbour app',
      'owner': 'me',
      'due': {'kind': 'none', 'text': null, 'date': null},
    },
    {
      'kind': 'document',
      'text': 'SA302 tax calculation for 2024/25',
      'quote': 'Your SA302 tax calculation for 2024/25',
      'channel': 'by email',
      'owner': 'me',
      'due': {'kind': 'none', 'text': null, 'date': null},
    },
    {
      'kind': 'document',
      'text': 'Tax year overview for 2025',
      'quote': 'Your tax year overview for 2025.',
      'channel': 'by email',
      'owner': 'me',
      'due': {'kind': 'none', 'text': null, 'date': null},
    },
    {
      'kind': 'action',
      'text': 'Complete the affordability form',
      'quote': 'The affordability form at https://forms.harbour.example/a/9f2c',
      'channel': null,
      'owner': 'me',
      'due': {'kind': 'none', 'text': null, 'date': null},
    },
    {
      'kind': 'condition',
      'text': 'The rate is secured once all of the above is in',
      'quote': 'Once we have all of the above we can submit the application and secure the rate.',
      'channel': null,
      'owner': 'them',
      'due': {'kind': 'conditional', 'text': 'once we have all of the above', 'date': null},
    },
    {
      'kind': 'next',
      'text': 'A case manager is assigned within 24 hours after submission to the lender',
      'quote': 'once the case has been submitted to the lender, a case manager will be assigned within 24 hours',
      'channel': null,
      'owner': 'them',
      'due': {'kind': 'conditional', 'text': 'within 24 hours after submission to the lender', 'date': null},
    },
  ],
};

/// [goodMortgageAnswer] with one item replaced or added.
Map<String, Object?> mortgageAnswerWith(Map<String, Object?> item, {int? replacing}) {
  final items = List<Object?>.of(goodMortgageAnswer['items']! as List<Object?>);
  if (replacing != null) {
    items[replacing] = item;
  } else {
    items.add(item);
  }
  return {...goodMortgageAnswer, 'items': items};
}
