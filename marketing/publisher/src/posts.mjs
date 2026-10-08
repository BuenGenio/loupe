import { readdirSync, readFileSync } from 'node:fs';
import { basename, join, relative, resolve } from 'node:path';
import { parse as parseYaml } from 'yaml';
import { mediaKind } from './media.mjs';

/**
 * Finds post files under `dir`. Anything whose name starts with "_" or "." is
 * skipped, as are READMEs, so posts/_examples/ and posts/_drafts/ never
 * publish.
 */
export function findPostFiles(dir) {
  const out = [];
  let entries;
  try {
    entries = readdirSync(dir, { withFileTypes: true });
  } catch (err) {
    if (err.code === 'ENOENT') return out;
    throw err;
  }
  for (const e of entries.sort((a, b) => a.name.localeCompare(b.name))) {
    if (e.name.startsWith('_') || e.name.startsWith('.')) continue;
    const full = join(dir, e.name);
    if (e.isDirectory()) out.push(...findPostFiles(full));
    else if (e.isFile() && e.name.endsWith('.md') && e.name.toLowerCase() !== 'readme.md') out.push(full);
  }
  return out;
}

export function loadPosts(cfg) {
  return findPostFiles(cfg.postsDir).map((file) =>
    parsePost(readFileSync(file, 'utf8'), { file, relPath: relative(cfg.marketingDir, file) }),
  );
}

const FRONTMATTER_RE = /^﻿?---[ \t]*\r?\n([\s\S]*?)\r?\n---[ \t]*(?:\r?\n|$)/;

/**
 * Parses one post. Never throws: problems land in `post.errors` so `check`
 * can report every broken file in one run.
 */
export function parsePost(source, { file = 'post.md', relPath = file } = {}) {
  const errors = [];
  const post = {
    file,
    relPath,
    id: basename(file).replace(/\.md$/i, ''),
    date: null,
    status: 'draft',
    campaign: null,
    platforms: [],
    link: null,
    media: [],
    overrides: {},
    body: '',
    frontmatter: {},
    errors,
  };

  const m = source.match(FRONTMATTER_RE);
  if (!m) {
    errors.push('missing YAML frontmatter (the file must start with a line containing only ---)');
    return post;
  }
  let fm;
  try {
    fm = parseYaml(m[1]) ?? {};
  } catch (err) {
    errors.push(`frontmatter is not valid YAML: ${err.message.split('\n')[0]}`);
    return post;
  }
  if (typeof fm !== 'object' || Array.isArray(fm)) {
    errors.push('frontmatter must be a YAML mapping');
    return post;
  }
  post.frontmatter = fm;
  post.body = cleanBody(source.slice(m[0].length));

  if (fm.id != null) post.id = String(fm.id);
  if (fm.status != null) post.status = String(fm.status);
  if (fm.campaign != null) post.campaign = String(fm.campaign);
  if (fm.link != null) post.link = String(fm.link);

  if (fm.date instanceof Date) {
    post.date = fm.date;
  } else if (typeof fm.date === 'string') {
    const s = fm.date.trim();
    if (!/^\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}(:\d{2}(\.\d+)?)?(Z|[+-]\d{2}:?\d{2})$/i.test(s)) {
      errors.push(`date "${s}" must be ISO 8601 with a time and a zone, e.g. 2026-10-20T15:00:00Z`);
    } else {
      const d = new Date(s.replace(' ', 'T'));
      if (Number.isNaN(d.getTime())) errors.push(`date "${s}" is not a real date`);
      else post.date = d;
    }
  } else if (fm.date == null) {
    errors.push('date is required');
  } else {
    errors.push('date must be a string like 2026-10-20T15:00:00Z');
  }

  if (fm.platforms != null) {
    if (Array.isArray(fm.platforms)) post.platforms = fm.platforms.map((p) => String(p).toLowerCase());
    else errors.push('platforms must be a list, e.g. [bluesky, mastodon]');
  }

  if (fm.media != null) {
    if (!Array.isArray(fm.media)) {
      errors.push('media must be a list of { path, alt } items');
    } else {
      fm.media.forEach((item, i) => {
        const it = typeof item === 'string' ? { path: item } : item ?? {};
        const src = it.path ?? it.url;
        if (!src) {
          errors.push(`media[${i}] needs a path (relative to marketing/) or an https URL`);
          return;
        }
        const isUrl = /^https?:\/\//i.test(String(src));
        post.media.push({
          src: String(src),
          isUrl,
          alt: it.alt == null ? '' : String(it.alt).trim(),
          kind: it.type ? String(it.type) : mediaKind(String(src)),
        });
      });
    }
  }

  for (const [key, value] of Object.entries(fm)) {
    if (value && typeof value === 'object' && !Array.isArray(value) && !(value instanceof Date) && key !== 'media') {
      post.overrides[key] = value;
    }
  }
  return post;
}

/** The body is plain text: networks don't render Markdown. HTML comments are notes for authors and are dropped. */
function cleanBody(body) {
  return body
    .replace(/<!--[\s\S]*?-->/g, '')
    .replace(/[ \t]+$/gm, '')
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

export function resolveMediaPath(cfg, item) {
  return item.isUrl ? item.src : resolve(cfg.marketingDir, item.src);
}
