// Checks every src/i18n/<lang>.json against en.json: the same keys, the same
// {placeholders}, the same markup in _html strings, no unexpected tags.
// npm run check:i18n  (exits 1 on any problem)
import { readdirSync, readFileSync } from 'node:fs';

const dir = new URL('../src/i18n/', import.meta.url);
const read = (f) => JSON.parse(readFileSync(new URL(f, dir), 'utf8'));
const en = read('en.json');

const flat = (o, prefix = '') =>
  Object.entries(o).flatMap(([k, v]) => (k === '$comment' ? [] : typeof v === 'string' ? [[prefix + k, v]] : flat(v, `${prefix}${k}.`)));
const placeholders = (s) => [...s.matchAll(/\{(\w+)\}/g)].map((m) => m[1]).sort().join(',');
const tags = (s) => [...s.matchAll(/<\/?([a-z]+)[^>]*>/g)].map((m) => m[0].replace(/\s+/g, ' ')).sort().join('');
const allowed = /^<\/?(a|strong|em|code|br)(\s+(href|rel)="[^"]*")*\s*\/?>$/;

const source = new Map(flat(en));
let problems = 0;
const report = (file, msg) => {
  problems++;
  console.log(`${file}: ${msg}`);
};

for (const [k, v] of source) for (const t of v.match(/<[^>]+>/g) ?? []) if (!allowed.test(t)) report('en.json', `${k}: tag ${t} not allowed`);

for (const file of readdirSync(dir).filter((f) => f.endsWith('.json') && f !== 'en.json')) {
  let data;
  try {
    data = read(file);
  } catch (e) {
    report(file, `invalid JSON: ${e.message}`);
    continue;
  }
  const target = new Map(flat(data));
  for (const [k, v] of source) {
    const t = target.get(k);
    if (t === undefined) report(file, `missing ${k}`);
    else {
      if (!t.trim()) report(file, `empty ${k}`);
      if (placeholders(t) !== placeholders(v)) report(file, `${k}: placeholders {${placeholders(t)}} ≠ {${placeholders(v)}}`);
      if (k.endsWith('_html') && tags(t) !== tags(v)) report(file, `${k}: markup differs from English`);
      if (!k.endsWith('_html') && /<[a-z]/i.test(t)) report(file, `${k}: markup in a plain string`);
    }
  }
  for (const k of target.keys()) if (!source.has(k)) report(file, `extra key ${k}`);
}

console.log(problems ? `\n${problems} problem(s)` : 'i18n: all languages match en.json');
process.exit(problems ? 1 : 0);
