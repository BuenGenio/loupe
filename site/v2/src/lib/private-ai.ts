// Private AI: the features planned in docs/plan/PLAN-combined.md. None of them
// has shipped, and every place that shows them says "Coming soon".
// English only for now; the strings move to src/i18n/en.json (and get
// translated) once the features are close to shipping.

import type { IconName } from './icons';

export const soonLabel = 'Coming soon';

export const intro = {
  eyebrow: 'Private AI · in the works',
  title: 'An assistant that never leaves your phone.',
  lead:
    "Loupe's next chapter: AI that turns mail into to-dos, plain English into searches and rules, and PDFs into the numbers that matter. You choose where it runs: on your phone, on your own server, or with a cloud provider you pick. There's still no Loupe cloud.",
  more: 'See what’s coming',
};

export const principles: { icon: IconName; title: string; text: string }[] = [
  { icon: 'phone', title: 'On this phone', text: 'A model on your phone, or Apple’s on-device model on iPhone, where tests show your phone runs it well.' },
  { icon: 'key', title: 'Or your server, or a cloud you choose', text: 'A model on your own server, or a cloud provider with your own key. Chosen per account and feature, and never through us.' },
  { icon: 'search-sparkle', title: 'Answers you can check', text: 'Every request links to its sentence, every figure to its page, every search to its expression.' },
  { icon: 'cloud-off', title: 'One switch turns it off', text: 'Off stops every model call. Your mail, rules and the to-dos you manage yourself keep working.' },
];

export type AiFeature = {
  key: string;
  icon: IconName;
  title: string;
  short: string;
  text: string;
  points: string[];
};

export const aiFeatures: AiFeature[] = [
  {
    key: 'todo',
    icon: 'checkmark',
    title: 'Brief',
    short: 'What a long email asks of you: actions, documents and dates, each with its source.',
    text:
      'A Brief lists what a message asks of you: actions, documents to send, dates and conditions, exactly as written. Tap an item to see the sentence it came from. Tick it off, give it a reminder, or turn it into a calendar event when it really is one.',
    points: ['Each item links to its sentence', 'Conditions kept: “within 24 hours after submission” stays that', 'Passwords in a message are never repeated'],
  },
  {
    key: 'search',
    icon: 'search-sparkle',
    title: 'Search in plain English',
    short: 'Say what you want; get an expression you can see, edit and save.',
    text:
      'Type “from Harbour with attachments since September” and Loupe writes the expression for you. It runs like any search, and you can edit it, save it as a Smart Mailbox or turn it into a rule.',
    points: ['Written in Loupe’s search language', 'Runs on the phone and the server', 'Save as a Smart Mailbox'],
  },
  {
    key: 'rules',
    icon: 'flow',
    title: 'Rules in plain English',
    short: 'Describe a rule; check it against your mail; send it to the server.',
    text:
      'Say “anything from Harbour or Northgate goes to Mortgage, flagged”. Loupe opens it in the rule editor with a dry run: the messages it would have caught, and the ones it wouldn’t. Nothing is saved until you say so, and anything Loupe can’t do exactly is left open, not guessed.',
    points: ['A dry run against your downloaded mail', 'Runs on your server, phone off or on', 'The AI proposes; Loupe writes the Sieve'],
  },
  {
    key: 'waiting',
    icon: 'send-clock',
    title: 'Needs my action, Waiting on others',
    short: 'Two folders that keep track until the work is actually done.',
    text:
      'What you’ve been asked to do lands in Needs my action; what others promised you lands in Waiting on others. Asked something and heard nothing? Loupe offers a follow-up after the days you choose. Wrote “I’ll send it tomorrow”? It reminds you tomorrow.',
    points: ['A reminder for each request, not the whole message', 'A “Thanks” doesn’t mark everything done', 'Your corrections survive new mail'],
  },
  {
    key: 'matters',
    icon: 'mail-multiple',
    title: 'Matters',
    short: 'One timeline for a matter that spans many senders and weeks.',
    text:
      'A mortgage, a move, an insurance claim: broker, lender and solicitor all write from different addresses. A matter gathers them into one timeline, with every open item and the latest status in two lines.',
    points: ['You decide what belongs; suggestions can be undone', 'Open items from every message', 'Filing a message doesn’t take it out of the matter'],
  },
  {
    key: 'facts',
    icon: 'document-text',
    title: 'Key facts from attachments',
    short: 'Rates, amounts, due dates and fees from PDFs, each linked to its page.',
    text:
      'Open a mortgage illustration, an invoice or a booking and see the numbers that matter at the top: rate, monthly payment, fees, due date. Each figure links to the page it came from. What Loupe can’t confirm stays marked unknown, never guessed.',
    points: ['Checked against the page text', 'Invoices, bookings, illustrations', 'Stays on your phone'],
  },
];

// The interactive demos on the home page and /private-ai/. Fictional mail.
export const demo = {
  email: {
    from: 'Dana at Harbour Home Loans',
    subject: 'Your application: what we need next',
    body: [
      'Good speaking to you earlier.',
      'To proceed, please email a full month’s bank statement and your SA302 for 2024/25.',
      'The ID check has to be completed in the Harbour app.',
      'Once we have everything, we can secure your rate.',
    ],
  },
  todos: [
    { text: 'Send a full month’s bank statement', tag: 'Document', from: 1 },
    { text: 'Send your SA302 for 2024/25', tag: 'Document', from: 1 },
    { text: 'Complete the ID check in the Harbour app', tag: 'Action', from: 2 },
    { text: 'Rate is secured once everything arrives', tag: 'Deadline', from: 3 },
  ],
  query: 'from Harbour with attachments since September',
  expression: 'f:harbour and has:attachment and after:2026-09-01',
  rule: 'Anything from Harbour or Northgate goes to Mortgage, flagged',
  sieve: [
    'require ["fileinto", "imap4flags"];',
    'if address :domain "from" ["harbour.example", "northgate.example"] {',
    '  addflag "\\\\Flagged";',
    '  fileinto "Mortgage";',
    '}',
  ],
  dryRun: 'Would have matched 14 of 2,000 downloaded messages',
  facts: [
    { label: 'Initial rate', value: '4.29%', page: 2 },
    { label: 'Monthly payment', value: '£1,184', page: 2 },
    { label: 'Term', value: '25 years', page: 1 },
    { label: 'Product fee', value: '£999', page: 4 },
  ],
};

// The roadmap's Private AI milestones (PLAN-combined.md, "Delivery milestones").
// Gates, not dates: each ships when its fixtures pass on real mail and phones.
export type MilestoneState = 'now' | 'planned';
export const milestoneStates: Record<MilestoneState, string> = { now: 'In progress', planned: 'Planned' };

export const roadmapAi = {
  eyebrow: 'Private AI',
  title: 'The assistant, one milestone at a time.',
  lead: 'Each step has a quality gate instead of a date: it ships when its tests pass on real mail and real phones, and it stays useful on its own.',
  note: 'Model output only ever proposes data. Loupe checks it, you confirm it, and the app you already have does the work.',
  more: 'What’s coming',
};

export const milestones: { key: string; state: MilestoneState; icon: IconName; title: string; text: string }[] = [
  { key: 'a', state: 'now', icon: 'code', title: 'Changes: a diff for email', text: 'Compare two messages in a conversation and see exactly what changed, line by line, with attachment names and sizes compared separately. Runs on the phone; no model involved.' },
  { key: 'b', state: 'planned', icon: 'shield-lock', title: 'The foundation', text: 'Typed tasks, a fake provider for tests, and the first on-device and network adapters. Every result is checked before a feature sees it, and nothing is uploaded without your choice.' },
  { key: 'c', state: 'planned', icon: 'search-sparkle', title: 'Search in plain English', text: 'A sentence becomes an expression you can see, edit and save, run through the same search as a typed query.' },
  { key: 'd', state: 'planned', icon: 'sparkle', title: 'Brief', text: 'What a message asks of you, every item linked to its sentence. Tested against tricky, mortgage-style mail before it ships.' },
  { key: 'e', state: 'planned', icon: 'mail-inbox', title: 'Needs my action, Waiting on others', text: 'Two folders built on durable action records, with a reminder per request. Your corrections survive new mail and new models.' },
  { key: 'f', state: 'planned', icon: 'flow', title: 'Rules in plain English', text: 'A typed proposal in the normal rule editor, with a dry run. Loupe writes the Sieve, never the model.' },
  { key: 'g', state: 'planned', icon: 'copy', title: 'Changes that explain themselves', text: 'On top of the literal diff: what changed in meaning, with both passages shown. Contradictions stay visible instead of being resolved by guesswork.' },
  { key: 'h', state: 'planned', icon: 'document-text', title: 'Documents', text: 'Search inside attachments, key-fact cards linked to their page, version comparison, and a check that your reply includes what was asked for.' },
  { key: 'i', state: 'planned', icon: 'mail-multiple', title: 'Matters', text: 'Group a mortgage, a claim or a move across senders and weeks, by hand first. Suggestions and optional sync come after.' },
];
