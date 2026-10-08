import assert from 'node:assert/strict';
import { existsSync, readFileSync } from 'node:fs';
import { describe, it } from 'node:test';
import { buildCalendar } from '../src/calendar.mjs';
import { Ledger } from '../src/ledger.mjs';
import { loadPosts } from '../src/posts.mjs';
import { publish, summaryMarkdown } from '../src/publish.mjs';
import { ENV, blueskyRoutes, mockFetch, png, silent, tempMarketing, testConfig, write } from './helpers.mjs';

const NOW = new Date('2026-10-20T15:10:00Z');

function setup(posts) {
  const dir = tempMarketing();
  write(dir, 'media/a.png', png(1080, 1350));
  for (const [name, text] of Object.entries(posts)) write(dir, `posts/${name}`, text);
  const cfg = testConfig(dir);
  return { dir, cfg };
}

const LAUNCH = `---
id: launch
date: 2026-10-20T15:00:00Z
status: scheduled
campaign: launch
platforms: [bluesky, mastodon, threads, reddit]
link: https://loupe.mx/
media:
  - path: media/a.png
    alt: The inbox
reddit: { subreddit: androidapps, title: "Loupe" }
---
Loupe is out {link}
`;

/** Fake adapters that record calls; `fail` makes a platform throw. */
function fakeAdapters({ fail = [] } = {}) {
  const calls = [];
  const adapterFor = (platform, mode) => ({
    unconfigured: () => null,
    async publish(r) {
      calls.push(`${r.id}/${platform}/${mode}`);
      if (fail.includes(platform)) throw new Error(`${platform} is down`);
      return { url: `https://${platform}.example/${r.id}`, remoteId: `${platform}-1` };
    },
  });
  return { calls, adapterFor };
}

describe('publish', () => {
  it('publishes every due platform and records it in the ledger', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH });
    const { calls, adapterFor } = fakeAdapters();
    const { results, failed } = await publish({ cfg, now: NOW, adapterFor, log: silent() });
    assert.equal(failed, 0);
    assert.deepEqual(calls.sort(), ['launch/bluesky/api', 'launch/mastodon/api', 'launch/reddit/assist', 'launch/threads/postiz']);
    assert.ok(results.every((r) => r.outcome === 'published'));
    const ledger = JSON.parse(readFileSync(cfg.ledgerFile, 'utf8'));
    assert.equal(ledger.version, 1);
    const reddit = ledger.entries.find((e) => e.platform === 'reddit');
    assert.equal(reddit.status, 'assist');
    assert.equal(reddit.url, 'https://reddit.example/launch');
    const bsky = ledger.entries.find((e) => e.platform === 'bluesky');
    assert.equal(bsky.status, 'published');
    assert.ok(bsky.publishedAt);
  });

  it('is idempotent: a second run posts nothing already in the ledger', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH });
    await publish({ cfg, now: NOW, adapterFor: fakeAdapters().adapterFor, log: silent() });
    const second = fakeAdapters();
    const later = new Date(NOW.getTime() + 30 * 60_000);
    const { results } = await publish({ cfg, now: later, adapterFor: second.adapterFor, log: silent() });
    assert.deepEqual(second.calls, []);
    assert.deepEqual(results, []);
  });

  it('skips posts more than maxLatenessHours late, logs them, and records the skip once', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH });
    const log = silent();
    const fake = fakeAdapters();
    const late = new Date('2026-10-21T03:30:00Z'); // 12.5 h after
    const { results, failed } = await publish({ cfg, now: late, adapterFor: fake.adapterFor, log });
    assert.equal(failed, 0);
    assert.deepEqual(fake.calls, []);
    assert.equal(results.filter((r) => r.outcome === 'late').length, 4);
    assert.equal(log.lines.warn.length, 4);
    assert.match(log.lines.warn[0], /13h late \(limit 12h\); skipped/);
    const ledger = new Ledger(cfg.ledgerFile);
    assert.ok(ledger.isSkipped('launch', 'bluesky'));
    // next run: quiet
    const log2 = silent();
    await publish({ cfg, now: late, adapterFor: fake.adapterFor, log: log2 });
    assert.equal(log2.lines.warn.length, 0);
    // but --ignore-lateness publishes it
    await publish({ cfg, now: late, adapterFor: fake.adapterFor, log: silent(), only: 'launch', platform: 'bluesky', ignoreLateness: true });
    assert.deepEqual(fake.calls, ['launch/bluesky/api']);
  });

  it('just within the window still publishes', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH });
    const fake = fakeAdapters();
    await publish({ cfg, now: new Date('2026-10-21T02:59:00Z'), adapterFor: fake.adapterFor, log: silent(), platform: 'mastodon' });
    assert.deepEqual(fake.calls, ['launch/mastodon/api']);
  });

  it('one platform failing does not block the others; it is retried next run', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH });
    const broken = fakeAdapters({ fail: ['mastodon'] });
    const log = silent();
    const run1 = await publish({ cfg, now: NOW, adapterFor: broken.adapterFor, log });
    assert.equal(run1.failed, 1);
    assert.equal(run1.results.find((r) => r.platform === 'mastodon').error, 'mastodon is down');
    assert.equal(run1.results.filter((r) => r.outcome === 'published').length, 3);
    assert.match(log.lines.error[0], /launch → mastodon: FAILED, will retry next run: mastodon is down/);
    const ledger = new Ledger(cfg.ledgerFile);
    assert.ok(!ledger.isDone('launch', 'mastodon'));
    assert.ok(ledger.isDone('launch', 'bluesky'));

    const fixed = fakeAdapters();
    const run2 = await publish({ cfg, now: new Date(NOW.getTime() + 30 * 60_000), adapterFor: fixed.adapterFor, log: silent() });
    assert.deepEqual(fixed.calls, ['launch/mastodon/api']);
    assert.equal(run2.failed, 0);
  });

  it('isolates real adapters too: a Bluesky outage still lets Mastodon post', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH.replace('platforms: [bluesky, mastodon, threads, reddit]', 'platforms: [bluesky, mastodon]') });
    const fetch = mockFetch([
      ['POST bsky.social/', () => Response.json({ error: 'InternalServerError', message: 'down' }, { status: 502 })],
      ['POST mastodon.example/api/v2/media', () => ({ id: 'm1', url: 'https://files/m1.png' })],
      ['POST mastodon.example/api/v1/statuses', () => ({ id: '7', url: 'https://mastodon.example/@loupe/7' })],
    ]);
    const { results, failed } = await publish({ cfg, env: ENV, fetch, now: NOW, log: silent() });
    assert.equal(failed, 1);
    assert.equal(results.find((r) => r.platform === 'bluesky').outcome, 'failed');
    assert.equal(results.find((r) => r.platform === 'mastodon').url, 'https://mastodon.example/@loupe/7');
  });

  it('dry run makes no network calls and writes no ledger', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH });
    const fetch = mockFetch([[() => true, () => assert.fail('network!')]]);
    const { results, failed } = await publish({ cfg, env: ENV, fetch, now: NOW, dryRun: true, log: silent() });
    assert.equal(failed, 0);
    assert.equal(fetch.calls.length, 0);
    assert.equal(results.length, 4);
    assert.ok(results.every((r) => r.outcome === 'dry-run'));
    assert.equal(results.find((r) => r.platform === 'mastodon').rendered.fields.text, 'Loupe is out https://loupe.mx/?utm_source=mastodon&utm_medium=social&utm_campaign=launch');
    assert.equal(existsSync(cfg.ledgerFile), false);
  });

  it('dry run does not record late skips either', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH });
    const { results } = await publish({ cfg, now: new Date('2026-10-22T00:00:00Z'), dryRun: true, log: silent(), fetch: () => assert.fail('network!') });
    assert.ok(results.every((r) => r.outcome === 'late'));
    assert.equal(existsSync(cfg.ledgerFile), false);
  });

  it('never publishes drafts or future posts; --only and --platform filter', async () => {
    const { cfg } = setup({
      'launch.md': LAUNCH,
      'draft.md': LAUNCH.replace('id: launch', 'id: draft').replace('status: scheduled', 'status: draft'),
      'future.md': LAUNCH.replace('id: launch', 'id: future').replace('2026-10-20T15:00:00Z', '2026-10-20T16:00:00Z'),
    });
    const fake = fakeAdapters();
    await publish({ cfg, now: NOW, adapterFor: fake.adapterFor, log: silent(), only: 'launch', platform: 'threads' });
    assert.deepEqual(fake.calls, ['launch/threads/postiz']);
    await publish({ cfg, now: NOW, adapterFor: fake.adapterFor, log: silent() });
    assert.ok(fake.calls.every((c) => c.startsWith('launch/')));
    await assert.rejects(publish({ cfg, now: NOW, adapterFor: fake.adapterFor, log: silent(), only: 'nope' }), /no post with id "nope"/);
  });

  it('skips unconfigured platforms with a warning (a failure with --strict)', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH });
    const log = silent();
    const { results, failed } = await publish({ cfg, env: {}, fetch: mockFetch(), now: NOW, log, platform: 'bluesky' });
    assert.equal(failed, 0);
    assert.equal(results[0].outcome, 'unconfigured');
    assert.match(log.lines.warn[0], /BLUESKY_HANDLE/);
    assert.equal(existsSync(cfg.ledgerFile), false, 'not recorded: it publishes once configured');
    const strict = await publish({ cfg, env: {}, fetch: mockFetch(), now: NOW, log: silent(), platform: 'bluesky', strict: true });
    assert.equal(strict.failed, 1);
  });

  it('an invalid post fails on its own without blocking valid ones', async () => {
    const { cfg } = setup({
      'launch.md': LAUNCH,
      'broken.md': LAUNCH.replace('id: launch', 'id: broken').replace('alt: The inbox', 'alt: ""'),
    });
    const fake = fakeAdapters();
    const { results, failed } = await publish({ cfg, now: NOW, adapterFor: fake.adapterFor, log: silent() });
    assert.equal(failed, 4);
    assert.ok(results.filter((r) => r.id === 'broken').every((r) => r.outcome === 'failed' && /no alt text/.test(r.error)));
    assert.equal(fake.calls.filter((c) => c.startsWith('launch/')).length, 4);
  });

  it('end to end with real adapters and mocked services', async () => {
    const { cfg } = setup({ 'launch.md': LAUNCH });
    const records = [];
    const fetch = mockFetch([
      ...blueskyRoutes(records),
      ['POST mastodon.example/api/v2/media', () => ({ id: 'm1', url: 'https://files/m1.png' })],
      ['POST mastodon.example/api/v1/statuses', () => ({ id: '7', url: 'https://mastodon.example/@loupe/7' })],
      ['POST api.postiz.com/public/v1/upload', () => ({ id: 'u1', path: 'https://uploads.postiz.com/a.png' })],
      ['POST api.postiz.com/public/v1/posts', () => [{ postId: 'p-9', integration: 'th-1' }]],
      ['POST api.github.com/repos/acme/loupe/issues', () => Response.json({ number: 5, html_url: 'https://github.com/acme/loupe/issues/5' }, { status: 201 })],
    ]);
    const result = await publish({ cfg, env: ENV, fetch, now: NOW, log: silent() });
    assert.equal(result.failed, 0, JSON.stringify(result.results));
    assert.equal(records.length, 1);
    const md = summaryMarkdown(result);
    assert.match(md, /\| ✅ published \| `launch` \| reddit \| assist \| https:\/\/github.com\/acme\/loupe\/issues\/5 \|/);

    const cal = buildCalendar(loadPosts(cfg), cfg, new Ledger(cfg.ledgerFile, { readOnly: true }), { now: NOW });
    const byPlatform = Object.fromEntries(cal.entries.map((e) => [e.platform, e]));
    assert.equal(byPlatform.mastodon.status, 'published');
    assert.equal(byPlatform.mastodon.url, 'https://mastodon.example/@loupe/7');
    assert.equal(byPlatform.reddit.status, 'assist');
    assert.equal(byPlatform.threads.date, '2026-10-20');
    assert.equal(byPlatform.threads.time, '15:00');
  });
});

describe('calendar', () => {
  it('flattens posts per platform with status, date, time and text', () => {
    const { cfg } = setup({
      'launch.md': LAUNCH,
      'draft.md': LAUNCH.replace('id: launch', 'id: draft').replace('status: scheduled', 'status: draft'),
    });
    const cal = buildCalendar(loadPosts(cfg), cfg, null, { now: new Date('2026-10-01T00:00:00Z') });
    assert.equal(cal.timezone, 'UTC');
    assert.equal(cal.entries.length, 8);
    const e = cal.entries.find((x) => x.id === 'launch' && x.platform === 'mastodon');
    assert.deepEqual(
      { status: e.status, datetime: e.datetime, date: e.date, time: e.time, mode: e.mode, valid: e.valid, source: e.source },
      { status: 'scheduled', datetime: '2026-10-20T15:00:00.000Z', date: '2026-10-20', time: '15:00', mode: 'api', valid: true, source: 'marketing/posts/launch.md' },
    );
    assert.match(e.text, /utm_source=mastodon/);
    assert.equal(cal.entries.find((x) => x.id === 'draft').status, 'draft');
    assert.equal(cal.entries.find((x) => x.platform === 'reddit').title, 'Loupe');
  });
});
