import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import { parsePost } from '../src/posts.mjs';
import { renderPost, utmLink } from '../src/render.mjs';
import { tempMarketing, testConfig } from './helpers.mjs';

const cfg = testConfig(tempMarketing());
const post = (fm, body = 'Body text') => parsePost(`---\ndate: 2026-10-20T15:00:00Z\nstatus: scheduled\n${fm}\n---\n${body}`, { file: '/p/t.md' });

describe('utmLink', () => {
  it('adds source, medium and campaign', () => {
    assert.equal(
      utmLink('https://loupe.mx/', { source: 'bluesky', campaign: 'launch' }),
      'https://loupe.mx/?utm_source=bluesky&utm_medium=social&utm_campaign=launch',
    );
  });
  it('keeps existing query and fragment, and never overwrites utm_* set by hand', () => {
    assert.equal(
      utmLink('https://loupe.mx/download?ref=x&utm_campaign=custom#android', { source: 'mastodon', campaign: 'launch' }),
      'https://loupe.mx/download?ref=x&utm_campaign=custom&utm_source=mastodon&utm_medium=social#android',
    );
  });
});

describe('renderPost', () => {
  const p = post('campaign: launch\nplatforms: [bluesky, mastodon, instagram, tiktok, youtube, reddit, x]\nlink: https://loupe.mx/', 'Loupe is out! {link}');

  it('uses the platform UTM link for {link}', () => {
    assert.equal(
      renderPost(p, 'mastodon', cfg).fields.text,
      'Loupe is out! https://loupe.mx/?utm_source=mastodon&utm_medium=social&utm_campaign=launch',
    );
    assert.equal(renderPost(p, 'x', cfg).fields.text, 'Loupe is out! https://loupe.mx/?utm_source=x&utm_medium=social&utm_campaign=launch');
  });

  it('Bluesky shows the short form and links it to the UTM URL', () => {
    const r = renderPost(p, 'bluesky', cfg);
    assert.equal(r.fields.text, 'Loupe is out! loupe.mx');
    assert.deepEqual(r.linkSpans, [{ start: 14, end: 22, url: 'https://loupe.mx/?utm_source=bluesky&utm_medium=social&utm_campaign=launch' }]);
  });

  it('Instagram and TikTok get a plain, readable link (captions are not clickable)', () => {
    assert.equal(renderPost(p, 'instagram', cfg).fields.caption, 'Loupe is out! loupe.mx');
    assert.equal(renderPost(p, 'tiktok', cfg).fields.caption, 'Loupe is out! loupe.mx');
  });

  it('appends the link when the text has no {link}, except where a card or caption does better', () => {
    const q = post('campaign: c\nplatforms: [bluesky, mastodon, instagram]\nlink: https://loupe.mx/', 'No placeholder here.');
    assert.equal(renderPost(q, 'mastodon', cfg).fields.text, 'No placeholder here.\n\nhttps://loupe.mx/?utm_source=mastodon&utm_medium=social&utm_campaign=c');
    assert.equal(renderPost(q, 'bluesky', cfg).fields.text, 'No placeholder here.', 'Bluesky uses a link card instead');
    assert.equal(renderPost(q, 'instagram', cfg).fields.caption, 'No placeholder here.');
  });

  it('per-platform overrides win over the body; campaign defaults to the id', () => {
    const q = post('id: my-post\nplatforms: [mastodon]\nlink: https://loupe.mx/\nmastodon: { text: "Own text {link}", spoiler: "CW" }');
    const r = renderPost(q, 'mastodon', cfg);
    assert.equal(r.fields.text, 'Own text https://loupe.mx/?utm_source=mastodon&utm_medium=social&utm_campaign=my-post');
    assert.equal(r.fields.spoiler, 'CW');
  });

  it('Reddit: link post when there is a link and no reddit.text, text post otherwise', () => {
    const link = renderPost(post('platforms: [reddit]\nlink: https://loupe.mx/\ncampaign: c\nreddit: { subreddit: r/androidapps, title: T }'), 'reddit', cfg);
    assert.equal(link.options.kind, 'link');
    assert.equal(link.options.subreddit, 'androidapps');
    assert.equal(link.options.url, 'https://loupe.mx/?utm_source=reddit&utm_medium=social&utm_campaign=c');
    const text = renderPost(post('platforms: [reddit]\nlink: https://loupe.mx/\nreddit: { subreddit: androidapps, title: T, text: "Hi {link}" }'), 'reddit', cfg);
    assert.equal(text.options.kind, 'text');
    assert.match(text.fields.text, /^Hi https:\/\/loupe\.mx\/\?utm_source=reddit/);
  });
});
