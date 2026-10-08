// What Loupe does, as structure only: the words live in src/i18n/<lang>.json
// under highlights.* and groups.*. Keep claims in step with README.md: only
// what ships in the Nightly build.
import type { IconName } from './icons';

export const highlights: { key: string; icon: IconName; docs: string }[] = [
  { key: 'readable', icon: 'reading-mode-mobile', docs: '/docs/reading/' },
  { key: 'search', icon: 'search', docs: '/docs/search/' },
  { key: 'smart', icon: 'mail-multiple', docs: '/docs/smart-mailboxes/' },
  { key: 'rules', icon: 'flow', docs: '/docs/rules/' },
  { key: 'subscriptions', icon: 'news', docs: '/docs/subscriptions/' },
  { key: 'snooze', icon: 'snooze', docs: '/docs/organising/' },
  { key: 'send', icon: 'send-clock', docs: '/docs/writing/' },
  { key: 'encryption', icon: 'shield-lock', docs: '/docs/encryption/' },
  { key: 'phishing', icon: 'shield-checkmark', docs: '/docs/privacy-security/' },
  { key: 'calendar', icon: 'calendar-ltr', docs: '/docs/calendar-invitations/' },
  { key: 'protocols', icon: 'server', docs: '/docs/accounts/' },
  { key: 'tablet', icon: 'tablet', docs: '/docs/tablets-and-keyboards/' },
];

// The "And more" cards on the Features page.
export const extras = ['protocols', 'calendar', 'tablet', 'phishing'];

export const groups: { id: string; shot: string; icons: [IconName, IconName, IconName, IconName] }[] = [
  { id: 'reading', shot: 'reading', icons: ['reading-mode-mobile', 'image-multiple', 'weather-moon', 'text-font'] },
  { id: 'search', shot: 'search', icons: ['search', 'arrow-sync', 'mail-multiple', 'flow'] },
  { id: 'organising', shot: 'organising', icons: ['archive', 'filter', 'tag', 'snooze'] },
  { id: 'subscriptions', shot: 'subscriptions', icons: ['news', 'link-dismiss', 'chat-multiple', 'window-dev-tools'] },
  { id: 'security', shot: 'security', icons: ['lock-closed', 'eye-off', 'link-dismiss', 'key'] },
  { id: 'writing', shot: 'writing', icons: ['person-mail', 'arrow-undo', 'send-clock', 'alert'] },
];

// Providers that work with a password or app password over IMAP/SMTP or JMAP.
// Outlook.com and Microsoft 365 need Microsoft sign-in (builds with an OAuth client ID).
export const providers = ['Gmail', 'iCloud Mail', 'Fastmail', 'Yahoo Mail', 'GMX', 'Posteo', 'mailbox.org', 'Stalwart', 'Dovecot', 'mailcow'];
