// Rasterises the flags the language switcher uses to tiny WebP files in
// public/flags/ (some flag SVGs carry detailed coats of arms; at 20 px a
// bitmap is a fraction of the size). Run after adding a language.
import sharp from 'sharp';
import { mkdir } from 'node:fs/promises';
import { locales } from '../src/i18n/locales.ts';

await mkdir(new URL('../public/flags/', import.meta.url), { recursive: true });
for (const { flag } of locales) {
  const src = new URL(`../node_modules/flag-icons/flags/4x3/${flag}.svg`, import.meta.url).pathname;
  await sharp(src, { density: 300 }).resize(48, 36).webp({ quality: 90 }).toFile(new URL(`../public/flags/${flag}.webp`, import.meta.url).pathname);
}
console.log(`${locales.length} flags written`);
