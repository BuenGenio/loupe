# Localisation

Loupe shows the device's language when it has it, else English. It takes the first of the languages the user set in the system settings that Loupe speaks. There is no language setting in the app. On Android 13 and later, the system's per-app language setting chooses one for Loupe alone.

The goal is the same 37 languages as the website (`site/src/i18n/locales.ts`). Progress is tracked in [#31](https://github.com/BuenGenio/loupe/issues/31).

## How it works

- The strings are in `app/lib/l10n/app_<lang>.arb`. `app_en.arb` is the source; the other languages translate it.
- `flutter gen-l10n` (also run by `flutter pub get` and every build) turns them into `app/lib/l10n/app_localizations*.dart`. Those are committed, so `dart analyze` works on a fresh checkout. Run it after editing an ARB file and commit the result.
- `app/lib/l10n/l10n.dart` holds the rest:
  - `context.l10n`.
  - How the language is picked (`resolveLocale`).
  - The locale dates and numbers are formatted in (`formatLocale`).
  - English Material texts for Luxembourgish and Maltese, which Flutter has none for.
  - `deviceL10n()` for code outside the widget tree.

## Using a string

```dart
import '../../l10n/l10n.dart';

Text(context.l10n.composeSendLater)

// Several in one build method:
final l10n = context.l10n;
```

- **Outside widgets** (providers, services): return data (an enum, a count, the error) and turn it into text in the widget. If a string has to be made there, pass `AppLocalizations` in.
- **Background work and notifications** run without a widget tree: use `deviceL10n()`.
- **Widget tests** run in English, so `find.text('Archive')` still works. A test that builds its own `MaterialApp` needs `localizationsDelegates: loupeLocalizationsDelegates`.

## Adding a string

Add it to `app_en.arb`, then run `flutter gen-l10n`:

```json
"composeSendLater": "Send Later",
"composeScheduled": "Scheduled for {time}",
"@composeScheduled": {
  "description": "Snack bar after scheduling a message.",
  "placeholders": {"time": {"type": "String", "example": "Tomorrow, 08:00"}}
},
"searchResultCount": "{count, plural, =0{No results} =1{1 result} other{{count} results}}",
"@searchResultCount": {"placeholders": {"count": {"type": "int"}}}
```

- **Sections:** `app_en.arb` is split into sections by area (`"@@x-section-reading": …`); gen-l10n ignores those keys. Add a key to its area's section, right after the section's line, so changes to different areas don't collide.
- **Keys:** camelCase, starting with the feature's folder (`accountSetup…`, `conversation…`, `settings…`). Name the thing, not its words: `settingsAppLockTitle`, not `settingsRequireUnlockToOpen`.
- **Shared keys:**
  - `common…` holds generic buttons and words: Cancel, Done, Try Again.
  - `mail…` holds message actions: Archive, Reply, Mark as Read.
  - `mailbox…` holds folder names: Inbox, Trash.
  - Reuse them where the meaning is exactly the same. Otherwise use the feature's own key, even when the English is the same: other languages often need different words in different places ("Archive" the action and "Archive" the folder are two keys).
- **Descriptions:** add an `@key` description whenever the English alone doesn't say what it is, such as a button vs a title, what a placeholder holds, or where it shows. Translators see nothing else.
- **Placeholders and plurals:** one string per sentence, with placeholders for what changes. Never build a sentence from pieces (`'$n ' + l10n.messages`) or pick singular/plural in code; word order and plural forms differ between languages (Polish has three, Irish five). Use `plural` for counts and `select` for choices.
- **Keep the English exactly as it was:**
  - Title Case for titles, buttons and menu items; sentence case for text.
  - Typographic apostrophes and quotes (’ “ ”), and an ellipsis character (…) for actions that ask for more.
- **No markup or line breaks** in the text, except `\n` where the layout needs two lines.

## Dates and numbers

`Intl.defaultLocale` follows the app's language, with the device's region where it matches, so en_GB gets a 24-hour clock. `DateFormat` and `NumberFormat` without a locale argument use it. Words like "Yesterday" or "Today" are strings like any other.

## What stays English

- Names: Loupe, Gmail, Thunderbird, and protocol and standard names (IMAP, JMAP, OpenPGP, S/MIME).
- What the user or a server wrote: mail, server error messages and folder names from the server. Only the special folders Loupe names itself get `mailbox…` keys.
- The demo mailbox's mail, which is content like a real mailbox's.
- Log lines (`debugPrint`), exception messages nobody sees, and raw header names in View Source.

Mark a user-visible literal that should stay English with `// l10n-ignore: <why>`, on its line or on the line before.

## The guard test

`app/test/l10n/hardcoded_strings_test.dart` fails on hard-coded English in `app/lib`: a widget's text, a named argument that labels something (`title:`, `label:`, `tooltip:` …) or a snack bar. Files not moved yet are listed in its `pending` set.

When you move a file's strings, take it off the list; the test fails if you forget. The test only sees the usual places. Moving a file means moving all of its text, including error messages built in a `switch` and strings in helper functions.

## Translations

Each language is one `app_<lang>.arb` with the same keys and placeholders as `app_en.arb`. It has no `@` entries and no `@@x-section` lines; those stay in the English file.

- **Words:** reuse the website's words for the same things (`site/src/i18n/<lang>.json`), so the app and the site name things alike. Follow the language's own conventions for capitals (most use sentence case where English uses Title Case), quotes and the ellipsis.
- **Plurals:** use the language's plural forms (`zero`, `one`, `two`, `few`, `many`, `other`), even where the English has only `other`.
  - Every plural needs `other`.
  - `=1` and `one` are the same thing to gen-l10n. In Ukrainian, Croatian, Serbian, Bosnian, Slovenian, Lithuanian, Latvian, Macedonian and Icelandic, `one` also means 21, 31 and so on; in French and Portuguese it also means 0. So `one` must show the number there (`one{{count} лист}`), never "1" or "a".
- **Scripts:** Serbian is written in Cyrillic, as on the website.
- **Tool:** `python3 tool/l10n.py todo <lang>` (in `app/`) prints the next untranslated strings with their descriptions and placeholder examples. `add <lang> <file.json>` checks a batch of translations and adds it in app_en.arb's order, and `check <lang>` reports what's missing or wrong.
- **Checks:** `test/l10n/translations_test.dart` checks every file for missing or extra keys, lost placeholders and those plural rules. `flutter gen-l10n` checks the syntax.

After adding a language, run `python3 tool/sync_languages.py` in `app/`. It lists the languages for Android 13's per-app language setting (`android/app/src/main/res/xml/locales_config.xml`) and in iOS's `Info.plist` (`CFBundleLocalizations`), and the test checks those lists too.
