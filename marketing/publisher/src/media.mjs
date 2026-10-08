// Media helpers: kind and MIME type from the file name, and pixel dimensions
// read straight from the file header (PNG, JPEG, GIF, WebP, MP4/MOV) so
// Bluesky gets an aspect ratio without an image library.

import { readFileSync } from 'node:fs';
import { basename } from 'node:path';

const MIME = {
  png: 'image/png',
  jpg: 'image/jpeg',
  jpeg: 'image/jpeg',
  gif: 'image/gif',
  webp: 'image/webp',
  avif: 'image/avif',
  mp4: 'video/mp4',
  m4v: 'video/mp4',
  mov: 'video/quicktime',
  webm: 'video/webm',
};

function extension(src) {
  const path = /^https?:\/\//i.test(src) ? new URL(src).pathname : src;
  const m = path.toLowerCase().match(/\.([a-z0-9]+)$/);
  return m ? m[1] : '';
}

export function mimeType(src) {
  return MIME[extension(src)] ?? 'application/octet-stream';
}

export function mediaKind(src) {
  const mime = mimeType(src);
  if (mime.startsWith('image/')) return 'image';
  if (mime.startsWith('video/')) return 'video';
  return 'unknown';
}

/** Reads a local file or downloads an https URL. Returns { bytes, mime, name }. */
export async function loadMedia(src, { fetch = globalThis.fetch, isUrl = /^https?:\/\//i.test(src) } = {}) {
  if (!isUrl) {
    return { bytes: new Uint8Array(readFileSync(src)), mime: mimeType(src), name: basename(src) };
  }
  const res = await fetch(src);
  if (!res.ok) throw new Error(`downloading ${src}: HTTP ${res.status}`);
  const bytes = new Uint8Array(await res.arrayBuffer());
  const mime = res.headers.get('content-type')?.split(';')[0] || mimeType(src);
  return { bytes, mime, name: basename(new URL(src).pathname) || 'media' };
}

/** { width, height } from an image or MP4/MOV header, or null if unknown. */
export function dimensions(bytes) {
  const b = bytes instanceof Uint8Array ? bytes : new Uint8Array(bytes);
  const dv = new DataView(b.buffer, b.byteOffset, b.byteLength);
  try {
    // PNG: IHDR width/height at 16 and 20
    if (b[0] === 0x89 && b[1] === 0x50 && b[2] === 0x4e && b[3] === 0x47) {
      return { width: dv.getUint32(16), height: dv.getUint32(20) };
    }
    // GIF
    if (b[0] === 0x47 && b[1] === 0x49 && b[2] === 0x46) {
      return { width: dv.getUint16(6, true), height: dv.getUint16(8, true) };
    }
    // JPEG: walk segments to the first SOFn
    if (b[0] === 0xff && b[1] === 0xd8) {
      let i = 2;
      while (i + 9 < b.length) {
        if (b[i] !== 0xff) {
          i++;
          continue;
        }
        const marker = b[i + 1];
        if (marker === 0xd8 || marker === 0x01 || (marker >= 0xd0 && marker <= 0xd7)) {
          i += 2;
          continue;
        }
        const len = dv.getUint16(i + 2);
        if (marker >= 0xc0 && marker <= 0xcf && ![0xc4, 0xc8, 0xcc].includes(marker)) {
          return { height: dv.getUint16(i + 5), width: dv.getUint16(i + 7) };
        }
        i += 2 + len;
      }
      return null;
    }
    // WebP
    if (ascii(b, 0, 4) === 'RIFF' && ascii(b, 8, 4) === 'WEBP') {
      const chunk = ascii(b, 12, 4);
      if (chunk === 'VP8X') return { width: 1 + read24(b, 24), height: 1 + read24(b, 27) };
      if (chunk === 'VP8 ') return { width: dv.getUint16(26, true) & 0x3fff, height: dv.getUint16(28, true) & 0x3fff };
      if (chunk === 'VP8L') {
        const bits = dv.getUint32(21, true);
        return { width: (bits & 0x3fff) + 1, height: ((bits >> 14) & 0x3fff) + 1 };
      }
      return null;
    }
    // ISO BMFF (MP4/MOV): moov > trak (with a 'vide' handler) > tkhd
    if (ascii(b, 4, 4) === 'ftyp') return mp4Dimensions(b, dv);
  } catch {
    return null;
  }
  return null;
}

function ascii(b, at, n) {
  return String.fromCharCode(...b.subarray(at, at + n));
}

function read24(b, at) {
  return b[at] | (b[at + 1] << 8) | (b[at + 2] << 16);
}

function* boxes(dv, start, end) {
  let i = start;
  while (i + 8 <= end) {
    let size = dv.getUint32(i);
    const type = String.fromCharCode(dv.getUint8(i + 4), dv.getUint8(i + 5), dv.getUint8(i + 6), dv.getUint8(i + 7));
    let header = 8;
    if (size === 1) {
      size = Number(dv.getBigUint64(i + 8));
      header = 16;
    } else if (size === 0) {
      size = end - i;
    }
    if (size < header) return;
    yield { type, start: i + header, end: Math.min(i + size, end) };
    i += size;
  }
}

function mp4Dimensions(b, dv) {
  for (const moov of boxes(dv, 0, b.length)) {
    if (moov.type !== 'moov') continue;
    for (const trak of boxes(dv, moov.start, moov.end)) {
      if (trak.type !== 'trak') continue;
      let tkhd = null;
      let isVideo = false;
      for (const child of boxes(dv, trak.start, trak.end)) {
        if (child.type === 'tkhd') tkhd = child;
        if (child.type === 'mdia') {
          for (const m of boxes(dv, child.start, child.end)) {
            if (m.type === 'hdlr' && ascii(b, m.start + 8, 4) === 'vide') isVideo = true;
          }
        }
      }
      if (!tkhd || !isVideo) continue;
      const version = dv.getUint8(tkhd.start);
      // version(1) flags(3) times… then reserved, layer, group, volume, reserved, matrix(36), width, height
      const matrixAt = tkhd.start + (version === 1 ? 52 : 40);
      const a = dv.getInt32(matrixAt);
      const d = dv.getInt32(matrixAt + 16);
      const width = dv.getUint32(matrixAt + 36) >>> 16;
      const height = dv.getUint32(matrixAt + 40) >>> 16;
      if (!width || !height) continue;
      // A 90° or 270° rotation matrix has a == d == 0: the picture is shown rotated.
      return a === 0 && d === 0 ? { width: height, height: width } : { width, height };
    }
  }
  return null;
}
