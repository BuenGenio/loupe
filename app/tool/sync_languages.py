#!/usr/bin/env python3
"""Lists the languages there are strings for (lib/l10n/app_<lang>.arb) where
Android 13's per-app language setting and iOS look for them:
android/app/src/main/res/xml/locales_config.xml and ios/Runner/Info.plist.

Run from app/ after adding a translation; test/l10n/translations_test.dart
checks the lists. See docs/localisation.md.
"""
import pathlib
import re

app = pathlib.Path(__file__).resolve().parent.parent
found = sorted(m[1] for f in (app / 'lib/l10n').glob('app_*.arb') if (m := re.fullmatch(r'app_([a-z]{2,3})\.arb', f.name)))
languages = ['en'] + [l for l in found if l != 'en']

config = app / 'android/app/src/main/res/xml/locales_config.xml'
text = config.read_text()
locales = ''.join(f'    <locale android:name="{l}" />\n' for l in languages)
config.write_text(re.sub(r'(<locale-config[^>]*>\n)(.*?)(</locale-config>)', lambda m: m[1] + locales + m[3], text, flags=re.S))

plist = app / 'ios/Runner/Info.plist'
text = plist.read_text()
strings = ''.join(f'\t\t<string>{l}</string>\n' for l in languages)
plist.write_text(re.sub(r'(<key>CFBundleLocalizations</key>\s*<array>\n)(.*?)(\t</array>)', lambda m: m[1] + strings + m[3], text, flags=re.S))

print(f'{len(languages)} languages: {" ".join(languages)}')
