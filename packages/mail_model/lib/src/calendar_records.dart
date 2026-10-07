/// What the device remembers about calendar invitations, by UID (and
/// RECURRENCE-ID, for one occurrence of a series): the latest version seen,
/// cancellations and the user's response, so an update can say what changed
/// and the card shows the answer sent. Kept in the encrypted store, on this
/// device only. The app owns the record's contents ([data], JSON written by
/// mail_calendar's `InvitationRecord`). Implemented by repositories that can
/// (`repository is CalendarRecords`).
abstract interface class CalendarRecords {
  /// The record of [uid] (and [recurrenceId]), or null.
  Future<String?> readCalendarRecord(String uid, {String recurrenceId = ''});

  /// Saves [data] as the record of [uid] (and [recurrenceId]); null deletes it.
  Future<void> writeCalendarRecord(String uid, String? data, {String recurrenceId = ''});
}
