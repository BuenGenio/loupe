import { readFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { MODES, PLATFORM_NAMES, SUPPORTED_MODES } from './platforms.mjs';

export const PUBLISHER_DIR = resolve(dirname(fileURLToPath(import.meta.url)), '..');
export const MARKETING_DIR = resolve(PUBLISHER_DIR, '..');

const DEFAULTS = {
  maxLatenessHours: 12,
  utm: { medium: 'social' },
  languages: ['en'],
  postsDir: 'posts',
  calendarFile: 'calendar.json',
  ledgerFile: '.state/published.json',
  platforms: {},
  postiz: { url: 'https://api.postiz.com/public/v1' },
  assist: { repository: '', labels: ['social'], ref: 'main' },
};

/**
 * Loads config.json and resolves paths. `overrides` lets tests swap
 * directories and settings without touching the committed file.
 */
export function loadConfig(overrides = {}, env = process.env) {
  const file = overrides.configFile ?? resolve(PUBLISHER_DIR, 'config.json');
  const raw = overrides.config ?? JSON.parse(readFileSync(file, 'utf8'));
  const cfg = {
    ...DEFAULTS,
    ...raw,
    utm: { ...DEFAULTS.utm, ...raw.utm },
    postiz: { ...DEFAULTS.postiz, ...raw.postiz },
    assist: { ...DEFAULTS.assist, ...raw.assist },
  };
  cfg.marketingDir = overrides.marketingDir ?? MARKETING_DIR;
  cfg.postsDir = resolve(cfg.marketingDir, overrides.postsDir ?? cfg.postsDir);
  cfg.calendarFile = resolve(cfg.marketingDir, overrides.calendarFile ?? cfg.calendarFile);
  cfg.ledgerFile = resolve(overrides.ledgerFile ?? env.SOCIAL_LEDGER ?? resolve(cfg.marketingDir, cfg.ledgerFile));
  if (overrides.maxLatenessHours != null) cfg.maxLatenessHours = overrides.maxLatenessHours;

  const platforms = {};
  for (const name of PLATFORM_NAMES) {
    const p = { mode: 'off', ...(raw.platforms?.[name] ?? {}) };
    if (!MODES.includes(p.mode)) throw new Error(`config.json: platforms.${name}.mode must be one of ${MODES.join(', ')}`);
    if (!SUPPORTED_MODES[name].includes(p.mode)) {
      throw new Error(`config.json: ${name} cannot run in mode "${p.mode}" (supported: ${SUPPORTED_MODES[name].join(', ')})`);
    }
    platforms[name] = p;
  }
  for (const name of Object.keys(raw.platforms ?? {})) {
    if (!PLATFORM_NAMES.includes(name)) throw new Error(`config.json: unknown platform "${name}"`);
  }
  cfg.platforms = platforms;

  // Env beats config for anything deployment-specific.
  if (env.POSTIZ_URL) cfg.postiz.url = env.POSTIZ_URL;
  cfg.postiz.url = normalizePostizUrl(cfg.postiz.url);
  if (!cfg.assist.repository) cfg.assist.repository = env.GITHUB_REPOSITORY ?? '';
  return cfg;
}

/**
 * Postiz Cloud's public API is https://api.postiz.com/public/v1; a self-hosted
 * instance serves it at https://<host>/api/public/v1. Accept either the full
 * API base or just the instance origin.
 */
export function normalizePostizUrl(url) {
  const u = String(url).replace(/\/+$/, '');
  if (/\/public\/v1$/.test(u)) return u;
  if (/^https?:\/\/api\.postiz\.com$/.test(u)) return `${u}/public/v1`;
  return `${u}/api/public/v1`;
}
