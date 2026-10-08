import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { describe, it } from 'node:test';
import { dimensions, mediaKind, mimeType } from '../src/media.mjs';
import { MARKETING_DIR, mp4, png } from './helpers.mjs';

describe('media', () => {
  it('kind and MIME type from the name', () => {
    assert.equal(mimeType('a/b.JPG'), 'image/jpeg');
    assert.equal(mediaKind('https://cdn.example/clip.mp4?x=1'), 'video');
    assert.equal(mediaKind('notes.pdf'), 'unknown');
  });

  it('dimensions from PNG, JPEG, GIF, WebP and MP4 headers', () => {
    assert.deepEqual(dimensions(png(1080, 1350)), { width: 1080, height: 1350 });
    assert.deepEqual(dimensions(readFileSync(`${MARKETING_DIR}media/_examples/inbox.jpg`)), { width: 1080, height: 1350 });
    const gif = Buffer.from('GIF89a\x40\x01\xf0\x00', 'binary');
    assert.deepEqual(dimensions(gif), { width: 320, height: 240 });
    const webp = Buffer.alloc(30);
    webp.write('RIFF', 0, 'ascii');
    webp.write('WEBPVP8X', 8, 'ascii');
    webp.writeUIntLE(1919, 24, 3);
    webp.writeUIntLE(1079, 27, 3);
    assert.deepEqual(dimensions(webp), { width: 1920, height: 1080 });
    assert.deepEqual(dimensions(mp4(1080, 1920)), { width: 1080, height: 1920 });
    assert.deepEqual(dimensions(mp4(1920, 1080, { rotate90: true })), { width: 1080, height: 1920 });
    assert.equal(dimensions(Buffer.from('nonsense')), null);
  });
});
