// Site-wide settings. Everything an owner may want to change without touching
// page code lives here: URLs, contact addresses, social handles, donations.

export const site = {
  name: 'Loupe',
  url: 'https://loupe.mx',
  tagline: 'Simple on the surface. Powerful underneath.',
  description:
    'Loupe is a free, open-source mail app for Android: as calm as Apple Mail, with Thunderbird-grade search, rules and encryption. No tracking, no servers.',
  locale: 'en',
  themeColor: { light: '#f6f8fa', dark: '#06121e' },
  // Shown as the publisher in structured data and the privacy policy.
  owner: { name: 'BuenGenio', url: 'https://github.com/BuenGenio' },
  repo: 'https://github.com/BuenGenio/loupe',
  licence: { name: 'MPL-2.0', url: 'https://www.mozilla.org/MPL/2.0/' },
  // Cloudflare Web Analytics beacon token (cookieless). Empty = no analytics.
  analyticsToken: '',
};

export const contact = {
  hello: 'hello@loupe.mx',
  security: 'security@loupe.mx',
  press: 'hello@loupe.mx',
  issues: `${site.repo}/issues`,
  discussions: `${site.repo}/discussions`,
};

// Profiles that exist. Leave href empty to hide a network everywhere.
export const socials: { name: string; handle: string; href: string; icon: string }[] = [
  { name: 'GitHub', handle: 'BuenGenio/loupe', href: site.repo, icon: 'github' },
  { name: 'Bluesky', handle: '@loupe.mx', href: '', icon: 'bluesky' },
  { name: 'Mastodon', handle: '@loupe@fosstodon.org', href: '', icon: 'mastodon' },
  { name: 'Instagram', handle: '@loupemail', href: '', icon: 'instagram' },
  { name: 'TikTok', handle: '@loupemail', href: '', icon: 'tiktok' },
  { name: 'YouTube', handle: '@loupemail', href: '', icon: 'youtube' },
  { name: 'Reddit', handle: 'r/LoupeMail', href: '', icon: 'reddit' },
];

export const downloads = {
  release: `${site.repo}/releases/tag/nightly`,
  // Served by worker/index.ts: a 302 to the current Nightly asset on GitHub.
  arm64: '/get/android-arm64',
  x86_64: '/get/android-x86_64',
  info: '/api/release.json',
};

// Pay what you want before downloading (the "donation wall").
//
// Create one Stripe Payment Link per amount (a fixed price) and one with
// "Customers choose what to pay" for `custom`. In each link's settings set
// "After payment" → "Don't show confirmation page" → redirect to
//   https://loupe.mx/thanks/
// Stripe passes the link's utm_* parameters on to that page; the wall adds
// utm_content=download, so /thanks/ knows to start the download.
// Tiers without an href are hidden in production builds (and marked in dev),
// so the page never shows a button that goes nowhere.
export const donate = {
  currency: 'USD',
  symbol: '$',
  // `note` is a key in src/i18n/<lang>.json.
  tiers: [
    { amount: 3, note: 'wall.tier3', href: '' },
    { amount: 7, note: 'wall.tier7', href: '', suggested: true },
    { amount: 15, note: 'wall.tier15', href: '' },
    { amount: 30, note: 'wall.tier30', href: '' },
  ],
  custom: { href: '' },
  // Other ways to give, shown under the wall and on /donate/.
  alternatives: [
    { name: 'GitHub Sponsors', href: '', note: 'Monthly or one-off, no fees for the developer.' },
    { name: 'Liberapay', href: '', note: 'Recurring donations, run by a non-profit.' },
    { name: 'Ko-fi', href: '', note: 'One-off tips with PayPal or card.' },
  ],
};

// Labels are keys in src/i18n/<lang>.json; hrefs are localized where the page
// exists in the visitor's language (src/i18n/locales.ts, translatedPaths).
export const nav = [
  { href: '/features/', label: 'nav.features' },
  { href: '/screenshots/', label: 'nav.screenshots' },
  { href: '/docs/', label: 'nav.docs' },
  { href: '/roadmap/', label: 'nav.roadmap' },
  { href: '/development/', label: 'nav.development' },
  { href: '/blog/', label: 'nav.blog' },
];

export const footerNav = [
  {
    title: 'footer.product',
    links: [
      { href: '/features/', label: 'footer.features' },
      { href: '/screenshots/', label: 'footer.screenshots' },
      { href: '/download/', label: 'footer.download' },
      { href: '/donate/', label: 'footer.support' },
    ],
  },
  {
    title: 'footer.learn',
    links: [
      { href: '/docs/', label: 'footer.documentation' },
      { href: '/docs/search-language/', label: 'footer.searchLanguage' },
      { href: '/docs/faq/', label: 'footer.faq' },
      { href: '/blog/', label: 'footer.blog' },
    ],
  },
  {
    title: 'footer.project',
    links: [
      { href: '/development/', label: 'footer.development' },
      { href: '/roadmap/', label: 'footer.roadmap' },
      { href: site.repo, label: 'footer.source' },
      { href: '/press/', label: 'footer.press' },
    ],
  },
  {
    title: 'footer.contact',
    links: [
      { href: '/contact/', label: 'footer.contactPage' },
      { href: '/privacy/', label: 'footer.privacy' },
      { href: `mailto:${contact.security}`, label: 'footer.vulnerability' },
    ],
  },
];
