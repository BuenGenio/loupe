// Turns a parsed post into exactly what goes out on one network.

import { PLATFORMS } from './platforms.mjs';
import { displayUrl } from './text.mjs';

/**
 * Adds utm_source=<platform>&utm_medium=social&utm_campaign=<campaign>,
 * keeping any query or fragment already on the link and never overwriting a
 * utm_* the author set by hand.
 */
export function utmLink(link, { source, medium = 'social', campaign }) {
  if (!link) return null;
  const u = new URL(link);
  const set = (k, v) => {
    if (v && !u.searchParams.has(k)) u.searchParams.set(k, v);
  };
  set('utm_source', source);
  set('utm_medium', medium);
  set('utm_campaign', campaign);
  return u.toString();
}

/** Where a missing {link} gets appended. Bluesky only when media takes the card's place. */
const APPENDS_LINK = new Set(['mastodon', 'threads', 'x', 'linkedin', 'facebook', 'youtube', 'reddit', 'bluesky']);

export function instagramKind(post, override) {
  if (override?.kind) return override.kind;
  const videos = post.media.filter((m) => m.kind === 'video').length;
  if (post.media.length > 1) return 'carousel';
  return videos === 1 ? 'reel' : 'image';
}

/**
 * Renders `post` for `platform`. The result carries the final text fields
 * plus `linkSpans`: UTF-16 ranges in the main text that must link to a URL
 * other than what they show (Bluesky shows "loupe.mx" but links the UTM URL).
 */
export function renderPost(post, platform, cfg) {
  const meta = PLATFORMS[platform];
  const pcfg = cfg.platforms?.[platform] ?? {};
  const o = post.overrides[platform] ?? {};
  const campaign = post.campaign ?? post.id;
  const link = post.link ? utmLink(post.link, { source: platform, medium: cfg.utm?.medium ?? 'social', campaign }) : null;
  const out = {
    id: post.id,
    platform,
    mode: pcfg.mode ?? 'off',
    date: post.date,
    link,
    rawLink: post.link,
    media: post.media,
    fields: {},
    linkSpans: [],
    options: {},
  };

  let kind = null;
  if (platform === 'reddit') {
    kind = o.kind ?? (post.link && o.text == null ? 'link' : 'text');
    out.options.kind = kind;
  }

  let text = String(o[meta.textField] ?? post.body ?? '').trim();
  const spans = [];
  if (text.includes('{link}')) {
    text = substituteLink(text, link, post.link, platform, spans);
  } else if (
    link &&
    APPENDS_LINK.has(platform) &&
    pcfg.appendLink !== false &&
    !text.includes(post.link) &&
    !(platform === 'bluesky' && post.media.length === 0) &&
    !(platform === 'reddit' && kind === 'link')
  ) {
    text = substituteLink(`${text.trimEnd()}\n\n{link}`.trimStart(), link, post.link, platform, spans);
  }
  out.fields[meta.textField] = text;
  out.linkSpans = spans;

  switch (platform) {
    case 'mastodon':
      out.fields.spoiler = String(o.spoiler ?? '').trim();
      out.options.visibility = o.visibility ?? pcfg.visibility ?? 'public';
      out.options.language = o.language ?? pcfg.language ?? cfg.languages?.[0];
      break;
    case 'bluesky':
      out.options.langs = o.langs ?? cfg.languages ?? ['en'];
      break;
    case 'youtube':
      out.fields.title = String(o.title ?? '').trim();
      out.fields.tags = Array.isArray(o.tags) ? o.tags.map(String) : [];
      out.options.short = Boolean(o.short);
      out.options.visibility = o.visibility ?? pcfg.visibility ?? 'public';
      break;
    case 'tiktok':
      out.fields.title = String(o.title ?? '').trim();
      break;
    case 'instagram':
      out.options.kind = instagramKind(post, o);
      break;
    case 'reddit':
      out.fields.title = String(o.title ?? '').trim();
      out.options.subreddit = String(o.subreddit ?? '').replace(/^\/?r\//i, '');
      out.options.flair = String(o.flair ?? '');
      out.options.url = kind === 'link' ? link : null;
      break;
  }
  out.primary = out.fields[meta.textField];
  return out;
}

function substituteLink(text, utm, raw, platform, spans) {
  const meta = PLATFORMS[platform];
  if (!utm) return text; // `check` reports {link} without a link
  let shown;
  if (!meta.clickableLinks) shown = displayUrl(raw);
  else if (platform === 'bluesky') shown = displayUrl(raw);
  else shown = utm;
  let result = '';
  let rest = text;
  let i;
  while ((i = rest.indexOf('{link}')) !== -1) {
    result += rest.slice(0, i);
    if (platform === 'bluesky') spans.push({ start: result.length, end: result.length + shown.length, url: utm });
    result += shown;
    rest = rest.slice(i + '{link}'.length);
  }
  return result + rest;
}
