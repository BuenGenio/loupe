// @ts-check
import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

// Languages with their own pages (src/i18n/locales.ts); English is the root.
const languages = ['en', 'es', 'de', 'fr', 'it', 'uk', 'sq', 'bs', 'bg', 'ca', 'hr', 'cs', 'da', 'nl', 'et', 'fi', 'gl', 'el', 'hu', 'is', 'ga', 'lv', 'lt', 'lb', 'mk', 'mt', 'nb', 'pl', 'pt', 'ro', 'sr', 'sk', 'sl', 'sv', 'tr', 'cy', 'eu'];

// Pages that must not be indexed (they also carry <meta name="robots" content="noindex">).
const unlisted = ['/download/start/', '/thanks/', '/404'];

export default defineConfig({
  site: 'https://loupe.mx',
  trailingSlash: 'always',
  build: { format: 'directory' },
  prefetch: { prefetchAll: false, defaultStrategy: 'hover' },
  integrations: [
    sitemap({
      filter: (page) => !unlisted.some((path) => page.includes(path)),
      changefreq: 'weekly',
      // hreflang alternates in the sitemap, for pages that exist in several languages.
      i18n: { defaultLocale: 'en', locales: Object.fromEntries(languages.map((l) => [l, l])) },
    }),
  ],
  markdown: {
    shikiConfig: { themes: { light: 'github-light', dark: 'github-dark-dimmed' } },
  },
});
