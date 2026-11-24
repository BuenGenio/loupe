// loupe.mx Worker. Static pages are served from assets without touching this
// code; only /get/* and /api/* run here (see run_worker_first in wrangler.jsonc).
//
//   /get/android-arm64    302 to the current Nightly APK for phones
//   /get/android-x86_64   302 to the current Nightly APK for emulators
//   /get/release          302 to the Nightly release page on GitHub
//   /api/release.json     version, build time and asset sizes, for the download page
//   /, /features/ …       first visit without a language cookie: a 302 to the
//                         visitor's language (Accept-Language), e.g. /de/features/
//
// CI deletes and re-uploads the Nightly assets on every build, so for a minute
// an asset can be missing; the redirects then fall back to the release page.

interface Env {
  ASSETS: Fetcher;
  GITHUB_REPO: string;
  RELEASE_TAG: string;
  // Optional (wrangler secret put GITHUB_TOKEN): raises GitHub's API rate limit.
  GITHUB_TOKEN?: string;
}

interface Asset {
  target: string | null;
  name: string;
  size: number;
  url: string;
  updatedAt: string;
}

interface Release {
  name: string;
  version: string | null;
  url: string;
  builtAt: string | null;
  assets: Asset[];
}

const targets: Record<string, RegExp> = {
  'android-arm64': /-arm64\.apk$/,
  'android-x86_64': /-x86_64\.apk$/,
};

const cacheSeconds = 300;

// Kept in step with src/i18n/locales.ts (codes, translatedPaths).
const languages = ['en', 'es', 'de', 'fr', 'it', 'uk', 'sq', 'bs', 'bg', 'ca', 'hr', 'cs', 'da', 'nl', 'et', 'fi', 'gl', 'el', 'hu', 'is', 'ga', 'lv', 'lt', 'lb', 'mk', 'mt', 'nb', 'pl', 'pt', 'ro', 'sr', 'sk', 'sl', 'sv', 'tr', 'cy', 'eu'];
const translatedPaths = ['/', '/features/', '/screenshots/', '/download/', '/download/start/', '/thanks/', '/donate/', '/contact/', '/press/', '/roadmap/'];
// Browser tags that mean one of our languages under another name.
const aliases: Record<string, string> = { no: 'nb', nn: 'nb', ua: 'uk', sh: 'sr', cnr: 'sr', me: 'sr', va: 'ca' };

export default {
  async fetch(request, env, ctx): Promise<Response> {
    const url = new URL(request.url);
    const path = url.pathname.replace(/\/+$/, '');

    if (path === '/api/release.json') {
      const release = await getRelease(env, ctx);
      if (!release) return json({ error: 'GitHub is unavailable; try the release page.', url: releasePage(env) }, 502, 30);
      return json(release, 200, cacheSeconds);
    }

    if (path.startsWith('/get/')) {
      const target = path.slice('/get/'.length);
      if (target === 'release') return redirect(releasePage(env));
      if (!(target in targets)) return env.ASSETS.fetch(new Request(new URL('/404', url), request));
      const release = await getRelease(env, ctx);
      const asset = release?.assets.find((a) => a.target === target);
      return redirect(asset?.url ?? releasePage(env));
    }

    const redirectTo = await languageRedirect(request, url, env);
    if (redirectTo) {
      return new Response(null, {
        status: 302,
        headers: { Location: redirectTo, 'Cache-Control': 'private, no-store', Vary: 'Accept-Language, Cookie' },
      });
    }
    const response = await env.ASSETS.fetch(request);
    if (!translatedPaths.includes(withSlash(url.pathname))) return response;
    // English pages vary by language preference: don't let a shared cache keep a redirect-free copy for everyone.
    const varied = new Response(response.body, response);
    varied.headers.append('Vary', 'Accept-Language, Cookie');
    return varied;
  },
} satisfies ExportedHandler<Env>;

const withSlash = (path: string) => (path.endsWith('/') ? path : `${path}/`);

// The best of our languages for an Accept-Language header, or null for English.
function preferredLanguage(header: string | null): string | null {
  if (!header) return null;
  const ranked = header
    .split(',')
    .map((part) => {
      const [tag, ...params] = part.trim().toLowerCase().split(';');
      const q = Number(params.find((p) => p.trim().startsWith('q='))?.split('=')[1] ?? 1);
      return { tag, q: Number.isFinite(q) ? q : 0 };
    })
    .filter((x) => x.tag && x.q > 0)
    .sort((a, b) => b.q - a.q);
  for (const { tag } of ranked) {
    const base = tag.split('-')[0];
    const code = aliases[base] ?? base;
    if (languages.includes(code)) return code === 'en' ? null : code;
  }
  return null;
}

// A first-time visitor to an English page that exists in their language goes
// there. A `lang` cookie (set by the language menu) always wins, and anything
// that isn't a page navigation (crawlers ask for no language) stays put.
async function languageRedirect(request: Request, url: URL, env: Env): Promise<string | null> {
  if (request.method !== 'GET') return null;
  const path = withSlash(url.pathname);
  if (!translatedPaths.includes(path)) return null;
  if (!(request.headers.get('Accept') ?? '').includes('text/html')) return null;
  const cookie = request.headers.get('Cookie') ?? '';
  if (/(?:^|;\s*)lang=/.test(cookie)) return null;
  const lang = preferredLanguage(request.headers.get('Accept-Language'));
  if (!lang) return null;
  // Only send people to a page that exists in this build.
  const target = `/${lang}${path}`;
  const probe = await env.ASSETS.fetch(new Request(new URL(target, url), { method: 'HEAD' }));
  return probe.ok ? `${target}${url.search}` : null;
}

function releasePage(env: Env): string {
  return `https://github.com/${env.GITHUB_REPO}/releases/tag/${env.RELEASE_TAG}`;
}

async function getRelease(env: Env, ctx: ExecutionContext): Promise<Release | null> {
  const cache = caches.default;
  const key = new Request(`https://loupe.mx/__cache/release/${env.GITHUB_REPO}/${env.RELEASE_TAG}`);
  const hit = await cache.match(key);
  if (hit) return hit.json();

  const response = await fetch(`https://api.github.com/repos/${env.GITHUB_REPO}/releases/tags/${env.RELEASE_TAG}`, {
    headers: {
      'User-Agent': 'loupe.mx-worker',
      Accept: 'application/vnd.github+json',
      ...(env.GITHUB_TOKEN ? { Authorization: `Bearer ${env.GITHUB_TOKEN}` } : {}),
    },
    cf: { cacheTtl: cacheSeconds, cacheEverything: true },
  });
  if (!response.ok) return null;

  const raw = (await response.json()) as {
    name: string;
    html_url: string;
    assets: { name: string; size: number; browser_download_url: string; updated_at: string }[];
  };
  const assets: Asset[] = raw.assets.map((a) => ({
    target: Object.keys(targets).find((t) => targets[t].test(a.name)) ?? null,
    name: a.name,
    size: a.size,
    url: a.browser_download_url,
    updatedAt: a.updated_at,
  }));
  const release: Release = {
    name: raw.name,
    version: raw.name.match(/\d+\.\d+\.\d+/)?.[0] ?? null,
    url: raw.html_url,
    builtAt: assets.map((a) => a.updatedAt).sort().at(-1) ?? null,
    assets,
  };
  ctx.waitUntil(
    cache.put(key, new Response(JSON.stringify(release), { headers: { 'Cache-Control': `max-age=${cacheSeconds}` } })),
  );
  return release;
}

function redirect(location: string): Response {
  return new Response(null, { status: 302, headers: { Location: location, 'Cache-Control': 'no-store' } });
}

function json(body: unknown, status: number, maxAge: number): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Cache-Control': `public, max-age=${maxAge}`,
      'Access-Control-Allow-Origin': '*',
    },
  });
}
