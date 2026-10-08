import rss from '@astrojs/rss';
import type { APIContext } from 'astro';
import { feed, releaseTitle } from '../lib/news';
import { plain } from '../lib/docs';
import { site } from '../config';

export async function GET(context: APIContext) {
  // A release's link carries a #fragment, so it is built absolute here: the
  // feed appends a trailing slash to relative links, fragment and all.
  const base = context.site ?? new URL(site.url);
  return rss({
    title: 'Loupe news',
    description: "What's new in Loupe: releases and notes from a private, open-source mail app for Android.",
    site: context.site ?? site.url,
    // Releases and articles in one feed, newest first. A release has no page of
    // its own, so it links to its entry on /news/.
    items: (await feed()).map((item) =>
      item.kind === 'release'
        ? {
            title: releaseTitle(item.date),
            description: plain(item.entry.body ?? ''),
            pubDate: item.date,
            link: new URL(`/news/#${item.entry.id}`, base).href,
            categories: ['release'],
          }
        : {
            title: item.entry.data.title,
            description: item.entry.data.description,
            pubDate: item.date,
            link: `/news/${item.entry.id}/`,
            categories: item.entry.data.tags,
          },
    ),
    customData: '<language>en</language>',
  });
}
