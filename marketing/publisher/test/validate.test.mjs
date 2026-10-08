import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import { loadConfig } from '../src/config.mjs';
import { loadPosts, parsePost } from '../src/posts.mjs';
import { validateAll, validatePost } from '../src/validate.mjs';
import { ALL_ON, EXAMPLES_DIR, MARKETING_DIR, png, tempMarketing, testConfig, write } from './helpers.mjs';

const dir = tempMarketing();
write(dir, 'media/a.png', png(1080, 1350));
write(dir, 'media/b.png', png(1080, 1080));
write(dir, 'media/big.png', Buffer.concat([png(10, 10), Buffer.alloc(2_000_001)]));
const cfg = testConfig(dir);
const NOW = new Date('2026-10-08T12:00:00Z');

function check(fm, body = 'Hello') {
  const post = parsePost(`---\ndate: 2026-10-20T15:00:00Z\nstatus: scheduled\n${fm}\n---\n${body}`, { file: `${dir}/posts/t.md` });
  return validatePost(post, cfg, { now: NOW });
}
const has = (list, re) => list.some((m) => re.test(m));

describe('validatePost', () => {
  it('accepts a good post', () => {
    const r = check('platforms: [bluesky, mastodon]\nlink: https://loupe.mx/\ncampaign: launch\nmedia:\n  - path: media/a.png\n    alt: "An inbox"');
    assert.deepEqual(r.errors, []);
    assert.deepEqual(r.warnings, []);
  });

  it('Bluesky: 300 graphemes; emoji count as one', () => {
    assert.deepEqual(check('platforms: [bluesky]', '🔍'.repeat(300)).errors, []);
    assert.ok(has(check('platforms: [bluesky]', 'a'.repeat(301)).errors, /\[bluesky\] text is 301 characters; the limit is 300/));
  });

  it('Mastodon: 500, URLs count as 23 however long', () => {
    const url = `https://loupe.mx/${'x'.repeat(200)}`;
    assert.deepEqual(check('platforms: [mastodon]', `${'a'.repeat(476)} ${url}`).errors, []);
    assert.ok(has(check('platforms: [mastodon]', `${'a'.repeat(477)} ${url}`).errors, /\[mastodon\] text is 501/));
  });

  it('Mastodon: the UTM link added for {link} counts as 23', () => {
    const r = check('platforms: [mastodon]\nlink: https://loupe.mx/a/very/long/path/that/goes/on/and/on/and/on/', `${'a'.repeat(476)} {link}`);
    assert.deepEqual(r.errors, []);
  });

  it('X: 280 weighted', () => {
    assert.deepEqual(check('platforms: [x]', 'a'.repeat(280)).errors, []);
    assert.ok(has(check('platforms: [x]', '🔍'.repeat(141)).errors, /\[x\] text is 282 weighted/));
  });

  it('Threads 500 and LinkedIn 3000', () => {
    assert.ok(has(check('platforms: [threads]', 'a'.repeat(501)).errors, /\[threads\] text is 501/));
    assert.ok(has(check('platforms: [threads]', '🔍'.repeat(126)).errors, /\[threads\] text is 504/));
    assert.ok(has(check('platforms: [linkedin]', 'a'.repeat(3001)).errors, /\[linkedin\] text is 3001/));
  });

  it('Instagram: caption 2200, at most 30 hashtags, media required', () => {
    const media = 'media:\n  - path: media/a.png\n    alt: x';
    assert.ok(has(check(`platforms: [instagram]\n${media}`, 'a'.repeat(2201)).errors, /caption is 2201/));
    const tags = Array.from({ length: 31 }, (_, i) => `#tag${i}x`).join(' ');
    assert.ok(has(check(`platforms: [instagram]\n${media}`, tags).errors, /caption is 31 hashtags; the limit is 30/));
    assert.ok(has(check('platforms: [instagram]').errors, /\[instagram\] needs at least one image or video/));
  });

  it('TikTok and YouTube need media; YouTube needs exactly one video and a title', () => {
    assert.ok(has(check('platforms: [tiktok]').errors, /\[tiktok\] needs at least one/));
    const yt = check('platforms: [youtube]\nmedia:\n  - path: media/a.png\n    alt: x');
    assert.ok(has(yt.errors, /\[youtube\] needs exactly one video/));
    assert.ok(has(yt.errors, /youtube.title is required/));
  });

  it('YouTube: title 100, description 5000 bytes, tags 500', () => {
    const fm = (t) => `platforms: [youtube]\nmedia:\n  - path: https://cdn.example/v.mp4\n    alt: x\nyoutube:\n  title: "${t}"\n  tags: [${Array(60).fill('abcdefghi').join(', ')}]`;
    const r = check(fm('t'.repeat(101)), 'é'.repeat(2501));
    assert.ok(has(r.errors, /\[youtube\] title is 101 characters; the limit is 100/));
    assert.ok(has(r.errors, /\[youtube\] description is 5002 bytes/));
    assert.ok(has(r.errors, /\[youtube\] tags is 599 characters of tags/));
  });

  it('Reddit: subreddit and title required, title at most 300', () => {
    assert.ok(has(check('platforms: [reddit]').errors, /reddit.subreddit is required/));
    assert.ok(has(check('platforms: [reddit]').errors, /reddit.title is required/));
    assert.ok(has(check(`platforms: [reddit]\nreddit: { subreddit: androidapps, title: "${'t'.repeat(301)}" }`).errors, /\[reddit\] title is 301/));
  });

  it('media must exist and have alt text; Bluesky images at most 2 MB', () => {
    const r = check('platforms: [bluesky]\nmedia:\n  - path: media/missing.png\n    alt: x\n  - path: media/a.png');
    assert.ok(has(r.errors, /media\[0\] \(media\/missing.png\) does not exist/));
    assert.ok(has(r.errors, /media\[1\] \(media\/a.png\) has no alt text/));
    assert.ok(has(check('platforms: [bluesky]\nmedia:\n  - path: media/big.png\n    alt: x').errors, /takes images up to 2000000 bytes/));
    assert.ok(has(check('platforms: [bluesky]\nmedia:\n  - path: ../secret.png\n    alt: x').errors, /relative to marketing/));
  });

  it('schema problems', () => {
    assert.ok(has(check('platforms: [myspace]').errors, /unknown platform "myspace"/));
    const published = parsePost('---\ndate: 2026-10-20T15:00:00Z\nstatus: published\nplatforms: [bluesky]\n---\nx', { file: 'p.md' });
    assert.ok(has(validatePost(published, cfg, { now: NOW }).errors, /status must be/));
    assert.ok(has(check('platforms: [bluesky]', 'Hi {name}').warnings, /contains \{name\}: only \{link\} is replaced/));
    assert.ok(has(check('platforms: [bluesky]', 'See {link}').errors, /uses \{link\} but the post has no link/));
    assert.ok(has(check('platforms: [bluesky]\nlinkk: https://x').warnings, /unknown frontmatter key "linkk"/));
    assert.ok(has(check('platforms: [bluesky]\nbluesky: { txt: hi }').warnings, /bluesky.txt is not a known field/));
    assert.ok(has(check('platforms: [bluesky]\nid: Has Spaces').errors, /id "Has Spaces" must be/));
  });

  it('warns about a scheduled post that is already too late', () => {
    const post = parsePost('---\ndate: 2026-10-01T00:00:00Z\nstatus: scheduled\nplatforms: [bluesky]\n---\nx', { file: `${dir}/posts/old.md` });
    assert.ok(has(validatePost(post, cfg, { now: NOW }).warnings, /in the past/));
  });

  it('finds duplicate ids across files', () => {
    const a = parsePost('---\nid: same\ndate: 2026-10-20T15:00:00Z\nplatforms: [bluesky]\n---\nx', { file: 'a.md' });
    const b = parsePost('---\nid: same\ndate: 2026-10-21T15:00:00Z\nplatforms: [bluesky]\n---\ny', { file: 'b.md' });
    const results = validateAll([a, b], cfg, { now: NOW });
    assert.ok(results.every((r) => has(r.errors, /used by more than one post/)));
  });
});

describe('the example posts', () => {
  it('pass check with the committed config', () => {
    const real = loadConfig({ postsDir: EXAMPLES_DIR, marketingDir: MARKETING_DIR }, {});
    const posts = loadPosts({ ...real, postsDir: EXAMPLES_DIR });
    assert.equal(posts.length, 3);
    for (const r of validateAll(posts, { ...real, platforms: { ...real.platforms, ...ALL_ON } }, { now: NOW })) {
      assert.deepEqual(r.errors, [], r.post.relPath);
    }
  });
});
