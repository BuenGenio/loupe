---
title: "Writing and sending"
description: "Compose, reply and forward in Loupe, attach files, choose who you send as, undo a send, schedule mail for later and handle the Outbox."
section: "Using Loupe"
order: 70
---

Loupe's composer is deliberately simple: plain text, recipients, attachments and the address you send from. Around it are the things that save you from mistakes: drafts that save themselves, a delay to take a message back, and an Outbox that never loses a message.

## Write a message

1. Tap the compose button at the bottom right of Mailboxes or any list (or press **Ctrl/⌘+N**).
2. Fill in **To:**. Type a name or address and pick a suggestion, or finish an address with a comma, a semicolon or Return. Addresses Loupe can't read show in red.
3. Tap **Cc/Bcc, From** to add Cc and Bcc recipients or change the address you send from.
4. Write a **Subject** and your message.
5. Tap **Send**.

Messages are plain text. There is no formatting toolbar.

- **Remove a recipient:** tap it and choose **Remove**, or press Backspace in the empty field.
- **No subject?** Loupe asks before sending a message without one.

### Choose who you send as

The **From** line shows the identity the message goes out from. Tap it to choose another identity of any account. Replies start from the address the original message was sent to. When that address isn't one of your identities but clearly belongs to you (a catch-all alias or a plus-address), Loupe suggests it: "Reply from *address*?".

Each identity brings its own signature and its automatic Cc or Bcc. See [Identities and signatures](/docs/identities/).

### Attach files

Tap **Attach** (the paperclip) and pick one or more files. Each shows as a chip with its name and size, and a button to remove it. Loupe warns when attachments add up to more than 20 MB, because some servers refuse messages that large.

## Reply and forward

- **Reply** goes to the sender, or to the Reply-To address if the message has one. Replying to a message you sent goes to its original recipients.
- **Reply All** adds everyone else who received it, leaving out your own addresses.
- **Reply to List** (called Reply List in the ⋯ menu) goes to a mailing list's posting address. It is offered on mail from lists that accept posts.
- **Forward** includes the original message below a "Forwarded message" line, with its attachments.

In a conversation, tap the Reply button, or long-press it for Reply All, Reply to List and Forward. Keyboard: **R**, **Shift+R**, **F**.

Replies start with "Re:" and forwards with "Fwd:". The original is quoted below your text ("On … , Name wrote:", with each line starting with ">"), and the cursor starts at the top.

Forwarding as an attachment isn't available yet.

## Drafts save themselves

- While you write, Loupe saves the message to the account's **Drafts** folder a few seconds after you stop typing (a little later when large attachments are involved). Each save replaces the last one, so your Drafts folder doesn't fill up with copies.
- If you leave a message you changed, Loupe asks: **Save Draft** or **Delete Draft**. Esc on a keyboard asks the same; it never throws your text away.
- If Loupe closes while you are writing, it offers to bring the message back next time: **Continue Editing**, **Save to Drafts** or **Discard**.

Open a draft from Drafts (or **All Drafts**) to continue it. Sending it deletes the draft.

## Undo Send

After you tap Send, the message waits a few seconds before it goes out, and a bar says "Sending…" with **Undo**. Tap Undo to get the message back in the composer.

Choose the delay in Settings › **Undo Send Delay**: Off, 5 seconds, 10 seconds (the default), 20 seconds or 30 seconds.

## Send later

1. In the composer, tap the clock (**Send Later**), or long-press **Send**.
2. Choose a time:
   - **Later Today** at 18:00 (offered before 17:00);
   - **Tomorrow Morning** at 08:00;
   - **Monday Morning** at 08:00;
   - **Pick Date & Time…** for any time up to a year ahead, in 5-minute steps.
3. The Send button now shows the time. Tap it to schedule the message.

Loupe says "Scheduled for …". To send at once after all, open Send Later again and choose **Send Without Delay**.

Scheduled messages wait in the Outbox on your phone, not on the server. Loupe sends them at their time, also when the app is closed, as long as the phone is on and online. Android runs this background work about every 15 minutes, so a message can go out a few minutes after its time.

## The Outbox

The **Outbox** appears on Mailboxes while something waits to be sent. It has three sections:

- **Not Sent:** messages that failed, with the server's reason in red.
- **Sending:** messages going out now, and those still in their Undo Send delay ("Sending soon").
- **Scheduled:** messages waiting for their time.

What you can do with a message there:

| Action | How |
|---|---|
| Change it | Tap it to open it in the composer. Sending replaces the waiting message. |
| Send it now, or try again | Swipe right: **Send Now** or **Retry** |
| Pick another time | Swipe left: **Reschedule** |
| Stop it | Swipe left: **Cancel**, then **Move to Drafts** or **Discard Message** (which you can undo) |

Long-pressing a message offers the same actions.

### When sending fails

A message stays in the Outbox until it is sent or you remove it.

- **A temporary problem** (no connection, a busy server) is retried by itself, first after 30 seconds and then less and less often, up to every 30 minutes.
- **A refusal for good** (for example an address that doesn't exist) stays under **Not Sent** with the server's answer, and the Outbox row on Mailboxes turns red. It isn't retried until you tap **Retry**. Fix the address by tapping the message.
- **If the server accepts some recipients but refuses others,** the others get the message, and the refused recipients stay in the Outbox as a message of their own.

Failed sends don't cause a notification: check for the red Outbox row.

## Encrypted and signed mail

When you have an OpenPGP key or an S/MIME certificate, an **Encrypt** and a **Sign** switch appear under the subject. See [End-to-end encryption](/docs/encryption/#sending-encrypted-and-signed-mail).
