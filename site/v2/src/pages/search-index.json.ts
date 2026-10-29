import type { APIRoute } from 'astro';
import { render } from 'astro:content';
import { allDocs, plain } from '../lib/docs';

export const GET: APIRoute = async () => {
  const docs = await allDocs();
  const index = await Promise.all(
    docs.map(async (d) => {
      const { headings } = await render(d);
      return {
        url: `/docs/${d.id}/`,
        title: d.data.title,
        section: d.data.section,
        headings: headings.filter((h) => h.depth <= 3).map((h) => ({ text: h.text, slug: h.slug })),
        text: plain(d.body ?? ''),
      };
    }),
  );
  return new Response(JSON.stringify(index), { headers: { 'Content-Type': 'application/json; charset=utf-8' } });
};
