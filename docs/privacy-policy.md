# Loupe privacy policy

*Draft. Publish it at a stable public URL on the same domain as Loupe's home page before submitting the Google verification (see [oauth-setup.md](oauth-setup.md#7-restricted-scope-verification)). Replace the bracketed parts.*

Last updated: [date]

Loupe is an open-source mail app for Android and iOS, developed by [owner name] ("we"). Its source code is public at <https://github.com/BuenGenio/loupe>.

## The short version

- Loupe has no servers. Your mail goes directly between your phone and your mail provider.
- Loupe collects nothing: no analytics, no telemetry, no advertising, no tracking, no crash reports.
- Your mail, your settings and your sign-in stay on your phone and with your mail provider. We never receive them, and so we can't read, sell or share them.

## What Loupe stores, and where

Loupe keeps the following on your phone only:

- **Your mail:** messages, folders, attachments you opened, and the address book Loupe builds from your mail (for address suggestions).
  - All of it is kept in an encrypted database in the app's private storage.
- **Your sign-in:**
  - The password or app password you entered, or the access and refresh tokens Google or Microsoft issued to Loupe when you signed in with them.
  - They are kept in the phone's secure storage: the Android Keystore or the iOS Keychain.
  - They never leave the phone except to sign in to your own mail provider.
- **Your settings:** accounts, signatures, rules, smart mailboxes and display preferences.
  - Some settings (for example smart mailboxes) can be saved on your own mail server, in your own mailbox, so your other devices can use them.

Removing an account in Loupe deletes its mail, settings and sign-in from your phone. Uninstalling Loupe deletes everything it stored.

## Who Loupe talks to

Loupe connects only to:

- **Your mail provider's servers:** IMAP, SMTP and, when you use server-side rules, ManageSieve. These are the servers you configured or Loupe found for your address.
- **Google or Microsoft, when you choose "Sign in with Google" or "Sign in with Microsoft":**
  - You sign in on their own page, in your phone's browser. Loupe never sees your Google or Microsoft password.
  - Loupe receives tokens that let it read, send and organise your mail through IMAP and SMTP. It later renews them directly with Google's or Microsoft's sign-in service.
- **Account discovery, when you add an account:**
  - To find server settings, Loupe asks Thunderbird's public settings database (autoconfig.thunderbird.net), and your mail domain's own configuration address.
  - It sends the domain of your address, and to your domain's own server the address itself.
- **Websites you choose to open,** like links in a message, or a mailing list's unsubscribe address when you tap Unsubscribe.
- **Senders' servers, for images in a message,** only when you choose to load remote content. Loupe blocks it by default.

## Google user data

Loupe uses the Gmail scope `https://mail.google.com/` only so that you can read, write, send, organise and delete your Gmail in Loupe, over IMAP and SMTP, on your own device.

- Loupe doesn't transfer Google user data to us or to anyone else.
- Loupe doesn't use it for advertising and doesn't sell it.
- No human reads it.

Loupe's use and transfer to any other app of information received from Google APIs will adhere to the [Google API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy), including the Limited Use requirements.

You can remove Loupe's access at any time:

- Google: <https://myaccount.google.com/permissions>
- Microsoft personal accounts: <https://account.live.com/consent/Manage>
- Microsoft work or school accounts: <https://myapps.microsoft.com>

## Microsoft user data

The same applies to Microsoft accounts. Loupe uses the permissions `IMAP.AccessAsUser.All`, `SMTP.Send` and `offline_access`, plus `openid` and `email` for the sign-in, only so you can read and send your mail in Loupe, on your own device.

## Children

Loupe is not directed at children under 13 and does not knowingly collect anything from anyone, at any age.

## Changes

If this policy changes, the new version is published at this address with a new date. The history of this file is public in the repository.

## Contact

[owner name], [contact email]. For bugs and questions: <https://github.com/BuenGenio/loupe/issues>.
