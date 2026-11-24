// Vista Social (https://vistasocial.com) is the dashboard: one connected
// profile per network that needs an approved developer app (Instagram,
// TikTok, YouTube, Threads, LinkedIn, X, Facebook, Reddit, Bluesky), plus
// paid promotion. A "boost configuration" (Vista → Settings → Boosts: ad
// account, budget, audience, duration) is set up once per profile; a post
// names one with `boost:` in its front matter, or falls back to the
// platform's default in config.json, and Vista buys the ads when it
// publishes.
//
// Two transports expose the same operations with the same argument shapes
// (checked 2026-11-10):
//   mcp   the MCP server, included with every paid plan. VISTA_MCP_URL is
//         the "link with API key" from Settings → Account Settings →
//         Integrations → MCP; JSON-RPC `tools/call` over HTTP, tool names
//         whoami, findProfiles, listBoostConfigurations, createOrUpdatePost.
//   rest  https://api.vistasocial.com (OpenAPI at /openapi.json), an add-on
//         on Professional plans. POST /v2/me, /v2/profiles/search,
//         /v2/boosts/list, /v2/posts/save with the key in `x-api-key`;
//         responses are `{ ok, data }` or `{ ok: false, error }`.
//
// Media: Vista fetches media from public URLs (`media_url`), so repo media
// is addressed as cfg.vista.mediaBaseUrl + path. In Actions that defaults
// to raw.githubusercontent.com for the published ref; the repository is
// public, so that works without an upload step.
//
// Timing: with vista.scheduleAheadHours > 0 a post is handed to Vista up to
// that many hours early with `publish_at` set to its date, so Vista does the
// timing and a late GitHub cron no longer matters. At 0 it behaves like the
// Postiz adapter: the publisher decides, `publish_at` is "now".

export const TRANSPORTS = ['mcp', 'rest'];

const OPS = {
  me: { rest: '/v2/me', mcp: 'whoami' },
  profiles: { rest: '/v2/profiles/search', mcp: 'findProfiles' },
  boosts: { rest: '/v2/boosts/list', mcp: 'listBoostConfigurations' },
  save: { rest: '/v2/posts/save', mcp: 'createOrUpdatePost' },
};

/** YouTube's text is the description; Shorts get a #Shorts hint. */
export function vistaMessage(rendered) {
  let text = rendered.primary ?? '';
  if (rendered.platform === 'youtube' && rendered.options.short && !/#shorts\b/i.test(`${rendered.fields.title} ${text}`)) {
    text = `${text}\n\n#Shorts`.trim();
  }
  if (rendered.platform === 'reddit' && rendered.options.kind === 'link' && rendered.options.url && !text.includes(rendered.options.url)) {
    text = `${rendered.options.url}\n\n${text}`.trim();
  }
  return text;
}

/**
 * Which boost configuration a post uses on this platform: `boost: <id>` in
 * the post wins, `boost: false` opts out, anything else takes the default
 * from config.json. Returns null for "no boost".
 */
export function vistaBoost(rendered, pcfg = {}) {
  const b = rendered.options.boost;
  if (b === false) return null;
  if (typeof b === 'string' && b.trim()) return b.trim();
  if (typeof b === 'number') return String(b);
  return pcfg.boost ? String(pcfg.boost) : null;
}

/** The flat `customization` object: boost plus per-network fields. */
export function vistaCustomization(rendered, pcfg = {}) {
  const c = { ...(pcfg.customization ?? {}) };
  const boost = vistaBoost(rendered, pcfg);
  if (boost) c.boost_gid = boost;
  switch (rendered.platform) {
    case 'youtube':
      if (rendered.fields.title) c.video_title = rendered.fields.title;
      c.privacyStatus ??= rendered.options.visibility ?? 'public';
      c.madeForKids ??= false;
      if (rendered.fields.tags?.length) c.tags = rendered.fields.tags;
      break;
    case 'tiktok':
      c.privacy_level ??= 'PUBLIC_TO_EVERYONE';
      c.comments_enabled ??= true;
      break;
    case 'reddit':
      if (rendered.options.subreddit) c.subreddit_name = rendered.options.subreddit;
      if (rendered.fields.title) c.title = rendered.fields.title;
      if (rendered.options.flair) c.flair_text = rendered.options.flair;
      break;
    default:
      break;
  }
  return c;
}

/** Public URL Vista can fetch a media item from. */
export function vistaMediaUrl(cfg, m) {
  if (m.isUrl) return m.src;
  const base = String(cfg.vista?.mediaBaseUrl ?? '').replace(/\/+$/, '');
  if (!base) {
    throw new Error(`no public URL for ${m.src}: set vista.mediaBaseUrl in config.json or VISTA_MEDIA_BASE_URL (GitHub Actions derives it from GITHUB_REPOSITORY)`);
  }
  return `${base}/${m.src.replace(/^\/+/, '').split('/').map(encodeURIComponent).join('/')}`;
}

/** "now", or the post's own time when Vista is allowed to schedule ahead. */
export function vistaPublishAt(rendered, cfg, now = new Date()) {
  const ahead = Number(cfg.vista?.scheduleAheadHours ?? 0);
  if (ahead > 0 && rendered.date && rendered.date.getTime() - now.getTime() > 60_000) return rendered.date.toISOString();
  return 'now';
}

const idOf = (v) => (typeof v === 'string' && /^\d+$/.test(v) ? Number(v) : v);

/** Pull an id out of whatever the save operation answers with. */
export function vistaRemoteId(data) {
  if (!data || typeof data !== 'object') return null;
  const first = Array.isArray(data) ? data[0] : data;
  if (!first || typeof first !== 'object') return null;
  for (const k of ['publication_id', 'publication_gid', 'id', 'gid']) if (first[k] != null) return String(first[k]);
  for (const k of ['publication', 'post', 'data']) if (first[k]?.id != null) return String(first[k].id);
  for (const k of ['publications', 'posts']) {
    const item = Array.isArray(first[k]) ? first[k][0] : null;
    if (item?.id != null) return String(item.id);
    if (item?.publication_id != null) return String(item.publication_id);
  }
  return null;
}

/**
 * The payload of an MCP `tools/call` result: structuredContent when the
 * server sends it, otherwise the text content parsed as JSON (or the text
 * itself). Throws on `isError`.
 */
export function mcpResultData(result, label = 'tool') {
  const texts = (result?.content ?? []).filter((c) => c.type === 'text').map((c) => c.text);
  if (result?.isError) throw new Error(`Vista Social MCP ${label}: ${texts.join('\n').slice(0, 500) || 'tool error'}`);
  if (result?.structuredContent !== undefined) return result.structuredContent;
  const text = texts.join('\n');
  try {
    return JSON.parse(text);
  } catch {
    return text;
  }
}

/** The JSON-RPC message with our id from a JSON or SSE body. */
export function parseJsonRpc(text, id) {
  const trimmed = String(text).trim();
  if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
    const parsed = JSON.parse(trimmed);
    const msgs = Array.isArray(parsed) ? parsed : [parsed];
    return msgs.find((m) => m.id === id) ?? msgs[0];
  }
  let last = null;
  for (const line of trimmed.split(/\r?\n/)) {
    if (!line.startsWith('data:')) continue;
    try {
      const m = JSON.parse(line.slice(5).trim());
      if (m.id === id) return m;
      last = m;
    } catch {
      /* keep-alive or partial line */
    }
  }
  if (!last) throw new Error('no JSON-RPC message in response');
  return last;
}

export function createVista(ctx) {
  const { env, fetch, cfg } = ctx;
  const transport = () => (TRANSPORTS.includes(cfg.vista?.transport) ? cfg.vista.transport : 'mcp');
  const restBase = () => String(cfg.vista?.url ?? 'https://api.vistasocial.com').replace(/\/+$/, '');
  let rpcId = 0;

  const retryHint = (res) => {
    const retry = res.headers.get('retry-after');
    return res.status === 429 ? ` (Vista Social rate limit${retry ? `, retry after ${retry}s` : ''}; the post will be retried next run)` : '';
  };

  async function rest(path, body = {}) {
    const res = await fetch(`${restBase()}${path}`, {
      method: 'POST',
      headers: { 'x-api-key': env.VISTA_API_KEY, 'Content-Type': 'application/json', Accept: 'application/json' },
      body: JSON.stringify(body),
    });
    const text = await res.text();
    let parsed;
    try {
      parsed = JSON.parse(text);
    } catch {
      parsed = null;
    }
    if (!res.ok || !parsed || parsed.ok === false) {
      const code = parsed?.error?.code ?? '';
      const msg = parsed?.error?.message ?? (parsed ? JSON.stringify(parsed) : String(text).slice(0, 300));
      throw new Error(`Vista Social POST ${path}: HTTP ${res.status}${code ? ` ${code}` : ''}: ${msg}${retryHint(res)}`);
    }
    return parsed.data;
  }

  async function mcp(name, args = {}) {
    const id = ++rpcId;
    const res = await fetch(env.VISTA_MCP_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Accept: 'application/json, text/event-stream' },
      body: JSON.stringify({ jsonrpc: '2.0', id, method: 'tools/call', params: { name, arguments: args } }),
    });
    const text = await res.text();
    if (!res.ok) throw new Error(`Vista Social MCP ${name}: HTTP ${res.status} ${String(text).slice(0, 300)}${retryHint(res)}`);
    let msg;
    try {
      msg = parseJsonRpc(text, id);
    } catch (err) {
      throw new Error(`Vista Social MCP ${name}: ${err.message}: ${String(text).slice(0, 300)}`);
    }
    if (msg.error) throw new Error(`Vista Social MCP ${name}: ${msg.error.code ?? ''} ${msg.error.message ?? JSON.stringify(msg.error)}`.trim());
    return mcpResultData(msg.result, name);
  }

  const call = (op, args) => (transport() === 'rest' ? rest(OPS[op].rest, args) : mcp(OPS[op].mcp, args));

  return {
    name: 'vista',
    transport,
    /** Why nothing can be sent at all (credentials), or null. */
    credentialsMissing() {
      if (transport() === 'rest') return env.VISTA_API_KEY ? null : 'VISTA_API_KEY not set';
      if (!env.VISTA_MCP_URL) return 'VISTA_MCP_URL not set (the "link with API key" from Vista Social → Settings → Integrations → MCP)';
      if (!/^https:\/\//.test(env.VISTA_MCP_URL)) return 'VISTA_MCP_URL must be an https URL';
      return null;
    },
    unconfigured(platform) {
      const why = this.credentialsMissing();
      if (why) return why;
      if (!cfg.platforms[platform]?.profile) return `no Vista Social profile id for ${platform} in config.json`;
      return null;
    },
    /** Whose key this is. */
    me() {
      return call('me', {});
    },
    /** Connected profiles, for `npm run vista:profiles` when filling in config.json. */
    profiles() {
      return call('profiles', { fields: ['id', 'name', 'network', 'network_code', 'username', 'status'], limit: 200 });
    },
    /** Boost configurations of one profile, for `npm run vista:boosts <profile id>`. */
    boosts(profileId, { configuration = false } = {}) {
      return call('boosts', { profile_id: idOf(profileId), include_configuration: configuration });
    },
    async publish(rendered) {
      const pcfg = cfg.platforms[rendered.platform];
      const publishAt = vistaPublishAt(rendered, cfg, ctx.now ?? new Date());
      const body = {
        profile_id: idOf(pcfg.profile),
        publish_at: publishAt,
        message: vistaMessage(rendered),
        shortening: false, // keep our UTM links as they are
        customization: vistaCustomization(rendered, pcfg),
      };
      if (rendered.media.length) body.media_url = rendered.media.map((m) => vistaMediaUrl(cfg, m));
      const tags = cfg.vista?.tags ?? [];
      if (tags.length) body.tags = tags;
      const data = await call('save', body);
      const boost = body.customization.boost_gid ? `, boost ${body.customization.boost_gid}` : '';
      const note = publishAt === 'now' ? `handed to Vista Social${boost}` : `scheduled in Vista Social for ${publishAt}${boost}`;
      return { url: null, remoteId: vistaRemoteId(data), note };
    },
  };
}
