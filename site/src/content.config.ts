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

const blog = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/blog' }),
  schema: z.object({
    title: z.string(),
    description: z.string().max(170),
    date: z.coerce.date(),
    updated: z.coerce.date().optional(),
    tags: z.array(z.string()).default([]),
    draft: z.boolean().default(false),
  }),
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

export const collections = { docs, blog, legal };
