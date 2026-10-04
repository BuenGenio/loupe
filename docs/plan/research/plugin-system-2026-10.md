# Research: Thunderbird add-ons and plugin systems on mobile (as of 2026-10-04)

Desk research for [PLAN.md §10](../PLAN.md#10-plugins-thunderbird-add-on-support-or-our-own-system).
Items that could not be confirmed are marked **UNCONFIRMED**.

## 1. Thunderbird desktop add-on architecture

- **The MailExtension API is large.** The "Thunderbird 156, Manifest V3" docs list **61 API entries: 51 top-level namespaces plus 10 sub-namespaces**. The MV2 docs list 63.
  - Many namespaces come from Firefox: tabs, windows, storage, webRequest, proxy.
  - Mail-specific ones: accounts, addressBooks, cloudFile, compose, folders, identities, mailTabs, messageDisplay, messages, messengerUtilities, oauthProvider, spaces.
  - <https://webextension-api.thunderbird.net/en/latest/>
- **Experiments** are shipped inside an add-on and use Thunderbird internals directly (`Services.wm`, `nsIMsgFolder`, …).
  - They "can bypass the WebExtension permission system entirely". The user only sees "Have full, unrestricted access to Thunderbird, and your computer".
  - Thunderbird allows them in release builds; Firefox does not.
  - <https://developer.thunderbird.net/add-ons/mailextensions/experiments>
- **How common Experiments are** (own sample; no official statistic exists): the top 100 extensions by users on addons.thunderbird.net, each `manifest.json` checked for `experiment_apis`.

  | Sample | Use Experiments | Share of users |
  |---|---|---|
  | Top 10 | 9 | 95% |
  | Top 50 | 26 (52%) | 70% |
  | Top 100 (98 WebExtensions) | 48 (49%) | 67% |

  - Examples: ImportExportTools NG, Provider for Google Calendar, Send Later, Quicktext, CardBook, Owl for Exchange, DKIM Verifier, Thunderbird Conversations, TbSync, QuickFolders, FiltaQuilla.
  - Expression Search Reloaded also needs one.
  - Only 6 of the top 100 are Manifest V3.
- **Mobile:**
  - April 2024 FAQ: "Right now, no, they will not be available… We *want* to have add-ons in the future, but this will likely not happen within the next two years."
    <https://blog.thunderbird.net/2024/04/team-thunderbird-answers-your-most-frequently-asked-questions/>
  - The Android and iOS roadmaps (roadmaps.thunderbird.net) have no add-on items.
  - Nothing found about add-ons on iOS (**UNCONFIRMED**).

## 2. App store rules

### Apple (App Review Guidelines, updated 2026-06-08)
<https://developer.apple.com/app-store/review/guidelines/>

- **2.5.2:** apps "may not download, install, or execute code which introduces or changes features or functionality of the app".
- **4.7:** "Apps may offer certain software that is not embedded in the binary, specifically HTML5 and JavaScript mini apps and mini games, streaming games, chatbots, and plug-ins." Conditions:
  - 4.7.1: privacy, content filtering and reporting, in-app purchase.
  - 4.7.2: "may not extend or expose native platform APIs or technologies to the software without prior permission from Apple".
  - 4.7.3: no sharing of data or privacy permissions with any plugin "without explicit user consent in each instance".
  - 4.7.4: an index of the software, with universal links.
  - 4.7.5: age gating.
  - The current text no longer names WebKit/JavaScriptCore (older versions required them). **UNCONFIRMED** whether reviewers still expect them.
- **3.2.2(i)** forbids an interface "for displaying third-party… extensions, or plug-ins similar to the App Store or as a general-interest collection".
- **Developer Program License Agreement 3.3.1(B):** downloaded interpreted code must not change the primary purpose, bypass signing or the sandbox, or create a store.
  <https://developer.apple.com/support/terms/apple-developer-program-license-agreement/>
- **No JIT for embedded engines:** QuickJS, Hermes, JIT-less V8 and in-process JavaScriptCore all run interpreted. JIT is available only inside WKWebView.
  The `allow-jit` entitlement is reserved for BrowserEngineKit browsers.
  <https://developer.apple.com/forums/thread/746159>

### Google Play (Device and Network Abuse)
<https://support.google.com/googleplay/android-developer/answer/9888379>

- No downloading of executable code (dex, JAR, .so) from outside Play.
- "This restriction does not apply to code that runs in a virtual machine or an interpreter where either provides indirect access to Android APIs (such as JavaScript in a webview or browser)."
- Interpreted code loaded at runtime must not enable policy violations.

## 3. Precedents

| App | Mobile plugins | How |
|---|---|---|
| Obsidian | Yes | Runs in the WebView; no Node or Electron APIs on mobile; `isDesktopOnly` opt-out. **Not sandboxed**: plugins inherit Obsidian's access. Restricted Mode is on by default. <https://docs.obsidian.md/Plugins/Getting+started/Mobile+development> |
| Joplin | Yes, since v3.0 (2024) | Iframes inside a background WebView. **iOS: only vetted "recommended" plugins**, to comply with App Store rules. <https://joplinapp.org/help/apps/plugins> |
| Logseq | Not yet | "Coming to mobile" (2025); current status **UNCONFIRMED**. |
| Outlook mobile | Office.js add-ins | HTML/JS in a task pane, mostly in message read mode, Microsoft accounts only. Add-ins pass mobile validation; developers sign an iOS addendum. <https://learn.microsoft.com/en-us/office/dev/add-ins/outlook/outlook-mobile-addins> |
| Gmail mobile | Workspace add-ons | Declarative cards, no HTML/CSS. Logic runs **server-side** (Apps Script or HTTP endpoints). <https://developers.google.com/workspace/add-ons/concepts/card-interfaces> |
| Spark, FairEmail, Canary, … | No | No mainstream mobile IMAP client with third-party plugins was found. |

## 4. Runtimes usable from Flutter

- **flutter_js 0.8.7** (2026-01): QuickJS on Android, JavaScriptCore on iOS, via FFI. 81 open issues; irregular releases. <https://pub.dev/packages/flutter_js>
- **fjs 3.3.2** (2026-09-30): Rust + QuickJS; Android, iOS, desktop. Active, but small. <https://pub.dev/packages/fjs>
- **QuickJS upstream:** active (quickjs-ng v0.17.0, 2026-09; bellard/quickjs commits this month). flutter_qjs is stale (2022).
- **Hermes:** no Flutter binding; last standalone release 2024. It would need custom FFI work.
- **WebView:** WKWebView gets JIT. Options: webview_flutter 4.14.1, or flutter_inappwebview (has headless mode; last stable 2024-10).
- **Node.js on mobile (nodejs-mobile):**
  - A community fork; last release v18.20.4 (2024-10), and Node 18 is end-of-life. Last commit 2025-11.
  - React Native and Cordova only, no Flutter. JIT-less V8 on iOS.
  - <https://github.com/nodejs-mobile/nodejs-mobile>
- **WebAssembly:**
  - Wasmtime on iOS needs the Pulley interpreter (about 10x slower); "supported but less well tested". <https://docs.wasmtime.dev/examples-pulley.html>
  - Extism: no Dart host; its iOS target issue has been open since 2025-01.
  - wasm3: interpreter for iOS and Android; v0.9.0 (2026-08).
  - Wasmer 5: iOS via interpreters (Wasmi, WAMR).
  - In Dart: wasm_run 0.2.0+2 (2026-07).
- **Dart code at runtime in release (AOT) builds: not possible** for stock Flutter.
  - The Flutter team dropped code push. <https://flutter.googlesource.com/mirrors/flutter/+/HEAD/docs/contributing/issue_hygiene/Popular-issues.md>
  - Dart "Dynamic Modules" is experimental, "not fully sandboxed", and loading untrusted third-party code is explicitly "not OK".
    <https://dart.googlesource.com/sdk/+/refs/heads/main/pkg/dynamic_modules/README.md>
  - dart_eval and Shorebird exist, but they are not sandboxes for untrusted code.

## 5. Permission design and security incidents

- **WebExtensions / Thunderbird:** permissions are declared in the manifest (accountsRead, messagesRead, messagesModifyPermanent, messagesMove, messagesDelete, compose, …). Experiments bypass all of them.
- **VS Code:** "The extension host has the same permissions as VS Code itself". It relies on marketplace scans, signatures, publisher verification, a block list and Workspace Trust.
  <https://code.visualstudio.com/docs/configure/extensions/extension-runtime-security>
- **Obsidian:** no permission model; Restricted Mode and scanning only.
- **Figma:** after sandbox escapes in 2019, plugin logic moved to **QuickJS compiled to WebAssembly**, with the UI in a separate iframe and `postMessage` between them.
  This is the closest reference for a real permission boundary. <https://madebyevan.com/figma/an-update-on-plugin-security/>
- **Incidents relevant to email:**
  - **AgreeToSteal (2026-02):** an abandoned Outlook add-in had its hosting URL taken over and served phishing in Outlook's sidebar; 4,000+ credentials stolen.
    Remotely hosted plugin code can change after review. <https://thehackernews.com/2026/02/first-malicious-outlook-add-in-found.html>
  - **postmark-mcp (2025-09):** an npm email plugin silently BCC'd every sent message to the attacker.
    <https://www.bleepingcomputer.com/news/security/unofficial-postmark-mcp-npm-silently-stole-users-emails/>
  - **GlassWorm (2025-10):** a self-spreading worm in VS Code/OpenVSX extensions, about 35,800 installs.
    <https://www.bleepingcomputer.com/news/security/self-spreading-glassworm-malware-hits-openvsx-vs-code-registries/>
  - **Cyberhaven (2024-12):** a phished developer account pushed a malicious Chrome extension update; about 35 extensions and 2.6M users affected.
    <https://www.cyberhaven.com/blog/cyberhavens-chrome-extension-security-incident-and-what-were-doing-about-it>
