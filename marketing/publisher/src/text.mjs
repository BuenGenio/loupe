// Text measuring the way each network does it.
//
// Every network counts differently: Bluesky counts graphemes (and caps UTF-8
// bytes), Mastodon counts graphemes but every URL as 23 and remote mentions
// as just "@user", X weights most non-Latin characters and every emoji as 2
// and URLs as 23, YouTube caps descriptions in bytes. The functions here are
// pure so `check` and the tests can use them without any network.

const segmenter = new Intl.Segmenter('en', { granularity: 'grapheme' });
const encoder = new TextEncoder();

export function graphemes(text) {
  let n = 0;
  for (const _ of segmenter.segment(text)) n++;
  return n;
}

export function utf8Length(text) {
  return encoder.encode(text).length;
}

export function utf16Length(text) {
  return text.length;
}

/** Byte offset (UTF-8) of a UTF-16 index into `text`. Bluesky facets use these. */
export function utf8Offset(text, utf16Index) {
  return encoder.encode(text.slice(0, utf16Index)).length;
}

// A URL as Mastodon/X see it: scheme, then anything up to whitespace, minus
// trailing punctuation that is almost never part of the link.
const URL_RE = /\bhttps?:\/\/[^\s<>"]+[^\s<>".,;:!?)\]'’”]/giu;

export function findUrls(text) {
  return [...text.matchAll(URL_RE)].map((m) => ({ url: m[0], start: m.index, end: m.index + m[0].length }));
}

/**
 * Mastodon: StatusLengthValidator counts graphemes, every http(s) URL as 23
 * characters, and "@user@remote.domain" as "@user". Content warning text
 * counts towards the same limit.
 */
export function mastodonLength(text, spoiler = '') {
  const countable = text
    .replace(URL_RE, 'x'.repeat(23))
    .replace(/(^|[^\p{L}\p{N}_/])@([\p{L}\p{N}_]+(?:[.-][\p{L}\p{N}_]+)*)@[\p{L}\p{N}.-]+\.[\p{L}]{2,}/gu, '$1@$2');
  return graphemes(countable) + graphemes(spoiler);
}

// twitter-text v3 weighting: these code point ranges weigh 1, everything else
// 2; any emoji sequence weighs 2; every URL is 23 (t.co).
const X_LIGHT_RANGES = [
  [0, 4351],
  [8192, 8205],
  [8208, 8223],
  [8242, 8247],
];
const EMOJI_RE = /\p{Extended_Pictographic}|\p{Regional_Indicator}/u;

export function xWeightedLength(text) {
  let n = 0;
  let last = 0;
  for (const { start, end } of findUrls(text)) {
    n += weighPlain(text.slice(last, start)) + 23;
    last = end;
  }
  return n + weighPlain(text.slice(last));
}

function weighPlain(text) {
  let n = 0;
  for (const { segment } of segmenter.segment(text)) {
    if (EMOJI_RE.test(segment)) {
      n += 2;
      continue;
    }
    for (const ch of segment) {
      const cp = ch.codePointAt(0);
      n += X_LIGHT_RANGES.some(([lo, hi]) => cp >= lo && cp <= hi) ? 1 : 2;
    }
  }
  return n;
}

/** Threads: 500 "characters" where an emoji counts as its UTF-8 byte length. */
export function threadsLength(text) {
  let n = 0;
  for (const { segment } of segmenter.segment(text)) n += EMOJI_RE.test(segment) ? utf8Length(segment) : 1;
  return n;
}

export function hashtags(text) {
  return [...text.matchAll(/(^|[^\p{L}\p{N}_&/])#([\p{L}\p{N}_]*\p{L}[\p{L}\p{N}_]*)/gu)].map((m) => m[2]);
}

export function mentions(text) {
  return [...text.matchAll(/(^|[^\p{L}\p{N}_/])@([\p{L}\p{N}_.]+)/gu)].map((m) => m[2]);
}

/** Counting methods by name, as referenced from the limits table. */
export const COUNTERS = {
  graphemes,
  utf16: utf16Length,
  bytes: utf8Length,
  mastodon: (text, extra) => mastodonLength(text, extra?.spoiler ?? ''),
  x: xWeightedLength,
  threads: threadsLength,
  links: (text) => new Set(findUrls(text).map((u) => u.url)).size,
};

/** "https://loupe.mx/blog/?a=1" -> "loupe.mx/blog" — how a link reads where links are not clickable. */
export function displayUrl(url) {
  try {
    const u = new URL(url);
    const path = u.pathname.replace(/\/+$/, '');
    return u.host.replace(/^www\./, '') + path;
  } catch {
    return url;
  }
}
