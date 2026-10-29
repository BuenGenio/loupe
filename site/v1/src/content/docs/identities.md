---
title: "Identities and signatures"
description: "Send from several addresses in Loupe: identities with their own signatures, replies from the address you were written to, and catch-all aliases."
section: "Accounts & security"
order: 140
---

An identity is an address you send from, with the name, signature and extras that go with it. One account can have several identities: your own address, a shared team address, an alias. Loupe picks the right one for replies by itself.

## Manage identities

Go to Settings › *account* › **Identities**.

- **The first identity** is the default for new messages from this account. Drag the handles to change the order.
- **Add Identity** creates a new one.
- **Tap an identity** to edit it, then tap **Done**.

If you leave the editor with unsaved changes, Loupe asks whether to **Save Identity** or **Discard Changes**.

Identities imported [from Thunderbird](/docs/accounts/#import-from-thunderbird) arrive with the account.

## What an identity holds

| Field | What it does |
|---|---|
| **Name** | The name recipients see |
| **Email** | The address messages go out from |
| **Reply-To** | Optional. Replies to your messages go to this address instead |
| **Signature** | Added below a "-- " line in messages from this identity |
| **Copy to Myself** | Optional **Cc** and **Bcc** addresses added to every message from this identity |
| **Use for Replies To** | Addresses or patterns this identity answers for (see below) |

**Delete Identity** removes an identity. Messages already sent from it stay as they are. An account needs at least one identity.

> **Note:** The email address must be one your mail server lets you send from. Loupe doesn't check this; a server that refuses it says so when you send, and the message waits in the Outbox.

## Signatures

Each identity has its own signature, in plain text. Loupe adds it to new messages, replies and forwards, below a "-- " line (the standard signature separator, which mail apps recognise).

To add or change a signature: Settings › *account* › **Identities** › tap the identity › **Signature**, type it, and tap **Done**.

When you change the From address while writing, Loupe swaps the signature, and the identity's automatic Cc and Bcc, for those of the new identity.

## Replies go out from the right address

When you reply to or forward a message, Loupe picks the identity it was sent to. It checks, in this order:

1. your identities among the message's To and Cc recipients;
2. the delivery headers your server added (such as Delivered-To), which reveal the address even when you were in Bcc or the mail came through a forwarding address;
3. plus-addresses of your identities, such as `me+shop@example.com` for `me@example.com`;
4. the **Use for Replies To** patterns of your identities;
5. the account's default identity.

It looks in the message's own account first, then in your other accounts.

When you **Reply All**, Loupe leaves the address you reply from out of the recipients.

### Use for Replies To

Patterns let one identity answer for many addresses. In the identity editor, tap **Add Address or Pattern** and enter an address, or a pattern where `*` stands for anything:

| Pattern | Matches |
|---|---|
| `*@example.com` | every address at example.com, as on a catch-all domain |
| `me+*@example.com` | every plus-address of `me@example.com` |
| `sales@example.com` | that one address |

Entering `@example.com` or `example.com` is the same as `*@example.com`.

## Catch-all aliases

If you give out a different address to every shop or service at your own domain, you don't need an identity for each one. When a message was sent to an address that isn't one of your identities but is clearly yours (an address at a domain your account uses, or a plus-address of an identity), Loupe offers to answer from it:

- In the composer, a line asks "Reply from *address*?" (or "Send from *address*?"). Tap it to use that address, or tap its close button to ignore it.
- In the **From** picker, the address appears as "Reply from *address*", marked "Not saved as an identity". It uses your default identity's name and signature.
- **Save as Identity** in the From picker keeps it as a proper identity.

Public mail domains such as gmail.com and outlook.com never count as yours, and neither does the sender's own domain.
