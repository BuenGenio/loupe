// Regenerates the favicons and app icons in public/ and src/assets/brand/ from
// the app's own icon. Run after the app icon changes: node scripts/brand-assets.mjs
import sharp from 'sharp';
import { writeFile } from 'node:fs/promises';

const square = new URL('../../app/assets/icon/icon.png', import.meta.url).pathname;
const pub = (name) => new URL(`../public/${name}`, import.meta.url).pathname;
const brand = (name) => new URL(`../src/assets/brand/${name}`, import.meta.url).pathname;

// The tile with the same corner radius as the app's rounded icon (~22.5%).
async function rounded(size) {
  const r = Math.round(size * 0.225);
  const mask = Buffer.from(`<svg width="${size}" height="${size}"><rect width="${size}" height="${size}" rx="${r}" ry="${r}"/></svg>`);
  return sharp(square).resize(size, size).composite([{ input: mask, blend: 'dest-in' }]).png().toBuffer();
}

await writeFile(brand('icon-tile.png'), await rounded(512));
await writeFile(pub('icon-192.png'), await rounded(192));
await writeFile(pub('icon-512.png'), await rounded(512));
await sharp(square).resize(512, 512).png().toFile(pub('icon-maskable-512.png'));
await sharp(square).resize(180, 180).png().toFile(pub('apple-touch-icon.png'));
await writeFile(pub('favicon-32.png'), await rounded(32));

// favicon.ico: an ICO container holding PNG images (supported everywhere since Vista).
const sizes = [16, 32, 48];
const pngs = await Promise.all(sizes.map(rounded));
const header = Buffer.alloc(6 + 16 * sizes.length);
header.writeUInt16LE(0, 0);
header.writeUInt16LE(1, 2);
header.writeUInt16LE(sizes.length, 4);
let offset = header.length;
sizes.forEach((s, i) => {
  const e = 6 + 16 * i;
  header.writeUInt8(s, e);
  header.writeUInt8(s, e + 1);
  header.writeUInt16LE(1, e + 4);
  header.writeUInt16LE(32, e + 6);
  header.writeUInt32LE(pngs[i].length, e + 8);
  header.writeUInt32LE(offset, e + 12);
  offset += pngs[i].length;
});
await writeFile(pub('favicon.ico'), Buffer.concat([header, ...pngs]));
console.log('brand assets written');
