// `publish`: post everything that is due, one platform at a time, each
// isolated from the others' failures.

import { Ledger } from './ledger.mjs';
import { loadPosts } from './posts.mjs';
import { renderPost } from './render.mjs';
import { planTasks } from './schedule.mjs';
import { validateAll } from './validate.mjs';
import { createAssist } from './platforms/assist.mjs';
import { createBluesky } from './platforms/bluesky.mjs';
import { createMastodon } from './platforms/mastodon.mjs';
import { createPostiz } from './platforms/postiz.mjs';

export function createAdapters(ctx) {
  const lazy = (make) => {
    let a;
    return () => (a ??= make(ctx));
  };
  const bluesky = lazy(createBluesky);
  const mastodon = lazy(createMastodon);
  const postiz = lazy(createPostiz);
  const assist = lazy(createAssist);
  return (platform, mode) => {
    if (mode === 'postiz') return postiz();
    if (mode === 'assist') return assist();
    if (mode === 'api' && platform === 'bluesky') return bluesky();
    if (mode === 'api' && platform === 'mastodon') return mastodon();
    throw new Error(`no ${mode} publisher for ${platform}`);
  };
}

export const silentLog = { info() {}, warn() {}, error() {} };

/**
 * Runs one publishing pass. Everything external is injectable: `fetch`,
 * `env`, `now`, `sleep`, `log`, `posts`, and `adapterFor` (tests swap in
 * fakes). A dry run touches neither the network nor the ledger file.
 *
 * Returns { results: [{ id, platform, mode, outcome, url?, error? }], failed }.
 * outcome: published | dry-run | failed | unconfigured | late
 */
export async function publish({
  cfg,
  env = process.env,
  fetch = globalThis.fetch,
  now = new Date(),
  sleep = (ms) => new Promise((r) => setTimeout(r, ms)),
  log = silentLog,
  dryRun = false,
  only,
  platform,
  ignoreLateness = false,
  strict = false,
  posts = loadPosts(cfg),
  ledger = new Ledger(cfg.ledgerFile, { readOnly: dryRun }),
  adapterFor,
} = {}) {
  const guardedFetch = dryRun
    ? () => {
        throw new Error('dry run: network access is not allowed');
      }
    : fetch;
  const ctx = { cfg, env, fetch: guardedFetch, sleep, log };
  adapterFor ??= createAdapters(ctx);

  const checked = new Map(validateAll(posts, cfg, { now }).map((v) => [v.post, v]));
  const tasks = planTasks(posts, cfg, ledger, { now, only, platform, ignoreLateness });
  if (only && !posts.some((p) => p.id === only)) throw new Error(`no post with id "${only}"`);

  const results = [];
  for (const t of tasks) {
    const base = { id: t.post.id, platform: t.platform, mode: t.mode };
    if (t.state === 'late') {
      const msg = `${t.post.id} → ${t.platform}: ${Math.round(t.lateHours)}h late (limit ${cfg.maxLatenessHours}h); skipped`;
      log.warn(msg);
      if (!dryRun) ledger.record({ ...base, status: 'skipped', note: msg });
      results.push({ ...base, outcome: 'late' });
      continue;
    }
    if (t.state !== 'due') continue;

    const { errors } = checked.get(t.post) ?? { errors: [] };
    if (errors.length) {
      const error = `post is invalid (run npm run check): ${errors[0]}`;
      log.error(`${t.post.id} → ${t.platform}: ${error}`);
      results.push({ ...base, outcome: 'failed', error });
      continue;
    }

    const rendered = renderPost(t.post, t.platform, cfg);
    let adapter;
    try {
      adapter = adapterFor(t.platform, t.mode);
    } catch (err) {
      results.push({ ...base, outcome: 'failed', error: err.message });
      continue;
    }
    if (dryRun) {
      log.info(`[dry run] would publish ${t.post.id} → ${t.platform} via ${t.mode}`);
      results.push({ ...base, outcome: 'dry-run', rendered });
      continue;
    }
    const why = adapter.unconfigured?.(t.platform);
    if (why) {
      log[strict ? 'error' : 'warn'](`${t.post.id} → ${t.platform}: not configured (${why}); skipped`);
      results.push({ ...base, outcome: 'unconfigured', error: why });
      continue;
    }
    try {
      const r = await adapter.publish(rendered);
      ledger.record({
        ...base,
        status: t.mode === 'assist' ? 'assist' : 'published',
        url: r.url ?? null,
        remoteId: r.remoteId ?? null,
        ...(r.note ? { note: r.note } : {}),
      });
      log.info(`${t.post.id} → ${t.platform}: ${t.mode === 'assist' ? 'assist issue' : 'published'} ${r.url ?? r.remoteId ?? ''}`.trimEnd());
      results.push({ ...base, outcome: 'published', url: r.url ?? null, remoteId: r.remoteId ?? null });
    } catch (err) {
      log.error(`${t.post.id} → ${t.platform}: FAILED, will retry next run: ${err.message}`);
      results.push({ ...base, outcome: 'failed', error: err.message });
    }
  }
  const failed = results.filter((r) => r.outcome === 'failed' || (strict && r.outcome === 'unconfigured')).length;
  return { results, failed, tasks };
}

/** Markdown for $GITHUB_STEP_SUMMARY. */
export function summaryMarkdown({ results }, { dryRun = false } = {}) {
  if (!results.length) return `### Social posts${dryRun ? ' (dry run)' : ''}\n\nNothing due.\n`;
  const icon = { published: '✅', 'dry-run': '🧪', failed: '❌', unconfigured: '⚠️', late: '⏭️' };
  const rows = results.map(
    (r) => `| ${icon[r.outcome] ?? ''} ${r.outcome} | \`${r.id}\` | ${r.platform} | ${r.mode} | ${(r.url ?? r.error ?? '').replace(/\|/g, '\\|')} |`,
  );
  return [`### Social posts${dryRun ? ' (dry run)' : ''}`, '', '| | Post | Platform | Via | Result |', '|---|---|---|---|---|', ...rows, ''].join('\n');
}
