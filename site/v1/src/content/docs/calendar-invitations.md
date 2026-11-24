---
title: "Calendar invitations"
description: "Read meeting invitations from Outlook, Google Calendar and others in Loupe, answer Accept, Maybe or Decline, and add events to your calendar."
section: "Using Loupe"
order: 110
---

When a message carries a meeting invitation, Loupe shows it as a card above the message: what, when, where, who, and buttons to answer. It reads invitations from Outlook, Google Calendar, Thunderbird and any other app that sends standard calendar invitations (iCalendar).

## The invitation card

The card shows:

- **The title**, and your answer once you gave one: Accepted, Maybe or Declined.
- **When**, in your time zone. If the event was planned in another time zone, the card shows both, for example "09:00–10:00 London · 17:00–18:00 your time". All-day events say "All day".
- **Repeats**, in words (for example, every week on Monday), with the next occurrence.
- **Where**, with a **Map** button that opens the place in your maps app.
- **The online meeting** (Teams, Zoom, Google Meet, Webex, Jitsi, GoTo Meeting or another), with a **Join** button. Loupe shows the meeting's web address before it opens it.
- **The organizer**, and the **guests** with their answers so far ("4 guests · 2 accepted, 1 maybe, 1 declined"). Tap the guests to see the list.

If a calendar file holds more than one event, the card says how many more there are.

> **Note:** Loupe never loads anything an invitation links to by itself. Map and Join open only when you tap them. If Loupe's [phishing check](/docs/privacy-security/#the-phishing-check) finds the message suspicious, the buttons are turned off.

## Answer an invitation

1. Tap **Accept**, **Maybe** or **Decline**.
2. Optionally, tap **Add a Comment** first and write a note for the organizer.

Loupe sends your answer to the organizer as a standard reply that their calendar understands, from the address the invitation was sent to. The card says where it goes ("Your reply goes to … from …").

The reply goes through the Outbox like any message, so your [Undo Send delay](/docs/writing/#undo-send) applies: a bar says "Accepted · sending reply to …" with **Undo**. Undo takes the reply back, and the card returns to your earlier answer.

Loupe only answers when you tap a button, never on its own. It answers invitations that come from the organizer; a calendar file someone else attached can only be added to your calendar.

## Add to your calendar

Tap **Add to Calendar**. Your phone's calendar app opens a new event filled in with the details, including how it repeats. Nothing is saved until you save it there.

Loupe doesn't sync calendars itself: answering an invitation tells the organizer, and adding it to your calendar is a separate step.

## Updates and cancellations

Loupe remembers the invitations you have seen, so later messages about the same event make sense:

- **Updated:** the card lists what changed, such as "Time changed from … to …", a new location, a new title, or a change to how it repeats. The earlier invitation is then marked **Out of date**: "This invitation was updated later; the newer one counts."
- **Updated invitation:** an update to an event whose first invitation you never opened in Loupe.
- **Cancelled:** the title is struck through and the card says the organizer cancelled the event.
- **Answers to your own invitations:** when someone replies to an event you organised, the card says so, for example "Wren declined:" with their comment. Proposals for a new time say so too.

If you answered an earlier version of an event, the card reminds you: "You accepted an earlier version."

## Time zones

Loupe understands the time zone names used by calendar apps, including Outlook's Windows names. If an invitation uses a time zone Loupe doesn't know, the card shows the times as written and says that the time zone is unknown.
