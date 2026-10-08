import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import { createAssist, issueBody, issueTitle, redditSubmitUrl } from '../src/platforms/assist.mjs';
import { createMastodon, idempotencyKey } from '../src/platforms/mastodon.mjs';
import { createPostiz, postizContent, postizSettings } from '../src/platforms/postiz.mjs';
import { normalizePostizUrl } from '../src/config.mjs';
import { parsePost } from '../src/posts.mjs';
import { renderPost } from '../src/render.mjs';
import { ENV, mockFetch, png, silent, tempMarketing, testConfig, write } from './helpers.mjs';

const dir = tempMarketing();
write(dir, 'media/a.png', png(1080, 1350));
const cfg = testConfig(dir);
const post = (fm, body = 'Hello {link}') =>
  parsePost(`---\nid: launch\ndate: 2026-10-20T15:00:00Z\nstatus: scheduled\ncampaign: launch\nlink: https://loupe.mx/\n${fm}\n---\n${body}`, { file: 'x.md' });
const ctx = (fetch, env = ENV) => ({ cfg, env, fetch, sleep: async () => {}, log: silent() });

describe('Mastodon', () => {
  it('uploads media with alt text, waits for processing, posts with an Idempotency-Key', async () => {
    let polled = 0;
    const fetch = mockFetch([
      ['POST mastodon.example/api/v2/media', async (c) => {
        const form = await c.formData();
        assert.equal(form.get('description'), 'The inbox');
        assert.equal(form.get('file').type, 'image/png');
        return Response.json({ id: 'm1', url: null }, { status: 202 });
      }],
      ['GET mastodon.example/api/v1/media/m1', () => {
        polled++;
        return polled < 2 ? Response.json({ id: 'm1', url: null }, { status: 206 }) : { id: 'm1', url: 'https://files/m1.png' };
      }],
      ['POST mastodon.example/api/v1/statuses', async (c) => {
        assert.equal(c.headers.get('authorization'), 'Bearer masto-token');
        assert.equal(c.headers.get('idempotency-key'), idempotencyKey('launch'));
        const body = await c.json();
        assert.deepEqual(body, {
          status: 'Hello https://loupe.mx/?utm_source=mastodon&utm_medium=social&utm_campaign=launch',
          visibility: 'public',
          language: 'en',
          spoiler_text: 'CW here',
          media_ids: ['m1'],
        });
        return { id: '1099', url: 'https://mastodon.example/@loupe/1099' };
      }],
    ]);
    const r = renderPost(post('platforms: [mastodon]\nmastodon: { spoiler: "CW here" }\nmedia:\n  - path: media/a.png\n    alt: The inbox'), 'mastodon', cfg);
    const res = await createMastodon(ctx(fetch)).publish(r);
    assert.deepEqual(res, { url: 'https://mastodon.example/@loupe/1099', remoteId: '1099' });
    assert.equal(polled, 2);
  });

  it('the Idempotency-Key is stable per post and differs between posts', () => {
    assert.equal(idempotencyKey('a'), idempotencyKey('a'));
    assert.notEqual(idempotencyKey('a'), idempotencyKey('b'));
  });

  it('reports HTTP errors', async () => {
    const fetch = mockFetch([['POST mastodon.example/api/v1/statuses', () => Response.json({ error: 'Validation failed' }, { status: 422 })]]);
    await assert.rejects(createMastodon(ctx(fetch)).publish(renderPost(post('platforms: [mastodon]'), 'mastodon', cfg)), /HTTP 422 Validation failed/);
  });
});

describe('Postiz', () => {
  it('accepts a cloud URL, a self-hosted origin or a full API base', () => {
    assert.equal(normalizePostizUrl('https://api.postiz.com'), 'https://api.postiz.com/public/v1');
    assert.equal(normalizePostizUrl('https://api.postiz.com/public/v1/'), 'https://api.postiz.com/public/v1');
    assert.equal(normalizePostizUrl('https://social.example.org'), 'https://social.example.org/api/public/v1');
  });

  it('uploads media, then creates a "now" post with the integration and provider settings', async () => {
    const fetch = mockFetch([
      ['POST api.postiz.com/public/v1/upload-from-url', async (c) => ({ id: 'u2', path: 'https://uploads.postiz.com/v.mp4', echo: await c.json() })],
      ['POST api.postiz.com/public/v1/upload', async (c) => {
        assert.equal(c.headers.get('authorization'), 'postiz-key');
        assert.equal((await c.formData()).get('file').name, 'a.png');
        return { id: 'u1', path: 'https://uploads.postiz.com/a.png' };
      }],
      ['POST api.postiz.com/public/v1/posts', async (c) => {
        const body = await c.json();
        assert.equal(body.type, 'now');
        assert.equal(body.shortLink, false);
        assert.equal(body.posts[0].integration.id, 'ig-1');
        assert.deepEqual(body.posts[0].value[0].image, [{ id: 'u1', path: 'https://uploads.postiz.com/a.png' }]);
        assert.equal(body.posts[0].value[0].content, 'Hello loupe.mx');
        assert.deepEqual(body.posts[0].settings, { __type: 'instagram-standalone', post_type: 'post', is_trial_reel: false, collaborators: [] });
        return [{ postId: 'p-1', integration: 'ig-1' }];
      }],
    ]);
    const r = renderPost(post('platforms: [instagram]\nmedia:\n  - path: media/a.png\n    alt: x'), 'instagram', cfg);
    const res = await createPostiz(ctx(fetch)).publish(r);
    assert.deepEqual(res, { url: null, remoteId: 'p-1', note: 'handed to Postiz' });
  });

  it('builds TikTok, YouTube, LinkedIn and Reddit settings', () => {
    const tt = renderPost(post('platforms: [tiktok]\ntiktok: { title: Short }'), 'tiktok', cfg);
    assert.equal(postizSettings(tt, { settings: { privacy_level: 'SELF_ONLY' } }).privacy_level, 'SELF_ONLY');
    assert.equal(postizSettings(tt, {}).content_posting_method, 'DIRECT_POST');
    assert.equal(postizSettings(tt, {}).title, 'Short');

    const yt = renderPost(post('platforms: [youtube]\nyoutube: { title: Demo, tags: [email, android], short: true }', 'Desc'), 'youtube', cfg);
    assert.deepEqual(postizSettings(yt, {}), {
      __type: 'youtube',
      title: 'Demo',
      type: 'public',
      selfDeclaredMadeForKids: 'no',
      tags: [{ value: 'email', label: 'email' }, { value: 'android', label: 'android' }],
    });
    assert.match(postizContent(yt), /#Shorts$/);

    const li = renderPost(post('platforms: [linkedin]'), 'linkedin', cfg);
    assert.equal(postizSettings(li, { type: 'linkedin' }).__type, 'linkedin');

    const rd = renderPost(post('platforms: [reddit]\nreddit: { subreddit: androidapps, title: T }'), 'reddit', cfg);
    assert.deepEqual(postizSettings(rd, {}).subreddit[0].value, {
      subreddit: 'androidapps',
      title: 'T',
      type: 'link',
      url: 'https://loupe.mx/?utm_source=reddit&utm_medium=social&utm_campaign=launch',
      is_flair_required: false,
      flair: null,
    });
  });

  it('turns a 429 into a clear, retryable error', async () => {
    const fetch = mockFetch([['POST api.postiz.com/public/v1/posts', () => Response.json({ message: 'Too many' }, { status: 429 })]]);
    await assert.rejects(createPostiz(ctx(fetch)).publish(renderPost(post('platforms: [threads]'), 'threads', cfg)), /HTTP 429.*retried next run/);
  });

  it('is unconfigured without an API key or an integration id', () => {
    const p = createPostiz(ctx(mockFetch(), {}));
    assert.match(p.unconfigured('threads'), /POSTIZ_API_KEY/);
    const q = createPostiz({ ...ctx(mockFetch()), cfg: { ...cfg, platforms: { ...cfg.platforms, threads: { mode: 'postiz', integration: '' } } } });
    assert.match(q.unconfigured('threads'), /integration id/);
  });
});

describe('assist (GitHub issues)', () => {
  const rd = renderPost(
    post('platforms: [reddit]\nreddit: { subreddit: androidapps, title: "I built Loupe & more", text: "Hi! {link}" }\nmedia:\n  - path: media/a.png\n    alt: The inbox'),
    'reddit',
    cfg,
  );

  it('prefilled Reddit submit links', () => {
    assert.equal(
      redditSubmitUrl({ subreddit: 'androidapps', kind: 'link', url: 'https://loupe.mx/?a=1&b=2', title: 'A & B' }),
      'https://www.reddit.com/r/androidapps/submit?type=LINK&url=https%3A%2F%2Floupe.mx%2F%3Fa%3D1%26b%3D2&title=A%20%26%20B',
    );
    assert.equal(
      redditSubmitUrl({ subreddit: 'androidapps', kind: 'text', title: 'T', text: 'line 1\nline 2' }),
      'https://www.reddit.com/r/androidapps/submit?type=TEXT&selftext=true&title=T&text=line%201%0Aline%202',
    );
  });

  it('issue title and body hold the ready text and the one-click link', () => {
    assert.equal(issueTitle(rd), 'Post now: r/androidapps — I built Loupe & more');
    const body = issueBody(rd, { repository: 'acme/loupe' });
    assert.match(body, /\[Submit to r\/androidapps →\]\(https:\/\/www\.reddit\.com\/r\/androidapps\/submit\?type=TEXT&selftext=true&title=I%20built%20Loupe%20%26%20more&text=Hi!%20https%3A%2F%2Floupe\.mx/);
    assert.match(body, /```text\nI built Loupe & more\n```/);
    assert.match(body, /```text\nHi! https:\/\/loupe\.mx\/\?utm_source=reddit&utm_medium=social&utm_campaign=launch\n```/);
    assert.match(body, /\[media\/a\.png\]\(https:\/\/github\.com\/acme\/loupe\/blob\/main\/marketing\/media\/a\.png\) — alt text: The inbox/);
    assert.match(body, /self-promotion/);
  });

  it('opens the issue, and retries without labels if GitHub refuses them', async () => {
    const payloads = [];
    const fetch = mockFetch([
      ['POST api.github.com/repos/acme/loupe/issues', async (c) => {
        assert.equal(c.headers.get('authorization'), 'Bearer gh-token');
        const body = await c.json();
        payloads.push(body);
        if (body.labels) return Response.json({ message: 'Validation Failed' }, { status: 422 });
        return Response.json({ number: 42, html_url: 'https://github.com/acme/loupe/issues/42' }, { status: 201 });
      }],
    ]);
    const res = await createAssist(ctx(fetch)).publish(rd);
    assert.deepEqual(res, { url: 'https://github.com/acme/loupe/issues/42', remoteId: '42', note: 'assist issue opened' });
    assert.deepEqual(payloads[0].labels, ['social']);
    assert.equal(payloads[1].labels, undefined);
  });
});
