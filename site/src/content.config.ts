import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';
import { execSync } from 'node:child_process';
import { readFile } from 'node:fs/promises';
import { contact, site } from './config';

const docs = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/docs' }),
  schema: z.object({
    title: z.string(),
    description: z.string().max(170),
    section: z.enum(['Get started', 'Using Loupe', 'Accounts & security', 'Reference']),
    order: z.number(),
  }),
});

// The written half of /news/: posts with a page of their own.
const articles = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/articles' }),
  schema: z.object({
    title: z.string(),
    description: z.string().max(170),
    date: z.coerce.date(),
    updated: z.coerce.date().optional(),
    tags: z.array(z.string()).default([]),
    draft: z.boolean().default(false),
  }),
});

// The release half of /news/: the repo's root CHANGELOG.md, one entry per
// `## YYYY-MM-DD` section. The file's title, its intro and its <!-- notes to
// contributors --> are left out; each entry's body is the bullets below the
// heading. A changelog that stops matching that shape fails the build rather
// than quietly publishing nothing.
function parseChangelog(source: string): { id: string; date: Date; body: string }[] {
  const sections = source.replace(/<!--[\s\S]*?-->/g, '').split(/^(?=## )/m).slice(1);
  const entries = sections.map((section) => {
    const [heading, ...rest] = section.split('\n');
    const date = /^## (\d{4}-\d{2}-\d{2})$/.exec(heading.trim());
    if (!date) throw new Error(`CHANGELOG.md: "${heading.trim()}" is not a "## YYYY-MM-DD" heading. /news/ is built from those headings.`);
    const when = new Date(`${date[1]}T00:00:00Z`);
    if (Number.isNaN(when.getTime())) throw new Error(`CHANGELOG.md: "${date[1]}" is not a real date.`);
    const body = rest.join('\n').trim();
    if (!body) throw new Error(`CHANGELOG.md: the ${date[1]} section is empty.`);
    return { id: date[1], date: when, body };
  });
  if (entries.length === 0) throw new Error('CHANGELOG.md: no "## YYYY-MM-DD" sections found, so /news/ would have no releases.');
  const ids = new Set<string>();
  for (const { id } of entries) {
    if (ids.has(id)) throw new Error(`CHANGELOG.md: two "## ${id}" sections; a date is one entry, so merge them.`);
    ids.add(id);
  }
  return entries;
}

const releases = defineCollection({
  loader: {
    name: 'repo-changelog',
    load: async ({ store, renderMarkdown, generateDigest, parseData, watcher }) => {
      const file = new URL(`file://${process.cwd()}/../CHANGELOG.md`);
      const sync = async () => {
        const entries = parseChangelog(await readFile(file, 'utf8'));
        store.clear();
        for (const entry of entries) {
          const data = await parseData({ id: entry.id, data: { date: entry.date } });
          store.set({ id: entry.id, data, body: entry.body, rendered: await renderMarkdown(entry.body), digest: generateDigest(entry.body) });
        }
      };
      await sync();
      watcher?.add(file.pathname);
      watcher?.on('change', (path) => path === file.pathname && sync());
    },
  },
  schema: z.object({ date: z.date() }),
});

// The app's privacy policy, published from its single source in the repo
// (docs/privacy-policy.md) with the placeholders filled in from config.ts.
const legal = defineCollection({
  loader: {
    name: 'repo-privacy-policy',
    load: async ({ store, renderMarkdown, generateDigest, parseData, watcher }) => {
      const file = new URL(`file://${process.cwd()}/../docs/privacy-policy.md`);
      const sync = async () => {
        let updated = new Date();
        try {
          const iso = execSync('git log -1 --format=%cI -- docs/privacy-policy.md', { cwd: '..', stdio: ['ignore', 'pipe', 'ignore'] })
            .toString()
            .trim();
          if (iso) updated = new Date(iso);
        } catch {}
        const day = updated.toLocaleDateString('en-GB', { day: 'numeric', month: 'long', year: 'numeric' });
        const body = (await readFile(file, 'utf8'))
          .replace(/^# .*\n+/, '')
          .replace(/^\*Draft\..*\*\n+/m, '')
          .replace(/^Last updated: .*\n+/m, '')
          .replaceAll('[owner name]', site.owner.name)
          .replaceAll('[contact email]', `[${contact.hello}](mailto:${contact.hello})`)
          .replaceAll('[date]', day);
        const data = await parseData({ id: 'privacy-policy', data: { title: 'Privacy policy', updated } });
        store.set({ id: 'privacy-policy', data, body, rendered: await renderMarkdown(body), digest: generateDigest(body) });
      };
      await sync();
      watcher?.add(file.pathname);
      watcher?.on('change', (path) => path === file.pathname && sync());
    },
  },
  schema: z.object({ title: z.string(), updated: z.date() }),
});

export const collections = { docs, articles, releases, legal };
