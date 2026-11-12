// The playground's mailbox: the same people as the app's demo data, arranged
// so every operator and every example search finds something.
// f:(dana or ben) -is:read gives the four messages in the search screenshot.
import type { Message } from './search-lang';

const me = 'Sam Rivera <sam@northwind.example>';

export const mailbox: Message[] = [
  {
    from: 'Jordan Lee', email: 'jordan@hey.example', to: me,
    subject: 'Re: Dinner Saturday?', body: '7:30 is perfect. Also I sent you the hike photos, check your inbox!',
    daysAgo: 0, time: '15:22', unread: false, flagged: false, replied: true, tags: ['Personal'], attachments: [],
  },
  {
    from: 'Jordan Lee', email: 'jordan@hey.example', to: me,
    subject: "Photos from Sunday's hike", body: 'Hey! Finally got the photos off my camera. The light on the ridge was unreal.',
    daysAgo: 0, time: '15:08', unread: false, flagged: true, replied: false, tags: ['Personal'], attachments: ['ridge.jpg', 'summit.jpg'],
  },
  {
    from: 'Tracker', email: 'notifications@tracker.northwind.example', to: me,
    subject: '[ATLAS-163] Onboarding: provider logos are blurry', body: 'Ben Walsh resolved the issue. View ATLAS-163 in Tracker.',
    daysAgo: 0, time: '14:49', unread: true, flagged: false, replied: false, tags: ['Work'], attachments: [],
  },
  {
    from: 'Dana Okafor', email: 'dana@northwind.example', to: `${me}, team@northwind.example`,
    subject: 'RE: Atlas Q4 roadmap review', body: 'Thanks all, this is great. Final version attached: I moved sync phase 2 to "tentative".',
    daysAgo: 0, time: '14:25', unread: true, flagged: true, replied: false, tags: ['Important', 'Work'], attachments: ['Atlas-Q4-roadmap.pdf'],
  },
  {
    from: 'Felix Brandt', email: 'felix@brandt.example', to: me,
    subject: 'Re: the closet server', body: 'Yes, still the 2014 laptop, and still with the battery as a free UPS.',
    daysAgo: 0, time: '11:04', unread: true, flagged: false, replied: false, tags: ['Personal'], attachments: [],
  },
  {
    from: 'Ben Walsh', email: 'ben@northwind.example', to: me,
    subject: 'Quick question about the export API', body: 'Hey Sam, quick one: does the export endpoint paginate by cursor or by page number?',
    daysAgo: 0, time: '10:30', unread: true, flagged: false, replied: false, tags: ['Work'], attachments: [],
  },
  {
    from: 'Dana Okafor', email: 'dana@northwind.example', to: me,
    subject: 'Updated invitation: Atlas design review', body: 'Dana Okafor has updated Atlas design review: it starts an hour later.',
    daysAgo: 1, time: '17:40', unread: true, flagged: true, replied: false, tags: ['Work'], attachments: ['invite.ics'],
  },
  {
    from: 'Dana Okafor', email: 'dana.okafor@northwlnd.example', to: me,
    subject: 'Quick favour', body: 'Are you at your desk? I need a quick favour before my 2 pm. Can you pick up six $100 gift cards?',
    daysAgo: 1, time: '09:12', unread: true, flagged: false, replied: false, tags: [], attachments: [],
  },
  {
    from: 'Trailhead Outfitters', email: 'hello@trailhead.example', to: me,
    subject: 'Members: 20% off layers + the autumn layering guide', body: 'Three layers, every trail. Members save 20% on all layers through Sunday.',
    daysAgo: 2, time: '06:02', unread: true, flagged: false, replied: false, tags: ['Newsletter'], attachments: [],
  },
  {
    from: 'Alice Chen', email: 'alice@acme-supplies.example', to: me,
    subject: 'Invoice 2026-0412', body: 'Please find attached invoice 2026-0412 for PO 123. Payment terms: 30 days.',
    daysAgo: 3, time: '12:15', unread: false, flagged: true, replied: true, tags: ['Work', 'To Do'], attachments: ['Invoice-2026-0412.pdf'],
  },
  {
    from: 'Alice Chen', email: 'alice@acme-supplies.example', to: me,
    subject: 'Delivery update', body: 'Good news: your order for PO 123 ships on Thursday.',
    daysAgo: 5, time: '08:47', unread: false, flagged: false, replied: false, tags: ['Work'], attachments: [],
  },
  {
    from: 'Lumen Bank', email: 'statements@lumenbank.example', to: me,
    subject: 'Your October statement is ready', body: 'Your statement for October is attached. Sign in to see all transactions.',
    daysAgo: 6, time: '07:30', unread: false, flagged: false, replied: false, tags: ['Important'], attachments: ['statement-october.pdf'],
  },
  {
    from: 'GitHub', email: 'notifications@github.com', to: me,
    subject: '[loupe] Pull request #42: Faster threading', body: 'Ben Walsh requested your review on pull request #42.',
    daysAgo: 8, time: '16:05', unread: false, flagged: false, replied: false, tags: ['Work'], attachments: [],
  },
  {
    from: 'Nordlicht Books', email: 'news@nordlicht.example', to: me,
    subject: "This week's new arrivals", body: 'Twelve new titles, two signed first editions, and a reading list for rainy weekends.',
    daysAgo: 12, time: '10:00', unread: false, flagged: false, replied: false, tags: ['Newsletter'], attachments: [],
  },
  {
    from: 'Mia Novak', email: 'mia@novak.example', to: me,
    subject: 'Trip photos, finally', body: 'All 300 of them, zipped. The lighthouse ones are my favourites.',
    daysAgo: 410, time: '19:21', unread: false, flagged: false, replied: true, tags: ['Personal', 'Later'], attachments: ['trip-photos.zip'],
  },
];

// Thunderbird's default tag colours, plus a neutral one for custom tags.
export const tagColours: Record<string, string> = {
  Important: '#d93025',
  Work: '#e8710a',
  Personal: '#188038',
  'To Do': '#1a73e8',
  Later: '#8430ce',
};
