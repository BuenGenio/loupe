import type { APIRoute } from 'astro';
import { site } from '../config';

// Everyone may crawl, AI crawlers included: being findable is the point of
// this site. Pages that shouldn't be indexed carry their own noindex.
export const GET: APIRoute = () =>
  new Response(
    ['User-agent: *', 'Allow: /', 'Disallow: /get/', 'Disallow: /api/', '', `Sitemap: ${site.url}/sitemap-index.xml`, ''].join('\n'),
    { headers: { 'Content-Type': 'text/plain; charset=utf-8' } },
  );
