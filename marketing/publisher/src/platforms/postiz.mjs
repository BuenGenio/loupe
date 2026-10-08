// Everything that needs an approved developer app (Instagram, TikTok,
// YouTube, Threads, LinkedIn, X, Facebook) goes through Postiz's public API —
// Postiz Cloud (https://api.postiz.com/public/v1) or a self-hosted instance
// (https://<host>/api/public/v1). Docs: https://docs.postiz.com/public-api
//
// Media is uploaded to Postiz first (POST /upload, or /upload-from-url for
// https media); Postiz then hands its own public URL to the network. Meta
// (Instagram, Threads) and TikTok fetch media from that URL, so a
// self-hosted Postiz must serve its uploads on a public HTTPS address.
//
// The post is created with type "now": this publisher decides when. Postiz
// answers with its own post id at once and publishes in the background, so
// the ledger stores that id; delivery errors show up in Postiz itself.

import { loadMedia } from '../media.mjs';
import { resolveMediaPath } from '../posts.mjs';

/** Provider settings per network, from https://docs.postiz.com/public-api/providers/* */
export function postizSettings(rendered, pcfg = {}) {
  const extra = pcfg.settings ?? {};
  switch (rendered.platform) {
    case 'instagram':
      return {
        __type: pcfg.type ?? 'instagram-standalone',
        post_type: 'post', // a single video posted as "post" becomes a Reel; several items a carousel
        is_trial_reel: false,
        collaborators: [],
        ...extra,
      };
    case 'tiktok':
      return {
        __type: 'tiktok',
        title: rendered.fields.title || '',
        privacy_level: 'PUBLIC_TO_EVERYONE',
        duet: false,
        stitch: false,
        comment: true,
        autoAddMusic: 'no',
        brand_content_toggle: false,
        brand_organic_toggle: false,
        video_made_with_ai: false,
        content_posting_method: 'DIRECT_POST',
        ...extra,
      };
    case 'youtube':
      return {
        __type: 'youtube',
        title: rendered.fields.title,
        type: rendered.options.visibility ?? 'public',
        selfDeclaredMadeForKids: 'no',
        tags: rendered.fields.tags.map((t) => ({ value: t, label: t })),
        ...extra,
      };
    case 'linkedin':
      return { __type: pcfg.type ?? 'linkedin-page', post_as_images_carousel: false, ...extra };
    case 'x':
      return { __type: 'x', who_can_reply_post: 'everyone', ...extra };
    case 'reddit':
      return {
        __type: 'reddit',
        subreddit: [
          {
            value: {
              subreddit: rendered.options.subreddit,
              title: rendered.fields.title,
              type: rendered.options.kind === 'link' ? 'link' : 'self',
              url: rendered.options.url ?? '',
              is_flair_required: Boolean(rendered.options.flair),
              flair: rendered.options.flair ? { id: rendered.options.flair, name: rendered.options.flair } : null,
            },
          },
        ],
        ...extra,
      };
    default: // threads, facebook, bluesky, mastodon need only the type
      return { __type: rendered.platform, ...extra };
  }
}

/** The text Postiz should post: YouTube's is the description; Shorts get a #Shorts hint. */
export function postizContent(rendered) {
  let text = rendered.primary ?? '';
  if (rendered.platform === 'youtube' && rendered.options.short && !/#shorts\b/i.test(`${rendered.fields.title} ${text}`)) {
    text = `${text}\n\n#Shorts`.trim();
  }
  return text;
}

export function createPostiz(ctx) {
  const { env, fetch, cfg } = ctx;
  const uploads = new Map();
  const base = () => cfg.postiz.url;

  async function api(path, init = {}) {
    const res = await fetch(`${base()}${path}`, {
      ...init,
      headers: { Authorization: env.POSTIZ_API_KEY, Accept: 'application/json', ...init.headers },
    });
    const text = await res.text();
    let body;
    try {
      body = JSON.parse(text);
    } catch {
      body = text;
    }
    if (!res.ok) {
      const msg = typeof body === 'object' ? (body.message ?? JSON.stringify(body)) : String(body).slice(0, 300);
      const hint = res.status === 429 ? ' (Postiz rate limit on post creation; the post will be retried next run)' : '';
      throw new Error(`Postiz ${init.method ?? 'GET'} ${path}: HTTP ${res.status} ${msg}${hint}`);
    }
    return body;
  }

  async function upload(m) {
    if (uploads.has(m.src)) return uploads.get(m.src);
    let file;
    if (m.isUrl) {
      file = await api('/upload-from-url', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ url: m.src }),
      });
    } else {
      const { bytes, mime, name } = await loadMedia(resolveMediaPath(cfg, m), { fetch, isUrl: false });
      const form = new FormData();
      form.append('file', new Blob([bytes], { type: mime }), name);
      file = await api('/upload', { method: 'POST', body: form });
    }
    const ref = { id: file.id, path: file.path };
    uploads.set(m.src, ref);
    return ref;
  }

  return {
    name: 'postiz',
    unconfigured(platform) {
      if (!env.POSTIZ_API_KEY) return 'POSTIZ_API_KEY not set';
      if (!cfg.platforms[platform]?.integration) return `no Postiz integration id for ${platform} in config.json`;
      return null;
    },
    /** GET /integrations, for `npm run postiz:integrations` when filling in config.json. */
    async integrations() {
      return api('/integrations');
    },
    async publish(rendered) {
      const pcfg = cfg.platforms[rendered.platform];
      const image = [];
      for (const m of rendered.media) image.push(await upload(m));
      const payload = {
        type: 'now',
        date: new Date().toISOString(),
        shortLink: false, // keep our UTM links as they are
        tags: [],
        posts: [
          {
            integration: { id: pcfg.integration },
            value: [{ content: postizContent(rendered), image }],
            settings: postizSettings(rendered, pcfg),
          },
        ],
      };
      const res = await api('/posts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });
      const first = Array.isArray(res) ? res[0] : res;
      return { url: null, remoteId: first?.postId ?? first?.id ?? null, note: 'handed to Postiz' };
    },
  };
}
