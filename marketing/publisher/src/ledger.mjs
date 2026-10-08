// The ledger: what has already gone out, so nothing goes out twice.
//
// In GitHub Actions it lives on the `social-state` branch (SOCIAL_LEDGER points
// at a checkout of it); locally at marketing/.state/published.json. Entries
// are { id, platform, status, mode, url, remoteId, publishedAt, note }.
// status "published" (or "assist" for an opened issue) blocks re-posting
// forever; "skipped" records a post that was too late, so it is not warned
// about on every run.

import { mkdirSync, readFileSync, renameSync, writeFileSync } from 'node:fs';
import { dirname } from 'node:path';

export class Ledger {
  constructor(file, { readOnly = false } = {}) {
    this.file = file;
    this.readOnly = readOnly;
    this.entries = [];
    try {
      const data = JSON.parse(readFileSync(file, 'utf8'));
      this.entries = Array.isArray(data) ? data : (data.entries ?? []);
    } catch (err) {
      if (err.code !== 'ENOENT') throw new Error(`can't read ledger ${file}: ${err.message}`);
    }
  }

  find(id, platform) {
    return this.entries.find((e) => e.id === id && e.platform === platform);
  }

  /** True when this post has gone out (or its assist issue was opened) on this platform. */
  isDone(id, platform) {
    const e = this.find(id, platform);
    return !!e && e.status !== 'skipped';
  }

  isSkipped(id, platform) {
    return this.find(id, platform)?.status === 'skipped';
  }

  record(entry) {
    const i = this.entries.findIndex((e) => e.id === entry.id && e.platform === entry.platform);
    const full = { publishedAt: new Date().toISOString(), ...entry };
    if (i === -1) this.entries.push(full);
    else this.entries[i] = full;
    this.save();
    return full;
  }

  /** Written after every single post (atomically), so a crash mid-run loses nothing. */
  save() {
    if (this.readOnly) return;
    mkdirSync(dirname(this.file), { recursive: true });
    const sorted = [...this.entries].sort(
      (a, b) => String(a.publishedAt).localeCompare(String(b.publishedAt)) || `${a.id}/${a.platform}`.localeCompare(`${b.id}/${b.platform}`),
    );
    const tmp = `${this.file}.tmp-${process.pid}`;
    writeFileSync(tmp, `${JSON.stringify({ version: 1, entries: sorted }, null, 2)}\n`);
    renameSync(tmp, this.file);
  }
}
