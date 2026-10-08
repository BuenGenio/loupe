// Open Graph images (1200x630), one per page, rendered at build time with
// satori (layout to SVG) and sharp (SVG to PNG). Shared links on Mastodon,
// Bluesky, Reddit, Slack and the rest show these.
import type { APIRoute, GetStaticPaths } from 'astro';
import { readFile } from 'node:fs/promises';
import { createRequire } from 'node:module';
import { resolve } from 'node:path';
import satori from 'satori';
import sharp from 'sharp';
import { allDocs } from '../../lib/docs';
import { posts } from '../../lib/blog';
import { screenshots } from '../../lib/screenshots';
import { useT, hasStrings } from '../../i18n';
import { otherCodes } from '../../i18n/locales';

type Card = { title: string; kicker: string; shot?: boolean };

// Translated pages take their words from src/i18n/<lang>.json (og.*).
const translated: Record<string, boolean> = { home: true, features: true, screenshots: true, download: true, donate: false, contact: false, press: false };
const card = (lang: string, page: string): Card => {
  const t = useT(lang);
  let kicker = t(`og.${page}.kicker`);
  // The kicker is set in capitals, and Greek capitals carry no accents (browsers do this for lang="el"; satori doesn't).
  if (lang === 'el') kicker = kicker.normalize('NFD').replace(/[\u0301\u0308]/g, '').normalize('NFC');
  return { title: t(`og.${page}.title`), kicker, shot: translated[page] };
};

const englishOnly: Record<string, Card> = {
  docs: { title: 'How to get the most out of Loupe', kicker: 'Documentation' },
  development: { title: 'Built in the open, tested to the bone.', kicker: 'Development' },
  privacy: { title: 'No servers. No tracking.', kicker: 'Privacy policy' },
  blog: { title: 'Notes from the workbench', kicker: 'Blog' },
};

export const getStaticPaths = (async () => {
  const docs = await allDocs();
  const blog = await posts();
  const pages = Object.keys(translated);
  return [
    ...pages.map((route) => ({ params: { route }, props: card('en', route) })),
    ...otherCodes.filter(hasStrings).flatMap((lang) => pages.map((page) => ({ params: { route: `${lang}/${page}` }, props: card(lang, page) }))),
    ...Object.entries(englishOnly).map(([route, c]) => ({ params: { route }, props: c })),
    ...docs.map((d) => ({ params: { route: `docs/${d.id}` }, props: { title: d.data.title, kicker: `Docs · ${d.data.section}` } })),
    ...blog.map((p) => ({ params: { route: `blog/${p.id}` }, props: { title: p.data.title, kicker: 'Blog' } })),
  ];
}) satisfies GetStaticPaths;

// Paths from the site root: this module is bundled before it runs.
const fromRoot = (p: string) => resolve(process.cwd(), p);
const require = createRequire(fromRoot('package.json'));
const font = (pkg: string, file: string) => readFile(require.resolve(`${pkg}/files/${file}`));
// Ubuntu in every script the site's languages use. Each subset is its own
// family, listed as a font-family fallback chain, so Cyrillic and Greek titles
// find their glyphs (satori doesn't fall back between same-named fonts).
const subsets = ['latin', 'latin-ext', 'cyrillic', 'cyrillic-ext', 'greek', 'greek-ext'];
const family = subsets.map((s) => `Ubuntu-${s}`).join(', ');
const fontsPromise = Promise.all(
  [500, 700].flatMap((weight) =>
    subsets.map(async (subset) => ({ name: `Ubuntu-${subset}`, weight: weight as 500 | 700, style: 'normal' as const, data: await font('@fontsource/ubuntu', `ubuntu-${subset}-${weight}-normal.woff`) })),
  ),
);

const dataUri = (buf: Buffer) => `data:image/png;base64,${buf.toString('base64')}`;
const tilePromise = sharp(fromRoot('src/assets/brand/icon-tile.png')).resize(96).png().toBuffer();

let shotCache: Promise<Buffer | null> | undefined;
function heroShot(): Promise<Buffer | null> {
  const s = screenshots.find((x) => x.slug === 'search-hero') ?? screenshots.find((x) => x.device === 'phone');
  if (!s) return Promise.resolve(null);
  const file = fromRoot(`src/assets/screenshots/${s.file}`);
  const r = 44;
  const mask = Buffer.from(`<svg width="330" height="714"><rect width="330" height="714" rx="${r}" ry="${r}"/></svg>`);
  return sharp(file).resize(330, 714).composite([{ input: mask, blend: 'dest-in' }]).png().toBuffer().catch(() => null);
}

const h = (type: string, style: Record<string, unknown>, children?: unknown) => ({ type, props: { style, children } });

export const GET: APIRoute = async ({ props }) => {
  const { title, kicker, shot } = props as Card;
  const fonts = await fontsPromise;
  const tile = dataUri(await tilePromise);
  const phone = shot ? await (shotCache ??= heroShot()) : null;

  const size = title.length > 56 ? 52 : title.length > 40 ? 60 : title.length > 26 ? 68 : 80;

  const tree = h(
    'div',
    {
      width: '100%',
      height: '100%',
      display: 'flex',
      position: 'relative',
      overflow: 'hidden',
      background: 'linear-gradient(150deg, #0c2238 0%, #071628 60%, #0a2a3a 100%)',
      fontFamily: family,
      color: '#e6eef5',
    },
    [
      // The lens: concentric rings in the brand teal.
      h('div', {
        position: 'absolute',
        right: phone ? -40 : -120,
        top: phone ? -60 : -110,
        width: 640,
        height: 640,
        borderRadius: 9999,
        border: '26px solid #0f8494',
        boxShadow: '0 0 0 6px #43c3cd33, inset 0 0 0 4px #dce8ee55',
        background: 'radial-gradient(circle at 35% 30%, #d4ebf833 0%, #0b7f8e22 45%, transparent 70%)',
      }),
      h(
        'div',
        { display: 'flex', flexDirection: 'column', justifyContent: 'space-between', padding: '64px 72px', width: phone ? 780 : 1060, height: '100%' },
        [
          h('div', { display: 'flex', alignItems: 'center', gap: 20 }, [
            { type: 'img', props: { src: tile, width: 64, height: 64, style: { borderRadius: 15 } } },
            h('div', { fontSize: 44, fontWeight: 500, color: '#ffffff', letterSpacing: -1 }, 'Loupe'),
          ]),
          h('div', { display: 'flex', flexDirection: 'column', gap: 18 }, [
            h('div', { fontSize: 26, fontWeight: 700, color: '#74d8e0', letterSpacing: 2, textTransform: 'uppercase' }, kicker),
            h('div', { fontSize: size, fontWeight: 500, lineHeight: 1.08, color: '#ffffff', letterSpacing: -1.5, maxWidth: phone ? 640 : 620 }, title),
          ]),
          h('div', { display: 'flex', fontSize: 26, color: '#b4c3d1' }, 'loupe.mx'),
        ],
      ),
      phone
        ? h('div', { position: 'absolute', right: 70, top: 70, display: 'flex', padding: 10, borderRadius: 54, background: '#0d1724', boxShadow: '0 30px 60px #00000080' }, [
            { type: 'img', props: { src: dataUri(phone), width: 330, height: 714, style: { borderRadius: 44 } } },
          ])
        : null,
    ].filter(Boolean),
  );

  const svg = await satori(tree as never, {
    width: 1200,
    height: 630,
    fonts,
  });
  const png = await sharp(Buffer.from(svg)).png({ compressionLevel: 9 }).toBuffer();
  return new Response(new Uint8Array(png), { headers: { 'Content-Type': 'image/png' } });
};
