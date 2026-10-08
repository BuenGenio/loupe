// `check`: everything that can be known about a post without a network.

import { existsSync, statSync } from 'node:fs';
import { PLATFORMS, PLATFORM_NAMES, OVERRIDE_KEYS } from './platforms.mjs';
import { renderPost } from './render.mjs';
import { resolveMediaPath } from './posts.mjs';
import { COUNTERS, hashtags, mentions } from './text.mjs';

const TOP_LEVEL_KEYS = new Set(['id', 'date', 'status', 'campaign', 'platforms', 'link', 'media', ...PLATFORM_NAMES]);
const ID_RE = /^[a-z0-9][a-z0-9._-]*$/;

function measure(count, value, extra) {
  switch (count) {
    case 'hashtags':
      return hashtags(value).length;
    case 'mentions':
      return mentions(value).length;
    case 'tags':
      // YouTube: total characters, commas between tags count, and a tag
      // containing a space counts its surrounding quotes.
      return value.reduce((n, t, i) => n + t.length + (/\s/.test(t) ? 2 : 0) + (i ? 1 : 0), 0);
    default:
      return COUNTERS[count](value, extra);
  }
}

const UNITS = {
  graphemes: 'characters',
  utf16: 'characters',
  bytes: 'bytes (UTF-8)',
  mastodon: 'characters (URLs count as 23)',
  x: 'weighted characters (URLs count as 23)',
  hashtags: 'hashtags',
  mentions: '@mentions',
  tags: 'characters of tags',
  threads: 'characters (emoji count as their UTF-8 bytes)',
  links: 'distinct links',
};

const SHORT = { bytes: 'bytes', hashtags: '#tags', mentions: '@mentions', links: 'links', tags: 'chars' };

/** Length report for one rendered post: [{ field, used, max, unit, ok }]. */
export function lengthReport(rendered) {
  const meta = PLATFORMS[rendered.platform];
  return meta.limits.map(({ field, max, count }) => {
    const value = rendered.fields[field] ?? (count === 'tags' ? [] : '');
    const used = measure(count, value, rendered.fields);
    const what = SHORT[count] ? `${field} ${SHORT[count]}` : field;
    return { field, what, used, max, unit: UNITS[count], ok: used <= max };
  });
}

/**
 * Validates one post. Returns { errors: [], warnings: [] }. `allIds` (a Map
 * of id -> count) catches duplicates across files.
 */
export function validatePost(post, cfg, { allIds, now = new Date() } = {}) {
  const errors = [...post.errors];
  const warnings = [];
  const fm = post.frontmatter;

  if (!ID_RE.test(post.id)) errors.push(`id "${post.id}" must be lowercase letters, digits, ".", "_" or "-"`);
  if (allIds && allIds.get(post.id) > 1) errors.push(`id "${post.id}" is used by more than one post`);
  if (!['scheduled', 'draft'].includes(post.status)) errors.push(`status must be "scheduled" or "draft", not "${post.status}"`);
  for (const key of Object.keys(fm)) {
    if (!TOP_LEVEL_KEYS.has(key)) warnings.push(`unknown frontmatter key "${key}" (typo?)`);
  }
  // A file whose frontmatter didn't parse has nothing more worth checking.
  if (post.errors.length && Object.keys(fm).length === 0) return { errors, warnings };

  if (post.platforms.length === 0 && post.status === 'scheduled') errors.push('platforms is empty: nothing would be published');
  for (const p of post.platforms) {
    if (!PLATFORMS[p]) errors.push(`unknown platform "${p}" (known: ${PLATFORM_NAMES.join(', ')})`);
  }
  for (const p of PLATFORM_NAMES) {
    const o = post.overrides[p];
    if (!o) continue;
    if (!post.platforms.includes(p)) warnings.push(`has a "${p}" block but ${p} is not in platforms`);
    for (const k of Object.keys(o)) {
      if (!OVERRIDE_KEYS[p].includes(k)) warnings.push(`${p}.${k} is not a known field (known: ${OVERRIDE_KEYS[p].join(', ')})`);
    }
  }

  if (post.link != null) {
    try {
      const u = new URL(post.link);
      if (!/^https?:$/.test(u.protocol)) throw new Error();
    } catch {
      errors.push(`link "${post.link}" is not an http(s) URL`);
    }
  }
  if (post.campaign != null && !/^[a-z0-9][a-z0-9._-]*$/i.test(post.campaign)) {
    warnings.push(`campaign "${post.campaign}" has characters that look odd in a utm_campaign`);
  }

  // Media: exists, has alt text, is a type we can post.
  const sizes = [];
  post.media.forEach((m, i) => {
    const label = `media[${i}] (${m.src})`;
    if (!m.alt) errors.push(`${label} has no alt text`);
    if (m.kind === 'unknown') errors.push(`${label}: can't tell if it's an image or a video; use .png/.jpg/.webp/.gif/.mp4/.mov or add type: image|video`);
    if (m.isUrl) {
      if (!/^https:\/\//i.test(m.src)) errors.push(`${label}: remote media must be https`);
      sizes.push(null);
      return;
    }
    if (m.src.startsWith('/') || m.src.includes('..')) {
      errors.push(`${label}: use a path relative to marketing/, e.g. media/launch/inbox.png`);
    }
    const path = resolveMediaPath(cfg, m);
    if (!existsSync(path)) {
      errors.push(`${label} does not exist (paths are relative to marketing/)`);
      sizes.push(null);
    } else {
      sizes.push(statSync(path).size);
    }
  });

  if (post.date && post.status === 'scheduled') {
    const lateH = (now - post.date) / 3_600_000;
    if (lateH > (cfg.maxLatenessHours ?? 12)) {
      warnings.push(`date ${post.date.toISOString()} is ${Math.round(lateH)}h in the past: platforms not yet published will be skipped as late`);
    }
  }

  // Per platform: render and measure.
  for (const platform of post.platforms.filter((p) => PLATFORMS[p])) {
    const meta = PLATFORMS[platform];
    const r = renderPost(post, platform, cfg);
    const tag = `[${platform}]`;

    for (const l of lengthReport(r)) {
      if (!l.ok) errors.push(`${tag} ${l.field} is ${l.used} ${l.unit}; the limit is ${l.max}`);
    }
    const main = r.primary;
    if (!main.trim() && !['reddit', 'youtube', 'tiktok', 'instagram'].includes(platform)) {
      errors.push(`${tag} has no text: write a body or ${platform}.${meta.textField}`);
    }
    if (/\{link\}/.test(String(post.overrides[platform]?.[meta.textField] ?? post.body)) && !post.link) {
      errors.push(`${tag} text uses {link} but the post has no link`);
    }
    const stray = main.match(/\{[a-z_]+\}/gi)?.filter((m) => m !== '{link}');
    if (stray?.length) warnings.push(`${tag} text contains ${[...new Set(stray)].join(', ')}: only {link} is replaced`);

    // Media rules
    const images = post.media.filter((m) => m.kind === 'image');
    const videos = post.media.filter((m) => m.kind === 'video');
    const rules = meta.media;
    if (rules.required && post.media.length === 0) errors.push(`${tag} needs at least one image or video`);
    if (rules.requiresVideo && videos.length !== 1) errors.push(`${tag} needs exactly one video`);
    if (images.length > rules.maxImages && !rules.requiresVideo) errors.push(`${tag} takes at most ${rules.maxImages} images (got ${images.length})`);
    if (videos.length > rules.maxVideos) errors.push(`${tag} takes at most ${rules.maxVideos} video(s) (got ${videos.length})`);
    if (!rules.mix && images.length && videos.length) errors.push(`${tag} can't mix images and video in one post`);
    if (rules.maxImageBytes) {
      post.media.forEach((m, i) => {
        if (m.kind === 'image' && sizes[i] > rules.maxImageBytes) {
          errors.push(`${tag} ${m.src} is ${sizes[i]} bytes; ${meta.label} takes images up to ${rules.maxImageBytes} bytes`);
        }
      });
    }
    if (rules.maxVideoBytes) {
      post.media.forEach((m, i) => {
        if (m.kind === 'video' && sizes[i] > rules.maxVideoBytes) {
          errors.push(`${tag} ${m.src} is ${sizes[i]} bytes; ${meta.label} takes videos up to ${rules.maxVideoBytes} bytes`);
        }
      });
    }

    if (platform === 'instagram') {
      const kind = r.options.kind;
      if (!['image', 'carousel', 'reel'].includes(kind)) errors.push(`${tag} kind must be image, carousel or reel`);
      if (kind === 'reel' && (videos.length !== 1 || post.media.length !== 1)) errors.push(`${tag} a reel is exactly one video`);
      if (kind === 'image' && (images.length !== 1 || post.media.length !== 1)) errors.push(`${tag} kind image takes exactly one image (use carousel for more)`);
      if (kind === 'carousel' && (post.media.length < 2 || post.media.length > 10)) errors.push(`${tag} a carousel takes 2 to 10 items`);
      if (post.media.some((m) => m.kind === 'image' && !/\.jpe?g$/i.test(m.src))) {
        warnings.push(`${tag} Instagram's API officially supports only JPEG images; prefer .jpg for Instagram`);
      }
    }
    if (platform === 'tiktok' && images.length && !videos.length && r.primary.length > 4000) {
      errors.push(`${tag} photo post descriptions are limited to 4000 characters`);
    }
    if (platform === 'youtube') {
      if (!r.fields.title.trim()) errors.push(`${tag} youtube.title is required`);
      if (/[<>]/.test(r.fields.title) || /[<>]/.test(r.fields.description)) errors.push(`${tag} YouTube rejects < and > in titles and descriptions`);
    }
    if (platform === 'reddit') {
      if (!r.options.subreddit) errors.push(`${tag} reddit.subreddit is required`);
      else if (!/^[A-Za-z0-9][A-Za-z0-9_]{1,20}$/.test(r.options.subreddit)) errors.push(`${tag} "${r.options.subreddit}" is not a valid subreddit name`);
      if (!r.fields.title.trim()) errors.push(`${tag} reddit.title is required`);
      if (!['link', 'text'].includes(r.options.kind)) errors.push(`${tag} reddit.kind must be link or text`);
      if (r.options.kind === 'link' && !post.link) errors.push(`${tag} a link post needs link:`);
    }
  }
  return { errors, warnings };
}

export function validateAll(posts, cfg, opts = {}) {
  const allIds = new Map();
  for (const p of posts) allIds.set(p.id, (allIds.get(p.id) ?? 0) + 1);
  return posts.map((post) => ({ post, ...validatePost(post, cfg, { ...opts, allIds }) }));
}

/** Config-level notes for `check`, printed once rather than per post. */
export function configNotes(cfg, env = process.env) {
  const notes = [];
  const byMode = (m) => Object.entries(cfg.platforms).filter(([, p]) => p.mode === m).map(([k]) => k);
  const missingIds = byMode('postiz').filter((k) => !cfg.platforms[k].integration);
  if (missingIds.length) notes.push(`no Postiz integration id yet for: ${missingIds.join(', ')} (skipped until set; npm run postiz:integrations lists them)`);
  if (byMode('off').length) notes.push(`off: ${byMode('off').join(', ')}`);
  if (byMode('assist').length) notes.push(`assist (a GitHub issue for a human to post): ${byMode('assist').join(', ')}`);
  return notes;
}
