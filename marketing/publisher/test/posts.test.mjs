import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import { findPostFiles, loadPosts, parsePost } from '../src/posts.mjs';
import { tempMarketing, testConfig, write } from './helpers.mjs';

const POST = `---
id: 2026-10-20-launch
date: 2026-10-20T15:00:00Z
status: scheduled
campaign: launch
platforms: [bluesky, mastodon, reddit]
link: https://loupe.mx/
media:
  - path: media/launch/inbox.png
    alt: "Loupe's inbox"
  - path: https://cdn.example/clip.mp4
    alt: A clip
bluesky: { text: "Short version {link}" }
reddit: { subreddit: androidapps, title: "Hello", flair: "" }
---
Default text.

<!-- a note for authors -->

{link}
`;

describe('parsePost', () => {
  it('reads frontmatter, overrides, media and body', () => {
    const p = parsePost(POST, { file: '/x/posts/whatever.md' });
    assert.deepEqual(p.errors, []);
    assert.equal(p.id, '2026-10-20-launch');
    assert.equal(p.date.toISOString(), '2026-10-20T15:00:00.000Z');
    assert.equal(p.status, 'scheduled');
    assert.equal(p.campaign, 'launch');
    assert.deepEqual(p.platforms, ['bluesky', 'mastodon', 'reddit']);
    assert.equal(p.link, 'https://loupe.mx/');
    assert.deepEqual(p.media, [
      { src: 'media/launch/inbox.png', isUrl: false, alt: "Loupe's inbox", kind: 'image' },
      { src: 'https://cdn.example/clip.mp4', isUrl: true, alt: 'A clip', kind: 'video' },
    ]);
    assert.equal(p.overrides.bluesky.text, 'Short version {link}');
    assert.equal(p.overrides.reddit.subreddit, 'androidapps');
    assert.equal(p.body, 'Default text.\n\n{link}', 'HTML comments are dropped');
  });

  it('defaults id to the file name and status to draft', () => {
    const p = parsePost('---\ndate: 2026-10-20T15:00:00+02:00\nplatforms: [bluesky]\n---\nHi', { file: '/p/2026-11-01-hello.md' });
    assert.equal(p.id, '2026-11-01-hello');
    assert.equal(p.status, 'draft');
    assert.equal(p.date.toISOString(), '2026-10-20T13:00:00.000Z');
  });

  it('collects errors instead of throwing', () => {
    assert.match(parsePost('no frontmatter').errors[0], /missing YAML frontmatter/);
    assert.match(parsePost('---\ndate: [unclosed\n---\n').errors[0], /not valid YAML/);
    assert.match(parsePost('---\ndate: 2026-10-20\n---\n').errors[0], /with a time and a zone/);
    assert.match(parsePost('---\ndate: 2026-10-20T15:00:00\n---\n').errors[0], /with a time and a zone/);
    assert.match(parsePost('---\nstatus: scheduled\n---\n').errors[0], /date is required/);
    assert.match(parsePost('---\ndate: 2026-10-20T15:00:00Z\nmedia: [{alt: x}]\n---\n').errors[0], /needs a path/);
  });
});

describe('findPostFiles / loadPosts', () => {
  it('skips directories and files starting with _ or ., and READMEs', () => {
    const dir = tempMarketing();
    write(dir, 'posts/a.md', '---\ndate: 2026-10-20T15:00:00Z\n---\nA');
    write(dir, 'posts/2026/b.md', '---\ndate: 2026-10-21T15:00:00Z\n---\nB');
    write(dir, 'posts/_examples/c.md', '---\ndate: 2026-10-22T15:00:00Z\n---\nC');
    write(dir, 'posts/2026/_drafts/d.md', '---\ndate: 2026-10-22T15:00:00Z\n---\nD');
    write(dir, 'posts/_e.md', 'E');
    write(dir, 'posts/.hidden.md', 'F');
    write(dir, 'posts/README.md', '# not a post');
    write(dir, 'posts/notes.txt', 'G');
    const files = findPostFiles(`${dir}/posts`).map((f) => f.slice(dir.length + 1));
    assert.deepEqual(files, ['posts/2026/b.md', 'posts/a.md']);
    const posts = loadPosts(testConfig(dir));
    assert.deepEqual(posts.map((p) => p.relPath), ['posts/2026/b.md', 'posts/a.md']);
  });

  it('returns nothing when posts/ does not exist yet', () => {
    const cfg = testConfig(tempMarketing());
    cfg.postsDir = `${cfg.marketingDir}/nope`;
    assert.deepEqual(loadPosts(cfg), []);
  });
});
