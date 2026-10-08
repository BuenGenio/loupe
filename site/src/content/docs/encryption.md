---
title: "End-to-end encryption"
description: "Read and send encrypted, signed mail in Loupe with OpenPGP (compatible with Thunderbird, with Autocrypt) and S/MIME, including certificates from Android."
section: "Accounts & security"
order: 160
---

Loupe reads and sends end-to-end encrypted and signed mail with both common standards: **OpenPGP**, as Thunderbird and GnuPG use it, and **S/MIME**, as Outlook, Apple Mail and many companies use it. Everything happens on your phone, and your secret keys stay there.

Encryption settings live in Settings › **End-to-End Encryption**.

## OpenPGP

### Add your key

Go to Settings › End-to-End Encryption › **My OpenPGP Keys** › **Add Key…**:

- **Import from File** or **Import from Clipboard** brings in the key you already use. Loupe asks for its passphrase.
- **Generate New Key** makes a new one (Curve25519). Choose a passphrase if you like and how long the key is valid: 1, 2 or 3 years (the default, as in Thunderbird), or never expires.

> **Tip:** To use your Thunderbird key, export it in Thunderbird (Account Settings › End-To-End Encryption › Export Secret Key). You get an `.asc` file protected by a passphrase. Put it on your phone and import it.

Without a passphrase, the key is protected by your phone's keystore alone and Loupe never asks for it. With one, Loupe asks when the key is needed.

Tap a key to see its fingerprint and validity, **Share Public Key** or **Copy Public Key** so others can encrypt to you, **Back Up Secret Key**, or delete it.

### Your correspondents' keys

You can encrypt to someone once you have their public key. Loupe collects keys in three ways:

- **Autocrypt:** many mail apps, Thunderbird included, send their public key with every message. Loupe collects these under **Collected from Autocrypt** and can encrypt to them when both sides ask for it.
- **Attached keys:** when a message has a key attached, Loupe shows "An OpenPGP key is attached." with an **Import** button.
- **By hand:** **Import Public Key…**, from a file or the clipboard.

A key is only used for automatic encryption once you **accept** it. Accept a key when you trust it belongs to its owner; compare the fingerprint with them, for example by phone, to mark it **Accepted and verified**. You can also reject a key.

### Autocrypt

Autocrypt lets other apps encrypt to you without any setup: Loupe sends your public key along with your messages. For each address (Settings › End-to-End Encryption › **Addresses** › *address*):

| Switch | Default | What it does |
|---|---|---|
| **Send My Key with Mail** | On | Attaches your public key to every message's headers |
| **Prefer Encryption** | Off | Asks others to encrypt to you when they can |

## S/MIME

### Add your certificate

Go to Settings › End-to-End Encryption › **My S/MIME Certificates**:

- **Import Certificate…** imports your certificate with its private key, as a `.p12` or `.pfx` file exported from Outlook, Windows, macOS or Thunderbird. Enter the **Certificate Password** it was exported with. If the file brings your company's certificate authority, Loupe offers to trust it.
- **Use a Certificate from This Device…** (Android) uses a certificate installed on the phone, by your company's device management or by you in Android's settings (Security › Encryption & credentials › Install a certificate › VPN & app user certificate). Android's own picker opens; picking a certificate lets Loupe use it. The private key stays in Android's keystore.

> **Note:** A certificate from the device can only be used while Loupe is open. Loupe signs scheduled mail when you schedule it, but mail encrypted to that certificate can only be read with Loupe open, and background work can't use the key.

You can protect an imported certificate with a passphrase: open it and tap **Set Passphrase…**. The private key is then also encrypted on the phone, and Loupe asks for the passphrase to sign and decrypt.

### Correspondents' certificates and trust

Loupe collects certificates from signed mail, as Outlook and Thunderbird do, so after someone sends you signed mail you can encrypt to them. You can also **Import Certificate…** under **Correspondents' Certificates**, from a `.cer`, `.crt` or `.pem` file or the clipboard.

Mail is encrypted only to trusted certificates. Loupe trusts the certificate authorities that Mozilla trusts for email, as Thunderbird does, and the authorities you add yourself (they are listed under **Trusted Authorities**). Certificates signed with SHA-1 aren't accepted.

### Revocation checking

Settings › End-to-End Encryption › **Check Certificate Revocation Online** is off by default.

When it is on and you open signed mail, Loupe asks the authority that issued the signer's certificate whether it was revoked (with OCSP, or the authority's revocation list). The message opens at once; a moment later the header shows "certificate revoked" if it was. Answers are kept on the phone until they expire.

> **Note:** This is a request outside your mail servers: the authority can see when someone at your internet address reads mail signed with that certificate. That is why it is off by default. Loupe only checks certificates that chain to a trusted authority.

## Reading encrypted and signed mail

Loupe decrypts and checks messages when you open them. A line under the header says what it found, for example:

| Line | Meaning |
|---|---|
| Encrypted | The message was encrypted with OpenPGP and Loupe decrypted it. |
| Encrypted (S/MIME) | The same, with S/MIME. |
| Signed by *name* ✓ | A good signature by a key you accepted, or a trusted certificate. For S/MIME, the authority is named in brackets. |
| Signed in part by *name* | Only part of the message is signed, for example when a mailing list added a footer. The unsigned part is shown below an "Unsigned content" line. |
| Signature invalid | The message was changed after it was signed, or the signature is broken. |
| Unknown key | Loupe doesn't have the signer's public key. |
| Signed by *name* · certificate revoked | The S/MIME certificate was revoked (with revocation checking on). |
| Encrypted · locked | Your key has a passphrase. Tap **Unlock** (OpenPGP), or open the message again (S/MIME). |
| Encrypted · no key | The message wasn't encrypted to any key on this phone. |

Tap the line for details: the fingerprint, what is wrong, and buttons such as **Change Acceptance…** or **Trust This Certificate…**. Loupe shows as signed exactly what the signature covers, nothing more.

### Hidden subjects

Encrypted mail can hide its real subject inside the encryption, showing only `...` outside. Once you open such a message, Loupe remembers its subject in its encrypted database, so the list, search, replies and notifications show it.

**Decrypt Subjects in the Background** (under **On This Device**, off by default) also decrypts the subjects of new encrypted messages you haven't opened yet, with keys that have no passphrase. Loupe downloads each message (up to 1 MB) to do so.

### Search inside encrypted mail

Search finds encrypted messages by their sender, recipients and subject. Turn on **Index Decrypted Messages for Search** (off by default) to also add the text of each encrypted message you open to the search index, in Loupe's encrypted database. Turning it off removes that text again.

## Sending encrypted and signed mail

When the address you send from has a key or a certificate, two switches appear under the subject: **Encrypt** and **Sign**.

- Loupe turns on encryption by itself when every recipient has an accepted key or a trusted certificate, or when Autocrypt says both sides want it, and when you reply to encrypted mail. A hint says "Everyone has a key", or which recipient has none.
- Encrypted mail is always signed.
- If both standards are set up, a chip shows **OpenPGP** or **S/MIME**; tap it to switch.
- If someone has no key when you send, Loupe asks: **Can't Encrypt**, with a **Send Unencrypted** button (unless the address is set to always encrypt).

Drafts of encrypted messages are encrypted to you only.

**Bcc stays private.** An encrypted message names the keys it is encrypted to, so one message for everyone would reveal who was in Bcc. Loupe sends each Bcc recipient a copy of their own instead.

**Subjects:** OpenPGP mail from Loupe hides its subject (`...` outside, the real one inside), as Thunderbird does. S/MIME mail keeps the subject readable, because Outlook and Thunderbird don't read hidden S/MIME subjects; it is still protected inside the encryption.

**Scheduled and queued mail:** Loupe signs and encrypts a message when you send or schedule it, while your key is unlocked, so it can go out later from the background. If you reschedule it while the key is locked, Loupe asks for the passphrase again.

### Settings per address

Settings › End-to-End Encryption › **Addresses** › *address*:

| Setting | Default | What it does |
|---|---|---|
| **OpenPGP Key** | | Which of your keys this address uses. **Generate a Key…** makes one. |
| **S/MIME** | | Which certificate this address uses |
| **Prefer S/MIME** | Off | When both could protect a message, use S/MIME rather than OpenPGP (unless only OpenPGP has keys for every recipient) |
| **Encrypt Automatically** | On | Encrypt when every recipient has a key or certificate |
| **Always Encrypt** | Off | Refuse to send when a recipient has no key |
| **Sign Unencrypted Mail** | Off | Sign messages you don't encrypt |
| **Attach My Public Key** | Off | Attach your OpenPGP public key as a file |

## Passphrases

| Setting | Default | What it does |
|---|---|---|
| **Remember Passphrases** | On | Keeps unlocked keys and certificates unlocked until Loupe closes. Off: each is locked again two minutes after it was last used. |
| **Lock Keys Now** | | Locks all keys and certificates at once |

Background work never has keys that are protected by a passphrase.
