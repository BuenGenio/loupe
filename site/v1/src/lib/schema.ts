// schema.org structured data (JSON-LD). Facts only: no invented ratings or
// reviews, which search engines penalise and which Loupe doesn't have yet.
import { site, socials, donate } from '../config';

const abs = (path: string) => new URL(path, site.url).href;

export const organization = () => ({
  '@type': 'Organization',
  '@id': abs('/#organization'),
  name: site.name,
  url: abs('/'),
  logo: { '@type': 'ImageObject', url: abs('/icon-512.png'), width: 512, height: 512 },
  sameAs: socials.filter((s) => s.href).map((s) => s.href),
});

export const website = () => ({
  '@type': 'WebSite',
  '@id': abs('/#website'),
  name: site.name,
  alternateName: 'loupe.mx',
  url: abs('/'),
  inLanguage: site.locale,
  publisher: { '@id': abs('/#organization') },
});

export const softwareApplication = (screenshots: string[] = []) => ({
  '@type': 'MobileApplication',
  '@id': abs('/#app'),
  name: site.name,
  description: site.description,
  url: abs('/'),
  downloadUrl: abs('/download/'),
  operatingSystem: 'Android 7.0 or later',
  applicationCategory: 'CommunicationApplication',
  applicationSubCategory: 'Email client',
  isAccessibleForFree: true,
  license: site.licence.url,
  offers: { '@type': 'Offer', price: '0', priceCurrency: donate.currency },
  image: abs('/icon-512.png'),
  screenshot: screenshots.map(abs),
  author: { '@type': 'Person', name: site.owner.name, url: site.owner.url },
  publisher: { '@id': abs('/#organization') },
  featureList: [
    'Readable mode that rebuilds HTML email to fit the screen',
    'Expression search across the phone and the server',
    'Smart Mailboxes stored on your own mail server',
    'Device rules and server rules (Sieve)',
    'Newsletter unsubscribe centre',
    'Snooze, undo send and scheduled send',
    'OpenPGP with Autocrypt, and S/MIME',
    'IMAP, SMTP and JMAP accounts',
    'Calendar invitations',
    'Encrypted local database, no telemetry',
  ],
});

export const sourceCode = () => ({
  '@type': 'SoftwareSourceCode',
  name: `${site.name} source code`,
  codeRepository: site.repo,
  programmingLanguage: ['Dart', 'Flutter', 'Kotlin'],
  license: site.licence.url,
  targetProduct: { '@id': abs('/#app') },
});

export const breadcrumbs = (items: { name: string; path: string }[]) => ({
  '@type': 'BreadcrumbList',
  itemListElement: items.map((item, i) => ({
    '@type': 'ListItem',
    position: i + 1,
    name: item.name,
    item: abs(item.path),
  })),
});

export const techArticle = (a: { title: string; description: string; path: string; modified?: Date }) => ({
  '@type': 'TechArticle',
  headline: a.title,
  description: a.description,
  url: abs(a.path),
  inLanguage: site.locale,
  ...(a.modified ? { dateModified: a.modified.toISOString() } : {}),
  author: { '@type': 'Person', name: site.owner.name, url: site.owner.url },
  publisher: { '@id': abs('/#organization') },
  about: { '@id': abs('/#app') },
});

export const blogPosting = (p: { title: string; description: string; path: string; date: Date; updated?: Date; image: string }) => ({
  '@type': 'BlogPosting',
  headline: p.title,
  description: p.description,
  url: abs(p.path),
  image: abs(p.image),
  datePublished: p.date.toISOString(),
  dateModified: (p.updated ?? p.date).toISOString(),
  author: { '@type': 'Person', name: site.owner.name, url: site.owner.url },
  publisher: { '@id': abs('/#organization') },
  mainEntityOfPage: abs(p.path),
});

export const faqPage = (items: { question: string; answer: string }[]) => ({
  '@type': 'FAQPage',
  mainEntity: items.map((qa) => ({
    '@type': 'Question',
    name: qa.question,
    acceptedAnswer: { '@type': 'Answer', text: qa.answer },
  })),
});

export const graph = (nodes: object[]) => ({ '@context': 'https://schema.org', '@graph': nodes });
