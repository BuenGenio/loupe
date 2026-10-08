// Renders the social images listed in cards.json to marketing/media/<file>.jpg
// (1080x1350, the 4:5 portrait size Instagram, Threads, Bluesky and Mastodon
// all show well). Uses the website's screenshots and the brand fonts.
//
//   npm run cards                 render everything
//   npm run cards:one -- <id>     render one card
//
// Card types: statement, screen, tip. See cards.json for the fields.
import { readFile, mkdir, writeFile } from 'node:fs/promises';
import { createRequire } from 'node:module';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import satori from 'satori';
import sharp from 'sharp';

const here = dirname(fileURLToPath(import.meta.url));
const repo = resolve(here, '../..');
const media = resolve(here, '../media');
const shots = join(repo, 'site/src/assets/screenshots');
const tilePath = join(repo, 'site/src/assets/brand/icon-tile.png');
const require = createRequire(import.meta.url);

const W = 1080;
const H = 1350;
const C = {
  navy: '#0c2238',
  navy2: '#071628',
  teal: '#0b7f8e',
  ring: '#0f8494',
  aqua: '#74d8e0',
  ink: '#0a1a2b',
  ink2: '#3a4b5e',
  mist: '#b4c3d1',
  glass: '#d4ebf8',
  paper: '#f6f8fa',
};

const font = (pkg, file) => readFile(require.resolve(`${pkg}/files/${file}`));
// The brand face: Ubuntu (Light text, Medium headlines) and Ubuntu Mono.
const fonts = [
  { name: 'Ubuntu', data: await font('@fontsource/ubuntu', 'ubuntu-latin-300-normal.woff'), weight: 300, style: 'normal' },
  { name: 'Ubuntu', data: await font('@fontsource/ubuntu', 'ubuntu-latin-500-normal.woff'), weight: 500, style: 'normal' },
  { name: 'Ubuntu', data: await font('@fontsource/ubuntu', 'ubuntu-latin-700-normal.woff'), weight: 700, style: 'normal' },
  { name: 'Mono', data: await font('@fontsource/ubuntu-mono', 'ubuntu-mono-latin-400-normal.woff'), weight: 400, style: 'normal' },
];

const uri = (buf) => `data:image/png;base64,${buf.toString('base64')}`;
const tile = uri(await sharp(tilePath).resize(112).png().toBuffer());

async function phone(file, width) {
  const meta = await sharp(join(shots, file)).metadata();
  const height = Math.round((meta.height / meta.width) * width);
  const r = Math.round(width * 0.12);
  const mask = Buffer.from(`<svg width="${width}" height="${height}"><rect width="${width}" height="${height}" rx="${r}" ry="${r}"/></svg>`);
  const png = await sharp(join(shots, file)).resize(width, height).composite([{ input: mask, blend: 'dest-in' }]).png().toBuffer();
  return { src: uri(png), width, height, radius: r };
}

const h = (type, style, children) => ({ type, props: { style: { display: 'flex', ...style }, children } });
const img = (src, width, height, style = {}) => ({ type: 'img', props: { src, width, height, style } });

function brand(dark) {
  return h('div', { alignItems: 'center', gap: 18 }, [
    img(tile, 64, 64, { borderRadius: 15 }),
    h('div', { fontWeight: 500, fontSize: 44, color: dark ? '#ffffff' : C.ink, letterSpacing: -1 }, 'Loupe'),
  ]);
}

function footer(dark, text = 'loupe.mx') {
  return h('div', { fontSize: 30, color: dark ? C.mist : C.ink2, fontWeight: 500 }, text);
}

function lensRing(style) {
  return h('div', {
    position: 'absolute',
    width: 760,
    height: 760,
    borderRadius: 9999,
    border: `30px solid ${C.ring}`,
    boxShadow: '0 0 0 8px #43c3cd33, inset 0 0 0 5px #dce8ee55',
    background: 'radial-gradient(circle at 35% 30%, #d4ebf833 0%, #0b7f8e22 45%, transparent 70%)',
    ...style,
  });
}

function headlineSize(text, base) {
  const n = text.length;
  return n > 60 ? base * 0.72 : n > 40 ? base * 0.84 : base;
}

async function statement(card) {
  return h(
    'div',
    { width: W, height: H, position: 'relative', overflow: 'hidden', background: `linear-gradient(155deg, ${C.navy} 0%, ${C.navy2} 60%, #0a2a3a 100%)`, color: '#fff', fontFamily: 'Ubuntu' },
    [
      lensRing({ right: -260, top: -200 }),
      h('div', { flexDirection: 'column', justifyContent: 'space-between', width: '100%', height: '100%', padding: '80px 84px' }, [
        brand(true),
        h('div', { flexDirection: 'column', gap: 28 }, [
          card.kicker ? h('div', { fontSize: 30, fontWeight: 700, color: C.aqua, letterSpacing: 3, textTransform: 'uppercase' }, card.kicker) : null,
          h('div', { fontWeight: 500, fontSize: headlineSize(card.headline, 112), lineHeight: 1.04, letterSpacing: -2.5, maxWidth: 900 }, card.headline),
          card.sub ? h('div', { fontSize: 38, fontWeight: 300, lineHeight: 1.4, color: C.mist, maxWidth: 860 }, card.sub) : null,
        ].filter(Boolean)),
        footer(true, card.footer),
      ]),
    ],
  );
}

async function screen(card) {
  const dark = card.theme === 'dark';
  const shot = await phone(card.shot, card.wide ? 900 : 600);
  const bg = dark
    ? `linear-gradient(160deg, ${C.navy} 0%, ${C.navy2} 100%)`
    : `linear-gradient(165deg, ${C.paper} 0%, ${C.glass} 100%)`;
  const frame = card.wide ? 18 : 16;
  return h('div', { width: W, height: H, position: 'relative', overflow: 'hidden', background: bg, fontFamily: 'Ubuntu', flexDirection: 'column', alignItems: 'center' }, [
    lensRing({ left: -380, bottom: -420, opacity: dark ? 1 : 0.35 }),
    h('div', { flexDirection: 'column', width: '100%', padding: '72px 84px 0', gap: 22 }, [
      h('div', { justifyContent: 'space-between', alignItems: 'center' }, [
        brand(dark),
        card.step ? h('div', { fontSize: 28, fontWeight: 700, color: dark ? C.aqua : C.teal }, card.step) : null,
      ].filter(Boolean)),
      card.kicker ? h('div', { marginTop: 18, fontSize: 28, fontWeight: 700, color: dark ? C.aqua : C.teal, letterSpacing: 3, textTransform: 'uppercase' }, card.kicker) : null,
      h('div', { fontWeight: 500, fontSize: headlineSize(card.headline, 78), lineHeight: 1.06, letterSpacing: -1.5, color: dark ? '#fff' : C.ink }, card.headline),
      card.sub ? h('div', { fontSize: 32, fontWeight: 300, lineHeight: 1.4, color: dark ? C.mist : C.ink2 }, card.sub) : null,
    ].filter(Boolean)),
    h('div', { position: 'absolute', left: Math.round((W - shot.width - 2 * frame) / 2), top: card.wide ? 640 : card.sub ? 600 : 520, padding: frame, borderRadius: shot.radius + frame, background: '#0d1724', boxShadow: '0 40px 80px #0a1a2b55' }, [
      img(shot.src, shot.width, shot.height, { borderRadius: shot.radius }),
    ]),
  ]);
}

async function tip(card) {
  return h(
    'div',
    { width: W, height: H, position: 'relative', overflow: 'hidden', background: `linear-gradient(155deg, ${C.navy} 0%, ${C.navy2} 70%)`, color: '#fff', fontFamily: 'Ubuntu' },
    [
      lensRing({ right: -300, bottom: -330 }),
      h('div', { flexDirection: 'column', justifyContent: 'space-between', width: '100%', height: '100%', padding: '80px 84px' }, [
        brand(true),
        h('div', { flexDirection: 'column', gap: 34 }, [
          h('div', { fontSize: 30, fontWeight: 700, color: C.aqua, letterSpacing: 3, textTransform: 'uppercase' }, card.kicker ?? 'Search tip'),
          h('div', { fontWeight: 500, fontSize: headlineSize(card.headline, 84), lineHeight: 1.06, letterSpacing: -1.5 }, card.headline),
          h('div', { alignItems: 'center', gap: 20, padding: '30px 34px', borderRadius: 28, background: '#ffffff12', border: '2px solid #ffffff22' }, [
            h('div', { width: 30, height: 30, borderRadius: 999, border: `4px solid ${C.aqua}` }),
            // Ubuntu Mono advances 0.5 em per character; keep the expression on one line.
            h('div', { fontFamily: 'Mono', fontSize: Math.min(48, Math.floor(770 / (0.5 * card.expr.length))), color: '#ffffff', whiteSpace: 'nowrap' }, card.expr),
          ]),
          card.chips
            ? h('div', { flexWrap: 'wrap', gap: 14 }, card.chips.map((c) =>
                h('div', { padding: '10px 22px', borderRadius: 999, background: '#0e2f38', border: `2px solid ${C.ring}`, fontSize: 28, color: C.aqua, fontWeight: 700 }, c),
              ))
            : null,
          card.sub ? h('div', { fontSize: 34, fontWeight: 300, lineHeight: 1.45, color: C.mist }, card.sub) : null,
        ].filter(Boolean)),
        footer(true, card.footer ?? 'loupe.mx/docs/search-language'),
      ]),
    ],
  );
}

const renderers = { statement, screen, tip };

const only = process.argv[2] === '--only' ? process.argv[3] : process.argv[2];
const cards = JSON.parse(await readFile(join(here, 'cards.json'), 'utf8')).cards.filter((c) => !only || c.id === only);
for (const card of cards) {
  const tree = await renderers[card.type](card);
  const svg = await satori(tree, { width: W, height: H, fonts });
  const out = join(media, `${card.file ?? card.id}.jpg`);
  await mkdir(dirname(out), { recursive: true });
  await writeFile(out, await sharp(Buffer.from(svg)).jpeg({ quality: 88, mozjpeg: true }).toBuffer());
  console.log(`✓ ${out.slice(repo.length + 1)}`);
}
