# Mobile mail client (working title)

Planning for a Flutter mail app for iOS and Android: simple like Apple Mail, with Thunderbird-desktop power features for those who want them.
The name is not final (see [NAMING.md](NAMING.md)). The app will not be called "Thunderbird" (Mozilla trademark).

Status: **planning** (draft 1, 2026-10-04). There is no code yet.

## Files

| File | What it contains |
|---|---|
| [PLAN.md](PLAN.md) | The plan: positioning, UX, the Readable HTML reader, search, protocols (including JMAP), architecture, security, phases, risks, licensing and open decisions. §10 is the plugin question: Thunderbird add-on support, whether plugins are needed, and which language. |
| [NAMING.md](NAMING.md) | Name options, conflicts found, and the checks to run before choosing. |
| [research/mobile-client-2026-10.md](research/mobile-client-2026-10.md) | Facts with sources: official TB mobile apps, trademark, Dart and Flutter libraries, background and push limits, Gmail and Microsoft OAuth, ISPDB, JMAP, IMAP search. |
| [research/plugin-system-2026-10.md](research/plugin-system-2026-10.md) | Facts with sources: TB add-on architecture and how common Experiments are, App Store and Play rules, precedents (Obsidian, Joplin, Outlook, Gmail), JS/Wasm/Node runtimes, permission models and plugin security incidents. |

## In one paragraph

- **Reading:** the default reader rebuilds HTML mail from a strict allowlist and renders it natively. It keeps colours, highlights, emphasis and images scaled to fit, shows several images as a gallery, and runs no WebView or JavaScript. Original HTML and Plain text (Sans or Mono) are one tap away.
- **Search:** a bar slides down from the top as in Apple Mail. It shows local results at once and server results as they arrive (IMAP SEARCH, Gmail `X-GM-RAW`, JMAP), and it understands the Expression Search language from the desktop add-on.
- **Protocols:** IMAP/SMTP first; JMAP is first-class from Phase 3.
- **Plugins:**
  - Running Thunderbird add-ons is not realistic.
  - v1 needs no plugins.
  - A later plugin system would use TypeScript in a QuickJS sandbox, and Node.js only for the developer tooling.

## Related

- [Expression Search Reloaded](https://github.com/BuenGenio/expression-search-reloaded), the desktop add-on whose search language the app reuses. Its local checkout is in `~/Projects/Thunderbird/Expression-Search-NG/`.
