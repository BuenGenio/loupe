// Decides, for every post × platform, what state it is in right now.

import { PLATFORMS } from './platforms.mjs';

/**
 * Each task is { post, platform, mode, state, lateHours } where state is:
 *   draft      status: draft — never published
 *   off        the platform is off in config.json
 *   done       already in the ledger
 *   skipped    in the ledger as skipped (it was too late)
 *   future     not due yet
 *   late       due, but more than maxLatenessHours ago — skip and log
 *   due        publish now
 */
export function planTasks(posts, cfg, ledger, { now = new Date(), only, platform, ignoreLateness = false } = {}) {
  const maxLateH = cfg.maxLatenessHours ?? 12;
  const tasks = [];
  for (const post of posts) {
    if (only && post.id !== only) continue;
    for (const p of post.platforms) {
      if (!PLATFORMS[p]) continue;
      if (platform && p !== platform) continue;
      const mode = cfg.platforms[p]?.mode ?? 'off';
      const lateHours = post.date ? (now - post.date) / 3_600_000 : null;
      let state;
      if (post.status !== 'scheduled') state = 'draft';
      else if (mode === 'off') state = 'off';
      else if (ledger?.isDone(post.id, p)) state = 'done';
      else if (!post.date) state = 'invalid';
      else if (lateHours < 0) state = 'future';
      else if (lateHours > maxLateH && !ignoreLateness) state = ledger?.isSkipped(post.id, p) ? 'skipped' : 'late';
      else state = 'due';
      tasks.push({ post, platform: p, mode, state, lateHours });
    }
  }
  tasks.sort((a, b) => (a.post.date ?? 0) - (b.post.date ?? 0) || a.post.id.localeCompare(b.post.id));
  return tasks;
}
