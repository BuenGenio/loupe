import rss from '@astrojs/rss';
import type { APIContext } from 'astro';
import { posts } from '../lib/blog';
import { site } from '../config';

export async function GET(context: APIContext) {
  return rss({
    title: 'Loupe blog',
    description: 'News from the Loupe project: a private, open-source mail app for Android.',
    site: context.site ?? site.url,
    items: (await posts()).map((p) => ({
      title: p.data.title,
      description: p.data.description,
      pubDate: p.data.date,
      link: `/blog/${p.id}/`,
      categories: p.data.tags,
    })),
    customData: '<language>en</language>',
  });
}
