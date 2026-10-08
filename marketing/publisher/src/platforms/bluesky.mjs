// Bluesky, directly over the AT Protocol with the official @atproto/api client.
//
// - Rich text: @atproto/api's RichText finds links, #tags and @mentions the
//   same way the Bluesky app does; facets index UTF-8 *bytes*, not JS string
//   indices. Links we insert ourselves show as "loupe.mx" in the text and
//   carry the full UTM URL in their facet, saving graphemes.
// - Embeds: up to 4 images (alt text + aspect ratio), or one video through
//   video.bsky.app, or — with a link and no media — a link card whose
//   thumbnail we upload ourselves (Bluesky clients build cards client-side).
// - Idempotency: the record key is a TID derived from the post's scheduled
//   time and id, so a retry after a lost response collides with the first
//   attempt instead of posting twice.

import { AtpAgent, RichText } from '@atproto/api';
import { createHash } from 'node:crypto';
import { dimensions, loadMedia } from '../media.mjs';
import { resolveMediaPath } from '../posts.mjs';
import { utf8Offset } from '../text.mjs';

// From the app.bsky.embed.* lexicons bundled with @atproto/api 0.24.
const MAX_IMAGE_BYTES = 2_000_000;
const MAX_THUMB_BYTES = 1_000_000;
const VIDEO_SERVICE = 'https://video.bsky.app';

/**
 * Text + facets for a post, without network. Mentions come back with the
 * handle in `did`; resolveMentions() swaps in real DIDs.
 */
export function buildRichText(text, linkSpans = []) {
  const rt = new RichText({ text });
  rt.detectFacetsWithoutResolution();
  const spans = linkSpans.map((s) => ({
    byteStart: utf8Offset(text, s.start),
    byteEnd: utf8Offset(text, s.end),
    url: s.url,
  }));
  const overlaps = (f) => spans.some((s) => f.index.byteStart < s.byteEnd && s.byteStart < f.index.byteEnd);
  const facets = (rt.facets ?? []).filter((f) => !overlaps(f));
  for (const s of spans) {
    facets.push({
      $type: 'app.bsky.richtext.facet',
      index: { byteStart: s.byteStart, byteEnd: s.byteEnd },
      features: [{ $type: 'app.bsky.richtext.facet#link', uri: s.url }],
    });
  }
  facets.sort((a, b) => a.index.byteStart - b.index.byteStart);
  return { text: rt.text, facets };
}

export async function resolveMentions(facets, agent) {
  for (const f of facets) {
    for (const feat of f.features) {
      if (feat.$type !== 'app.bsky.richtext.facet#mention' || feat.did.startsWith('did:')) continue;
      try {
        const { data } = await agent.com.atproto.identity.resolveHandle({ handle: feat.did });
        feat.did = data.did;
      } catch {
        feat.did = '';
      }
    }
    f.features = f.features.filter((feat) => feat.$type !== 'app.bsky.richtext.facet#mention' || feat.did);
  }
  return facets.filter((f) => f.features.length);
}

const S32 = '234567abcdefghijklmnopqrstuvwxyz';

/** A valid TID (13 chars, base32-sortable) from a time and a stable seed. */
export function deterministicTid(date, seed) {
  const micros = BigInt(date.getTime()) * 1000n + BigInt(parseInt(sha(seed).slice(0, 3), 16) % 1000);
  const clock = BigInt(parseInt(sha(`clock:${seed}`).slice(0, 4), 16) % 1024);
  let n = ((micros & ((1n << 53n) - 1n)) << 10n) | clock;
  let out = '';
  for (let i = 0; i < 13; i++) {
    out = S32[Number(n & 31n)] + out;
    n >>= 5n;
  }
  return out;
}

function sha(s) {
  return createHash('sha256').update(s).digest('hex');
}

/** og:title / og:description / og:image from an HTML page. */
export function parseOpenGraph(html, baseUrl) {
  const meta = {};
  for (const m of html.matchAll(/<meta\s+[^>]*>/gi)) {
    const tag = m[0];
    const key = tag.match(/(?:property|name)\s*=\s*["']([^"']+)["']/i)?.[1]?.toLowerCase();
    const content = tag.match(/content\s*=\s*["']([^"']*)["']/i)?.[1];
    if (key && content != null && !(key in meta)) meta[key] = decodeEntities(content);
  }
  const title = meta['og:title'] ?? meta['twitter:title'] ?? decodeEntities(html.match(/<title[^>]*>([^<]*)<\/title>/i)?.[1] ?? '').trim();
  const description = meta['og:description'] ?? meta['twitter:description'] ?? meta.description ?? '';
  let image = meta['og:image'] ?? meta['twitter:image'] ?? null;
  if (image) {
    try {
      image = new URL(image, baseUrl).toString();
    } catch {
      image = null;
    }
  }
  return { title, description, image };
}

function decodeEntities(s) {
  return s
    .replace(/&quot;/g, '"')
    .replace(/&#39;|&apos;/g, "'")
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&#(\d+);/g, (_, d) => String.fromCodePoint(Number(d)))
    .replace(/&amp;/g, '&');
}

export function createBluesky(ctx) {
  const { env, fetch, sleep } = ctx;
  let agentPromise = null;

  function agent() {
    agentPromise ??= (async () => {
      const a = new AtpAgent({ service: env.BLUESKY_SERVICE || 'https://bsky.social', fetch });
      await a.login({ identifier: env.BLUESKY_HANDLE, password: env.BLUESKY_APP_PASSWORD });
      return a;
    })();
    return agentPromise;
  }

  async function uploadImages(a, items) {
    const images = [];
    for (const m of items) {
      const { bytes, mime } = await loadMedia(resolveMediaPath(ctx.cfg, m), { fetch, isUrl: m.isUrl });
      if (bytes.length > MAX_IMAGE_BYTES) {
        throw new Error(`${m.src} is ${bytes.length} bytes; Bluesky takes images up to ${MAX_IMAGE_BYTES} bytes`);
      }
      const { data } = await a.uploadBlob(bytes, { encoding: mime });
      const dims = dimensions(bytes);
      images.push({ image: data.blob, alt: m.alt, ...(dims ? { aspectRatio: dims } : {}) });
    }
    return { $type: 'app.bsky.embed.images', images };
  }

  async function uploadVideo(a, m) {
    const { bytes, mime, name } = await loadMedia(resolveMediaPath(ctx.cfg, m), { fetch, isUrl: m.isUrl });
    const pds = new URL(a.pdsUrl ?? a.serviceUrl);
    const { data: auth } = await a.com.atproto.server.getServiceAuth({
      aud: `did:web:${pds.hostname}`,
      lxm: 'com.atproto.repo.uploadBlob',
      exp: Math.floor(Date.now() / 1000) + 30 * 60,
    });
    const url = new URL('/xrpc/app.bsky.video.uploadVideo', VIDEO_SERVICE);
    url.searchParams.set('did', a.session.did);
    url.searchParams.set('name', name);
    const res = await fetch(url, {
      method: 'POST',
      headers: { Authorization: `Bearer ${auth.token}`, 'Content-Type': mime },
      body: bytes,
    });
    const body = await res.json().catch(() => ({}));
    let job = body.jobStatus ?? body;
    if (!res.ok && !job.jobId) throw new Error(`video upload failed: HTTP ${res.status} ${body.message ?? body.error ?? ''}`);
    for (let i = 0; !job.blob; i++) {
      if (job.state === 'JOB_STATE_FAILED') throw new Error(`video processing failed: ${job.error ?? job.message ?? 'unknown'}`);
      if (i > 150) throw new Error('video processing timed out');
      await sleep(2000);
      const s = await fetch(`${VIDEO_SERVICE}/xrpc/app.bsky.video.getJobStatus?jobId=${encodeURIComponent(job.jobId)}`);
      job = (await s.json()).jobStatus ?? job;
    }
    const dims = dimensions(bytes);
    return { $type: 'app.bsky.embed.video', video: job.blob, alt: m.alt, ...(dims ? { aspectRatio: dims } : {}) };
  }

  async function linkCard(a, rendered) {
    const external = { uri: rendered.link, title: '', description: '' };
    try {
      const res = await fetch(rendered.rawLink, { headers: { 'User-Agent': 'loupe-social-publisher (+https://loupe.mx)' } });
      if (res.ok && (res.headers.get('content-type') ?? '').includes('html')) {
        const og = parseOpenGraph(await res.text(), rendered.rawLink);
        external.title = og.title;
        external.description = og.description;
        if (og.image) {
          const img = await fetch(og.image);
          const type = img.headers.get('content-type') ?? '';
          const bytes = new Uint8Array(await img.arrayBuffer());
          if (img.ok && type.startsWith('image/') && bytes.length <= MAX_THUMB_BYTES) {
            const { data } = await a.uploadBlob(bytes, { encoding: type.split(';')[0] });
            external.thumb = data.blob;
          } else {
            ctx.log.warn(`bluesky: link card for ${rendered.id} has no thumbnail (${og.image}: ${type || 'no type'}, ${bytes.length} bytes)`);
          }
        }
      }
    } catch (err) {
      ctx.log.warn(`bluesky: couldn't build a full link card for ${rendered.rawLink}: ${err.message}`);
    }
    if (!external.title) external.title = new URL(rendered.rawLink).host;
    return { $type: 'app.bsky.embed.external', external };
  }

  return {
    name: 'bluesky',
    unconfigured() {
      if (!env.BLUESKY_HANDLE || !env.BLUESKY_APP_PASSWORD) return 'BLUESKY_HANDLE / BLUESKY_APP_PASSWORD not set';
      return null;
    },
    async publish(rendered) {
      const a = await agent();
      const did = a.session.did;
      const rt = buildRichText(rendered.primary, rendered.linkSpans);
      const facets = await resolveMentions(rt.facets, a);

      const images = rendered.media.filter((m) => m.kind === 'image');
      const videos = rendered.media.filter((m) => m.kind === 'video');
      let embed;
      if (videos.length) embed = await uploadVideo(a, videos[0]);
      else if (images.length) embed = await uploadImages(a, images);
      else if (rendered.link) embed = await linkCard(a, rendered);

      const record = {
        $type: 'app.bsky.feed.post',
        text: rt.text,
        createdAt: new Date().toISOString(),
        langs: rendered.options.langs,
        ...(facets.length ? { facets } : {}),
        ...(embed ? { embed } : {}),
      };
      const rkey = deterministicTid(rendered.date ?? new Date(), `${rendered.id}/bluesky`);
      let uri;
      try {
        const { data } = await a.com.atproto.repo.createRecord({ repo: did, collection: 'app.bsky.feed.post', rkey, record });
        uri = data.uri;
      } catch (err) {
        // Already there from an earlier attempt whose response was lost?
        const existing = await a.com.atproto.repo
          .getRecord({ repo: did, collection: 'app.bsky.feed.post', rkey })
          .catch(() => null);
        if (!existing) throw err;
        uri = existing.data.uri;
      }
      const handle = a.session.handle ?? env.BLUESKY_HANDLE;
      return { url: `https://bsky.app/profile/${handle}/post/${rkey}`, remoteId: uri };
    },
  };
}
