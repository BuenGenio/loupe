import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import { buildRichText, createBluesky, deterministicTid, parseOpenGraph } from '../src/platforms/bluesky.mjs';
import { parsePost } from '../src/posts.mjs';
import { renderPost } from '../src/render.mjs';
import { ENV, blueskyRoutes, mockFetch, mp4, png, silent, tempMarketing, testConfig, write } from './helpers.mjs';

const bytes = (s) => Buffer.from(s, 'utf8');
/** The text a facet covers, sliced the way Bluesky does: by UTF-8 bytes. */
const covered = (text, f) => bytes(text).subarray(f.index.byteStart, f.index.byteEnd).toString('utf8');

describe('Bluesky rich text facets', () => {
  it('uses UTF-8 byte offsets, so emoji before a link shift it by 4 bytes each', () => {
    const text = '🔍✉️ Loupe is out https://loupe.mx #android';
    const { facets } = buildRichText(text);
    const link = facets.find((f) => f.features[0].$type === 'app.bsky.richtext.facet#link');
    const tag = facets.find((f) => f.features[0].$type === 'app.bsky.richtext.facet#tag');
    // 🔍 = 4 bytes, ✉️ = 3 + 3 (variation selector) bytes, then " Loupe is out " = 14
    assert.equal(link.index.byteStart, 4 + 6 + 14);
    assert.equal(text.indexOf('https'), 2 + 2 + 14, 'JS index differs: emoji are 2 UTF-16 units');
    assert.equal(covered(text, link), 'https://loupe.mx');
    assert.equal(link.features[0].uri, 'https://loupe.mx');
    assert.equal(covered(text, tag), '#android');
    assert.equal(tag.features[0].tag, 'android');
  });

  it('handles ZWJ sequences and flags', () => {
    const text = '👨‍👩‍👧‍👦🇺🇦 #família';
    const { facets } = buildRichText(text);
    assert.equal(facets.length, 1);
    assert.equal(facets[0].index.byteStart, 25 + 8 + 1);
    assert.equal(covered(text, facets[0]), '#família');
    assert.equal(facets[0].index.byteEnd - facets[0].index.byteStart, bytes('#família').length);
  });

  it('short display links carry the full UTM URL; detected links inside them are replaced', () => {
    const utm = 'https://loupe.mx/?utm_source=bluesky&utm_medium=social&utm_campaign=launch';
    const text = 'Out now 🎉 loupe.mx';
    const start = text.indexOf('loupe.mx');
    const { facets } = buildRichText(text, [{ start, end: start + 8, url: utm }]);
    assert.equal(facets.length, 1, 'RichText also detects "loupe.mx"; ours replaces it');
    assert.equal(facets[0].features[0].uri, utm);
    assert.equal(facets[0].index.byteStart, bytes('Out now 🎉 ').length);
    assert.equal(covered(text, facets[0]), 'loupe.mx');
  });

  it('mentions are detected (resolved to DIDs at publish time)', () => {
    const { facets } = buildRichText('💐 thanks @alice.bsky.social');
    assert.equal(facets[0].features[0].$type, 'app.bsky.richtext.facet#mention');
    assert.equal(facets[0].features[0].did, 'alice.bsky.social');
    assert.deepEqual(facets[0].index, { byteStart: 4 + 8, byteEnd: 4 + 8 + 18 });
  });
});

describe('deterministic record keys', () => {
  it('are valid TIDs, stable per post, different between posts', () => {
    const d = new Date('2026-10-20T15:00:00Z');
    const a = deterministicTid(d, 'launch/bluesky');
    assert.match(a, /^[234567abcdefghij][234567abcdefghijklmnopqrstuvwxyz]{12}$/);
    assert.equal(deterministicTid(d, 'launch/bluesky'), a);
    assert.notEqual(deterministicTid(d, 'other/bluesky'), a);
    assert.ok(deterministicTid(new Date('2026-10-21T15:00:00Z'), 'launch/bluesky') > a, 'TIDs sort by time');
  });
});

describe('parseOpenGraph', () => {
  it('reads og tags, falls back to <title>, resolves relative images', () => {
    const html = `<html><head><title>Fallback</title>
      <meta property="og:title" content="Loupe &amp; you">
      <meta content="Mail for Android" property="og:description">
      <meta property="og:image" content="/og.png"></head></html>`;
    assert.deepEqual(parseOpenGraph(html, 'https://loupe.mx/'), {
      title: 'Loupe & you',
      description: 'Mail for Android',
      image: 'https://loupe.mx/og.png',
    });
    assert.equal(parseOpenGraph('<title>Only</title>', 'https://x.example/').title, 'Only');
  });
});

describe('Bluesky publishing (mocked PDS)', () => {
  const dir = tempMarketing();
  write(dir, 'media/a.png', png(1080, 1350));
  const cfg = testConfig(dir);
  const post = (fm, body) =>
    parsePost(`---\nid: launch\ndate: 2026-10-20T15:00:00Z\nstatus: scheduled\nplatforms: [bluesky]\ncampaign: launch\n${fm}\n---\n${body}`, { file: 'x.md' });
  const ctx = (fetch) => ({ cfg, env: ENV, fetch, sleep: async () => {}, log: silent() });

  it('posts images with alt text and aspect ratio, facets and langs', async () => {
    const records = [];
    const fetch = mockFetch(blueskyRoutes(records));
    const bsky = createBluesky(ctx(fetch));
    const r = renderPost(
      post('link: https://loupe.mx/\nmedia:\n  - path: media/a.png\n    alt: "The inbox"', 'Hi @alice.bsky.social and @nobody.bsky.social 🎉 {link} #email'),
      'bluesky',
      cfg,
    );
    const res = await bsky.publish(r);
    assert.equal(records.length, 1);
    const rec = records[0];
    assert.equal(rec.collection, 'app.bsky.feed.post');
    assert.equal(rec.repo, 'did:plc:loupetest');
    assert.match(rec.rkey, /^[2-7a-z]{13}$/);
    assert.equal(rec.record.text, 'Hi @alice.bsky.social and @nobody.bsky.social 🎉 loupe.mx #email');
    assert.deepEqual(rec.record.langs, ['en']);
    assert.equal(rec.record.embed.$type, 'app.bsky.embed.images');
    assert.equal(rec.record.embed.images[0].alt, 'The inbox');
    assert.deepEqual(rec.record.embed.images[0].aspectRatio, { width: 1080, height: 1350 });
    assert.equal(rec.record.embed.images[0].image.ref.$link, 'bafkreibme22gw2h7y2h7tg2fhqotaqjucnbc24deqo72b6mkl2egezxhvy');
    const kinds = rec.record.facets.map((f) => [covered(rec.record.text, f), f.features[0].$type.split('#')[1]]);
    assert.deepEqual(kinds, [
      ['@alice.bsky.social', 'mention'],
      ['loupe.mx', 'link'],
      ['#email', 'tag'],
    ], 'unresolvable @nobody.bsky.social is dropped');
    assert.equal(rec.record.facets[0].features[0].did, 'did:plc:alice');
    assert.equal(rec.record.facets[1].features[0].uri, 'https://loupe.mx/?utm_source=bluesky&utm_medium=social&utm_campaign=launch');
    assert.equal(res.url, `https://bsky.app/profile/loupe.test/post/${rec.rkey}`);
  });

  it('builds a link card with an uploaded thumbnail when there is a link and no media', async () => {
    const records = [];
    const fetch = mockFetch([
      ...blueskyRoutes(records),
      ['GET loupe.mx/og.png', () => new Response(png(1200, 630), { headers: { 'content-type': 'image/png' } })],
      ['GET loupe.mx/', () => new Response('<meta property="og:title" content="Loupe"><meta property="og:description" content="Mail"><meta property="og:image" content="https://loupe.mx/og.png">', { headers: { 'content-type': 'text/html; charset=utf-8' } })],
    ]);
    const res = await createBluesky(ctx(fetch)).publish(renderPost(post('link: https://loupe.mx/', 'New site'), 'bluesky', cfg));
    const embed = records[0].record.embed;
    assert.equal(records[0].record.text, 'New site', 'the card carries the link');
    assert.equal(embed.$type, 'app.bsky.embed.external');
    assert.equal(embed.external.uri, 'https://loupe.mx/?utm_source=bluesky&utm_medium=social&utm_campaign=launch');
    assert.equal(embed.external.title, 'Loupe');
    assert.equal(embed.external.description, 'Mail');
    assert.equal(embed.external.thumb.mimeType, 'image/png');
    assert.ok(res.url);
  });

  it('a retry after a lost response finds the record instead of posting twice', async () => {
    const records = [];
    const existing = new Map();
    const fetch = mockFetch(blueskyRoutes(records, { existing }));
    const r = renderPost(post('', 'Once only'), 'bluesky', cfg);
    const first = await createBluesky(ctx(fetch)).publish(r);
    const second = await createBluesky(ctx(fetch)).publish(r);
    assert.equal(records.length, 1);
    assert.equal(second.url, first.url);
  });
});

describe('Bluesky video (mocked video service)', () => {
  it('gets service auth for the PDS, uploads to video.bsky.app, polls the job, embeds the blob', async () => {
    const dir = tempMarketing();
    write(dir, 'media/clip.mp4', mp4(1080, 1920));
    const cfg = testConfig(dir);
    const records = [];
    let polls = 0;
    const blob = { $type: 'blob', ref: { $link: 'bafkreibme22gw2h7y2h7tg2fhqotaqjucnbc24deqo72b6mkl2egezxhvy' }, mimeType: 'video/mp4', size: 1234 };
    const fetch = mockFetch([
      ...blueskyRoutes(records),
      ['GET bsky.social/xrpc/com.atproto.server.getServiceAuth', (c) => {
        assert.equal(c.query.get('aud'), 'did:web:bsky.social');
        assert.equal(c.query.get('lxm'), 'com.atproto.repo.uploadBlob');
        return { token: 'svc-token' };
      }],
      ['POST video.bsky.app/xrpc/app.bsky.video.uploadVideo', (c) => {
        assert.equal(c.headers.get('authorization'), 'Bearer svc-token');
        assert.equal(c.query.get('did'), 'did:plc:loupetest');
        return { jobId: 'job-1', did: 'did:plc:loupetest', state: 'JOB_STATE_CREATED' };
      }],
      ['GET video.bsky.app/xrpc/app.bsky.video.getJobStatus', () => {
        polls++;
        return { jobStatus: polls < 2 ? { jobId: 'job-1', state: 'JOB_STATE_ENCODING' } : { jobId: 'job-1', state: 'JOB_STATE_COMPLETED', blob } };
      }],
    ]);
    const post = parsePost('---\nid: v\ndate: 2026-10-20T15:00:00Z\nstatus: scheduled\nplatforms: [bluesky]\nmedia:\n  - path: media/clip.mp4\n    alt: A demo\n---\nWatch', { file: 'v.md' });
    await createBluesky({ cfg, env: ENV, fetch, sleep: async () => {}, log: silent() }).publish(renderPost(post, 'bluesky', cfg));
    const embed = records[0].record.embed;
    assert.equal(embed.$type, 'app.bsky.embed.video');
    assert.equal(embed.alt, 'A demo');
    assert.deepEqual(embed.aspectRatio, { width: 1080, height: 1920 });
    assert.equal(embed.video.ref.$link, blob.ref.$link);
    assert.equal(polls, 2);
  });
});
