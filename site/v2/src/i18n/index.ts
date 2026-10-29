// t(): looks a key up in the page language, falls back to English, fills
// {placeholders}. Keys ending in _html are rendered with set:html; their
// markup is checked by scripts/check-i18n.mjs (a, strong, em, code, br only).
import en from './en.json';
import { defaultLocale, locales, translatedPaths } from './locales';

type Dict = { [key: string]: string | Dict };
const dicts = import.meta.glob<{ default: Dict }>('./*.json', { eager: true });

function lookup(dict: Dict | undefined, key: string): string | undefined {
  let node: string | Dict | undefined = dict;
  for (const part of key.split('.')) {
    if (!node || typeof node === 'string') return undefined;
    node = node[part];
  }
  return typeof node === 'string' ? node : undefined;
}

export type T = (key: string, vars?: Record<string, string | number>) => string;

export function useT(lang: string): T {
  const dict = dicts[`./${lang}.json`]?.default;
  return (key, vars) => {
    const value = lookup(dict, key) ?? lookup(en as Dict, key);
    if (value === undefined) {
      if (import.meta.env.DEV) console.warn(`[i18n] missing key ${key}`);
      return key;
    }
    return vars ? value.replace(/\{(\w+)\}/g, (m, k) => (k in vars ? String(vars[k]) : m)) : value;
  };
}

/** True when the language has its own strings file (else pages fall back to English). */
export const hasStrings = (lang: string) => lang === defaultLocale || `./${lang}.json` in dicts;

/** A site path in a language: /de/features/ for translated pages, the English path for the rest. */
export function localize(lang: string, path: string): string {
  const [bare, hash = ''] = path.split('#');
  if (lang === defaultLocale || !translatedPaths.includes(bare)) return path;
  return `/${lang}${bare}${hash ? `#${hash}` : ''}`;
}

/** The language of a URL path, and the path without its language prefix. */
export function splitPath(pathname: string): { lang: string; path: string } {
  const m = pathname.match(/^\/([a-z]{2})(\/.*)$/);
  if (m && locales.some((l) => l.code === m[1] && l.code !== defaultLocale)) return { lang: m[1], path: m[2] };
  return { lang: defaultLocale, path: pathname };
}

/** hreflang alternates for a translated page (empty for English-only pages). */
export function alternates(path: string): { lang: string; href: string }[] {
  if (!translatedPaths.includes(path)) return [];
  return [
    ...locales.filter((l) => hasStrings(l.code)).map((l) => ({ lang: l.code, href: localize(l.code, path) })),
    { lang: 'x-default', href: path },
  ];
}
