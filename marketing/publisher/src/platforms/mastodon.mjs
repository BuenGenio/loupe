// Mastodon, directly over its REST API.
//
// Media goes up through POST /api/v2/media (images answer 200 at once; video
// answers 202 and is polled at GET /api/v1/media/:id until it stops
// answering 206). The status is created with an Idempotency-Key derived from
// the post id, so a retry within Mastodon's one-hour window can't duplicate.

import { createHash } from 'node:crypto';
import { loadMedia } from '../media.mjs';
import { resolveMediaPath } from '../posts.mjs';

export function idempotencyKey(id, platform = 'mastodon') {
  return `loupe-social-${createHash('sha256').update(`${id}/${platform}`).digest('hex').slice(0, 32)}`;
}

export function createMastodon(ctx) {
  const { env, fetch, sleep } = ctx;
  const base = () => String(env.MASTODON_URL).replace(/\/+$/, '');
  const auth = () => ({ Authorization: `Bearer ${env.MASTODON_TOKEN}` });

  async function api(path, init = {}) {
    const res = await fetch(`${base()}${path}`, { ...init, headers: { ...auth(), ...init.headers } });
    const body = await res.json().catch(() => ({}));
    if (!res.ok) throw new Error(`Mastodon ${init.method ?? 'GET'} ${path}: HTTP ${res.status} ${body.error ?? ''}`.trim());
    return { status: res.status, body };
  }

  async function uploadMedia(m) {
    const { bytes, mime, name } = await loadMedia(resolveMediaPath(ctx.cfg, m), { fetch, isUrl: m.isUrl });
    const form = new FormData();
    form.append('file', new Blob([bytes], { type: mime }), name);
    if (m.alt) form.append('description', m.alt);
    let { status, body } = await api('/api/v2/media', { method: 'POST', body: form });
    for (let i = 0; status === 202 || status === 206 || body.url == null; i++) {
      if (i > 90) throw new Error(`Mastodon is still processing ${m.src}; giving up`);
      await sleep(2000);
      ({ status, body } = await api(`/api/v1/media/${encodeURIComponent(body.id)}`));
    }
    return body.id;
  }

  return {
    name: 'mastodon',
    unconfigured() {
      if (!env.MASTODON_URL || !env.MASTODON_TOKEN) return 'MASTODON_URL / MASTODON_TOKEN not set';
      return null;
    },
    async publish(rendered) {
      const mediaIds = [];
      for (const m of rendered.media) mediaIds.push(await uploadMedia(m));
      const payload = {
        status: rendered.fields.text,
        visibility: rendered.options.visibility,
        ...(rendered.options.language ? { language: rendered.options.language } : {}),
        ...(rendered.fields.spoiler ? { spoiler_text: rendered.fields.spoiler } : {}),
        ...(mediaIds.length ? { media_ids: mediaIds } : {}),
      };
      const { body } = await api('/api/v1/statuses', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Idempotency-Key': idempotencyKey(rendered.id) },
        body: JSON.stringify(payload),
      });
      return { url: body.url ?? body.uri, remoteId: body.id };
    },
  };
}
