#!/usr/bin/env python3
"""Writes marketing/posts/*.md (and posts/_drafts/ for video posts) from the
plan below. Re-run after editing; existing files are overwritten.

    python3 marketing/creative/schedule.py
"""
import pathlib
import yaml

ROOT = pathlib.Path(__file__).resolve().parents[1]
POSTS = ROOT / "posts"
DRAFTS = POSTS / "_drafts"


class Literal(str):
    pass


yaml.SafeDumper.add_representer(Literal, lambda d, v: d.represent_scalar("tag:yaml.org,2002:str", v, style="|"))


def lit(s):
    return Literal(s.strip() + "\n")


IMG = ["bluesky", "mastodon", "threads", "instagram"]
TEXT = ["bluesky", "mastodon", "threads"]

posts = []


def post(id, date, platforms, text, *, campaign, link="https://loupe.mx/", media=None, kind=None, **extra):
    p = {
        "id": id,
        "date": date,
        "status": extra.pop("status", "scheduled"),
        "campaign": campaign,
        "platforms": platforms,
        "link": link,
    }
    if media:
        p["media"] = [{"path": f"media/{m}.jpg" if not m.endswith((".mp4", ".jpg", ".png")) else f"media/{m}", "alt": a} for m, a in media]
    for k, v in extra.items():
        if isinstance(v, dict):
            v = {kk: lit(vv) if isinstance(vv, str) and "\n" in vv.strip() or kk in ("text", "caption", "description") else vv for kk, vv in v.items()}
        p[k] = v
    if kind and "instagram" in platforms:
        p.setdefault("instagram", {})["kind"] = kind
    posts.append((p, text, extra.get("_draft", False)))


ALT = {
    "tease/focus": "Dark navy card with a teal lens ring: 'Coming 20 October. Your mail, in focus. A calm mail app for Android, with serious tools underneath.'",
    "tease/search": "Card reading 'Look closer: what if the mail app on your phone understood this?' above a phone showing Loupe's search for f:(dana or ben) -is:read with chips 'From: dana or ben' and 'Unread' and four results.",
    "tease/no-cloud": "Dark card: 'There is no Loupe cloud. Your phone talks to your mail server. Nobody sits in between.'",
    "tease/tuesday": "Dark card: 'Tuesday. Free. Open source. Private by design. Loupe lands on 20 October.'",
    "launch/1-hello": "Dark card: 'Out now on Android. Meet Loupe. Simple on the surface. Powerful underneath. Free and open source.'",
    "launch/2-inbox": "Loupe's All Inboxes screen on a phone: unread dots, starred senders, flags, thread counts and coloured account stripes. Caption: 'One calm inbox.'",
    "launch/3-readable": "A Trailhead Outfitters newsletter in Loupe's Readable mode: large hero photo, legible text and a 'Shop the guide' button. Caption: 'Newsletters, rebuilt for your hand.'",
    "launch/4-search": "Loupe's search screen with the query f:(dana or ben) -is:read, chips 'From: dana or ben' and 'Unread', and four results. Caption: 'Search like you mean it.'",
    "launch/5-phishing": "Loupe's 'This looks like phishing' sheet explaining a look-alike domain and a familiar name from a new address. Caption: 'Phishing, explained.'",
    "launch/6-free": "Dark card: 'No servers. No tracking. No ads. Download free at loupe.mx. Pay what you want, if you like it.'",
    "features/readable": "A newsletter in Loupe's Readable mode on a phone, with the headline 'Stop pinching newsletters.'",
    "features/your-server": "Loupe's New Rule editor with a search-style condition, 'Run On Server' switched on and the generated Sieve script. Headline: 'Rules as Sieve. Snooze as a folder.'",
    "features/built-in-public": "Dark card: 'Built in public. 11 packages. 1,900+ tests. 0 trackers. Every line is on GitHub under the MPL-2.0.'",
    "launch/thanks": "Dark card: 'Launch week. Thank you. For every download, bug report, star and kind word.'",
    "no-cloud/snooze-1": "Card 1 of 4: 'How do you snooze mail without a server? Most apps snooze on their own servers. Loupe has none.'",
    "no-cloud/snooze-2": "Card 2 of 4: 'The message moves to a Snoozed folder, on your mail server, where every client can see it.'",
    "no-cloud/snooze-3": "Card 3 of 4: 'A keyword says when it wakes up, stored on the message itself, in UTC minutes.'",
    "no-cloud/snooze-4": "Card 4 of 4: 'Any device can wake it. Switch phones or clients: nothing is trapped.'",
    "no-cloud/phishing": "Loupe's phishing sheet on a phone listing why a message looks suspicious. Headline: 'This looks like phishing, and why.'",
    "search/tip-unread-week": "Search tip card: 'Unread this week, minus the newsletters' with the expression is:unread newer_than:7d -tag:newsletter and chips Unread, Newer than 7 days, Not tagged newsletter.",
    "search/smart-mailboxes": "Loupe's Mailboxes screen with accounts and two Smart Mailboxes. Headline: 'Save a search. Find it on every device.'",
    "search/tip-old-attachments": "Search tip card: 'Big, old attachments, ready to clean up' with the expression attachment:yes older_than:1y.",
    "subscriptions/never-read": "Loupe's Subscriptions screen with Newsletters and Discussions tabs, a Never Read filter, read rates and Unsubscribe buttons. Headline: 'Which newsletters do you never read?'",
    "encryption/openpgp": "Loupe's 'Signed by Dana Okafor' sheet: decrypted on this device, protected subject and the key fingerprint. Headline: 'OpenPGP that just works.'",
    "encryption/smime": "Dark card: 'S/MIME. Use the certificate your company already gave you. Loupe signs and decrypts with certificates installed on your Android device.'",
    "rules/rules": "Loupe's rule editor: a search-style condition, a Mark as Read action and Run On Server with its Sieve script. Headline: 'Write a rule like a search.'",
    "rules/invitation": "An Outlook meeting invitation in Loupe showing both time zones and Accept, Maybe and Decline buttons. Headline: 'Accept, Maybe, Decline. Right there.'",
    "power/tablet": "Loupe on a tablet in landscape: mailboxes, message list and a message with a photo, in three panes. Headline: 'Three panes and a command palette.'",
    "power/patches": "A mailing-list patch in Loupe drawn as a red and green diff in a monospace font. Headline: 'Review patches on the train.'",
    "power/dark": "Loupe's All Inboxes in true-black dark mode. Headline: 'True black, and readable.'",
}


def m(*names):
    return [(n, ALT[n]) for n in names]


# ---------------------------------------------------------------- Week 0: tease
post("2026-10-12-tease-focus", "2026-10-12T15:00:00Z", IMG + ["linkedin"], campaign="tease", media=m("tease/focus"), kind="image",
     text="A mail app, brought into focus. Loupe: calm on the surface, serious underneath, private by design. Coming to Android on 20 October. {link}",
     bluesky={"text": "Hello 👋 We're Loupe: a calm mail app for Android with serious tools underneath, and no servers of its own.\n\nComing 20 October. {link}"},
     mastodon={"text": "Hello, Fediverse 👋\n\nLoupe is a free, open-source mail app for Android: calm on the surface, with desktop-class search, rules and encryption underneath. No servers of its own, no tracking.\n\nIt lands on 20 October. {link}\n\n#Android #Email #FOSS #OpenSource #Privacy"},
     instagram={"caption": "Your mail, in focus. 🔍\n\nLoupe is a calm mail app for Android with serious tools underneath. Free, open source and private by design.\n\nComing 20 October. Link in bio.\n\n#android #email #opensource #privacy #androidapps #productivity"},
     linkedin={"text": "After months of evenings and weekends, Loupe is almost ready: a free, open-source mail app for Android that's as calm as the best phone mail apps, with the search, rules and encryption people expect from a desktop client.\n\nIt has no servers of its own and collects nothing. It lands on 20 October.\n\n{link}"})

post("2026-10-14-tease-search", "2026-10-14T15:00:00Z", IMG, campaign="tease", media=m("tease/search"), kind="image", link="https://loupe.mx/features/#search",
     text="f:(dana or ben) -is:read. Unread mail from Dana or Ben, on your phone, in one line. Loupe has a real search language. Six days. {link}",
     bluesky={"text": "f:(dana or ben) -is:read\n\nUnread mail from Dana or Ben, in one line, on your phone. Loupe's search understands fields, groups, dates and negation.\n\n6 days. {link}"},
     mastodon={"text": "f:(dana or ben) -is:read\n\nUnread mail from Dana or Ben, typed in one line on a phone. Loupe has a real search language: fields, groups, dates, negation. Results from the phone first, then the server.\n\nSix days to go. {link}\n\n#Android #Email #FOSS"},
     instagram={"caption": "Look closer. 🔍\n\nf:(dana or ben) -is:read finds unread mail from Dana or Ben, in one line. Loupe's search speaks fields, groups, dates and negation.\n\nComing 20 October. Link in bio.\n\n#android #email #productivity #opensource #inboxzero"})

post("2026-10-16-tease-cloud", "2026-10-16T15:00:00Z", IMG + ["linkedin"], campaign="tease", media=m("tease/no-cloud"), kind="image",
     text="There is no Loupe cloud. Your phone talks to your mail server, and nobody sits in between. Four days. {link}",
     bluesky={"text": "There is no Loupe cloud.\n\nNo account, no sync server, no analytics. Your phone talks to your mail server and nobody sits in between.\n\n4 days. {link}"},
     mastodon={"text": "There is no Loupe cloud.\n\nMany mail apps sync your mailbox through their own servers. Loupe has none: no account, no analytics, no crash reporter. Your phone talks to your mail server, full stop.\n\nFour days. {link}\n\n#Privacy #Email #Android #FOSS"},
     instagram={"caption": "There is no Loupe cloud. ☁️❌\n\nNo account. No sync server. No analytics. Your phone talks to your mail server, and nobody sits in between.\n\nComing 20 October. Link in bio.\n\n#privacy #android #email #opensource #degoogle"},
     linkedin={"text": "A design choice I keep coming back to: Loupe has no servers.\n\nMany mail apps log in to your mailbox from their own infrastructure to power push and snooze. Loupe does those things with open standards on your own mail server instead (a Snoozed folder, Sieve rules, settings in your mailbox), so there's nothing in between to breach.\n\nLaunching 20 October. {link}"})

post("2026-10-18-tease-tuesday", "2026-10-18T17:00:00Z", IMG, campaign="tease", media=m("tease/tuesday"), kind="image",
     text="Tuesday. Loupe: free, open source, private by design. Mail for Android, coming 20 October. {link}",
     bluesky={"text": "Tuesday. 🔍✉️\n\nFree. Open source. Private by design. {link}"},
     mastodon={"text": "Tuesday: Loupe, a free and open-source mail app for Android, MPL-2.0. IMAP, JMAP, Sieve, OpenPGP, S/MIME, no tracking.\n\n{link}\n\n#Android #Email #FOSS"},
     instagram={"caption": "Tuesday. 🔍✉️\n\nFree. Open source. Private by design.\n\nLink in bio.\n\n#android #email #opensource #privacy"})

# ---------------------------------------------------------------- Week 1: launch
# Bluesky and Mastodon take 4 images; the full 6-card carousel goes to the others.
post("2026-10-20-launch", "2026-10-20T13:00:00Z", ["bluesky", "mastodon"], campaign="launch", link="https://loupe.mx/blog/introducing-loupe/",
     media=m("launch/2-inbox", "launch/3-readable", "launch/4-search", "launch/5-phishing"),
     text="Loupe is out: a free, open-source mail app for Android. Calm on the surface, serious underneath, private by design. {link}",
     bluesky={"text": "Loupe is out 🔍✉️\n\nA free, open-source mail app for Android: Readable mode, a real search language, Sieve rules, OpenPGP and S/MIME. IMAP and JMAP. No servers, no tracking.\n\n{link}"},
     mastodon={"text": "Loupe is out! 🔍✉️\n\nA free, open-source (MPL-2.0) mail app for Android:\n\n• Readable mode rebuilds HTML mail for your phone\n• A real search language, phone first, server after\n• Smart Mailboxes and Sieve rules stored on your server\n• OpenPGP with Autocrypt, and S/MIME\n• IMAP and JMAP\n\nNo servers, no tracking, no ads.\n\n{link}\n\n#Android #Email #FOSS #OpenSource #Privacy #JMAP"})

post("2026-10-20-launch-carousel", "2026-10-20T13:05:00Z", ["threads", "instagram", "linkedin"], campaign="launch", link="https://loupe.mx/blog/introducing-loupe/",
     media=m("launch/1-hello", "launch/2-inbox", "launch/3-readable", "launch/4-search", "launch/5-phishing", "launch/6-free"), kind="carousel",
     text="Loupe is out: a free, open-source mail app for Android. Calm on the surface, serious underneath, private by design. {link}",
     threads={"text": "Loupe is out 🔍✉️\n\nA free, open-source mail app for Android. Readable mode for newsletters, a real search language, rules on your own server, OpenPGP and S/MIME. No servers of its own, no tracking.\n\n{link}"},
     instagram={"caption": "Loupe is out. 🔍✉️\n\nA free, open-source mail app for Android:\n→ Readable mode for newsletters\n→ Search that understands you\n→ Phishing, explained\n→ No servers, no tracking, no ads\n\nDownload free, pay what you want. Link in bio.\n\n#android #email #opensource #privacy #androidapps #productivity #inboxzero"},
     linkedin={"text": "Today I'm releasing Loupe, a free and open-source mail app for Android.\n\nThe idea: as calm as the best phone mail apps for everyday reading, with the depth of a desktop client underneath. A search language with phone-first results, Smart Mailboxes and Sieve rules stored on your own mail server, OpenPGP and S/MIME, IMAP and JMAP.\n\nIt has no servers of its own and collects nothing. It's MPL-2.0 and built in public on GitHub. The story behind it is on the blog:\n\n{link}"})

post("2026-10-20-reddit-showcase", "2026-10-20T15:00:00Z", ["reddit"], campaign="launch", link="https://loupe.mx/",
     text="Loupe: a free, open-source mail app for Android. {link}",
     reddit={"subreddit": "droidappshowcase", "title": "I made Loupe, a free and open-source (MPL-2.0) mail app for Android: Readable mode, search expressions, Sieve rules, OpenPGP/S/MIME, no tracking",
             "text": "Hi! I'm the developer. Loupe is a mail client for Android that tries to be calm for everyday use and powerful when you need it:\n\n- **Readable mode** rebuilds HTML newsletters to fit the phone (original and plain text one tap away)\n- **Search language**: `from:alice and (subject:invoice or body:\"PO 123\")`, results from the phone first, then the server\n- **Smart Mailboxes, snooze and Sieve rules** stored on your own mail server\n- **Subscriptions**: newsletters by sender with read rates and one-tap unsubscribe\n- **OpenPGP** (Autocrypt, Thunderbird-compatible) and **S/MIME**\n- IMAP/SMTP and JMAP (Fastmail, Stalwart)\n\nNo servers of its own, no analytics, no ads. Free to download (pay what you want, optional). Source: https://github.com/BuenGenio/loupe\n\nWebsite: {link}\n\nIt's early: nightly builds, one developer. I'd love to hear what's missing or broken."})

post("2026-10-21-readable", "2026-10-21T15:00:00Z", IMG, campaign="launch", media=m("features/readable"), kind="image", link="https://loupe.mx/docs/reading/",
     text="Stop pinching newsletters. Loupe's Readable mode rebuilds HTML mail for your phone: real text sizes, footers as fine print, photos as a carousel. {link}",
     bluesky={"text": "Stop pinching newsletters.\n\nLoupe's Readable mode rebuilds HTML mail for the phone: real text sizes, footers as fine print, photo grids as a carousel. Original and plain text are one tap away.\n\n{link}"},
     mastodon={"text": "Stop pinching newsletters.\n\nLoupe's Readable mode rebuilds desktop-sized HTML mail for the screen in your hand: real text sizes, footers shrunk to fine print, photo grids as a swipeable carousel, colours fixed for dark mode. No web view, no scripts.\n\n{link}\n\n#Android #Email #FOSS"},
     instagram={"caption": "Stop pinching newsletters. 🤏\n\nLoupe's Readable mode rebuilds HTML mail for your phone: real text sizes, footers as fine print, photos as a carousel.\n\nLink in bio.\n\n#android #email #newsletter #design #opensource"})

post("2026-10-21-reddit-fossdroid", "2026-10-21T16:00:00Z", ["reddit"], campaign="launch", link="https://loupe.mx/",
     text="Loupe {link}",
     reddit={"subreddit": "fossdroid", "title": "Loupe: a new MPL-2.0 mail client for Android with JMAP, Sieve rules, OpenPGP and S/MIME, and no servers of its own",
             "text": "Loupe is a new open-source mail client for Android (Flutter, MPL-2.0). Things that might interest this sub:\n\n- No telemetry, analytics or crash reporting; no servers of its own\n- Encrypted local database (sqlite3mc); remote images blocked by default; tracking redirects unwrapped\n- Snooze, Smart Mailboxes and rules live on *your* mail server (a Snoozed folder + keyword, IMAP METADATA, Sieve), so nothing is locked into the app\n- OpenPGP with Autocrypt, S/MIME with Android KeyChain certificates\n- IMAP/SMTP and JMAP\n\nBuilds are signed nightly APKs from GitHub Actions; Obtainium works with the GitHub releases. It isn't on F-Droid.\n\nSource: https://github.com/BuenGenio/loupe · Site: {link}\n\nFeedback very welcome. I'm the developer."})

post("2026-10-22-your-server", "2026-10-22T15:00:00Z", IMG, campaign="launch", media=m("features/your-server"), kind="image", link="https://loupe.mx/blog/introducing-loupe/",
     text="Your mail server is the source of truth: Loupe keeps rules as Sieve, snooze as a folder, and Smart Mailboxes in your mailbox. Nothing is trapped in the app. {link}",
     bluesky={"text": "Your mail server is the source of truth.\n\nLoupe keeps rules as Sieve, snooze as a folder + keyword, and Smart Mailboxes in your own mailbox. Switch phones or clients and nothing is trapped.\n\n{link}"},
     mastodon={"text": "Your mail server is the source of truth.\n\nLoupe has no cloud, so everything that should outlive your phone lives on your server, in the open:\n• rules as Sieve (ManageSieve or JMAP)\n• snooze as a Snoozed folder + keyword\n• Smart Mailboxes as IMAP METADATA or a settings folder\n\nWorks nicely with Stalwart, Dovecot and mailcow.\n\n{link}\n\n#SelfHosted #Email #JMAP #Sieve #FOSS"},
     instagram={"caption": "Your server, your rules. 🗄️\n\nLoupe keeps rules as Sieve, snooze as a folder and Smart Mailboxes in your own mailbox. Switch phones or apps: nothing is trapped.\n\nLink in bio.\n\n#selfhosted #email #privacy #opensource #android"})

post("2026-10-22-reddit-flutterdev", "2026-10-22T16:00:00Z", ["reddit"], campaign="launch", link="https://loupe.mx/development/",
     text="Loupe {link}",
     reddit={"subreddit": "FlutterDev", "title": "I built a full mail client in Flutter: 11 packages, an encrypted SQLite store, IMAP + JMAP, pure-Dart S/MIME. Notes on what worked",
             "text": "Loupe is an open-source (MPL-2.0) mail app for Android, written in Flutter. Some notes that might be useful to other Flutter devs:\n\n- **Pub workspace monorepo**: 11 packages with a contracts-only `mail_model` at the bottom, so packages could be built in parallel and tested without a device.\n- **Storage**: drift + SQLite FTS5 for search, sqlite3mc for encryption.\n- **Search**: one parser produces a syntax tree that compiles to SQL, IMAP SEARCH, Gmail's raw search and JMAP filters; server results are post-filtered with the same matcher.\n- **Rendering**: Readable mode rebuilds HTML mail from plain widgets: no web view, no scripts.\n- **Crypto**: OpenPGP via dart_pg; S/MIME (CMS, PKCS #12, chain validation) in pure Dart on pointycastle, with Android KeyChain keys used through a small platform channel.\n- **Marketing screenshots** are rendered from widget tests with real fonts.\n\nArchitecture and build steps: {link} · Source: https://github.com/BuenGenio/loupe\n\nHappy to go deeper on any of it."})

post("2026-10-23-numbers", "2026-10-23T15:00:00Z", IMG + ["linkedin"], campaign="launch", media=m("features/built-in-public"), kind="image", link="https://loupe.mx/development/",
     text="Built in public: 11 packages, 1,900+ automated tests, 0 trackers. Every line of Loupe is on GitHub under the MPL-2.0. {link}",
     bluesky={"text": "Built in public:\n\n11 packages\n1,900+ automated tests\n0 trackers\n\nEvery line of Loupe is on GitHub under the MPL-2.0. Nightly APKs come straight from CI.\n\n{link}"},
     mastodon={"text": "Loupe, by the numbers:\n\n• 11 Dart packages with explicit contracts\n• 1,900+ automated tests\n• 0 trackers, 0 servers\n\nEvery push to main is analysed, tested, signed and published as a Nightly APK by GitHub Actions, so what you install is what you can read.\n\n{link}\n\n#Flutter #Dart #FOSS #OpenSource"},
     instagram={"caption": "Built in public. 🛠️\n\n11 packages. 1,900+ tests. 0 trackers. Every line of Loupe is on GitHub.\n\nLink in bio.\n\n#opensource #flutter #developer #buildinpublic #android"},
     linkedin={"text": "Loupe by the numbers, launch week: 11 Dart packages behind explicit contracts, 1,900+ automated tests, and zero trackers.\n\nEvery push is analysed, tested, signed and published as a Nightly build by GitHub Actions. If you're curious how a mail client is put together in Flutter (sync engine, encrypted store, IMAP and JMAP transports, pure-Dart S/MIME), the architecture is documented here:\n\n{link}"})

post("2026-10-23-reddit-selfhosted", "2026-10-23T16:00:00Z", ["reddit"], campaign="launch", link="https://loupe.mx/",
     text="Loupe {link}",
     reddit={"subreddit": "selfhosted", "title": "A mobile mail client that keeps its state on your own server: Loupe (Android, open source, JMAP + Sieve)",
             "text": "If you run your own mail (Stalwart, Dovecot, mailcow…), you may like how Loupe works: it has no cloud of its own, so its state lives on your server.\n\n- **Server rules** compiled to Sieve and uploaded over ManageSieve, or over JMAP (RFC 9661)\n- **Snooze** = a `Snoozed` folder + a keyword with the wake-up time (documented convention)\n- **Smart Mailboxes** stored as IMAP METADATA, or a message in a `Loupe Settings` folder\n- **JMAP** accounts with push, plus plain IMAP/SMTP\n\nThe app itself: Android, MPL-2.0, no telemetry, encrypted local store, OpenPGP and S/MIME.\n\nSite: {link} · Source: https://github.com/BuenGenio/loupe\n\n(Check the sub's rules on new-project posts before this goes up: some days are reserved.)"})

post("2026-10-24-thanks", "2026-10-24T16:00:00Z", IMG, campaign="launch", media=m("launch/thanks"), kind="image", link="https://loupe.mx/development/#roadmap",
     text="Thank you for an incredible launch week. Every download, bug report, star and kind word helps. Here's what's next for Loupe. {link}",
     bluesky={"text": "Thank you for launch week 💙\n\nEvery download, bug report, star and kind word helps. Next up: Google and Microsoft sign-in, a Play Store beta, and iOS.\n\n{link}"},
     mastodon={"text": "Thank you for launch week 💙\n\nEvery download, bug report, star and kind word made a difference. Next for Loupe: Sign in with Google and Microsoft, a Google Play beta, and iOS on TestFlight.\n\nThe roadmap: {link}\n\n#FOSS #Android #Email"},
     instagram={"caption": "Thank you. 💙\n\nFor every download, bug report, star and kind word in launch week. Next: Google and Microsoft sign-in, a Play Store beta, and iOS.\n\nLink in bio.\n\n#opensource #android #email #thankyou"})

# ---------------------------------------------------------------- Week 2: no cloud
post("2026-10-27-no-cloud", "2026-10-27T13:00:00Z", TEXT + ["linkedin"], campaign="no-cloud", link="https://loupe.mx/blog/no-loupe-cloud/",
     text="There is no Loupe cloud, and that's the point. How snooze, Smart Mailboxes and notifications work without a server in the middle. {link}",
     bluesky={"text": "There is no Loupe cloud, and that's the point.\n\nHow snooze, Smart Mailboxes, rules and notifications work without a server in the middle, and the honest trade-off:\n\n{link}"},
     mastodon={"text": "New on the blog: \"There is no Loupe cloud, and that's the point.\"\n\nHow snooze, Smart Mailboxes, rules and notifications work without a company server in the middle, and what that costs (notifications every ~15 min, or experimental Instant Delivery).\n\n{link}\n\n#Privacy #Email #FOSS #Android"},
     linkedin={"text": "Many mail apps sync your mailbox through their own servers. It makes push and snooze easy, and it means a third party holds a key to your inbox.\n\nLoupe has no servers. I wrote up how its features work anyway, using open standards on your own mail server, and the honest trade-offs:\n\n{link}"})

post("2026-10-28-snooze-carousel", "2026-10-28T15:00:00Z", IMG, campaign="no-cloud", link="https://loupe.mx/blog/no-loupe-cloud/",
     media=m("no-cloud/snooze-1", "no-cloud/snooze-2", "no-cloud/snooze-3", "no-cloud/snooze-4"), kind="carousel",
     text="How do you snooze mail without a server? A Snoozed folder on your mail server, and a keyword with the wake-up time. Any device can wake it. {link}",
     bluesky={"text": "How do you snooze mail without a server?\n\n1. Move it to a Snoozed folder on your mail server\n2. Add a keyword with the wake-up time\n3. Any device that follows the convention wakes it\n\n{link}"},
     mastodon={"text": "How Loupe snoozes mail without a server:\n\n1️⃣ The message moves to a Snoozed folder on your mail server\n2️⃣ A keyword records the wake-up time (UTC minutes)\n3️⃣ After each sync, any device following the convention moves due messages back\n\nThe convention is documented, so other clients can join in.\n\n{link}\n\n#Email #IMAP #FOSS"},
     instagram={"caption": "How do you snooze mail without a server? 😴\n\nSwipe →\n\nLoupe keeps snoozed mail on your own mail server, so nothing is trapped in an app.\n\nLink in bio.\n\n#email #privacy #productivity #opensource #android"})

post("2026-10-28-reddit-fastmail", "2026-10-28T16:00:00Z", ["reddit"], campaign="no-cloud", link="https://loupe.mx/docs/accounts/",
     text="Loupe {link}",
     reddit={"subreddit": "fastmail", "title": "Loupe, an open-source Android mail app with native JMAP and push",
             "text": "For Fastmail users on Android looking for a third-party client: Loupe supports JMAP natively, not just IMAP.\n\n- Sync and search over JMAP, with push via EventSource\n- Rules written like searches (run on the phone, or as Sieve on servers that offer it)\n- Smart Mailboxes saved in your account so they follow you\n- Readable mode, a search language, OpenPGP and S/MIME\n\nIt's free, MPL-2.0, and has no servers of its own. Setup: {link}\n\nI'm the developer; feedback from Fastmail users especially welcome."})

post("2026-10-30-phishing", "2026-10-30T15:00:00Z", IMG, campaign="no-cloud", media=m("no-cloud/phishing"), kind="image", link="https://loupe.mx/docs/privacy-security/",
     text="Not just 'this might be phishing', but why: look-alike domains, a familiar name from a new address. Loupe checks on your phone and explains. {link}",
     bluesky={"text": "\"This looks like phishing\", and why.\n\nLoupe flags look-alike domains and familiar names from new addresses, explains each finding in plain words, and does it all on your phone.\n\n{link}"},
     mastodon={"text": "A phishing warning that explains itself.\n\nLoupe checks every message on the phone (nothing is sent anywhere) and tells you why it looks wrong: a look-alike domain, a name you know from an address you don't, links that don't go where they say.\n\n{link}\n\n#Security #Phishing #Email #FOSS"},
     instagram={"caption": "Phishing, explained. 🎣\n\nLoupe doesn't just warn you. It tells you why: a look-alike domain, a familiar name from a new address. All checked on your phone.\n\nLink in bio.\n\n#cybersecurity #phishing #privacy #email #android"})

# ---------------------------------------------------------------- Week 3: search
post("2026-11-03-search-tour", "2026-11-03T13:00:00Z", TEXT + ["linkedin"], campaign="search", link="https://loupe.mx/blog/search-like-you-mean-it/",
     text="Search your mail like you mean it: a short tour of Loupe's search language, and how one query runs on the phone and on the server. {link}",
     bluesky={"text": "Search your mail like you mean it 🔍\n\nA short tour of Loupe's search language: fields, groups, dates, negation, and how one query compiles to SQLite, IMAP, Gmail and JMAP.\n\n{link}"},
     mastodon={"text": "New on the blog: a tour of Loupe's search language.\n\nfrom:alice and (subject:invoice or body:\"PO 123\")\n\nOne parse, four engines: SQLite FTS5 on the phone, IMAP SEARCH, Gmail's raw search, JMAP filters, with post-filtering where a server can't keep up.\n\n{link}\n\n#Email #Search #FOSS #Android"},
     linkedin={"text": "Phone mail search is usually a box and a prayer. Loupe parses your query once into a syntax tree and compiles it four ways: SQLite full-text search on the device, IMAP SEARCH, Gmail's search syntax, and JMAP filters, then filters server results on the phone so they match exactly.\n\nA short tour for anyone who likes precise tools:\n\n{link}"})

post("2026-11-04-tip-unread", "2026-11-04T15:00:00Z", IMG, campaign="search", media=m("search/tip-unread-week"), kind="image", link="https://loupe.mx/docs/search-language/",
     text="Search tip: is:unread newer_than:7d -tag:newsletter finds this week's unread mail without the newsletters. Save it as a Smart Mailbox. {link}",
     bluesky={"text": "Search tip 🔍\n\nis:unread newer_than:7d -tag:newsletter\n\nThis week's unread mail, minus the newsletters. Save it as a Smart Mailbox and it follows you to every device.\n\n{link}"},
     mastodon={"text": "Loupe search tip:\n\nis:unread newer_than:7d -tag:newsletter\n\nUnread, from the last 7 days, not tagged newsletter. Save it as a Smart Mailbox; it's stored on your mail server, so it's on your tablet too.\n\nAll operators: {link}\n\n#Email #Productivity #FOSS"},
     instagram={"caption": "Search tip 🔍\n\nis:unread newer_than:7d -tag:newsletter\n\nThis week's unread mail, minus the newsletters. Save it as a Smart Mailbox.\n\nLink in bio.\n\n#productivity #inboxzero #email #android #tips"})

post("2026-11-06-smart-mailboxes", "2026-11-06T15:00:00Z", IMG, campaign="search", media=m("search/smart-mailboxes"), kind="image", link="https://loupe.mx/docs/smart-mailboxes/",
     text="Save a search, find it on every device. Loupe stores Smart Mailboxes on your own mail server, not in a cloud of ours. We don't have one. {link}",
     bluesky={"text": "Save a search. Find it on every device.\n\nLoupe stores Smart Mailboxes on your own mail server (IMAP METADATA, or a settings folder), not in a cloud of ours. We don't have one.\n\n{link}"},
     mastodon={"text": "Smart Mailboxes in Loupe are saved searches, stored on your own mail server: as an IMAP METADATA annotation where supported, otherwise in a small message in a \"Loupe Settings\" folder. The format is documented.\n\nSet one up on your phone, find it on your tablet.\n\n{link}\n\n#Email #IMAP #FOSS"},
     instagram={"caption": "Save a search. Find it everywhere. 📬\n\nLoupe stores Smart Mailboxes on your own mail server, not in a cloud of ours.\n\nLink in bio.\n\n#email #productivity #android #opensource"})

post("2026-11-07-tip-attachments", "2026-11-07T16:00:00Z", ["bluesky", "mastodon", "threads"], campaign="search", media=m("search/tip-old-attachments"), link="https://loupe.mx/docs/search-language/",
     text="Weekend clean-up: attachment:yes older_than:1y finds big, old attachments. Save it as a Smart Mailbox and tidy up once a month. {link}",
     bluesky={"text": "Weekend inbox clean-up 🧹\n\nattachment:yes older_than:1y\n\nEvery attachment older than a year. Save it as a Smart Mailbox and tidy up once a month.\n\n{link}"})

# ---------------------------------------------------------------- Week 4: subscriptions
post("2026-11-10-subscriptions", "2026-11-10T15:00:00Z", IMG + ["linkedin"], campaign="subscriptions", media=m("subscriptions/never-read"), kind="image", link="https://loupe.mx/docs/subscriptions/",
     text="Which newsletters do you never read? Loupe counts on your phone, then unsubscribes in one tap, without a third-party service reading your inbox. {link}",
     bluesky={"text": "Which newsletters do you never read? 📰\n\nLoupe ranks bulk mail by how much you leave unread, counted on your phone, then unsubscribes in one tap. No third-party service reading your inbox.\n\n{link}"},
     mastodon={"text": "Which newsletters do you never read?\n\nLoupe's Subscriptions screen groups bulk mail by sender, shows read rates for the last 90 days, and unsubscribes by one-click, mail or the sender's page. Everything is counted on your phone; no unsubscribe service gets access to your inbox.\n\n{link}\n\n#Email #Privacy #FOSS"},
     instagram={"caption": "Which newsletters do you never read? 📰\n\nLoupe counts on your phone, then unsubscribes in one tap. No third-party service reading your inbox.\n\nLink in bio.\n\n#inboxzero #email #declutter #privacy #android"},
     linkedin={"text": "Unsubscribe services usually need full access to your inbox. Loupe's Subscriptions screen does the counting on your phone instead: newsletters ranked by how much you leave unread, and one-tap unsubscribe using the standard methods the sender offers.\n\n{link}"})

# ---------------------------------------------------------------- Week 5: encryption
post("2026-11-17-openpgp", "2026-11-17T15:00:00Z", IMG, campaign="encryption", media=m("encryption/openpgp"), kind="image", link="https://loupe.mx/docs/encryption/",
     text="OpenPGP that just works: Autocrypt, Thunderbird-compatible keys, and a hidden subject line. Decrypted on your phone. {link}",
     bluesky={"text": "OpenPGP that just works 🔐\n\nAutocrypt for painless key exchange, keys compatible with Thunderbird, a protected subject line, all decrypted on your phone.\n\n{link}"},
     mastodon={"text": "End-to-end encryption in Loupe:\n\n• OpenPGP, compatible with Thunderbird, with Autocrypt\n• Protected (hidden) subject lines for OpenPGP\n• S/MIME, including certificates installed on the Android device\n• Keys stay on the phone\n\n{link}\n\n#OpenPGP #Encryption #Email #FOSS #Privacy"},
     instagram={"caption": "OpenPGP that just works. 🔐\n\nAutocrypt, Thunderbird-compatible keys, and a hidden subject line. Decrypted on your phone.\n\nLink in bio.\n\n#encryption #privacy #cybersecurity #email #opensource"})

post("2026-11-19-smime", "2026-11-19T15:00:00Z", ["bluesky", "mastodon", "linkedin", "threads"], campaign="encryption", media=m("encryption/smime"), link="https://loupe.mx/docs/encryption/",
     text="Use the S/MIME certificate your company already gave you: Loupe signs and decrypts with certificates installed on your Android device. {link}",
     bluesky={"text": "S/MIME on Android, done properly: Loupe signs and decrypts with certificates installed on your device (KeyChain), or a .p12 you import, with optional passphrases and revocation checks.\n\n{link}"},
     mastodon={"text": "S/MIME in Loupe: certificates installed on the Android device (by your IT department or in Settings) can sign and decrypt without the key ever leaving the keystore. PKCS #12 import, optional passphrases, opt-in OCSP/CRL revocation checks.\n\n{link}\n\n#SMIME #Email #Encryption #FOSS"},
     linkedin={"text": "If your organisation issues S/MIME certificates, Loupe can use them on Android: it signs and decrypts with certificates installed in the device's KeyChain, so the private key never leaves the keystore. PKCS #12 import, passphrases and opt-in revocation checks are supported too.\n\nOpen source, no servers, no telemetry: {link}"})

# ---------------------------------------------------------------- Week 6: rules
post("2026-11-24-rules", "2026-11-24T15:00:00Z", IMG + ["linkedin"], campaign="rules", media=m("rules/rules"), kind="image", link="https://loupe.mx/docs/rules/",
     text="Write a rule like a search, and run it on your phone or on your server as Sieve, so it works while your phone sleeps. {link}",
     bluesky={"text": "Write a rule like a search ⚙️\n\nThen run it on the phone, or on your server as Sieve, so it keeps working while your phone sleeps (and if you ever stop using Loupe).\n\n{link}"},
     mastodon={"text": "Rules in Loupe are written like searches. Run them on the phone, or tick \"Run On Server\": Loupe compiles them to Sieve and uploads them over ManageSieve or JMAP. They keep running with your phone off, and if you ever stop using Loupe.\n\n{link}\n\n#Sieve #Email #SelfHosted #FOSS"},
     instagram={"caption": "Write a rule like a search. ⚙️\n\nRun it on your phone, or on your server so it works while you sleep.\n\nLink in bio.\n\n#productivity #automation #email #android #opensource"},
     linkedin={"text": "Mail rules in Loupe are written like searches, and can run on the server as standard Sieve scripts, so they work when the phone is off and survive a change of app. Small thing, big difference for people who manage a lot of mail.\n\n{link}"})

post("2026-11-26-invitations", "2026-11-26T15:00:00Z", IMG, campaign="rules", media=m("rules/invitation"), kind="image", link="https://loupe.mx/docs/calendar-invitations/",
     text="Meeting invitations, answered in the mail: Accept, Maybe or Decline right above the message, with both time zones when they differ. {link}",
     bluesky={"text": "Accept, Maybe, Decline. Right there. 📅\n\nLoupe shows meeting invitations above the message, with your time zone and the organiser's when they differ, and sends a proper reply.\n\n{link}"},
     mastodon={"text": "Calendar invitations in Loupe: an invitation card above the message with Accept / Maybe / Decline, both time zones when they differ, updates and cancellations, and add to calendar. Works with Outlook and Google invitations.\n\n{link}\n\n#Email #Calendar #FOSS"},
     instagram={"caption": "Accept, Maybe, Decline. Right there. 📅\n\nMeeting invitations answered from your inbox, with both time zones.\n\nLink in bio.\n\n#productivity #calendar #email #android #worklife"})

# ---------------------------------------------------------------- Week 7: power users
post("2026-12-01-tablet", "2026-12-01T15:00:00Z", IMG, campaign="power", media=m("power/tablet"), kind="image", link="https://loupe.mx/docs/tablets-and-keyboards/",
     text="Three panes, keyboard shortcuts, drag and drop, and a command palette on Ctrl+K. Loupe on Android tablets. {link}",
     bluesky={"text": "Loupe on a tablet: three panes, keyboard shortcuts, drag and drop, and a command palette on Ctrl+K ⌨️\n\n{link}"},
     mastodon={"text": "Loupe on Android tablets: a three-pane layout, keyboard shortcuts for everything, drag and drop, and a command palette on Ctrl/⌘+K.\n\nShortcut list: {link}\n\n#Android #Tablet #Email #FOSS"},
     instagram={"caption": "Three panes and a command palette. ⌨️\n\nLoupe on Android tablets: shortcuts, drag and drop, Ctrl+K for everything.\n\nLink in bio.\n\n#android #tablet #productivity #email #setup"})

post("2026-12-03-patches", "2026-12-03T15:00:00Z", ["bluesky", "mastodon"], campaign="power", media=m("power/patches"), link="https://loupe.mx/docs/mailing-lists/",
     text="Review patches on the train: Loupe draws patches as coloured diffs, shows mailing lists as forum threads, and mutes noisy threads. {link}",
     bluesky={"text": "Review patches on the train 🚆\n\nLoupe draws mailed patches as coloured diffs, shows mailing lists as forum threads, and lets you mute the noisy ones. Plain-text replies for technical lists.\n\n{link}"},
     mastodon={"text": "For people who live on mailing lists: Loupe draws patches as coloured diffs, shows lists as forum-style threads, mutes threads like Thunderbird's Ignore Thread, and can keep technical lists in plain text and monospace.\n\n{link}\n\n#Linux #OpenSource #Git #Email #FOSS"})

post("2026-12-05-dark", "2026-12-05T16:00:00Z", IMG, campaign="power", media=m("power/dark"), kind="image", link="https://loupe.mx/screenshots/",
     text="True black, and readable: Loupe fixes message colours for dark backgrounds, so dark text never disappears. {link}",
     bluesky={"text": "True black, and readable 🌙\n\nLoupe's dark mode fixes the colours inside messages too, so dark text on dark backgrounds never disappears.\n\n{link}"},
     instagram={"caption": "True black, and readable. 🌙\n\nLoupe fixes message colours for dark mode, so nothing disappears.\n\nLink in bio.\n\n#darkmode #android #design #email #amoled"})

# ---------------------------------------------------------------- Video posts (need recordings)
VIDEO_NOTE = "Move this file to marketing/posts/ once the video exists at the media path. Shot list: see the SMM deck, 'Video briefs'."
for vid, date, title, caption, link in [
    ("2026-10-20-video-look-closer", "2026-10-20T17:00:00Z", "Your mail, in focus: meet Loupe", "Meet Loupe 🔍 A calm mail app for Android with serious tools underneath. Free, open source, no tracking. #android #email #opensource #privacy #androidapps", "https://loupe.mx/"),
    ("2026-10-29-video-trackers", "2026-10-29T17:00:00Z", "Your newsletters are watching you open them", "That newsletter knows when you opened it. Unless you use Loupe 👀 Remote images blocked, tracking links unwrapped. #privacy #email #android #cybersecurity", "https://loupe.mx/docs/privacy-security/"),
    ("2026-11-05-video-search", "2026-11-05T17:00:00Z", "Find any email in 5 seconds", "Find any email in 5 seconds with Loupe's search language 🔍 #productivity #email #android #techtips", "https://loupe.mx/docs/search-language/"),
    ("2026-11-12-video-unsubscribe", "2026-11-12T17:00:00Z", "Unsubscribe from 10 newsletters in 30 seconds", "Unsubscribe from 10 newsletters in 30 seconds 🧹 Counted on your phone, no third-party service. #inboxzero #email #declutter #android", "https://loupe.mx/docs/subscriptions/"),
]:
    p = {
        "id": vid, "date": date, "status": "draft", "campaign": vid.split("-video-")[1],
        "platforms": ["tiktok", "youtube", "instagram", "bluesky", "mastodon"], "link": link,
        "media": [{"path": f"media/video/{vid}.mp4", "alt": f"Screen recording: {title}"}],
        "tiktok": {"caption": caption, "title": title[:90]},
        "youtube": {"title": title, "description": lit(f"{caption}\n\nDownload free: {{link}}\nSource: https://github.com/BuenGenio/loupe"), "tags": ["email", "android", "opensource", "privacy"], "short": True},
        "instagram": {"caption": lit(caption.replace(" #", "\n\nLink in bio.\n\n#", 1)), "kind": "reel"},
    }
    posts.append((p, f"{title}. {{link}}", True))

# ---------------------------------------------------------------- write
POSTS.mkdir(parents=True, exist_ok=True)
DRAFTS.mkdir(parents=True, exist_ok=True)
for p, text, draft in posts:
    target = (DRAFTS if draft else POSTS) / f"{p['id']}.md"
    front = yaml.safe_dump(p, sort_keys=False, allow_unicode=True, width=10000)
    header = f"# {VIDEO_NOTE}\n" if draft else ""
    target.write_text(f"---\n{header}{front}---\n{text}\n")
print(f"{sum(1 for _, _, d in posts if not d)} posts, {sum(1 for _, _, d in posts if d)} video drafts")
