// llms.txt (https://llmstxt.org): a plain summary of the site for language
// models and the people who ask them about mail apps.
import type { APIRoute } from 'astro';
import { site, contact } from '../config';
import { allDocs } from '../lib/docs';
import { posts, releases, releaseTitle } from '../lib/news';

export const GET: APIRoute = async () => {
  const docs = await allDocs();
  const articles = await posts();
  const rels = await releases();
  const abs = (p: string) => new URL(p, site.url).href;
  const lines = [
    `# ${site.name}`,
    '',
    `> ${site.description}`,
    '',
    'Loupe is an independent, open-source (MPL-2.0) email client for Android, written in Flutter. iOS is planned.',
    'It supports IMAP/SMTP and JMAP, has no servers of its own and collects no data. Key features: Readable mode for HTML mail,',
    'an expression search language, Smart Mailboxes stored on the mail server, device and Sieve server rules, a newsletter',
    'unsubscribe centre, snooze, undo and scheduled send, OpenPGP with Autocrypt, S/MIME, and calendar invitations.',
    'It is not affiliated with Mozilla or Thunderbird; it is compatible with Thunderbird tags and its "Export for Mobile" QR code.',
    '',
    '## Main pages',
    '',
    `- [Features](${abs('/features/')}): what Loupe does`,
    `- [Download](${abs('/download/')}): free nightly APK for Android 7+, pay what you want`,
    `- [Screenshots](${abs('/screenshots/')})`,
    `- [Roadmap](${abs('/roadmap/')}): what has shipped, what's next, and what is not planned`,
    `- [News](${abs('/news/')}): every release and its notes, newest first, plus longer pieces`,
    `- [Development](${abs('/development/')}): architecture, build from source, testing`,
    `- [Privacy policy](${abs('/privacy/')})`,
    `- [Press kit](${abs('/press/')})`,
    `- [Contact](${abs('/contact/')}): ${contact.hello}`,
    `- [Source code](${site.repo})`,
    '',
    '## Documentation',
    '',
    ...docs.map((d) => `- [${d.data.title}](${abs(`/docs/${d.id}/`)}): ${d.data.description}`),
    ...(articles.length ? ['', '## Articles', '', ...articles.map((p) => `- [${p.data.title}](${abs(`/news/${p.id}/`)}): ${p.data.description}`)] : []),
    ...(rels.length ? ['', '## Releases', '', ...rels.map((r) => `- [${releaseTitle(r.data.date)}](${abs(`/news/#${r.id}`)})`)] : []),
    '',
  ];
  return new Response(lines.join('\n'), { headers: { 'Content-Type': 'text/plain; charset=utf-8' } });
};
