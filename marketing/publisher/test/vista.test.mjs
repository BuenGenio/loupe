import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import { createVista, mcpResultData, parseJsonRpc, vistaBoost, vistaCustomization, vistaMediaUrl, vistaMessage, vistaPublishAt, vistaRemoteId } from '../src/platforms/vista.mjs';
import { parsePost } from '../src/posts.mjs';
import { renderPost } from '../src/render.mjs';
import { planTasks } from '../src/schedule.mjs';
import { ALL_ON, ENV, mockFetch, png, silent, tempMarketing, testConfig, write } from './helpers.mjs';

const dir = tempMarketing();
write(dir, 'media/a.png', png(1080, 1350));
const cfg = testConfig(dir, {
  platforms: {
    ...ALL_ON,
    instagram: { mode: 'vista', profile: '101', boost: 'boost-ig-default' },
    linkedin: { mode: 'vista', profile: '202' },
    youtube: { mode: 'vista', profile: '303' },
    reddit: { mode: 'vista', profile: '404' },
  },
  vista: { transport: 'rest', mediaBaseUrl: 'https://media.example/marketing', scheduleAheadHours: 168, tags: ['posts-as-code'] },
});
const mcpCfg = { ...cfg, vista: { ...cfg.vista, transport: 'mcp' } };
const MCP_URL = 'https://vistasocial.com/api/integration/mcp?api_key=secret';
const post = (fm, body = 'Hello {link}') =>
  parsePost(`---\nid: launch\ndate: 2026-10-20T15:00:00Z\nstatus: scheduled\ncampaign: launch\nlink: https://loupe.mx/\n${fm}\n---\n${body}`, { file: 'x.md' });
const ctx = (fetch, { env = { ...ENV, VISTA_API_KEY: 'vista-key' }, now = new Date('2026-10-18T10:00:00Z') } = {}) => ({
  cfg,
  env,
  fetch,
  sleep: async () => {},
  log: silent(),
  now,
});

describe('Vista Social', () => {
  it('schedules the post in Vista with public media URLs and the default boost', async () => {
    const fetch = mockFetch([
      [
        'POST api.vistasocial.com/v2/posts/save',
        async (c) => {
          assert.equal(c.headers.get('x-api-key'), 'vista-key');
          const body = await c.json();
          assert.equal(body.profile_id, 101);
          assert.equal(body.publish_at, '2026-10-20T15:00:00.000Z');
          assert.equal(body.message, 'Hello loupe.mx');
          assert.equal(body.shortening, false);
          assert.deepEqual(body.media_url, ['https://media.example/marketing/media/a.png']);
          assert.deepEqual(body.tags, ['posts-as-code']);
          assert.equal(body.customization.boost_gid, 'boost-ig-default');
          return { ok: true, data: { publication_id: 'pub-1' } };
        },
      ],
    ]);
    const r = renderPost(post('platforms: [instagram]\nmedia:\n  - path: media/a.png\n    alt: x'), 'instagram', cfg);
    const res = await createVista(ctx(fetch)).publish(r);
    assert.deepEqual(res, { url: null, remoteId: 'pub-1', note: 'scheduled in Vista Social for 2026-10-20T15:00:00.000Z, boost boost-ig-default' });
  });

  it('publishes "now" once the time has come, and whenever scheduling ahead is off', () => {
    const r = renderPost(post('platforms: [linkedin]'), 'linkedin', cfg);
    assert.equal(vistaPublishAt(r, cfg, new Date('2026-10-18T10:00:00Z')), '2026-10-20T15:00:00.000Z');
    assert.equal(vistaPublishAt(r, cfg, new Date('2026-10-20T15:05:00Z')), 'now');
    assert.equal(vistaPublishAt(r, { vista: { scheduleAheadHours: 0 } }, new Date('2026-10-01T00:00:00Z')), 'now');
  });

  it('a post picks its own boost configuration or opts out of the default', () => {
    const own = renderPost(post('platforms: [instagram]\ninstagram: { caption: Hi, boost: boost-launch }'), 'instagram', cfg);
    assert.equal(vistaBoost(own, cfg.platforms.instagram), 'boost-launch');
    const none = renderPost(post('platforms: [instagram]\ninstagram: { caption: Hi, boost: false }'), 'instagram', cfg);
    assert.equal(vistaBoost(none, cfg.platforms.instagram), null);
    assert.equal(vistaCustomization(none, cfg.platforms.instagram).boost_gid, undefined);
    const li = renderPost(post('platforms: [linkedin]'), 'linkedin', cfg);
    assert.equal(vistaBoost(li, cfg.platforms.linkedin), null);
  });

  it('builds YouTube and Reddit customization', () => {
    const yt = renderPost(post('platforms: [youtube]\nyoutube: { title: Demo, tags: [email, android], short: true, visibility: unlisted }', 'Desc'), 'youtube', cfg);
    assert.deepEqual(vistaCustomization(yt, {}), { video_title: 'Demo', privacyStatus: 'unlisted', madeForKids: false, tags: ['email', 'android'] });
    assert.match(vistaMessage(yt), /#Shorts$/);
    const rd = renderPost(post('platforms: [reddit]\nreddit: { subreddit: androidapps, title: T, flair: News }'), 'reddit', cfg);
    assert.deepEqual(vistaCustomization(rd, {}), { subreddit_name: 'androidapps', title: 'T', flair_text: 'News' });
    assert.ok(vistaMessage(rd).includes('utm_source=reddit'));
    const tt = renderPost(post('platforms: [tiktok]\ntiktok: { caption: Hi }'), 'tiktok', cfg);
    assert.deepEqual(vistaCustomization(tt, { customization: { privacy_level: 'SELF_ONLY' } }), { privacy_level: 'SELF_ONLY', comments_enabled: true });
  });

  it('needs a public base URL for repo media and leaves https media alone', () => {
    assert.throws(() => vistaMediaUrl({ vista: { mediaBaseUrl: '' } }, { src: 'media/a.png', isUrl: false }), /VISTA_MEDIA_BASE_URL/);
    assert.equal(
      vistaMediaUrl({ vista: { mediaBaseUrl: 'https://m.example/marketing/' } }, { src: 'media/launch/in box.jpg', isUrl: false }),
      'https://m.example/marketing/media/launch/in%20box.jpg',
    );
    assert.equal(vistaMediaUrl({}, { src: 'https://cdn.example/v.mp4', isUrl: true }), 'https://cdn.example/v.mp4');
  });

  it('reports API errors with their code, and a 429 as retryable', async () => {
    const r = renderPost(post('platforms: [linkedin]'), 'linkedin', cfg);
    const denied = mockFetch([
      ['POST api.vistasocial.com/v2/posts/save', () => Response.json({ ok: false, error: { code: 'forbidden', message: 'API add-on required' } }, { status: 403 })],
    ]);
    await assert.rejects(createVista(ctx(denied)).publish(r), /HTTP 403 forbidden: API add-on required/);
    const busy = mockFetch([
      [
        'POST api.vistasocial.com/v2/posts/save',
        () => Response.json({ ok: false, error: { code: 'rate_limited', message: 'slow down' } }, { status: 429, headers: { 'retry-after': '30' } }),
      ],
    ]);
    await assert.rejects(createVista(ctx(busy)).publish(r), /retry after 30s.*retried next run/);
  });

  it('is unconfigured without credentials or a profile id', () => {
    assert.match(createVista(ctx(mockFetch(), { env: {} })).unconfigured('instagram'), /VISTA_API_KEY/);
    assert.match(createVista({ ...ctx(mockFetch(), { env: {} }), cfg: mcpCfg }).unconfigured('instagram'), /VISTA_MCP_URL not set/);
    assert.match(createVista({ ...ctx(mockFetch(), { env: { VISTA_MCP_URL: 'http://x' } }), cfg: mcpCfg }).unconfigured('instagram'), /https/);
    assert.match(createVista(ctx(mockFetch())).unconfigured('threads'), /profile id/);
    assert.equal(createVista(ctx(mockFetch())).unconfigured('instagram'), null);
  });

  it('finds the id in whatever posts/save returns', () => {
    assert.equal(vistaRemoteId({ publication_id: 7 }), '7');
    assert.equal(vistaRemoteId([{ id: 'a' }]), 'a');
    assert.equal(vistaRemoteId({ publications: [{ id: 'p' }] }), 'p');
    assert.equal(vistaRemoteId(null), null);
  });

  it('vista-mode tasks become due scheduleAheadHours early; other modes do not', () => {
    const p = post('platforms: [instagram, bluesky]');
    const soon = planTasks([p], cfg, null, { now: new Date('2026-10-15T15:00:00Z') });
    assert.equal(soon.find((t) => t.platform === 'instagram').state, 'due');
    assert.equal(soon.find((t) => t.platform === 'bluesky').state, 'future');
    const far = planTasks([p], cfg, null, { now: new Date('2026-10-01T15:00:00Z') });
    assert.equal(far.find((t) => t.platform === 'instagram').state, 'future');
  });

  it('over MCP, calls createOrUpdatePost with the same body via JSON-RPC and reads the text content', async () => {
    const fetch = mockFetch([
      [
        'POST vistasocial.com/api/integration/mcp',
        async (c) => {
          assert.equal(c.query.get('api_key'), 'secret');
          assert.match(c.headers.get('accept'), /text\/event-stream/);
          const rpc = await c.json();
          assert.equal(rpc.jsonrpc, '2.0');
          assert.equal(rpc.method, 'tools/call');
          assert.equal(rpc.params.name, 'createOrUpdatePost');
          const a = rpc.params.arguments;
          assert.equal(a.profile_id, 101);
          assert.equal(a.publish_at, '2026-10-20T15:00:00.000Z');
          assert.equal(a.customization.boost_gid, 'boost-ig-default');
          assert.deepEqual(a.media_url, ['https://media.example/marketing/media/a.png']);
          return { jsonrpc: '2.0', id: rpc.id, result: { content: [{ type: 'text', text: JSON.stringify({ publication_id: 'pub-9' }) }] } };
        },
      ],
    ]);
    const r = renderPost(post('platforms: [instagram]\nmedia:\n  - path: media/a.png\n    alt: x'), 'instagram', mcpCfg);
    const v = createVista({ ...ctx(fetch, { env: { VISTA_MCP_URL: MCP_URL } }), cfg: mcpCfg });
    assert.equal(v.unconfigured('instagram'), null);
    const res = await v.publish(r);
    assert.equal(res.remoteId, 'pub-9');
    assert.match(res.note, /^scheduled in Vista Social for 2026-10-20T15:00:00.000Z, boost boost-ig-default$/);
  });

  it('over MCP, surfaces tool errors, JSON-RPC errors and SSE bodies', async () => {
    const r = renderPost(post('platforms: [linkedin]'), 'linkedin', mcpCfg);
    const mk = (handler) => createVista({ ...ctx(mockFetch([['POST vistasocial.com/api/integration/mcp', handler]]), { env: { VISTA_MCP_URL: MCP_URL } }), cfg: mcpCfg });
    await assert.rejects(
      mk(async (c) => ({ jsonrpc: '2.0', id: (await c.json()).id, result: { isError: true, content: [{ type: 'text', text: 'profile 202 is not connected' }] } })).publish(r),
      /createOrUpdatePost: profile 202 is not connected/,
    );
    await assert.rejects(
      mk(async (c) => ({ jsonrpc: '2.0', id: (await c.json()).id, error: { code: -32602, message: 'Invalid params' } })).publish(r),
      /-32602 Invalid params/,
    );
    const sse = mk(
      async (c) =>
        new Response(`event: message\ndata: ${JSON.stringify({ jsonrpc: '2.0', id: (await c.json()).id, result: { structuredContent: { id: 'sse-1' } } })}\n\n`, {
          headers: { 'content-type': 'text/event-stream' },
        }),
    );
    assert.equal((await sse.publish(r)).remoteId, 'sse-1');
    assert.equal(parseJsonRpc('[{"id":1},{"id":2,"result":1}]', 2).result, 1);
    assert.equal(mcpResultData({ content: [{ type: 'text', text: 'plain' }] }), 'plain');
  });
});
