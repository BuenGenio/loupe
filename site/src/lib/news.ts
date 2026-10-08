import { getCollection, type CollectionEntry } from 'astro:content';

// /news/ is one reverse-chronological feed of two kinds of entry: a release
// for every dated section of the repo's CHANGELOG.md, and an article with a
// page of its own.

// Published articles, newest first. One dated in the future appears with the
// first build after its date (the deploy workflow rebuilds daily); drafts never
// do, except in `astro dev`.
export async function posts(): Promise<CollectionEntry<'articles'>[]> {
  const now = Date.now();
  return (await getCollection('articles'))
    .filter((p) => import.meta.env.DEV || (!p.data.draft && p.data.date.getTime() <= now))
    .sort((a, b) => b.data.date.getTime() - a.data.date.getTime());
}

/** Releases, newest first. Their ids are their dates, which are also their anchors on /news/. */
export async function releases(): Promise<CollectionEntry<'releases'>[]> {
  return (await getCollection('releases')).sort((a, b) => b.data.date.getTime() - a.data.date.getTime());
}

export type FeedItem =
  | { kind: 'release'; date: Date; entry: CollectionEntry<'releases'> }
  | { kind: 'article'; date: Date; entry: CollectionEntry<'articles'> };

/** Releases and articles together, newest first; an article leads a release of the same day. */
export async function feed(): Promise<FeedItem[]> {
  const [articles, rels] = await Promise.all([posts(), releases()]);
  const items: FeedItem[] = [
    ...articles.map((entry) => ({ kind: 'article' as const, date: entry.data.date, entry })),
    ...rels.map((entry) => ({ kind: 'release' as const, date: entry.data.date, entry })),
  ];
  return items.sort((a, b) => b.date.getTime() - a.date.getTime() || (a.kind === b.kind ? 0 : a.kind === 'article' ? -1 : 1));
}

// In UTC, so a release dated 2026-10-08 reads as 8 October wherever the site is built.
export const formatDate = (d: Date) => d.toLocaleDateString('en-GB', { day: 'numeric', month: 'long', year: 'numeric', timeZone: 'UTC' });

export const readingTime = (body = '') => Math.max(1, Math.round(body.split(/\s+/).length / 220));

/** The headline a release carries in feeds and link previews. */
export const releaseTitle = (d: Date) => `Release: ${formatDate(d)}`;
