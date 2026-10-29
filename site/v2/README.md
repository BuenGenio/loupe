# loupe.mx, v2 (redesign)

The production website for loupe.mx (see [../README.md](../README.md)). What changed from v1: a lit, dark hero and Private AI section (`.night`, `.aurora`, `.glass`, `.spot` and `.glow-border` in `src/styles/global.css`), a providers marquee, a bento feature grid, and the Private AI preview: `src/lib/private-ai.ts` (English-only strings), `src/components/AiDemo.astro` and `src/pages/private-ai.astro`. The AI features are planned, not shipped ([docs/plan/PLAN-combined.md](../../docs/plan/PLAN-combined.md)), and are labelled "Coming soon" everywhere.

The website: an [Astro](https://astro.build) static site served by Cloudflare (Workers with static assets), plus a small Worker for download links and language redirects.

```sh
cd site/v2
npm ci
npm run dev           # http://localhost:4321 (dev shows future news articles and unconfigured donation tiers)
npm run build         # checks translations, then builds to dist/
npx wrangler dev      # dist/ plus the Worker, as in production
```

Use `npm run dev` while editing. Static previews serve `dist/`, which a new build replaces; an already-open page can lose its screenshot files during that rebuild. Let the build finish before refreshing a static preview.

## What's where

| Path | What |
|---|---|
| `src/config.ts` | URLs, contact addresses, social profiles, **donation links**, analytics token |
| `src/views/` | The pages that exist in every language (home, features, screenshots, download, donate, contact, press) |
| `src/pages/` | Routes: English at `/`, other languages at `/[lang]/` (thin wrappers around the views); docs, news, development and privacy (English only) |
| `src/i18n/` | `en.json` (source strings), one `<lang>.json` per language, `locales.ts` (languages, flags, translated paths) |
| `src/content/docs/` | User documentation (Markdown) |
| `src/content/articles/` | The written entries in `/news/`; one dated in the future appears with the first build after that date |
| `src/assets/screenshots/` | App screenshots, light and dark, rendered by `tool/screenshots.sh` from the app's demo data |
| `src/data/screenshots.json` | Titles, captions and alt text for the screenshots |
| `worker/index.ts` | `/get/android-arm64`, `/get/android-x86_64` (302 to the current Nightly APK), `/api/release.json`, and the first-visit language redirect |
| `worker-www/` | The separate `www.loupe.mx` → `loupe.mx` redirect Worker |
| `../../CHANGELOG.md` | The releases in `/news/`, one entry per `## YYYY-MM-DD` section (`releases` collection in `src/content.config.ts`) |
| `../../docs/privacy-policy.md` | The privacy policy, published at `/privacy/` (placeholders filled from `config.ts`) |

## Deploy

GitHub Actions (`.github/workflows/site.yml`) builds this folder on pull requests and deploys it on matching pushes to `main`. It also rebuilds and deploys daily at 06:05 UTC so scheduled news articles go live. V1 is archived and is no longer automatically deployed.

1. In Cloudflare, create an API token from the **Edit Cloudflare Workers** template (account: yours; zone: loupe.mx).
2. In GitHub, add repository secrets `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID`.
3. Push to `main`. The workflow deploys the existing `loupe-site` Worker on `loupe.mx` and the `loupe-www-redirect` Worker on `www.loupe.mx`.
4. Optional: `npx wrangler secret put GITHUB_TOKEN` with a fine-grained read-only token, to raise GitHub's API limit for the download redirects.

For an authenticated manual deployment, run these commands from this folder:

```sh
npm run build
npx wrangler deploy
npx wrangler deploy --config worker-www/wrangler.jsonc
```

Keep the production Worker names in both Wrangler configurations: they reuse the existing custom domains and secret bindings.

## Mail

Turn on **Email Routing** for loupe.mx in Cloudflare and route `hello@` and `security@` to your mailbox (or point the MX records at your own server).

## Donations (the download wall)

Visitors choose an amount before downloading; $0 is always offered. Paid amounts use Stripe Payment Links:

1. In Stripe, create four Payment Links with fixed prices ($3, $7, $15, $30) and one with **Customers choose what to pay**.
2. For each: **After payment → Don't show confirmation page → Redirect** to `https://loupe.mx/thanks/`.
3. Paste the links into `donate.tiers[].href` and `donate.custom.href` in `src/config.ts`.

Until then, production shows only the free download (dev shows every tier marked "No link yet"). GitHub Sponsors, Liberapay and Ko-fi links in `donate.alternatives` appear under the wall when filled in.

## Languages

37 languages: English plus the EU languages, Albanian, Bosnian, Catalan, Basque, Galician, Icelandic, Luxembourgish, Macedonian, Norwegian, Serbian, Turkish, Ukrainian and Welsh.

- The marketing pages are translated; docs, news, development and privacy are English.
- First visits to an English page are redirected by the Worker to the browser's language (`Accept-Language`). Picking a language in the menu stores a `lang` cookie, which always wins.
- `npm run check:i18n` (also run by `npm run build`) fails if a language is missing a key, changes a `{placeholder}`, or alters the markup of an `_html` string.
- To change copy: edit `src/i18n/en.json`, then update the other files (the checker lists every missing or extra key).
- To add a language: add it to `src/i18n/locales.ts` and `worker/index.ts` (`languages`), add its flag with `node scripts/flags.mjs`, and add `<code>.json`.

## Images

- Screenshots: `tool/screenshots.sh` (from the repo root) renders every screen, light and dark, into `src/assets/screenshots/`.
- Open Graph images are rendered at build time (`src/pages/og/`), one per page and language.
- Favicons and app icons: `node scripts/brand-assets.mjs` after the app icon changes.
- Social media cards: `marketing/creative` (`npm run cards`).

## Analytics

None by default. To count visits without cookies, create a Cloudflare Web Analytics site and put its token in `site.analyticsToken`; the privacy page then mentions it automatically.
