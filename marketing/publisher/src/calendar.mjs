// `calendar`: every post flattened per platform, for a calendar view.

import { PLATFORMS } from './platforms.mjs';
import { renderPost } from './render.mjs';
import { planTasks } from './schedule.mjs';
import { lengthReport, validateAll } from './validate.mjs';

/**
 * status per entry:
 *   draft | off | scheduled (future) | due (publishes on the next run) |
 *   published | assist (issue opened, posted by hand) | skipped / missed (too late)
 */
export function buildCalendar(posts, cfg, ledger, { now = new Date() } = {}) {
  const checked = new Map(validateAll(posts, cfg, { now }).map((v) => [v.post, v]));
  const tasks = planTasks(posts, cfg, ledger, { now });
  const entries = tasks.map((t) => {
    const r = renderPost(t.post, t.platform, cfg);
    const entry = ledger?.find(t.post.id, t.platform);
    const status = {
      draft: 'draft',
      off: 'off',
      done: entry?.status === 'assist' ? 'assist' : 'published',
      skipped: 'skipped',
      future: 'scheduled',
      late: 'missed',
      due: 'due',
      invalid: 'invalid',
    }[t.state];
    const iso = t.post.date ? t.post.date.toISOString() : null;
    const { errors } = checked.get(t.post);
    return {
      id: t.post.id,
      platform: t.platform,
      platformLabel: PLATFORMS[t.platform].label,
      mode: t.mode,
      status,
      datetime: iso,
      date: iso?.slice(0, 10) ?? null,
      time: iso?.slice(11, 16) ?? null,
      campaign: t.post.campaign,
      title: r.fields.title || null,
      text: r.primary,
      link: r.link,
      media: t.post.media.map((m) => ({ src: m.src, kind: m.kind, alt: m.alt })),
      lengths: lengthReport(r).map(({ field, used, max }) => ({ field, used, max })),
      valid: errors.length === 0,
      source: `marketing/${t.post.relPath}`,
      ...(entry?.url ? { url: entry.url } : {}),
      ...(entry?.publishedAt && entry.status !== 'skipped' ? { publishedAt: entry.publishedAt } : {}),
    };
  });
  return {
    generatedAt: now.toISOString(),
    timezone: 'UTC',
    platforms: Object.fromEntries(Object.entries(cfg.platforms).map(([k, v]) => [k, { label: PLATFORMS[k].label, mode: v.mode }])),
    entries,
  };
}
