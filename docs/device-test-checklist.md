# Device test checklist

A morning on the phone with the build that has everything merged up to the hardening follow-ups (#25) and the
OpenPGP follow-ups (#24, section 11a): OpenPGP, S/MIME, the unsubscribe centre, tablet panes, rules, snooze, Smart Mailbox sync, notifications, OAuth readiness, the
hardening pass and its follow-ups. The steps are ordered so that the slow ones (scheduled send, snooze, background
sync) wait while you do the rest. The steps that lose data come last.

Each step gives what to **do**, what to **expect**, and **if not** where to look.

## Before you start (5 minutes)

- **You need:**
  - the new APK: the Nightly `loupe-<version>-arm64.apk`, or `flutter build apk --release` in `app/`;
  - the mailcow account;
  - a second address to send from and to (any webmail);
  - Thunderbird on the computer with the mailcow account and an OpenPGP key;
  - a second Android device or an emulator (Smart Mailbox sync, first launch);
  - adb, and a keyboard and tablet if you have them.
- **Where to look when something fails:**
  - **Sync line:** the line at the bottom of Mailboxes and every list ("Updated Just Now", "Offline", "<account>: <error>").
  - **Outbox:** Mailboxes › Outbox. Failed sends show their server's answer under "Not Sent", and the Outbox icon turns red.
  - **logcat:** `adb logcat -v time | grep -iE 'flutter|loupe|WM-'`. Background failures log "Background sync failed:", "Instant Delivery did not start:" and "Notification action failed:". `WM-` lines are WorkManager.
  - **errors.log:** uncaught errors, readable only on a debug build: `adb shell run-as io.github.buengenio.loupe cat files/logs/errors.log`.
  - **Version:** Settings › Advanced › About › Version.
  - **mailcow:** the admin UI › Logs (Postfix, Dovecot, SOGo, Sieve), and SOGo webmail for the server's view of folders and flags.

## 1. Upgrade over the build on the phone (5 min)

The database moves to schema version 5, then 6 (with the OpenPGP follow-ups), then 7 (newsletters and discussions):

- outbox entries can be held;
- the Subscriptions screen keeps its groups;
- the list-header refetch saves its progress;
- encrypted messages keep their decrypted subject, and (opted in) their text for search;
- signed and encrypted mail is composed when it is queued;
- Subscriptions groups everything once more on its first open (newsletters by sender, discussions by List-Id), and
  keeps "Unsubscribed on" for newsletters unsubscribed from before.

1. **Do:**
   - Leave Instant Delivery as it is.
   - Install the new APK over the old one with `adb install -r loupe-…-arm64.apk`, then open Loupe.
2. **Expect:**
   - Mailboxes as before, with no "Your accounts couldn’t be opened" screen.
   - Mail, the Outbox, rules and Smart Mailboxes are all still there.
   - A background sync or Instant Delivery starting at the same moment doesn't matter: two processes now upgrade the file once.
3. **If not:**
   - On the recovery screen, don't tap Reset. Tap Try Again, then copy the logcat around "MailStoreException".

## 2. Start the slow ones, then close Loupe (10 min, then wait)

1. **Scheduled send:**
   - **Do:**
     - Compose to your second address with the subject "sched".
     - Tap **Send Later** (the clock; or long-press Send), then **Pick Date & Time…**, and pick 20 minutes from now. Send.
   - **Expect:**
     - The snack "Scheduled for …".
     - Mailboxes › **Outbox** lists it under "Scheduled" with its time.
2. **Snooze:**
   - **Do:** open a message in the Inbox, then the message's More (⋯) › **Snooze…** › **Pick Date & Time…**, and pick 15 minutes from now.
   - **Expect:**
     - The snack "Snoozed 1 message until …", with Undo.
     - The message is in Mailboxes › **Snoozed**.
     - In SOGo it sits in the `Snoozed` folder with a `$snoozed-…` keyword.
     - "…on this device only" would mean the server can't store keywords; mailcow can.
3. **Close the app:**
   - **Do:** swipe Loupe away from Recents. Don't use Force stop: it cancels Loupe's scheduled work until you open it again.
   - **Expect, at the times you picked (Android may delay this by up to about 15 minutes):**
     - "sched" arrives at the second address.
     - The snoozed message is back in the Inbox, unread, with a small "Snoozed" marker. It keeps its date, so it sorts where it was, not at the top.
     - Both happen while Loupe is closed.
   - **If not:**
     - The Outbox still shows it (Scheduled or Not Sent with an error), or Snoozed still holds the message.
     - Android Settings › Apps › Loupe › Battery: set it to Unrestricted, then try again.
     - In logcat, look for `WM-` lines and "Background sync failed:".

Go on with the next steps while you wait.

## 3. Sending failures: what the server refuses waits for Retry (10 min, new in #25)

There is no notification for a failed send: failures show in the Outbox, whose row in Mailboxes turns red.

1. **Refused for good:**
   - **Do:** send to `nobody-test@<your mailcow domain>` (no such mailbox).
   - **Expect:**
     - After the undo delay, the Outbox shows it under "Not Sent" with the server's answer in red, something like "Recipient nobody-test@… rejected by …: 5.1.1 … User unknown…".
     - The message names neither your password nor anything like a token.
     - It is **not** retried by itself. In an hour it's still there, and mailcow's Postfix log shows a single attempt.
     - Tap **Retry**: one more attempt, the same answer.
     - Swipe left › **Cancel** › **Discard Message**.
2. **Some recipients refused:**
   - **Do:** send one message to your second address and to `nobody-test@<domain>`.
   - **Expect:**
     - The second address gets it.
     - Sent holds one copy that shows both recipients.
     - The Outbox keeps a "Not Sent" message to `nobody-test@…` alone, with the reason.
     - Tap it: compose opens. Fix the address and send.
3. **Refused for now:**
   - **Do:** turn on airplane mode, send to the second address, wait 10 seconds, then turn airplane mode off.
   - **Expect:**
     - "Not Sent" with a connection error while offline.
     - Once back online it goes out by itself within about a minute: the retries wait 30 s, 1 min, 2 min, and so on, at most 30 min.
4. **If not:** the Outbox row's text is the server's answer. mailcow › Logs › Postfix shows what the server saw.

## 4. First launch (10 min, on the second device or an emulator)

1. **Do:** install the APK on a device that never had Loupe.
2. **Expect:**
   - The Welcome screen: "Loupe", three feature rows, and the buttons **Add Account**, **Import from Thunderbird** and **Try with demo mail**.
   - No notification prompt yet.
3. **Do:**
   - Tap Try with demo mail and look around: Mailboxes, a conversation, Search.
   - Then Settings › Advanced › Demo Mode off.
4. **Expect:** demo mail without any network traffic, then back to Welcome.
5. **If not:** logcat. A grey "Something went wrong showing this" box is a widget error; it is also in errors.log on a debug build.

Keep this device for step 10 (Smart Mailbox sync).

## 5. A real account (10 min, on the second device)

1. **Do:**
   - Add Account, then Name and Email (mailcow), then **Continue**.
   - The Server Settings row should say "Found via …".
   - Enter the password, tap **Sign In**, and when "Your mail is syncing." shows, tap **Done**.
2. **Expect:**
   - The Inbox fills newest first, the folders appear, and the sync line says "Updated Just Now".
   - On Android 13 and later, the notification permission is asked once.
3. **Do:** first try a wrong password once.
4. **Expect:**
   - "Password rejected. Check it and try again."
   - The account isn't added until the password works.
5. **If not:**
   - The red card says which: the password, "Can't reach server", or the certificate. A certificate error offers "Trust This Certificate" with its SHA-256 fingerprint.
   - Server Settings › Edit Settings shows what discovery found.

## 6. Notifications and background, Instant Delivery off (15–30 min, mostly waiting)

1. **Do:**
   - Settings › Notifications: the account's switch on, **Instant Delivery** off.
   - Tap **Send Test Notification**.
   - Swipe Loupe away, then send yourself a message from the second address.
2. **Expect:**
   - The test notification appears.
   - The new mail notifies within about 15 minutes (WorkManager, needs a network; Doze can make it later).
   - The notification has **Archive**, **Mark as Read** and **Reply**.
3. **Do:** on another new message, tap Archive. On a third, tap Mark as Read. Don't open Loupe.
4. **Expect:** in SOGo, the first is in Archive and the second is read, both done while Loupe stayed closed.
5. **If not:**
   - If the test notification never shows: Android Settings › Apps › Loupe › Notifications.
   - If nothing comes after 30 minutes: Battery › Unrestricted, and logcat for `WM-` and "Background sync failed:".
   - If an action doesn't apply: logcat for "Notification action failed:".

## 7. Instant Delivery on (10 min)

1. **Do:**
   - Settings › Notifications › **Instant Delivery** on.
   - If the footer offers **Allow Unrestricted Battery Use**, allow it.
   - Swipe Loupe away and send yourself mail.
2. **Expect:**
   - A quiet ongoing notification, "Watching for new mail", "Instant Delivery is on".
   - New mail notifies within seconds.
3. **Do:** restart the phone and unlock it, then send another mail.
4. **Expect:** "Watching for new mail" is back without opening Loupe, and the mail notifies at once.
5. **Do:** turn Instant Delivery off.
6. **Expect:** the ongoing notification goes away. Mail notifies on the 15-minute schedule again.
7. **If not:** logcat for "Instant Delivery did not start:". Check that the account's notification switch is on: Instant Delivery only runs for accounts that notify.

## 8. Rules, on the device and on mailcow with Sieve (15 min)

1. **Device rule:**
   - **Do:**
     - Settings › **Rules** › New Rule. Under "When a New Message Matches", enter `from:<second address>`.
     - Under "Then", choose Add Action › **Move to Folder…** and pick a folder.
     - Set "Run On" to **This Device**, then Save.
     - Send from the second address.
   - **Expect:**
     - After the next check for mail, the message is in that folder, here and in SOGo.
     - Mail that was already there isn't touched.
     - The rule acts once per message, even when background sync and the app check at the same time (#25).
2. **Server rule (Sieve):**
   - **Do:** a second rule, `s:sieve-test` with the action **Flag**, set to Run On › **Server**.
   - **Expect:**
     - The "Server Rules" group says "On".
     - The script `loupe` is active on the server (SOGo › Preferences › Mail › Filters).
     - Send a "sieve-test" mail with the phone in airplane mode: it is flagged on the server before Loupe sees it.
3. **Your own Sieve script:**
   - **Do:** if the account already has an active script of its own, save a server rule.
   - **Expect:**
     - Loupe never replaces it. The sheet "Turn On Server Rules" shows the `include :personal "loupe";` line it would add.
     - After **Add to "<script>"**, both run.
4. **If not:**
   - "Couldn’t Save the Server Rule" names the reason and offers "Run on This Device Instead". The Server Rules status says "Not Available" or "Couldn’t ask the server".
   - Loupe uses ManageSieve on port 4190. See mailcow › Logs › Dovecot.

## 9. Subscriptions: newsletters and discussion lists (15 min)

1. **Do:** Mailboxes › **Subscriptions** (in the top group, after Unread, Snoozed and Outbox).
2. **Expect:**
   - No "Mailing Lists" section and no Tools on Mailboxes. The Subscriptions row counts unread mail in discussion lists,
     or shows nothing.
   - **Newsletters** first: most unread mail a month first. Rows read like "≈ 24 / month · read 3%".
   - No row is named like `MTEyNzQxMzMtODAtNQ==`, `111929.broadcast`, `spc.265094.4.sparkpostmail.com` or
     `<hex>mc list`: newsletters are named after their senders. A sender whose campaigns each had a List-Id of their own
     (the two `NTE4…` ones) is one row.
   - The chips "Never Read", "Rarely Read" and "All"; the Filter field narrows by name.
   - The first open after the upgrade groups everything once (well under a second). After that it opens at once, also on a large mailbox (#25).
   - **Discussions:** the lists people write to, with their address, last activity and unread count. A tap opens the
     forum view. A long press offers Pin to Mailboxes (a Lists section appears on Mailboxes), Unsubscribe, Open as
     Plain Text (Mono) and Treat as Newsletter; a newsletter that came with a List-Id offers Treat as Discussion.
   - Subscriptions opens again on the tab used last.
3. **Do:** read one newsletter in the Inbox, then go back to Subscriptions.
4. **Expect:** its read count and rate change.
5. **Do:** unsubscribe from a real newsletter. Try one with a one-click link and one with only a `mailto:` link if you have them.
6. **Expect:**
   - **One-click:**
     - "Unsubscribe from X?" with "Loupe will contact <host>…" (the first time, an explanation of the single request).
     - Then "Unsubscribing from X…", then "Unsubscribed from X.".
   - **`mailto:`:**
     - "Loupe will send an email to … from …".
     - Then "Unsubscribe email sent to …". It goes out through the Outbox, from the address the newsletter came to.
   - **Web page:** "Open <host>?", then the in-app browser.
   - The row says "Unsubscribed on <date>". "Still sending" only appears for mail more than seven days later.
7. **Do:** long-press another row and try:
   - **Archive N in Inbox** (with Undo);
   - **Create Rule…**: the editor opens filled in;
   - **Block Sender**: a rule moves its mail to Junk.
8. **If not:**
   - A failed one-click shows "Couldn’t Unsubscribe Automatically" with the other ways.
   - A `mailto:` that fails sits in the Outbox like any send (step 3).

## 10. Smart Mailbox sync between two devices (15 min)

1. **Do (phone):**
   - Search `is:unread from:<second address>`, then **Save as Smart Mailbox**, and name it.
   - In Settings › Mail › **Smart Mailboxes**, set "Sync via" to the mailcow account. Use the same choice on every device.
2. **Do (second device, with the same account from step 5):** set the same "Sync via", then pull to refresh in Mailboxes.
3. **Expect:**
   - The Smart Mailbox appears with the same name and query. The line under its title says "Synced to <account>".
   - Rename it there (⋯ › Rename). After the phone's next check for mail, the phone shows the new name. Deleting works the same way.
   - "On the Server" says "Server metadata", or "Loupe Settings folder" when METADATA is off on mailcow. See [smart-mailboxes-format.md](smart-mailboxes-format.md) › Checking a server.
4. **Reinstall instead of a second device:**
   - Uninstall, reinstall and add the account.
   - **Expect:** the Smart Mailboxes come back after the first sync. The first account that isn't Gmail is the default "Sync via".
5. **If not:**
   - "On the Server" shows "Couldn’t sync", "Not supported" or "Newer format". Try **Sync Now**.
   - A refused password stops it until the next sync logs in (fail2ban protection).

## 11. OpenPGP with Thunderbird (15 min)

1. **Do:**
   - In Thunderbird: Account Settings › End-To-End Encryption › Export Secret Key, which gives an `.asc` file with a passphrase.
   - In Loupe: Settings › **End-to-End Encryption** › My OpenPGP Keys › **Add Key…** › **Import from File**, then the passphrase. Or **Generate New Key**.
   - Send Thunderbird a signed message, so it learns your key (Autocrypt, or "Attach My Public Key").
2. **Do:** from Thunderbird, send Loupe a signed and encrypted message.
3. **Expect:**
   - "Unlock OpenPGP Key" asks for the passphrase.
   - The line under the header says "Encrypted" and "Signed by <name> ✓".
   - Attachments open.
4. **Do:** reply from Loupe. The "Encrypt" and "Sign" toggles under Subject are on, and the hint says "Everyone has a key".
5. **Expect:** Thunderbird shows the message as encrypted, with a valid OpenPGP signature.
6. **Do:** with a passphrase-protected key and Remember Passphrases off, schedule an encrypted message for a few minutes ahead (Send Later), then close Loupe (swipe it away).
7. **Expect:**
   - It goes out at its time from the background: Loupe signed and encrypted it when you scheduled it. Thunderbird shows a valid signature, and its Date is the scheduled time.
   - Outbox › Reschedule (or Send Now) of a scheduled signed message asks for the passphrase again when the key is locked, since it is signed again for the new time; Cancel leaves it as it was.
   - A message that couldn't be signed when queued shows "Not Sent" with "Your OpenPGP key is locked. Tap Retry…". Retry asks for the passphrase and sends it. It never goes out in the clear.
   - A key kept without a passphrase ("Keychain only") sends from the background either way.
8. **If not:** tap the status line. Its sheet says what is wrong: no key, "Signature invalid", "Unknown key". Compare with Thunderbird's OpenPGP Key Manager.

## 11a. Encrypted mail follow-ups with Thunderbird (20 min, #24)

You need a second address with a key in Thunderbird (a second Thunderbird identity, or Thunderbird on another
account), and Loupe having both keys (Autocrypt from a signed message of each, or Import Public Key).

1. **Bcc.**
   - **Do:** from Loupe, write an encrypted message To your first Thunderbird address and Bcc the second (Encrypt on).
   - **Expect:**
     - Each address gets the message once; Loupe's Sent has one copy, without a Bcc header.
     - The To copy names no second key: in Thunderbird, the message's OpenPGP security panel (or save it as `.eml`
       and run `gpg --list-packets` on its `encrypted.asc` part) lists your key and the To key only, and the
       decrypted message has no Autocrypt-Gossip for the Bcc address.
     - The Bcc copy shows the same To, and lists only the Bcc key and yours. Both copies have the same Message-ID.
     - With S/MIME (certificates for both), the same: save each copy as `.eml`; `openssl cms -cmsout -print -in
       copy.eml` lists two `recipientInfos`, yours and that copy's recipient's.
   - **If not:** the Outbox shows a copy that failed; `adb logcat` around "Couldn’t send".
2. **Protected subjects.**
   - **Do:** with Loupe in the background (Instant Delivery or a background sync), send Loupe an encrypted message
     from Thunderbird.
   - **Expect:** the notification says "Encrypted message", not "...". The list shows "..." until you open it; then
     the list, search (type a word of the subject) and a reply ("Re: <subject>") show the real subject, also after
     a sync and in its copy in another folder.
   - **Do:** Settings › End-to-End Encryption › On This Device › **Decrypt Subjects in the Background** on, with a key
     kept without a passphrase. Send another one.
   - **Expect:** its notification shows the real subject (nothing with Hide Content), and the list shows it before
     you open it. With a passphrase-protected key: still "Encrypted message", and no passphrase is asked.
3. **Search.**
   - **Do:** search a word that is only in the body of an encrypted message you opened.
   - **Expect:** not found. Turn on **Index Decrypted Messages for Search**, open the message again, search: found.
     Turn it off: not found again.
4. **Speed.**
   - **Do:** from Thunderbird, send an encrypted message with a 5 MB photo; open it. Send one from Loupe with a 5 MB
     attachment, encrypted.
   - **Expect:** it opens within a few seconds while the spinner keeps turning (the UI never freezes); compose
     closes right after Send. Unlocking a key exported from Thunderbird takes about a second (or a few on an older phone).
5. **Signed in part.**
   - **Do:** if a mailing list adds a footer to mail, send it an inline-signed message (Thunderbird can't; `gpg
     --clearsign` and paste), or let a list add a footer to a PGP/MIME signed one.
   - **Expect:** inline: the signed text, then a "━━━━ Unsigned content: …" line and the footer below it, and
     "Signed in part by …" without ✓. PGP/MIME: "Signature invalid" with the added part not shown (the list added a
     part), or no signature line at all (the list wrapped the message); never "Signed by … ✓" over the footer.

## 12. S/MIME (10 min; merged into main with these follow-ups)

1. **Do:**
   - Settings › End-to-End Encryption › My S/MIME Certificates › **Import Certificate…**.
   - Pick a `.p12` and enter its "Certificate Password".
   - If it brings a company CA, decide on the trust prompt.
2. **Do:**
   - Send a signed message to Thunderbird (or Outlook).
   - From there, send back a signed and encrypted reply.
3. **Expect:**
   - Thunderbird shows a valid S/MIME signature.
   - Loupe's header says "Encrypted (S/MIME)" and "Signed by … ✓".
   - The sender's certificate is collected (Correspondents’ Certificates), so your next message to them can be encrypted.
   - With both standards set up, Compose shows an OpenPGP / S/MIME switch. "Prefer S/MIME" on your address picks S/MIME first.
   - Hidden subject (#26): an S/MIME encrypted message from Loupe shows "..." as its subject in Thunderbird and
     Outlook, and its text starts with "Subject: <the real one>" and a blank line. In Loupe (the Sent copy, or
     another phone) the subject shows normally, without that line, in the list and search too once opened.
4. **If not:** the header's sheet names the trust problem (unknown issuer, expired, SHA-1). It can trust the issuer after showing its fingerprint.
5. **Certificates from the device (#26).**
   - **Do:** install a `.p12` in Android's Settings › Security › Encryption & credentials › Install a certificate ›
     VPN & app user certificate (or have device management install one). In Loupe: Settings › End-to-End
     Encryption › **Use a Certificate from This Device…**, pick it.
   - **Expect:** Android's own picker; then "Added your certificate … from this device" (and the CA offered for
     trust). Its details say "Private key: On this device". Send a signed and an encrypted message to Thunderbird:
     both verify there. Mail encrypted to it (from Thunderbird) decrypts in Loupe, RSA and EC certificates alike.
   - **If not:** "Encrypted (S/MIME) · locked" and the sheet give the platform's reason. ECDH needs Android 12 or
     later and a key allowed to agree; an EC certificate that can't decrypt says "can’t do this". A message queued
     while the app was closed waits in the Outbox with "open Loupe".
6. **Revocation (#26).**
   - **Do:** Settings › End-to-End Encryption › **Check Certificate Revocation Online** (read the footer), then
     open signed mail from a public CA's certificate (or ask a colleague whose company certificate names an OCSP
     responder).
   - **Expect:** the message opens at once; a moment later the sheet says "Not revoked · Asked the authority
     (OCSP)". Offline: "Revocation unknown" with the reason, never a wait. A revoked certificate (the CA's test
     pages) shows "Signed by … · certificate revoked" in red, no ✓. In demo mode, Hana Sato's "New bank details"
     message shows it without going online.
8. **S/MIME in demo mode (#26).**
   - **Do:** in the demo, open the Work inbox: Aisha Karimi's "Q4 budget, signed off", her encrypted message
     (listed as "..." until opened) and Hana Sato's "New bank details for the Fabrikam invoice".
   - **Expect:** "Signed by Aisha Karimi ✓ (Northwind Traders (demo))"; "Encrypted (S/MIME)" with the subject
     "Salary review dates (confidential)", which then replaces "..." in the list; Hana's "✓" turns into
     "certificate revoked" with Check Certificate Revocation Online on. Settings › End-to-End Encryption lists
     Sam's demo certificate and the Northwind demo CA.
7. **A passphrase on a certificate (#26).**
   - **Do:** open your imported certificate (Settings › End-to-End Encryption › My S/MIME Certificates) ›
     **Set Passphrase…**. Turn Remember Passphrases off, Lock Keys Now, then open an S/MIME encrypted message
     and send a signed one; schedule a signed one for in 10 minutes and close Loupe.
   - **Expect:** "Unlock S/MIME Certificate" when reading and on Send (about a second or a few after the
     passphrase); the scheduled message goes out from the background, signed at queue time. Two minutes
     after the last use it asks again. Remove Passphrase asks for it once more.

## 13. Attachments (10 min)

1. **Do:** compose to the second address. Tap **Attach** (the paperclip) and add a photo and a PDF; they show as chips with their sizes. Send.
2. **Expect:** both arrive intact and open there. The Sent copy lists them.
3. **Do:** open a received message with an image, a PDF and an inline (`cid:`) picture, and a newsletter with remote images.
4. **Expect:**
   - The inline picture shows in place and isn't listed as an attachment.
   - Remote images stay blocked behind "Images from <domain> are blocked…", with **Load images** and **Always for this sender**.
   - The image opens in the gallery and the PDF in the viewer, with **Share**, **Open in…** and **Save** ("Saved …").
   - On mobile data, a file of 25 MB or more asks before downloading.
5. **If not:** the viewer's details card shows the type and size. If no app opens a file, it suggests Share. Check logcat.

## 13a. Saving and exporting mail (10 min)

1. **Do:** in a message's ⋯ menu, **Save as File…**, and pick Downloads; then **Share as File…** to Drive or a chat.
2. **Expect:** Android's save dialog suggests `<subject>.eml` ("Saved …"); the file opens in another mail app and
   in Thunderbird, attachments included. An encrypted message (sections 11 and 12) is saved encrypted.
3. **Do:** long-press a folder of a few hundred messages on Mailboxes, **Export Folder…**, then save to Downloads.
4. **Expect:**
   - "Finding messages…", then "Exporting n of N…" with a bar; the save dialog suggests
     `<account> - <folder>.mbox`, without another extension added.
   - Thunderbird with ImportExportTools NG imports the file with the same number of messages, oldest first.
   - Settings › Apps › Loupe › Storage: the cache doesn't keep the export afterwards.
5. **Do:** start another export and tap **Cancel**; start one more and turn on aeroplane mode halfway.
6. **Expect:** Cancel (and Back) closes the sheet with no save dialog. Offline, the file is saved with what
   was downloaded and "Saved … without N messages that couldn't be downloaded."
7. **If not:** the save dialog for folders is `SaveFileChannel.kt` (logcat), the export
   `app/lib/features/export/`.

## 14. Tablet and keyboard (10 min, on a tablet or a large emulator)

1. **Do:**
   - Open Loupe on a tablet.
   - Rotate it, or resize the window across 840 dp and 1100 dp.
2. **Expect:**
   - Phone layout below 840 dp.
   - List and conversation side by side from 840 dp; Mailboxes, list and conversation from 1100 dp.
   - What was open stays open across the change.
   - The dividers drag, and double-tap resets them.
   - A message can be dragged onto a folder in the Mailboxes pane, with Undo.
3. **Do:** with a hardware keyboard, try:
   - Ctrl+K, the command palette (try "mar" for Mark All as Read);
   - J and K, next and previous;
   - E, Archive;
   - R, Reply;
   - Ctrl+Enter, Send in Compose;
   - Esc;
   - Ctrl+/ or ?, the shortcut list.
4. **Expect:**
   - Every shortcut acts on the screen on top.
   - Plain letters do nothing while a text field has focus.
   - See [tablet-and-keyboard.md](tablet-and-keyboard.md).
5. **If not:** note the width and the screen. Shortcuts are in `app/lib/features/keyboard/`.

## 15. Thunderbird QR import (10 min)

1. **Do:**
   - In Thunderbird: Tools › Export for Mobile. Select the accounts and tick the option to include the passwords.
   - In Loupe, on a device without the account (or after removing it): Welcome, or Add Account › **Import from Thunderbird**. Allow the camera, then scan each code.
2. **Expect:**
   - "Scanned N of M", then "Found N Accounts", then **Add N Accounts**, then **Done**.
   - The accounts sync, with their identities.
   - An account already in Loupe says so and isn't added twice.
   - "Paste Text Instead" accepts the export text.
3. **If not:** the import screen says why an account can't be added (POP3, Kerberos, NTLM, a Microsoft sign-in without a client id). See [thunderbird-qr-format.md](thunderbird-qr-format.md).

## 16. OAuth (only when the build has client ids, 15 min)

1. **Do:** check that the CI log's "Build APKs" step says "Sign in with Google: on" (or Microsoft). Then follow [oauth-setup.md › Test after adding the secrets](oauth-setup.md#test-after-adding-the-secrets):
   - Add Account › Gmail address › **Sign in with Google**;
   - send yourself mail;
   - revoke Loupe in your Google account;
   - pull to refresh.
2. **Expect:**
   - "Account Added" and the Inbox syncs.
   - After the revoke, the banner says Google "no longer accepts Loupe’s sign-in…" with **Sign In Again**, and Loupe stops trying.
   - After signing in again, the account syncs at once.
   - With Loupe closed, background sync still notifies an hour later, after a token refresh.
3. **If not:** see the troubleshooting table in oauth-setup.md: `redirect_uri_mismatch`, custom URI scheme, AADSTS codes.

## 17. Backup exclusion (5 min)

1. **Do:**
   - `adb shell dumpsys package io.github.buengenio.loupe | grep -i backup`
   - `adb shell bmgr backupnow io.github.buengenio.loupe`
2. **Expect:**
   - No `ALLOW_BACKUP` flag.
   - The backup is refused or skipped for Loupe, never "Success".
   - In Android Settings › Google › Backup, Loupe isn't listed with data.
   - A device-to-device transfer, if you try one, arrives at the Welcome screen. The database key stays in the old phone's Keystore, so nothing else could be opened.
3. **If not:** `app/android/app/src/main/AndroidManifest.xml` (`allowBackup="false"`, `dataExtractionRules`) and `res/xml/data_extraction_rules.xml`.

## 18. The Keystore and the recovery screen (last: this deletes the phone's mail data)

1. **After an Android system update** (whenever one comes):
   - **Do:** open Loupe.
   - **Expect:** it opens normally.
   - **If not:** if it says "Loupe couldn’t read the key… This is often temporary", tap **Try Again**, then restart the phone. Report it either way, with logcat.
2. **The recovery screen (debug build only, `flutter run` or `flutter install --debug`):**
   - **Do:**
     - `adb shell run-as io.github.buengenio.loupe ls shared_prefs`
     - Delete flutter_secure_storage's file, for example `adb shell run-as io.github.buengenio.loupe rm shared_prefs/FlutterSecureStorage.xml`. This also removes saved passwords and keys.
     - `adb shell am force-stop io.github.buengenio.loupe`, then open Loupe.
   - **Expect:**
     - "Your accounts couldn’t be opened": "The key that protects your mail on this phone is gone… Your mail is still on the server."
     - **Try Again** keeps showing it. **Use Demo Mail** opens the demo.
     - **Reset Mail on This Phone…** asks first. **Delete and Start Over** leads to Welcome, and adding the account works again.
     - Loupe never makes a new key for the old database by itself.
   - **If not:** logcat around "DatabaseKeyUnavailable".
