---
title: "Accounts"
description: "Add IMAP and JMAP mail accounts to Loupe: automatic settings, app passwords, Gmail, Outlook, iCloud, Fastmail, Stalwart, and import from Thunderbird."
section: "Get started"
order: 20
---

Loupe works with any mail account you can reach over IMAP and SMTP, and with JMAP servers such as Fastmail and Stalwart. You can add as many accounts as you like and read them together in All Inboxes.

Loupe keeps your mail on the server and a copy on your phone. It doesn't support POP3, or Exchange ActiveSync and Exchange Web Services. Microsoft 365 and Outlook.com work over IMAP.

## Add an account

1. Open Settings and tap **Add Account** (or tap **Add Account** on the Welcome screen).
2. Enter your **Name** (as people see it on your mail) and your **Email** address, then tap **Continue**.
3. Loupe looks up the server settings. The next screen is named after your provider and shows a **Server Settings** row, such as "Found via ISPDB".
4. Enter the password your provider asks for and tap **Sign In**. The field says **Password**, **App Password** or **API Token**, depending on the provider (see below).
5. When "Your mail is syncing." appears, choose a **Description** (such as Work or Personal) and a **Colour**, and tap **Done**.

The account isn't added until the server accepts the sign-in, so a wrong password costs nothing: correct it and try again.

### How Loupe finds your settings

Loupe tries, in this order:

1. its built-in settings for Gmail, Microsoft, iCloud, Yahoo, AOL and Fastmail;
2. a JMAP server at your domain;
3. Thunderbird's public settings database (autoconfig.thunderbird.net), which learns your mail domain, not your address;
4. your mail domain's own configuration address, over HTTPS;
5. common server names such as `imap.` and `mail.` on your domain, confirmed by a quick connection.

When it finds an IMAP server, Loupe also checks whether that server offers JMAP, and uses JMAP if it does.

Loupe doesn't look up your domain's mail servers in DNS, so that no one learns which provider you use from those lookups. As a result, a custom domain hosted by Google or Microsoft may not be recognised; enter its settings by hand (below).

If nothing is found, Loupe says "Couldn't find settings for *domain*. Enter them below." and opens the server form.

## Providers

| Provider | How you sign in |
|---|---|
| Gmail | **Sign in with Google**, when your build of Loupe has it; otherwise an app password |
| Outlook.com, Hotmail, Microsoft 365 | **Sign in with Microsoft**, when your build of Loupe has it |
| iCloud | An app-specific password, not your Apple Account password |
| Yahoo and AOL | An app password, not your account password |
| Fastmail | An API token (Loupe uses JMAP); or an app password over IMAP |
| Stalwart and other JMAP servers | Your password, or an API key |
| Any other IMAP server | Your password |

When a provider needs an app password or a token, the sign-in screen explains it and has a **How to Create One** link (for Gmail, **How to Create an App Password**).

### Google and Microsoft sign-in

With **Sign in with Google** or **Sign in with Microsoft**, you sign in on Google's or Microsoft's own page in your browser. Loupe never sees your password; it receives a permission to read and send your mail, which you can withdraw in your Google or Microsoft account at any time.

> **Note:** These buttons only appear in builds of Loupe that have been registered with Google and Microsoft. In a build without them, Loupe says so on the sign-in screen.
>
> - **Gmail** then works with an app password, which needs 2-Step Verification on your Google account. Tap **Use an App Password** and follow **How to Create an App Password**.
> - **Outlook, Hotmail and Microsoft 365** accounts can't be added in such a build: they no longer accept passwords from mail apps.

Microsoft sign-in works for personal Outlook.com and Hotmail accounts and for work or school accounts on Microsoft 365. Some organisations must approve Loupe first; Loupe tells you when an administrator needs to grant consent.

If Google or Microsoft later stops accepting Loupe's sign-in (for example because you withdrew the permission), a banner on Mailboxes says the account isn't syncing. Tap **Sign In Again**.

## JMAP accounts

JMAP is a modern mail protocol that replaces IMAP and SMTP with one connection. It is efficient on phones. Loupe supports it next to IMAP: everything in Loupe works the same on both.

- **Fastmail:** Loupe connects over JMAP automatically. Create an API token in Fastmail (Settings › Privacy & Security › Manage API tokens, for JMAP, with access to email and sending) and paste it into **API Token**.
- **Stalwart** and other servers that publish JMAP are found automatically. Sign in with your password, or with an API key.
- **Any JMAP server by hand:** tap **Server Settings**, then **Edit Settings**, and set **Protocol** to **JMAP**. The server can be a host name or a URL such as `https://mail.example.com`. There are no SMTP settings: JMAP sends mail itself.

The account's settings page shows the connection as "JMAP · *host:port*".

> **Note:** Not yet supported for JMAP: Fastmail's browser sign-in (use an API token), importing the identities set up on the server (add them in Loupe; see [Identities](/docs/identities/)), and new-mail push while Loupe is in the background (background sync works as for IMAP).

## Enter settings by hand

On the sign-in screen, tap **Server Settings**, then **Edit Settings**.

| Field | What to enter |
|---|---|
| **Protocol** | IMAP or JMAP (incoming only) |
| **Server** | The server name, such as `mail.example.com` |
| **Port** | Filled in for the security you choose; change it only if your provider says so |
| **Security** | TLS, STARTTLS or None |
| **Username** | Usually your email address |

The usual ports are 993 (IMAP with TLS), 143 (IMAP with STARTTLS), 465 (SMTP with TLS) and 587 (SMTP with STARTTLS).

Choosing **None** asks you to confirm, because your password and every message would travel as plain text. Use it only for a server on your own network.

### Self-signed certificates

If the server's certificate isn't trusted (common on home servers), Loupe shows its SHA-256 fingerprint and a **Trust This Certificate** button. Compare the fingerprint with your server's before you tap it. Loupe then trusts exactly that certificate for that server.

## Import from Thunderbird

Thunderbird on your computer can hand its accounts to your phone with QR codes.

1. In Thunderbird, choose **Tools › Export for Mobile**, select your accounts, and tick the option to include the passwords if you want them copied too.
2. In Loupe, tap **Import from Thunderbird** on the Welcome screen (or on the first step of Add Account). Allow the camera.
3. Scan each code Thunderbird shows, in any order. Loupe counts them: "Scanned 1 of 2".
4. Check the accounts Loupe found (tap one to leave it out), enter any missing passwords, and tap the button that adds them, such as **Add 2 Accounts**. Then tap **Done**.

Each account comes with its identities. An account already in Loupe is marked and left out. If your camera can't scan, tap **Paste Text Instead** and paste the code's text, one code per line.

Some Thunderbird accounts can't be imported:

- **POP3 accounts**, because Loupe keeps mail on the server with IMAP;
- accounts that sign in with **Kerberos**, **NTLM** or a **client certificate**;
- **Microsoft accounts**, in a build without Microsoft sign-in;
- **Google accounts** that sign in through the browser in Thunderbird use Sign in with Google, or an app password in a build without it. Other accounts that sign in through the browser need an app password, if the provider offers one.

Thunderbird never exports sign-in tokens, so accounts that use Google or Microsoft sign-in sign in again in Loupe.

## Account settings

Open Settings and tap an account.

| Setting | What it does |
|---|---|
| **Description** | The account's name in Loupe |
| **Email** | The account's address (can't be changed) |
| **Colour** | Marks this account's messages in All Inboxes and other unified mailboxes |
| **Identities** | The addresses you send from, with their signatures. See [Identities and signatures](/docs/identities/). |
| **Manage Folders**, **Show All Folders** | Which folders show and sync. See [Folders](/docs/organising/#folders). |
| **Server** | The incoming and outgoing servers and how you sign in, for reference |
| **Sign In Again** | For Google and Microsoft accounts, renews the sign-in |
| **Remove Account** | Removes the account from this phone |

Server settings and passwords can't be changed after an account is added. To change them, remove the account and add it again.

### Remove an account

Tap **Remove Account** and confirm. The account's mail, settings and sign-in are removed from this phone. Nothing is deleted on the server.
