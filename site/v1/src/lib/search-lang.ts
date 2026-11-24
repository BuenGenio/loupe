// A browser-side subset of Loupe's search language (packages/expr_search),
// for the playground on the website. Same rules as the app: a space means
// "and"; not binds tightest, then and, then or; an operator in front of a
// group applies to every value in it (f:(dana or ben)); some operators take
// one word, the text operators take a phrase; lower-case operators only.

export type Op = 'all' | 'from' | 'to' | 'subject' | 'body' | 'is' | 'has' | 'attachment' | 'tag' | 'newer' | 'older' | 'after' | 'before' | 'date';

export type Node =
  | { k: 'and'; c: Node[] }
  | { k: 'or'; c: Node[] }
  | { k: 'not'; c: Node }
  | { k: 'term'; op: Op; value: string };

export interface Message {
  from: string;
  email: string;
  to: string;
  subject: string;
  body: string;
  daysAgo: number;
  time: string;
  unread: boolean;
  flagged: boolean;
  replied: boolean;
  tags: string[];
  attachments: string[];
}

const OPS: Record<string, Op> = {
  from: 'from', f: 'from',
  to: 'to', t: 'to', toorcc: 'to',
  subject: 'subject', s: 'subject',
  body: 'body', b: 'body',
  all: 'all',
  is: 'is', status: 'is', i: 'is', u: 'is',
  has: 'has',
  attachment: 'attachment', a: 'attachment',
  tag: 'tag', l: 'tag', label: 'tag',
  newer_than: 'newer', n: 'newer', nt: 'newer',
  older_than: 'older', ot: 'older', age: 'older', ag: 'older', days: 'older', da: 'older',
  after: 'after', af: 'after',
  before: 'before', be: 'before',
  date: 'date', d: 'date',
};
const ONE_WORD = new Set<Op>(['is', 'has', 'attachment', 'tag', 'newer', 'older', 'after', 'before', 'date']);

type Tok = { t: 'lp' | 'rp' | 'neg' | 'and' | 'or' | 'not' } | { t: 'op'; op: Op } | { t: 'word' | 'quote'; v: string };

function lex(input: string): { toks: Tok[]; incomplete: boolean } {
  const toks: Tok[] = [];
  let incomplete = false;
  let i = 0;
  const atStart = () => i === 0 || /[\s(]/.test(input[i - 1]);
  while (i < input.length) {
    const c = input[i];
    if (/\s/.test(c)) { i++; continue; }
    if (c === '(') { toks.push({ t: 'lp' }); i++; continue; }
    if (c === ')') { toks.push({ t: 'rp' }); i++; continue; }
    if ('"“„”'.includes(c)) {
      let j = i + 1, v = '';
      while (j < input.length && !'"“”'.includes(input[j])) {
        if (input[j] === '\\' && j + 1 < input.length) j++;
        v += input[j++];
      }
      if (j >= input.length) incomplete = true;
      toks.push({ t: 'quote', v });
      i = j + 1;
      continue;
    }
    if (c === '-' && atStart() && i + 1 < input.length && !/\s/.test(input[i + 1])) { toks.push({ t: 'neg' }); i++; continue; }
    let j = i;
    while (j < input.length && !/[\s()"“„”]/.test(input[j])) j++;
    const word = input.slice(i, j);
    i = j;
    if (/^(and|AND)$/.test(word)) { toks.push({ t: 'and' }); continue; }
    if (/^(or|OR)$/.test(word)) { toks.push({ t: 'or' }); continue; }
    if (/^(not|NOT)$/.test(word)) { toks.push({ t: 'not' }); continue; }
    const m = word.match(/^([a-z_]+):(.*)$/);
    if (m && OPS[m[1]]) {
      toks.push({ t: 'op', op: OPS[m[1]] });
      let rest = m[2];
      if (rest.startsWith('-') && rest.length > 1) { toks.push({ t: 'neg' }); rest = rest.slice(1); }
      if (rest) toks.push({ t: 'word', v: rest });
      continue;
    }
    toks.push({ t: 'word', v: word });
  }
  return { toks, incomplete };
}

export function parse(input: string): { node: Node | null; incomplete: boolean } {
  const { toks, incomplete: lexIncomplete } = lex(input);
  let pos = 0;
  let incomplete = lexIncomplete;
  const peek = () => toks[pos];
  const ctx: Op[] = ['all'];

  const phrase = (): string => {
    const words: string[] = [];
    while (peek()?.t === 'word') words.push((toks[pos++] as { v: string }).v);
    return words.join(' ');
  };

  const parseOr = (): Node | null => {
    const parts: Node[] = [];
    const first = parseAnd();
    if (first) parts.push(first);
    while (peek()?.t === 'or') {
      pos++;
      const n = parseAnd();
      if (n) parts.push(n);
      else incomplete = true;
    }
    return parts.length === 0 ? null : parts.length === 1 ? parts[0] : { k: 'or', c: parts };
  };

  const parseAnd = (): Node | null => {
    const parts: Node[] = [];
    for (;;) {
      const t = peek();
      if (!t || t.t === 'rp' || t.t === 'or') break;
      if (t.t === 'and') { pos++; continue; }
      const n = parseUnary();
      if (n) parts.push(n);
    }
    return parts.length === 0 ? null : parts.length === 1 ? parts[0] : { k: 'and', c: parts };
  };

  const parseUnary = (): Node | null => {
    const t = peek();
    if (t && (t.t === 'not' || t.t === 'neg')) {
      pos++;
      const n = parseUnary();
      if (!n) { incomplete = true; return null; }
      return { k: 'not', c: n };
    }
    return parsePrimary();
  };

  const parsePrimary = (): Node | null => {
    const t = peek();
    if (!t) return null;
    if (t.t === 'lp') {
      pos++;
      const n = parseOr();
      if (peek()?.t === 'rp') pos++;
      else incomplete = true;
      return n;
    }
    if (t.t === 'op') { pos++; return parseValue(t.op); }
    if (t.t === 'quote') { pos++; return { k: 'term', op: ctx[ctx.length - 1], value: t.v }; }
    if (t.t === 'word') {
      const op = ctx[ctx.length - 1];
      const value = ONE_WORD.has(op) ? (toks[pos++] as { v: string }).v : phrase();
      return { k: 'term', op, value };
    }
    pos++; // a stray ")" at the top level
    incomplete = true;
    return null;
  };

  const parseValue = (op: Op): Node | null => {
    const t = peek();
    if (!t || t.t === 'rp' || t.t === 'or' || t.t === 'and') { incomplete = true; return null; }
    if (t.t === 'lp') {
      pos++;
      ctx.push(op);
      const n = parseOr();
      ctx.pop();
      if (peek()?.t === 'rp') pos++;
      else incomplete = true;
      return n;
    }
    if (t.t === 'neg' || t.t === 'not') {
      pos++;
      const n = parseValue(op);
      return n ? { k: 'not', c: n } : null;
    }
    if (t.t === 'quote') { pos++; return { k: 'term', op, value: t.v }; }
    if (t.t === 'word') {
      const value = ONE_WORD.has(op) ? (toks[pos++] as { v: string }).v : phrase();
      return { k: 'term', op, value };
    }
    incomplete = true;
    return null;
  };

  const node = parseOr();
  if (pos < toks.length) incomplete = true;
  return { node, incomplete };
}

// ---------------------------------------------------------------- matching

const has = (hay: string, needle: string) => hay.toLowerCase().includes(needle.toLowerCase());

function ageDays(v: string): number | null {
  const s = v.toLowerCase();
  if (s === 'today') return 0;
  if (s === 'yesterday') return 1;
  const m = s.match(/^(\d+)([dwmy]?)$/);
  if (!m) return null;
  const n = Number(m[1]);
  return n * ({ d: 1, w: 7, m: 30, y: 365, '': 1 } as Record<string, number>)[m[2]];
}

function dayOf(v: string, now: Date): { from: Date; to: Date } | null {
  const age = ageDays(v);
  const startOfDay = (d: Date) => new Date(d.getFullYear(), d.getMonth(), d.getDate());
  if (age !== null) {
    const d = startOfDay(new Date(now.getTime() - age * 86400000));
    return { from: d, to: new Date(d.getTime() + 86400000) };
  }
  let m = v.match(/^(\d{4})[-/.](\d{1,2})[-/.](\d{1,2})$/);
  if (m) {
    const d = new Date(+m[1], +m[2] - 1, +m[3]);
    return { from: d, to: new Date(+m[1], +m[2] - 1, +m[3] + 1) };
  }
  m = v.match(/^(\d{4})[-/.](\d{1,2})$/);
  if (m) return { from: new Date(+m[1], +m[2] - 1, 1), to: new Date(+m[1], +m[2], 1) };
  m = v.match(/^(\d{4})$/);
  if (m) return { from: new Date(+m[1], 0, 1), to: new Date(+m[1] + 1, 0, 1) };
  return null;
}

export const received = (msg: Message, now: Date) => new Date(now.getTime() - msg.daysAgo * 86400000);

function matchTerm(op: Op, value: string, msg: Message, now: Date): boolean {
  const v = value.trim();
  if (!v) return true;
  const when = received(msg, now);
  switch (op) {
    case 'all':
      return [msg.from, msg.email, msg.to, msg.subject, msg.body].some((f) => has(f, v));
    case 'from':
      return has(msg.from, v) || has(msg.email, v);
    case 'to':
      return has(msg.to, v);
    case 'subject':
      return has(msg.subject, v);
    case 'body':
      return has(msg.body, v);
    case 'is': {
      const s = v.toLowerCase();
      if (['unread', 'unseen', 'new'].includes(s)) return msg.unread;
      if (['read', 'seen'].includes(s)) return !msg.unread;
      if (['flagged', 'starred', 'marked'].includes(s)) return msg.flagged;
      if (['unflagged', 'unstarred', 'unmarked'].includes(s)) return !msg.flagged;
      if (['replied', 'answered'].includes(s)) return msg.replied;
      if (['unreplied', 'unanswered'].includes(s)) return !msg.replied;
      if (s === 'attachment') return msg.attachments.length > 0;
      return false;
    }
    case 'has':
      return /^(attachments?|att|a)$/i.test(v) ? msg.attachments.length > 0 : false;
    case 'attachment': {
      if (/^(yes|y|1)$/i.test(v)) return msg.attachments.length > 0;
      if (/^(no|n|0)$/i.test(v)) return msg.attachments.length === 0;
      return msg.attachments.some((a) => has(a, v));
    }
    case 'tag': {
      if (v.toLowerCase() === 'na') return msg.tags.length === 0;
      const exact = msg.tags.some((t) => t.toLowerCase() === v.toLowerCase());
      return exact || msg.tags.some((t) => has(t, v));
    }
    case 'newer': {
      const a = ageDays(v);
      return a === null ? false : msg.daysAgo <= a;
    }
    case 'older': {
      const a = ageDays(v);
      return a === null ? false : msg.daysAgo > a;
    }
    case 'after': {
      const d = dayOf(v, now);
      return d ? when >= d.to : false;
    }
    case 'before': {
      const d = dayOf(v, now);
      return d ? when < d.from : false;
    }
    case 'date': {
      const d = dayOf(v, now);
      return d ? when >= d.from && when < d.to : false;
    }
  }
}

export function matches(node: Node, msg: Message, now: Date): boolean {
  switch (node.k) {
    case 'and':
      return node.c.every((n) => matches(n, msg, now));
    case 'or':
      return node.c.some((n) => matches(n, msg, now));
    case 'not':
      return !matches(node.c, msg, now);
    case 'term':
      return matchTerm(node.op, node.value, msg, now);
  }
}

// ---------------------------------------------------------------- chips

export interface Labels {
  [key: string]: string;
}

export interface Chip {
  field: string;
  value: string;
}

const conjuncts = (node: Node): Node[] => (node.k === 'and' ? node.c : [node]);

function statusWord(v: string, L: Labels): string | null {
  const s = v.toLowerCase();
  if (['unread', 'unseen', 'new'].includes(s)) return L.unread;
  if (['read', 'seen'].includes(s)) return L.read;
  if (['flagged', 'starred', 'marked'].includes(s)) return L.flagged;
  if (['unflagged', 'unstarred', 'unmarked'].includes(s)) return L.unflagged;
  if (['replied', 'answered'].includes(s)) return L.replied;
  if (['unreplied', 'unanswered'].includes(s)) return L.unreplied;
  if (s === 'attachment') return L.hasAttachment;
  return null;
}

function ageText(v: string, L: Labels): string {
  const s = v.toLowerCase();
  if (s === 'today') return L.today;
  if (s === 'yesterday') return L.yesterday;
  const m = s.match(/^(\d+)([dwmy]?)$/);
  if (!m) return v;
  const unit = ({ d: 'day', w: 'week', m: 'month', y: 'year', '': 'day' } as Record<string, 'day' | 'week' | 'month' | 'year'>)[m[2]];
  // "7 days", "1 Jahr", "3 тижні": the browser knows every language's plurals.
  return new Intl.NumberFormat(L.lang || 'en', { style: 'unit', unit, unitDisplay: 'long' }).format(Number(m[1]));
}

const fieldLabel = (op: Op, L: Labels): string =>
  ({ all: L.all, from: L.from, to: L.to, subject: L.subject, body: L.body, tag: L.tag, after: L.after, before: L.before, date: L.date, newer: L.newerThan, older: L.olderThan, attachment: L.attachment, is: L.status, has: L.attachment }) [op];

function describe(node: Node, L: Labels): Chip {
  if (node.k === 'term') {
    const { op, value } = node;
    if (op === 'is') {
      const w = statusWord(value, L);
      return w ? { field: w, value: '' } : { field: L.status, value };
    }
    if (op === 'has' || (op === 'attachment' && /^(yes|y|1)$/i.test(value))) return { field: L.hasAttachment, value: '' };
    if (op === 'attachment' && /^(no|n|0)$/i.test(value)) return { field: L.noAttachment, value: '' };
    if (op === 'tag' && value.toLowerCase() === 'na') return { field: L.tagNone, value: '' };
    if (op === 'newer' || op === 'older') return { field: fieldLabel(op, L), value: ageText(value, L) };
    return { field: fieldLabel(op, L), value };
  }
  if (node.k === 'not') {
    const c = node.c;
    if (c.k === 'term' && c.op === 'is') {
      const flip: Record<string, string> = { read: 'unread', seen: 'unread', unread: 'read', unseen: 'read', new: 'read', flagged: 'unflagged', unflagged: 'flagged', replied: 'unreplied', unreplied: 'replied' };
      const f = flip[c.value.toLowerCase()];
      if (f) return describe({ k: 'term', op: 'is', value: f }, L);
    }
    const inner = describe(c, L);
    return { field: `${L.not} ${inner.field}`.trim(), value: inner.value };
  }
  // A group under one field: "From: dana or ben".
  const kids = node.c.map((n) => describe(n, L));
  const sameField = node.c.every((n) => n.k === 'term') && new Set(kids.map((k) => k.field)).size === 1 && kids[0].value;
  const joiner = node.k === 'or' ? ` ${L.or} ` : ` ${L.and} `;
  if (sameField) return { field: kids[0].field, value: kids.map((k) => k.value).join(joiner) };
  return { field: '', value: kids.map((k) => (k.value && k.field ? `${k.field}: ${k.value}` : k.value || k.field)).join(joiner) };
}

export function chips(node: Node | null, L: Labels): Chip[] {
  return node ? conjuncts(node).map((n) => describe(n, L)) : [];
}
