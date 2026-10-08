#!/usr/bin/env python3
"""Helps translate Loupe's strings (see docs/localisation.md). Run from app/.

  python3 tool/l10n.py todo <lang> [--limit N]  the next untranslated strings, one JSON object a line,
                                                with the English, its description and placeholder examples
  python3 tool/l10n.py add <lang> <file.json>   adds translations ({"key": "text", ...}) to lib/l10n/app_<lang>.arb,
                                                after checking them; nothing is added if any is wrong
  python3 tool/l10n.py check <lang>             what's missing, wrong or not in app_en.arb

app_<lang>.arb keeps app_en.arb's order. Afterwards run `flutter gen-l10n`, which checks the
message syntax, and for a new language `python3 tool/sync_languages.py`.
"""
import json
import pathlib
import re
import sys

l10n = pathlib.Path(__file__).resolve().parent.parent / 'lib/l10n'


def load(lang):
    path = l10n / f'app_{lang}.arb'
    return json.loads(path.read_text()) if path.exists() else {'@@locale': lang}


en = load('en')
keys = [k for k in en if not k.startswith('@')]
section = {}
current = None
for k in en:
    if k.startswith('@@x-section-'):
        current = k.removeprefix('@@x-section-')
    elif not k.startswith('@'):
        section[k] = current


def meta(key):
    return en.get('@' + key) or {}


def problems(key, text):
    if key not in section:
        return ['not in app_en.arb']
    if not isinstance(text, str) or not text.strip():
        return ['empty']
    found = []
    for name in (meta(key).get('placeholders') or {}):
        if not re.search(r'\{\s*' + re.escape(name) + r'\s*[,}]', text):
            found.append(f'lost {{{name}}}')
    depth = 0
    for c in text:
        depth += {'{': 1, '}': -1}.get(c, 0)
        if depth < 0:
            break
    if depth != 0:
        found.append('unbalanced braces')
    for m in re.finditer(r'\{\s*\w+\s*,\s*plural\s*,', text):
        if not re.search(r'\bother\s*\{', text[m.end():]):
            found.append('plural without other')
    return found


def save(lang, arb):
    out = {'@@locale': lang, **{k: arb[k] for k in keys if k in arb}}
    (l10n / f'app_{lang}.arb').write_text(json.dumps(out, ensure_ascii=False, indent=2) + '\n')


def main(cmd, lang, *rest):
    arb = load(lang)
    if cmd == 'todo':
        limit = int(rest[rest.index('--limit') + 1]) if '--limit' in rest else 150
        todo = [k for k in keys if k not in arb]
        print(f'{len(todo)} of {len(keys)} left', file=sys.stderr)
        for k in todo[:limit]:
            row = {'key': k, 'en': en[k], 'section': section[k]}
            if meta(k).get('description'):
                row['description'] = meta(k)['description']
            if meta(k).get('placeholders'):
                row['placeholders'] = {n: p.get('example', p.get('type', '')) for n, p in meta(k)['placeholders'].items()}
            print(json.dumps(row, ensure_ascii=False))
    elif cmd == 'add':
        new = json.loads(pathlib.Path(rest[0]).read_text())
        wrong = {k: p for k, v in new.items() if (p := problems(k, v))}
        if wrong:
            for k, p in wrong.items():
                print(f'{k}: {", ".join(p)}')
            sys.exit(f'Nothing added: {len(wrong)} of {len(new)} need fixing.')
        save(lang, {**arb, **new})
        print(f'Added {len(new)}; {len([k for k in keys if k not in arb and k not in new])} left.')
    elif cmd == 'check':
        missing = [k for k in keys if k not in arb]
        extra = [k for k in arb if not k.startswith('@') and k not in section]
        wrong = {k: p for k in keys if k in arb and (p := problems(k, arb[k]))}
        print(f'{len(keys) - len(missing)} of {len(keys)} translated, {len(wrong)} wrong, {len(extra)} not in app_en.arb')
        for k, p in wrong.items():
            print(f'  {k}: {", ".join(p)}')
        for k in extra:
            print(f'  {k}: not in app_en.arb')
        sys.exit(1 if missing or wrong or extra else 0)
    else:
        sys.exit(__doc__)


if __name__ == '__main__':
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    main(*sys.argv[1:])
