// What each network accepts. Numbers checked 2026-10-08; sources are in
// marketing/README.md. `count` names a counter in text.mjs.

export const PLATFORMS = {
  bluesky: {
    label: 'Bluesky',
    textField: 'text',
    limits: [
      { field: 'text', max: 300, count: 'graphemes' },
      { field: 'text', max: 3000, count: 'bytes' },
    ],
    media: { maxImages: 4, maxVideos: 1, mix: false, maxImageBytes: 2_000_000, maxVideoBytes: 300_000_000 },
    // Links: the text shows "loupe.mx/…" and a link facet carries the full UTM URL.
    clickableLinks: true,
  },
  mastodon: {
    label: 'Mastodon',
    textField: 'text',
    limits: [{ field: 'text', max: 500, count: 'mastodon' }],
    media: { maxImages: 4, maxVideos: 1, mix: false },
    clickableLinks: true,
  },
  threads: {
    label: 'Threads',
    textField: 'text',
    // Threads counts an emoji as its UTF-8 byte length and allows at most 5 links.
    limits: [
      { field: 'text', max: 500, count: 'threads' },
      { field: 'text', max: 5, count: 'links' },
    ],
    media: { maxImages: 20, maxVideos: 20, mix: true },
    clickableLinks: true,
  },
  x: {
    label: 'X',
    textField: 'text',
    limits: [{ field: 'text', max: 280, count: 'x' }],
    media: { maxImages: 4, maxVideos: 1, mix: false },
    clickableLinks: true,
  },
  linkedin: {
    label: 'LinkedIn',
    textField: 'text',
    limits: [{ field: 'text', max: 3000, count: 'utf16' }],
    media: { maxImages: 20, maxVideos: 1, mix: false },
    clickableLinks: true,
  },
  facebook: {
    label: 'Facebook',
    textField: 'text',
    limits: [{ field: 'text', max: 63206, count: 'utf16' }],
    media: { maxImages: 10, maxVideos: 1, mix: false },
    clickableLinks: true,
  },
  instagram: {
    label: 'Instagram',
    textField: 'caption',
    limits: [
      { field: 'caption', max: 2200, count: 'utf16' },
      { field: 'caption', max: 30, count: 'hashtags' },
      { field: 'caption', max: 20, count: 'mentions' },
    ],
    media: { required: true, maxImages: 10, maxVideos: 10, mix: true },
    // Links in captions are not clickable: {link} renders as "loupe.mx".
    clickableLinks: false,
  },
  tiktok: {
    label: 'TikTok',
    textField: 'caption',
    limits: [
      // TikTok allows 2200 UTF-16 units for video captions; Postiz caps TikTok at 2000.
      { field: 'caption', max: 2000, count: 'utf16' },
      { field: 'title', max: 90, count: 'utf16' },
    ],
    media: { required: true, maxImages: 35, maxVideos: 1, mix: false },
    clickableLinks: false,
  },
  youtube: {
    label: 'YouTube',
    textField: 'description',
    limits: [
      { field: 'title', max: 100, count: 'graphemes' },
      { field: 'description', max: 5000, count: 'bytes' },
      { field: 'tags', max: 500, count: 'tags' },
    ],
    media: { required: true, requiresVideo: true, maxImages: 0, maxVideos: 1, mix: false },
    clickableLinks: true,
  },
  reddit: {
    label: 'Reddit',
    textField: 'text',
    limits: [
      { field: 'title', max: 300, count: 'utf16' },
      { field: 'text', max: 40000, count: 'utf16' },
    ],
    media: { maxImages: 20, maxVideos: 1, mix: false },
    clickableLinks: true,
  },
};

export const PLATFORM_NAMES = Object.keys(PLATFORMS);

/**
 * Keys allowed inside each per-platform override block. `boost` (vista mode)
 * names a Vista Social boost configuration id, or `false` to skip the
 * platform's default boost for this post.
 */
export const OVERRIDE_KEYS = {
  bluesky: ['text', 'langs', 'boost'],
  mastodon: ['text', 'spoiler', 'visibility', 'language'],
  threads: ['text', 'boost'],
  x: ['text', 'boost'],
  linkedin: ['text', 'boost'],
  facebook: ['text', 'boost'],
  instagram: ['caption', 'kind', 'boost'],
  tiktok: ['caption', 'title', 'boost'],
  youtube: ['title', 'description', 'tags', 'short', 'visibility', 'boost'],
  reddit: ['subreddit', 'title', 'text', 'flair', 'kind', 'boost'],
};

export const MODES = ['api', 'postiz', 'vista', 'assist', 'off'];

/** Which modes each platform can actually run in. */
export const SUPPORTED_MODES = {
  bluesky: ['api', 'postiz', 'vista', 'assist', 'off'],
  mastodon: ['api', 'postiz', 'assist', 'off'], // Vista Social has no Mastodon
  threads: ['postiz', 'vista', 'assist', 'off'],
  x: ['postiz', 'vista', 'assist', 'off'],
  linkedin: ['postiz', 'vista', 'assist', 'off'],
  facebook: ['postiz', 'vista', 'assist', 'off'],
  instagram: ['postiz', 'vista', 'assist', 'off'],
  tiktok: ['postiz', 'vista', 'assist', 'off'],
  youtube: ['postiz', 'vista', 'assist', 'off'],
  reddit: ['postiz', 'vista', 'assist', 'off'],
};
