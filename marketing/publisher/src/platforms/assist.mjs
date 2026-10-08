// "Assist" mode: no API at all. When a post is due, open a GitHub issue that
// holds the finished text and a one-click prefilled submit link, and a human
// posts it. Default for Reddit, where new API access needs Reddit's approval
// and automated self-promotion is a quick way to get banned.

import { execFileSync } from 'node:child_process';
import { PLATFORMS } from '../platforms.mjs';

const enc = encodeURIComponent;

/** Reddit's submit page, prefilled. Link posts take url+title; text posts selftext=true+title+text. */
export function redditSubmitUrl({ subreddit, title, kind, url, text }, host = 'https://www.reddit.com') {
  const base = `${host}/r/${subreddit}/submit`;
  if (kind === 'link') return `${base}?type=LINK&url=${enc(url)}&title=${enc(title)}`;
  return `${base}?type=TEXT&selftext=true&title=${enc(title)}&text=${enc(text)}`;
}

/** A compose/share link for networks that have one. */
export function intentUrl(rendered, env = {}) {
  const text = rendered.primary;
  switch (rendered.platform) {
    case 'reddit':
      return redditSubmitUrl({ ...rendered.options, title: rendered.fields.title, text });
    case 'bluesky':
      return `https://bsky.app/intent/compose?text=${enc(text)}`;
    case 'x':
      return `https://x.com/intent/post?text=${enc(text)}`;
    case 'threads':
      return `https://www.threads.com/intent/post?text=${enc(text)}`;
    case 'mastodon':
      return env.MASTODON_URL ? `${env.MASTODON_URL.replace(/\/+$/, '')}/share?text=${enc(text)}` : null;
    case 'linkedin':
      return rendered.link ? `https://www.linkedin.com/sharing/share-offsite/?url=${enc(rendered.link)}` : null;
    case 'facebook':
      return rendered.link ? `https://www.facebook.com/sharer/sharer.php?u=${enc(rendered.link)}` : null;
    default:
      return null; // Instagram, TikTok, YouTube: post from the app
  }
}

function fence(text) {
  const ticks = text.includes('```') ? '````' : '```';
  return `${ticks}text\n${text}\n${ticks}`;
}

export function issueTitle(rendered) {
  const label = PLATFORMS[rendered.platform].label;
  if (rendered.platform === 'reddit') return `Post now: r/${rendered.options.subreddit} — ${rendered.fields.title}`;
  const summary = (rendered.fields.title || rendered.primary || rendered.id).split('\n')[0].slice(0, 80);
  return `Post now: ${label} — ${summary}`;
}

export function issueBody(rendered, { repository, ref = 'main', env = {} } = {}) {
  const label = PLATFORMS[rendered.platform].label;
  const lines = [];
  const when = rendered.date ? rendered.date.toISOString().replace('.000Z', 'Z') : 'now';
  lines.push(`**${label}** post \`${rendered.id}\`, scheduled for ${when}. Nothing has been posted yet: this one is manual.`, '');

  const intent = intentUrl(rendered, env);
  if (rendered.platform === 'reddit') {
    const o = rendered.options;
    lines.push(`### 1. Open the prefilled form`, '', `**[Submit to r/${o.subreddit} →](${intent})**`, '');
    if (o.kind === 'text') {
      lines.push(
        `If the body comes up empty, try [old Reddit](${redditSubmitUrl({ ...o, title: rendered.fields.title, text: rendered.primary }, 'https://old.reddit.com')}) or paste it from below.`,
        '',
      );
    }
    lines.push('### 2. Title', '', fence(rendered.fields.title), '');
    if (o.kind === 'link') {
      lines.push('### 3. Link', '', fence(o.url), '');
      if (rendered.primary) lines.push('### 4. First comment (say who you are and why you built it)', '', fence(rendered.primary), '');
    } else {
      lines.push('### 3. Body', '', fence(rendered.primary), '');
    }
    if (o.flair) lines.push(`**Flair:** ${o.flair}`, '');
    lines.push(
      '> [!IMPORTANT]',
      `> Read r/${o.subreddit}'s rules first (sidebar / wiki). Many subreddits only allow self-promotion in a weekly thread or with a flair.`,
      '> Post as yourself, disclose that you made Loupe, and stay to answer comments.',
      '',
    );
  } else {
    if (intent) lines.push(`**[Open a prefilled ${label} composer →](${intent})**`, '');
    for (const [field, value] of Object.entries(rendered.fields)) {
      if (value == null || value === '' || (Array.isArray(value) && !value.length)) continue;
      lines.push(`### ${field[0].toUpperCase()}${field.slice(1)}`, '', fence(Array.isArray(value) ? value.join(', ') : String(value)), '');
    }
  }

  if (rendered.media.length) {
    lines.push('### Media', '');
    for (const m of rendered.media) {
      const url = m.isUrl ? m.src : repository ? `https://github.com/${repository}/blob/${ref}/marketing/${m.src}` : `marketing/${m.src}`;
      lines.push(`- [${m.src}](${url}) — alt text: ${m.alt || '(none)'}`);
    }
    lines.push('');
  }
  if (rendered.link) lines.push(`Tracked link: ${rendered.link}`, '');
  lines.push('---', 'Close this issue once it is posted, and paste the post URL in a comment.', `<!-- loupe-social:${rendered.id}:${rendered.platform} -->`);
  return lines.join('\n');
}

function githubToken(env) {
  if (env.GITHUB_TOKEN) return env.GITHUB_TOKEN;
  if (env.GH_TOKEN) return env.GH_TOKEN;
  try {
    return execFileSync('gh', ['auth', 'token'], { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'] }).trim();
  } catch {
    return null;
  }
}

export function createAssist(ctx) {
  const { env, fetch, cfg } = ctx;
  let token;

  async function createIssue(payload) {
    const res = await fetch(`https://api.github.com/repos/${cfg.assist.repository}/issues`, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${token}`,
        Accept: 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28',
        'Content-Type': 'application/json',
        'User-Agent': 'loupe-social-publisher',
      },
      body: JSON.stringify(payload),
    });
    const body = await res.json().catch(() => ({}));
    return { ok: res.ok, status: res.status, body };
  }

  return {
    name: 'assist',
    unconfigured() {
      if (!cfg.assist.repository) return 'no repository: set GITHUB_REPOSITORY or assist.repository in config.json';
      token ??= githubToken(env);
      if (!token) return 'GITHUB_TOKEN not set (and `gh auth token` gave nothing)';
      return null;
    },
    async publish(rendered) {
      token ??= githubToken(env);
      const payload = {
        title: issueTitle(rendered),
        body: issueBody(rendered, { repository: cfg.assist.repository, ref: cfg.assist.ref, env }),
        ...(cfg.assist.labels?.length ? { labels: cfg.assist.labels } : {}),
        ...(cfg.assist.assignees?.length ? { assignees: cfg.assist.assignees } : {}),
      };
      let r = await createIssue(payload);
      if (!r.ok && r.status === 422 && (payload.labels || payload.assignees)) {
        // A label or assignee the token can't set: open the issue without them.
        delete payload.labels;
        delete payload.assignees;
        r = await createIssue(payload);
      }
      if (!r.ok) throw new Error(`GitHub issue: HTTP ${r.status} ${r.body.message ?? ''}`.trim());
      return { url: r.body.html_url, remoteId: String(r.body.number), note: 'assist issue opened' };
    },
  };
}
