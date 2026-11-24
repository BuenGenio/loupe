import type { APIRoute } from 'astro';
import { site } from '../config';

export const GET: APIRoute = () =>
  new Response(
    JSON.stringify({
      name: `${site.name}: mail, in focus`,
      short_name: site.name,
      description: site.description,
      start_url: '/',
      display: 'browser',
      background_color: site.themeColor.light,
      theme_color: '#0c2238',
      icons: [
        { src: '/icon-192.png', sizes: '192x192', type: 'image/png' },
        { src: '/icon-512.png', sizes: '512x512', type: 'image/png' },
        { src: '/icon-maskable-512.png', sizes: '512x512', type: 'image/png', purpose: 'maskable' },
      ],
    }),
    { headers: { 'Content-Type': 'application/manifest+json' } },
  );
