import { getCollection, type CollectionEntry } from 'astro:content';

// Published posts, newest first. A post dated in the future appears with the
// first build after its date (the deploy workflow rebuilds daily); drafts never
// do, except in `astro dev`.
export async function posts(): Promise<CollectionEntry<'blog'>[]> {
  const now = Date.now();
  return (await getCollection('blog'))
    .filter((p) => import.meta.env.DEV || (!p.data.draft && p.data.date.getTime() <= now))
    .sort((a, b) => b.data.date.getTime() - a.data.date.getTime());
}

export const formatDate = (d: Date) => d.toLocaleDateString('en-GB', { day: 'numeric', month: 'long', year: 'numeric' });

export const readingTime = (body = '') => Math.max(1, Math.round(body.split(/\s+/).length / 220));
