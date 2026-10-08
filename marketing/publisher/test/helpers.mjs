import { mkdirSync, mkdtempSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { loadConfig } from '../src/config.mjs';

export const EXAMPLES_DIR = new URL('../../posts/_examples/', import.meta.url).pathname;
export const MARKETING_DIR = new URL('../../', import.meta.url).pathname;

/** A throwaway marketing/ directory with posts/ and media/. */
export function tempMarketing() {
  const dir = mkdtempSync(join(tmpdir(), 'loupe-social-'));
  mkdirSync(join(dir, 'posts'), { recursive: true });
  mkdirSync(join(dir, 'media'), { recursive: true });
  return dir;
}

export function write(dir, rel, content) {
  const full = join(dir, rel);
  mkdirSync(dirname(full), { recursive: true });
  writeFileSync(full, content);
  return full;
}

export const ALL_ON = {
  bluesky: { mode: 'api' },
  mastodon: { mode: 'api', visibility: 'public' },
  instagram: { mode: 'postiz', integration: 'ig-1', type: 'instagram-standalone' },
  threads: { mode: 'postiz', integration: 'th-1' },
  tiktok: { mode: 'postiz', integration: 'tt-1' },
  youtube: { mode: 'postiz', integration: 'yt-1' },
  linkedin: { mode: 'postiz', integration: 'li-1', type: 'linkedin-page' },
  x: { mode: 'postiz', integration: 'x-1' },
  facebook: { mode: 'off' },
  reddit: { mode: 'assist' },
};

export function testConfig(marketingDir, { platforms = ALL_ON, env = {}, ...rest } = {}) {
  return loadConfig(
    {
      config: { maxLatenessHours: 12, languages: ['en'], platforms, assist: { repository: 'acme/loupe', labels: ['social'] }, ...rest },
      marketingDir,
      ledgerFile: join(marketingDir, '.state', 'published.json'),
    },
    env,
  );
}

export const ENV = {
  BLUESKY_HANDLE: 'loupe.test',
  BLUESKY_APP_PASSWORD: 'aaaa-bbbb-cccc-dddd',
  MASTODON_URL: 'https://mastodon.example',
  MASTODON_TOKEN: 'masto-token',
  POSTIZ_API_KEY: 'postiz-key',
  GITHUB_TOKEN: 'gh-token',
};

/** A tiny real PNG of the given size (header is all `dimensions` needs, but keep it valid-ish). */
export function png(width, height) {
  const b = Buffer.alloc(33);
  Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]).copy(b, 0);
  b.writeUInt32BE(13, 8);
  b.write('IHDR', 12, 'ascii');
  b.writeUInt32BE(width, 16);
  b.writeUInt32BE(height, 20);
  b[24] = 8;
  b[25] = 6;
  return b;
}

/**
 * A fake fetch. `routes` is a list of [matcher, handler]: matcher is
 * "METHOD /path" (prefix match on host+path) or a function(req); handler
 * gets ({ url, method, headers, json(), text(), formData() }) and returns
 * a Response or a plain object (sent as 200 JSON).
 */
export function mockFetch(routes = []) {
  const calls = [];
  const fn = async (input, init) => {
    const req = input instanceof Request ? input : new Request(input, init);
    const url = new URL(req.url);
    const call = {
      url: url.toString(),
      host: url.host,
      path: url.pathname,
      query: url.searchParams,
      method: req.method,
      headers: req.headers,
      _req: req.clone(),
      async json() {
        return JSON.parse(await this._req.clone().text());
      },
      async text() {
        return this._req.clone().text();
      },
      async formData() {
        return this._req.clone().formData();
      },
    };
    calls.push(call);
    for (const [matcher, handler] of routes) {
      const hit =
        typeof matcher === 'function'
          ? matcher(call)
          : (() => {
              const [method, target] = matcher.split(' ');
              return method === call.method && `${call.host}${call.path}`.startsWith(target.replace(/^https?:\/\//, ''));
            })();
      if (!hit) continue;
      const out = await handler(call);
      return out instanceof Response ? out : Response.json(out);
    }
    throw new Error(`unexpected fetch: ${call.method} ${call.url}`);
  };
  fn.calls = calls;
  return fn;
}

export function fakeJwt(payload = {}) {
  const b64 = (o) => Buffer.from(JSON.stringify(o)).toString('base64url');
  return `${b64({ alg: 'ES256K', typ: 'at+jwt' })}.${b64({ scope: 'com.atproto.appPass', exp: Math.floor(Date.now() / 1000) + 3600, ...payload })}.c2ln`;
}

export const CID = 'bafkreibme22gw2h7y2h7tg2fhqotaqjucnbc24deqo72b6mkl2egezxhvy';

/** Routes for a minimal Bluesky PDS. `records` collects created records. */
export function blueskyRoutes(records = [], { did = 'did:plc:loupetest', existing = new Map() } = {}) {
  return [
    [
      'POST bsky.social/xrpc/com.atproto.server.createSession',
      () => ({ did, handle: 'loupe.test', accessJwt: fakeJwt({ sub: did }), refreshJwt: fakeJwt({ sub: did }), active: true }),
    ],
    [
      'POST bsky.social/xrpc/com.atproto.repo.uploadBlob',
      async (c) => ({
        blob: { $type: 'blob', ref: { $link: CID }, mimeType: c.headers.get('content-type'), size: (await c._req.clone().arrayBuffer()).byteLength },
      }),
    ],
    [
      'GET bsky.social/xrpc/com.atproto.identity.resolveHandle',
      (c) =>
        c.query.get('handle') === 'alice.bsky.social'
          ? { did: 'did:plc:alice' }
          : Response.json({ error: 'InvalidRequest', message: 'Unable to resolve handle' }, { status: 400 }),
    ],
    [
      'POST bsky.social/xrpc/com.atproto.repo.createRecord',
      async (c) => {
        const body = await c.json();
        if (existing.has(body.rkey)) {
          return Response.json({ error: 'InvalidRequest', message: 'Record already exists' }, { status: 400 });
        }
        records.push(body);
        existing.set(body.rkey, body);
        return { uri: `at://${did}/app.bsky.feed.post/${body.rkey}`, cid: CID };
      },
    ],
    [
      'GET bsky.social/xrpc/com.atproto.repo.getRecord',
      (c) => {
        const rkey = c.query.get('rkey');
        if (!existing.has(rkey)) return Response.json({ error: 'RecordNotFound', message: 'Could not locate record' }, { status: 400 });
        return { uri: `at://${did}/app.bsky.feed.post/${rkey}`, cid: CID, value: existing.get(rkey).record };
      },
    ],
  ];
}

/** A logger that remembers what it was told. */
export function silent() {
  const lines = { info: [], warn: [], error: [] };
  return {
    lines,
    info: (m) => lines.info.push(m),
    warn: (m) => lines.warn.push(m),
    error: (m) => lines.error.push(m),
  };
}

function box(type, ...children) {
  const body = Buffer.concat(children);
  const head = Buffer.alloc(8);
  head.writeUInt32BE(8 + body.length);
  head.write(type, 4, 'ascii');
  return Buffer.concat([head, body]);
}

/** A structurally valid MP4 header: ftyp + moov/trak/{tkhd,mdia/hdlr}. */
export function mp4(width, height, { rotate90 = false } = {}) {
  const tkhd = Buffer.alloc(84);
  // version 0: matrix at 40, width at 76, height at 80 (16.16 fixed point)
  const matrix = rotate90 ? [0, 0x10000, 0, -0x10000, 0, 0, 0, 0, 0x40000000] : [0x10000, 0, 0, 0, 0x10000, 0, 0, 0, 0x40000000];
  matrix.forEach((v, i) => tkhd.writeInt32BE(v, 40 + i * 4));
  tkhd.writeUInt32BE(width << 16, 76);
  tkhd.writeUInt32BE(height << 16, 80);
  const hdlr = Buffer.alloc(24);
  hdlr.write('vide', 8, 'ascii');
  return Buffer.concat([
    box('ftyp', Buffer.from('isom\0\0\0\0isomiso2mp41', 'binary')),
    box('moov', box('mvhd', Buffer.alloc(100)), box('trak', box('tkhd', tkhd), box('mdia', box('hdlr', hdlr)))),
  ]);
}
