// Writes the Google Play store listing for every language Play supports into
// app/android/fastlane/metadata/android/<locale>/ (fastlane supply's layout):
// title, short and full description from the website's translations
// (site/src/i18n), a localised feature graphic, framed phone screenshots with
// localised captions, tablet screenshots and the 512 px icon.
//
//   cd marketing/creative && npm ci && npm run play            texts and images
//   node play.mjs --images-only                                  images only (CI)
//
// The texts are committed (edit the site's translations, or the files, then
// review the diff); the images are git-ignored and regenerated from the
// screenshots by .github/workflows/play-listing.yml.
import { readFile, mkdir, writeFile, rm } from 'node:fs/promises';
import { createRequire } from 'node:module';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import satori from 'satori';
import sharp from 'sharp';

const here = dirname(fileURLToPath(import.meta.url));
const repo = resolve(here, '../..');
const i18n = join(repo, 'site/src/i18n');
const shots = join(repo, 'site/src/assets/screenshots');
const out = join(repo, 'app/android/fastlane/metadata/android');
const require = createRequire(import.meta.url);

// Site language → Play listing locale. Bosnian, Irish, Luxembourgish, Maltese
// and Welsh have no Play listing language (checked 2026-10-08).
const PLAY = {
  en: ['en-US', 'en-GB'], es: ['es-ES'], de: ['de-DE'], fr: ['fr-FR'], it: ['it-IT'], uk: ['uk'], sq: ['sq'], bg: ['bg'],
  ca: ['ca'], hr: ['hr'], cs: ['cs-CZ'], da: ['da-DK'], nl: ['nl-NL'], et: ['et'], fi: ['fi-FI'], gl: ['gl-ES'], el: ['el-GR'],
  hu: ['hu-HU'], is: ['is-IS'], lv: ['lv'], lt: ['lt'], mk: ['mk-MK'], nb: ['no-NO'], pl: ['pl-PL'], pt: ['pt-PT'], ro: ['ro'],
  sr: ['sr'], sk: ['sk'], sl: ['sl'], sv: ['sv-SE'], tr: ['tr-TR'], eu: ['eu-ES'],
};

const SHOTS = ['search-hero', 'inbox', 'newsletter', 'subscriptions', 'phishing', 'rules', 'invitation', 'inbox-dark'];
const HIGHLIGHTS = ['readable', 'search', 'smart', 'rules', 'subscriptions', 'snooze', 'send', 'encryption', 'phishing', 'calendar', 'protocols', 'tablet'];

const en = JSON.parse(await readFile(join(i18n, 'en.json'), 'utf8'));
const get = (dict, key) => key.split('.').reduce((n, k) => (n && typeof n === 'object' ? n[k] : undefined), dict);
const tr = (dict) => (key, vars = {}) => {
  const v = get(dict, key) ?? get(en, key) ?? key;
  return v.replace(/\{(\w+)\}/g, (m, k) => (k in vars ? String(vars[k]) : m));
};
const stripTags = (s) => s.replace(/<[^>]+>/g, '');
const fit = (s, max) => (s.length <= max ? s : `${s.slice(0, max - 1).replace(/\s+\S*$/, '')}…`);

// ---------------------------------------------------------------- text

function listing(t) {
  const tagline = stripTags(t('og.home.title')).replace(/[.。]$/, '');
  const titleFull = `Loupe: ${tagline}`;
  const title = titleFull.length <= 30 ? titleFull : 'Loupe';
  const kicker = t('og.home.kicker');
  const both = `${kicker} · ${t('home.fact1')}`;
  const short = both.length <= 80 ? both : fit(kicker, 80);
  const bullets = HIGHLIGHTS.map((k) => `• ${t(`highlights.${k}.title`)}: ${t(`highlights.${k}.text`)}`).join('\n');
  const full = [
    t('home.lead'),
    `${t('home.pillarsTitle')}\n${bullets}`,
    `${t('home.privacyTitle')}\n${t('home.privacyLead')}`,
    `${t('home.openTitle')}\n${t('home.openLead', { licence: 'MPL-2.0' })}`,
    `${t('common.appEnglish')}\nhttps://loupe.mx`,
  ].join('\n\n');
  return { title, short, full: fit(full, 4000) };
}

// ---------------------------------------------------------------- images

const subsets = ['latin', 'latin-ext', 'cyrillic', 'cyrillic-ext', 'greek', 'greek-ext'];
const family = subsets.map((s) => `U-${s}`).join(', ');
const fonts = [];
for (const weight of [300, 500, 700])
  for (const subset of subsets)
    fonts.push({ name: `U-${subset}`, weight, style: 'normal', data: await readFile(require.resolve(`@fontsource/ubuntu/files/ubuntu-${subset}-${weight}-normal.woff`)) });

const C = { navy: '#0c2238', navy2: '#071628', ring: '#0f8494', aqua: '#74d8e0', mist: '#b4c3d1', ink: '#0a1a2b', ink2: '#3a4b5e', glass: '#d4ebf8', paper: '#f6f8fa' };
const uri = (buf) => `data:image/png;base64,${buf.toString('base64')}`;
const h = (type, style, children) => ({ type, props: { style: { display: 'flex', ...style }, children } });
const img = (src, width, height, style = {}) => ({ type: 'img', props: { src, width, height, style } });
const tile = uri(await sharp(join(repo, 'site/src/assets/brand/icon-tile.png')).resize(128).png().toBuffer());

async function phone(file, width) {
  const meta = await sharp(join(shots, file)).metadata();
  const height = Math.round((meta.height / meta.width) * width);
  const r = Math.round(width * 0.12);
  const mask = Buffer.from(`<svg width="${width}" height="${height}"><rect width="${width}" height="${height}" rx="${r}" ry="${r}"/></svg>`);
  const png = await sharp(join(shots, file)).resize(width, height).composite([{ input: mask, blend: 'dest-in' }]).png().toBuffer();
  return { src: uri(png), width, height, radius: r };
}

const ring = (style) =>
  h('div', { position: 'absolute', borderRadius: 9999, border: `28px solid ${C.ring}`, boxShadow: '0 0 0 8px #43c3cd33', ...style });

async function render(tree, width, height) {
  const svg = await satori(tree, { width, height, fonts });
  return sharp(Buffer.from(svg)).flatten({ background: C.navy }).png({ compressionLevel: 9 }).toBuffer();
}

async function featureGraphic(t) {
  const shot = await phone('search-hero.png', 300);
  return render(
    h('div', { width: 1024, height: 500, position: 'relative', overflow: 'hidden', background: `linear-gradient(150deg, ${C.navy} 0%, ${C.navy2} 70%)`, fontFamily: family, color: '#fff' }, [
      ring({ width: 560, height: 560, right: -90, top: -150 }),
      h('div', { flexDirection: 'column', justifyContent: 'center', gap: 22, padding: '0 56px', width: 640, height: '100%' }, [
        h('div', { alignItems: 'center', gap: 16 }, [img(tile, 64, 64, { borderRadius: 15 }), h('div', { fontSize: 46, fontWeight: 500 }, 'Loupe')]),
        h('div', { fontSize: stripTags(t('og.home.title')).length > 28 ? 46 : 58, fontWeight: 500, lineHeight: 1.08, letterSpacing: -1 }, stripTags(t('og.home.title'))),
        h('div', { fontSize: 24, fontWeight: 300, color: C.mist }, t('og.home.kicker')),
      ]),
      h('div', { position: 'absolute', right: 70, top: 50, padding: 10, borderRadius: shot.radius + 10, background: '#0d1724' }, [img(shot.src, shot.width, shot.height, { borderRadius: shot.radius })]),
    ]),
    1024,
    500,
  );
}

async function screenshot(t, slug) {
  const dark = slug.endsWith('-dark');
  const shot = await phone(`${slug}.png`, 820);
  const title = t(`shots.${slug.replace(/-dark$/, '')}.title`);
  return render(
    h('div', {
      width: 1080, height: 1920, position: 'relative', overflow: 'hidden', flexDirection: 'column', alignItems: 'center', fontFamily: family,
      background: dark ? `linear-gradient(165deg, ${C.navy} 0%, ${C.navy2} 100%)` : `linear-gradient(165deg, ${C.paper} 0%, ${C.glass} 100%)`,
    }, [
      ring({ width: 900, height: 900, left: -420, bottom: -380, opacity: dark ? 1 : 0.3 }),
      h('div', { flexDirection: 'column', alignItems: 'center', width: '100%', padding: '110px 80px 0', gap: 18 }, [
        h('div', { alignItems: 'center', gap: 14 }, [img(tile, 52, 52, { borderRadius: 12 }), h('div', { fontSize: 36, fontWeight: 500, color: dark ? '#fff' : C.ink }, 'Loupe')]),
        h('div', { fontSize: title.length > 26 ? 66 : 80, fontWeight: 500, lineHeight: 1.08, letterSpacing: -1.5, color: dark ? '#fff' : C.ink, textAlign: 'center', justifyContent: 'center' }, title),
      ]),
      h('div', { position: 'absolute', left: Math.round((1080 - shot.width - 32) / 2), top: 470, padding: 16, borderRadius: shot.radius + 16, background: '#0d1724', boxShadow: '0 40px 80px #0a1a2b55' }, [
        img(shot.src, shot.width, shot.height, { borderRadius: shot.radius }),
      ]),
    ]),
    1080,
    1920,
  );
}

// ---------------------------------------------------------------- write

const imagesOnly = process.argv.includes('--images-only');
const icon = await sharp(join(repo, 'app/assets/icon/icon.png')).resize(512, 512).png().toBuffer();
const jpeg = (buf) => sharp(buf).flatten({ background: '#ffffff' }).jpeg({ quality: 88, mozjpeg: true }).toBuffer();
const tablet = [await jpeg(join(shots, 'tablet.png')), await jpeg(join(shots, 'tablet-dark.png'))];
const report = [];

for (const [lang, locales] of Object.entries(PLAY)) {
  const dict = lang === 'en' ? en : JSON.parse(await readFile(join(i18n, `${lang}.json`), 'utf8'));
  const t = tr(dict);
  const text = listing(t);
  const feature = await featureGraphic(t);
  const phones = [];
  for (const slug of SHOTS) phones.push(await jpeg(await screenshot(t, slug)));
  for (const locale of locales) {
    const dir = join(out, locale);
    await rm(join(dir, 'images'), { recursive: true, force: true });
    await mkdir(join(dir, 'images/phoneScreenshots'), { recursive: true });
    if (!imagesOnly) {
      await writeFile(join(dir, 'title.txt'), `${text.title}\n`);
      await writeFile(join(dir, 'short_description.txt'), `${text.short}\n`);
      await writeFile(join(dir, 'full_description.txt'), `${text.full}\n`);
    }
    await writeFile(join(dir, 'images/featureGraphic.png'), feature);
    for (const [i, png] of phones.entries()) await writeFile(join(dir, `images/phoneScreenshots/${i + 1}.jpg`), png);
    // Play shows the default language's graphics where a language has none.
    if (locale === 'en-US') {
      await mkdir(join(dir, 'images/tenInchScreenshots'), { recursive: true });
      await writeFile(join(dir, 'images/icon.png'), icon);
      for (const [i, png] of tablet.entries()) await writeFile(join(dir, `images/tenInchScreenshots/${i + 1}.jpg`), png);
    }
    report.push(`${locale.padEnd(6)} title ${String(text.title.length).padStart(2)}/30  short ${String(text.short.length).padStart(2)}/80  full ${String(text.full.length).padStart(4)}/4000  "${text.title}"`);
  }
}
await mkdir(join(out, 'en-US/changelogs'), { recursive: true });
if (!imagesOnly) await writeFile(join(out, 'en-US/changelogs/default.txt'), 'Nightly build from the main branch. What changed: https://github.com/BuenGenio/loupe/blob/main/CHANGELOG.md\n');
console.log(report.join('\n'));
