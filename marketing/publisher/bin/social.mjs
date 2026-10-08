#!/usr/bin/env node
// Loupe social posts as code. See marketing/README.md.
//
//   node bin/social.mjs check                       validate every post
//   node bin/social.mjs due                         what would publish now
//   node bin/social.mjs publish [--dry-run] [--only <id>] [--platform <p>]
//   node bin/social.mjs preview [<id>] [--platform <p>]
//   node bin/social.mjs calendar [--out <file>]
//   node bin/social.mjs postiz-integrations         list Postiz channel ids for config.json
//
// Shared options: --dir <posts dir>  --ledger <file>  --now <ISO time>  --config <file>

import { appendFileSync, mkdirSync, writeFileSync } from 'node:fs';
import { dirname, relative, resolve } from 'node:path';
import { parseArgs } from 'node:util';
import { buildCalendar } from '../src/calendar.mjs';
import { loadConfig } from '../src/config.mjs';
import { Ledger } from '../src/ledger.mjs';
import { PLATFORMS } from '../src/platforms.mjs';
import { createPostiz } from '../src/platforms/postiz.mjs';
import { loadPosts } from '../src/posts.mjs';
import { publish, summaryMarkdown } from '../src/publish.mjs';
import { renderPost } from '../src/render.mjs';
import { planTasks } from '../src/schedule.mjs';
import { configNotes, lengthReport, validateAll } from '../src/validate.mjs';

const GHA = process.env.GITHUB_ACTIONS === 'true';
const repoPath = (cfg, rel) => `marketing/${rel}`;
const annotate = (level, msg, file) => {
  if (GHA) console.log(`::${level}${file ? ` file=${file}` : ''}::${msg.replace(/\r?\n/g, '%0A')}`);
};
const log = {
  info: (m) => console.log(m),
  warn: (m) => (GHA ? annotate('warning', m) : console.warn(`warning: ${m}`)),
  error: (m) => (GHA ? annotate('error', m) : console.error(`error: ${m}`)),
};

const { values: opts, positionals } = parseArgs({
  allowPositionals: true,
  options: {
    'dry-run': { type: 'boolean', default: false },
    only: { type: 'string' },
    platform: { type: 'string' },
    'ignore-lateness': { type: 'boolean', default: false },
    strict: { type: 'boolean', default: false },
    dir: { type: 'string' },
    ledger: { type: 'string' },
    now: { type: 'string' },
    config: { type: 'string' },
    out: { type: 'string' },
    help: { type: 'boolean', short: 'h', default: false },
  },
});

const [command, ...rest] = positionals;
if (opts.help || !command) {
  console.log(`usage: social <check|due|publish|preview|calendar|postiz-integrations> [options]

  publish   --dry-run  --only <id>  --platform <name>  --ignore-lateness  --strict
  preview   [<id>] --platform <name>
  calendar  --out <file>       (default: marketing/calendar.json)
  shared    --dir <posts dir>  --ledger <file>  --now <ISO time>  --config <file>`);
  process.exit(command ? 0 : 1);
}

const cfg = loadConfig({
  ...(opts.config ? { configFile: resolve(opts.config) } : {}),
  ...(opts.dir ? { postsDir: resolve(opts.dir) } : {}),
  ...(opts.ledger ? { ledgerFile: resolve(opts.ledger) } : {}),
});
const now = opts.now ? new Date(opts.now) : new Date();
if (Number.isNaN(now.getTime())) {
  console.error(`--now "${opts.now}" is not a date`);
  process.exit(2);
}
if (opts.platform && !PLATFORMS[opts.platform]) {
  console.error(`unknown platform "${opts.platform}" (known: ${Object.keys(PLATFORMS).join(', ')})`);
  process.exit(2);
}
const fmt = (d) => (d ? d.toISOString().replace(/:00\.000Z$/, 'Z').replace('T', ' ') : '?');

const commands = {
  check() {
    const posts = loadPosts(cfg);
    const results = validateAll(posts, cfg, { now });
    let errors = 0;
    let warnings = 0;
    for (const { post, errors: e, warnings: w } of results) {
      const file = repoPath(cfg, post.relPath);
      if (!e.length && !w.length) {
        console.log(`ok    ${file}`);
        continue;
      }
      console.log(`${e.length ? 'FAIL ' : 'warn '} ${file}`);
      for (const m of e) {
        console.log(`        error: ${m}`);
        annotate('error', m, file);
      }
      for (const m of w) {
        console.log(`        warning: ${m}`);
        annotate('warning', m, file);
      }
      errors += e.length;
      warnings += w.length;
    }
    const where = relative(process.cwd(), cfg.postsDir) || '.';
    console.log(`\n${posts.length} post(s) in ${where}: ${errors} error(s), ${warnings} warning(s)`);
    for (const n of configNotes(cfg)) console.log(`config: ${n}`);
    return errors ? 1 : 0;
  },

  due() {
    const posts = loadPosts(cfg);
    const ledger = new Ledger(cfg.ledgerFile, { readOnly: true });
    const tasks = planTasks(posts, cfg, ledger, { now, only: opts.only, platform: opts.platform, ignoreLateness: opts['ignore-lateness'] });
    const by = (s) => tasks.filter((t) => t.state === s);
    console.log(`Now: ${fmt(now)}   ledger: ${relative(process.cwd(), cfg.ledgerFile)}   lateness limit: ${cfg.maxLatenessHours}h\n`);
    const due = by('due');
    console.log(due.length ? 'Due now:' : 'Nothing due now.');
    for (const t of due) console.log(`  ${fmt(t.post.date)}  ${t.post.id} → ${t.platform} (${t.mode})`);
    const late = by('late');
    if (late.length) {
      console.log('\nToo late (will be skipped and logged):');
      for (const t of late) console.log(`  ${fmt(t.post.date)}  ${t.post.id} → ${t.platform}  ${Math.round(t.lateHours)}h late`);
    }
    const next = by('future').slice(0, 8);
    if (next.length) {
      console.log('\nComing up:');
      for (const t of next) console.log(`  ${fmt(t.post.date)}  ${t.post.id} → ${t.platform} (${t.mode})`);
    }
    console.log(`\nAlready published: ${by('done').length}   drafts: ${by('draft').length}   platform off: ${by('off').length}`);
    return 0;
  },

  async publish() {
    const dryRun = opts['dry-run'];
    const result = await publish({
      cfg,
      now,
      log,
      dryRun,
      only: opts.only,
      platform: opts.platform,
      ignoreLateness: opts['ignore-lateness'],
      strict: opts.strict,
    });
    for (const r of result.results.filter((x) => x.outcome === 'dry-run')) {
      printRendered(r.rendered);
    }
    const counts = {};
    for (const r of result.results) counts[r.outcome] = (counts[r.outcome] ?? 0) + 1;
    const summary = Object.entries(counts).map(([k, v]) => `${v} ${k}`).join(', ') || 'nothing due';
    console.log(`\n${dryRun ? '[dry run] ' : ''}${summary}`);
    if (process.env.GITHUB_STEP_SUMMARY) appendFileSync(process.env.GITHUB_STEP_SUMMARY, summaryMarkdown(result, { dryRun }));
    return result.failed ? 1 : 0;
  },

  preview() {
    const id = rest[0] ?? opts.only;
    const posts = loadPosts(cfg).filter((p) => !id || p.id === id);
    if (id && !posts.length) {
      console.error(`no post with id "${id}"`);
      return 1;
    }
    for (const post of posts) {
      console.log(`\n${'='.repeat(72)}\n${post.id}  ${fmt(post.date)}  [${post.status}]  ${repoPath(cfg, post.relPath)}`);
      for (const p of post.platforms.filter((x) => PLATFORMS[x] && (!opts.platform || x === opts.platform))) {
        printRendered(renderPost(post, p, cfg));
      }
    }
    return 0;
  },

  calendar() {
    const posts = loadPosts(cfg);
    const ledger = new Ledger(cfg.ledgerFile, { readOnly: true });
    const cal = buildCalendar(posts, cfg, ledger, { now });
    const out = opts.out ? resolve(opts.out) : cfg.calendarFile;
    mkdirSync(dirname(out), { recursive: true });
    writeFileSync(out, `${JSON.stringify(cal, null, 2)}\n`);
    console.log(`wrote ${cal.entries.length} entries to ${relative(process.cwd(), out)}`);
    return 0;
  },

  async 'postiz-integrations'() {
    const postiz = createPostiz({ cfg, env: process.env, fetch: globalThis.fetch, log });
    if (!process.env.POSTIZ_API_KEY) {
      console.error('POSTIZ_API_KEY is not set');
      return 1;
    }
    const list = await postiz.integrations();
    console.log(`Postiz channels at ${cfg.postiz.url} (put the id into config.json → platforms.<name>.integration):\n`);
    for (const i of list) console.log(`  ${String(i.identifier).padEnd(22)} ${i.id}  ${i.name}${i.disabled ? '  (disabled)' : ''}`);
    return 0;
  },
};

function printRendered(r) {
  const meta = PLATFORMS[r.platform];
  console.log(`\n--- ${meta.label} (${r.mode}) ${'-'.repeat(Math.max(0, 56 - meta.label.length))}`);
  if (r.platform === 'reddit') console.log(`r/${r.options.subreddit}  [${r.options.kind} post]${r.options.flair ? `  flair: ${r.options.flair}` : ''}`);
  if (r.fields.title) console.log(`Title: ${r.fields.title}`);
  if (r.fields.spoiler) console.log(`CW: ${r.fields.spoiler}`);
  if (r.platform === 'instagram') console.log(`Kind: ${r.options.kind}`);
  console.log(r.primary || '(no text)');
  if (r.options.url) console.log(`URL: ${r.options.url}`);
  if (r.fields.tags?.length) console.log(`Tags: ${r.fields.tags.join(', ')}`);
  for (const s of r.linkSpans) console.log(`  ↳ "${r.primary.slice(s.start, s.end)}" links to ${s.url}`);
  if (r.platform === 'bluesky' && r.link && !r.media.length) console.log(`  ↳ link card: ${r.link}`);
  for (const m of r.media) console.log(`  [${m.kind}] ${m.src} — alt: ${m.alt || '(missing!)'}`);
  const lens = lengthReport(r)
    .map((l) => `${l.what} ${l.used}/${l.max}${l.ok ? '' : ' TOO LONG'}`)
    .join(' · ');
  console.log(`(${lens})`);
}

try {
  const code = await commands[command]?.();
  if (code === undefined) {
    console.error(`unknown command "${command}"`);
    process.exit(2);
  }
  process.exitCode = code;
} catch (err) {
  console.error(`error: ${err.message}`);
  process.exitCode = 1;
}
