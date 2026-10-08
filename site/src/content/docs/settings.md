---
title: "Settings reference"
description: "Every setting in Loupe with its default value: mail, appearance, reading, security, notifications, rules, encryption, accounts, identities and advanced options."
section: "Reference"
order: 180
---

This page lists every setting in Loupe, in the order the Settings screen shows them, with its default. Open Settings with the gear at the bottom left of Mailboxes, or find any settings page in the [command palette](/docs/tablets-and-keyboards/#the-command-palette).

## Accounts

One row per account, and **Add Account**. Tap an account for its own settings (see [Account settings](#account-settings) below).

## Mail

| Setting | Default | What it does |
|---|---|---|
| **Swipe Actions** | | Choose the action for **Swipe Left** (default Archive) and **Swipe Right** (default Mark as Read / Unread): None, Mark as Read / Unread, Flag, Archive, Trash, Move Message, Snooze or More. See [Swipes](/docs/organising/#swipes). |
| **Organize by Conversation** | On | Groups a message and its replies into one row |
| **Undo Send Delay** | 10 seconds | How long sent messages wait so you can take them back: Off, 5, 10, 20 or 30 seconds |
| **Smart Mailboxes** | First non-Gmail account | Where your Smart Mailboxes are kept (**Sync via**), and their state on each server. See [Smart Mailboxes](/docs/smart-mailboxes/). |

## Appearance

| Setting | Default | Choices |
|---|---|---|
| **Theme** | Automatic | Automatic (follows the phone), Light, Dark |
| **Message List** | Comfortable | Comfortable, Compact |

## Reading

| Setting | Default | What it does |
|---|---|---|
| **Default View** | Readable | The view messages open in: Readable, Original or Plain Text. The **Aa** button switches any message. |
| **Plain Text Font** | Sans Serif | Sans Serif or Monospaced, for the Plain view |
| **Technical Lists** | None | Mailing lists whose messages open as plain text in Mono. See [Mailing lists and patches](/docs/mailing-lists/). |
| **Load Remote Images** | Off | Loads images from the internet in every message. Off, you allow them per message or per sender. |
| **Open Links Directly** | On | Skips known click trackers when the destination is in the link |

## Security

| Setting | Default | What it does |
|---|---|---|
| **App Lock** | Off | Asks for your fingerprint, face or screen lock before your mail shows. Turning it on asks once first, and needs a screen lock on the phone. See [App Lock](/docs/privacy-security/#app-lock). |
| **Lock After** | Immediately | Shown while App Lock is on: how long Loupe can be in the background before it asks again. Immediately, 1 Minute, 5 Minutes, 15 Minutes or 1 Hour. |

## Notifications

| Setting | Default | What it does |
|---|---|---|
| **New Mail** | On for every account | Whether each account notifies |
| **VIP Only** | Off | Only messages from your VIPs notify |
| **Hide Content** | Off | Notifications don't show the sender, subject or preview |
| **Instant Delivery** | Off | Experimental: keeps a connection open so new mail arrives within seconds |
| **Send Test Notification** | | Shows a sample notification |
| **App Icon Badge** | Unread in Inboxes | Off, Unread in Inboxes or Unread in VIP |

See [Notifications](/docs/notifications/).

## Rules

Your device and server rules. See [Rules](/docs/rules/).

## End-to-End Encryption

| Setting | Default | What it does |
|---|---|---|
| **My OpenPGP Keys** | | Your keys: Add Key… (import or generate) |
| **Addresses** | | Per address: which key and certificate it uses, and when it encrypts and signs |
| **Correspondents' OpenPGP Keys** | | Other people's keys, and whether you accepted them |
| **Collected from Autocrypt** | | Keys that arrived with messages |
| **My S/MIME Certificates** | | Your certificates: Import Certificate…, Use a Certificate from This Device… |
| **Correspondents' Certificates** | | Certificates collected from signed mail, or imported |
| **Check Certificate Revocation Online** | Off | Asks certificate authorities whether a signer's certificate was revoked |
| **Trusted Authorities** | | Certificate authorities you trust, besides Mozilla's |
| **Decrypt Subjects in the Background** | Off | Decrypts the subjects of new encrypted mail before you open it |
| **Index Decrypted Messages for Search** | Off | Makes the text of encrypted messages you open searchable |
| **Remember Passphrases** | On | Keeps keys unlocked until Loupe closes |
| **Lock Keys Now** | | Locks all keys at once |

Per address (**Addresses** › *address*): **Prefer S/MIME** (off), **Encrypt Automatically** (on), **Always Encrypt** (off), **Sign Unencrypted Mail** (off), **Attach My Public Key** (off), **Send My Key with Mail** (on) and **Prefer Encryption** (off). See [End-to-end encryption](/docs/encryption/).

## Advanced

| Setting | What it does |
|---|---|
| **Demo Mode** | Switches to the made-up demo mailbox, which lives only on this phone. Turning it off goes back to the Welcome screen. |
| **Reset App** | Forgets every setting, Smart Mailbox and recent search, and returns to the Welcome screen |
| **Version** | The version and build number of Loupe |
| **Licences** | The licences of Loupe and the software it uses |
| **Privacy** | A reminder: Loupe has no analytics and no tracking |

## Account settings

Settings › *account*:

| Setting | Default | What it does |
|---|---|---|
| **Description** | Provider or domain name | The account's name in Loupe |
| **Email** | | The address (can't be changed) |
| **Colour** | The next colour in turn | Marks the account's messages in unified mailboxes |
| **Identities** | | Your addresses, signatures and reply patterns. See [Identities and signatures](/docs/identities/). |
| **Manage Folders** | | Which folders show and sync |
| **Show All Folders** | Off | Shows every folder, subscribed or not |
| **Server** | | The incoming and outgoing servers, for reference |
| **Sign In Again** | | For Google and Microsoft accounts |
| **Remove Account** | | Removes the account from this phone, not from the server |

## Elsewhere

Some choices aren't in Settings but where you use them:

- **Show or hide mailboxes:** **Edit** on the Mailboxes screen.
- **The Filter button's criteria:** tap "Filtered by:" in a message list.
- **VIPs:** the ⓘ button on the VIP mailbox, or a sender's name in a message.
- **View, text size and colours for one sender:** **Aa** › Remember for this sender.
- **Images for one sender:** **Always for this sender** on the images banner.
