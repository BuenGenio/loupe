import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

/// Every icon of the app, by meaning. Screens use these, never an icon pack
/// directly, so changing the pack means changing this file.
///
/// The pack is Fluent UI System Icons, 24 px glyphs. Regular is the default;
/// the `…Filled` variants are for active or selected states (a flagged
/// message, VIP on, a filter that is on) and for glyphs on solid colour
/// (swipe actions).
abstract final class LoupeIcons {
  // Mailboxes ---------------------------------------------------------------

  static const IconData inbox = FluentIcons.mail_inbox_24_regular;
  static const IconData allInboxes = FluentIcons.mail_inbox_all_24_regular;
  static const IconData vip = FluentIcons.star_24_regular;
  static const IconData vipFilled = FluentIcons.star_24_filled;
  static const IconData flagged = FluentIcons.flag_24_regular;
  static const IconData flaggedFilled = FluentIcons.flag_24_filled;
  static const IconData unread = FluentIcons.mail_unread_24_regular;
  static const IconData drafts = FluentIcons.drafts_24_regular;
  static const IconData sent = FluentIcons.send_24_regular;
  static const IconData junk = FluentIcons.mail_prohibited_24_regular;
  static const IconData trash = FluentIcons.delete_24_regular;
  static const IconData archive = FluentIcons.archive_24_regular;
  static const IconData allMail = FluentIcons.mail_multiple_24_regular;
  static const IconData important = FluentIcons.important_24_regular;
  static const IconData outbox = FluentIcons.mail_inbox_arrow_up_24_regular;
  static const IconData folder = FluentIcons.folder_24_regular;
  static const IconData smartMailbox = FluentIcons.folder_search_24_regular;
  static const IconData tag = FluentIcons.tag_24_regular;
  static const IconData tagFilled = FluentIcons.tag_24_filled;

  // Message actions ---------------------------------------------------------

  static const IconData compose = FluentIcons.compose_24_regular;
  static const IconData reply = FluentIcons.arrow_reply_24_regular;
  static const IconData replyAll = FluentIcons.arrow_reply_all_24_regular;
  static const IconData forward = FluentIcons.arrow_forward_24_regular;

  /// The "replied" mark in a message row.
  static const IconData repliedFilled = FluentIcons.arrow_reply_24_filled;
  static const IconData markRead = FluentIcons.mail_read_24_regular;
  static const IconData markUnread = FluentIcons.mail_unread_24_regular;
  static const IconData move = FluentIcons.folder_arrow_right_24_regular;
  static const IconData notJunk = FluentIcons.thumb_like_24_regular;
  static const IconData deleteForever = FluentIcons.delete_dismiss_24_regular;
  static const IconData send = FluentIcons.send_24_filled;
  static const IconData attachment = FluentIcons.attach_24_regular;
  static const IconData headers = FluentIcons.text_description_24_regular;
  static const IconData source = FluentIcons.code_24_regular;
  static const IconData searchSender = FluentIcons.person_search_24_regular;

  // Send Later and the Outbox ------------------------------------------------

  static const IconData sendLater = FluentIcons.clock_24_regular;
  static const IconData sendLaterFilled = FluentIcons.clock_24_filled;
  static const IconData laterToday = FluentIcons.weather_moon_24_regular;
  static const IconData tomorrowMorning = FluentIcons.weather_sunny_low_24_regular;
  static const IconData mondayMorning = FluentIcons.calendar_week_start_24_regular;
  static const IconData pickDateTime = FluentIcons.calendar_edit_24_regular;
  static const IconData sendNow = FluentIcons.send_24_regular;
  static const IconData reschedule = FluentIcons.calendar_clock_24_regular;
  static const IconData retry = FluentIcons.arrow_clockwise_24_regular;
  static const IconData cancelSend = FluentIcons.dismiss_circle_24_regular;
  static const IconData swipeSendNow = FluentIcons.send_24_filled;
  static const IconData swipeReschedule = FluentIcons.calendar_clock_24_filled;
  static const IconData swipeCancelSend = FluentIcons.dismiss_circle_24_filled;

  // Swipe actions: white on solid colour.

  static const IconData swipeMarkRead = FluentIcons.mail_read_24_filled;
  static const IconData swipeMarkUnread = FluentIcons.mail_unread_24_filled;
  static const IconData swipeFlag = FluentIcons.flag_24_filled;
  static const IconData swipeArchive = FluentIcons.archive_24_filled;
  static const IconData swipeMoveToInbox = FluentIcons.mail_inbox_24_filled;
  static const IconData swipeTrash = FluentIcons.delete_24_filled;
  static const IconData swipeMove = FluentIcons.folder_arrow_right_24_filled;
  static const IconData swipeMore = FluentIcons.more_circle_24_filled;

  // Controls ----------------------------------------------------------------

  static const IconData settings = FluentIcons.settings_24_regular;
  static const IconData search = FluentIcons.search_24_regular;
  static const IconData filter = FluentIcons.filter_24_regular;
  static const IconData filterFilled = FluentIcons.filter_24_filled;
  static const IconData more = FluentIcons.more_horizontal_24_regular;
  static const IconData moreCircle = FluentIcons.more_circle_24_regular;
  static const IconData back = FluentIcons.chevron_left_24_regular;

  /// The chevron at the end of a row that opens something.
  static const IconData disclosure = FluentIcons.chevron_right_24_regular;
  static const IconData expand = FluentIcons.chevron_down_24_regular;
  static const IconData collapse = FluentIcons.chevron_up_24_regular;
  static const IconData close = FluentIcons.dismiss_24_regular;

  /// Clears a field or removes a chip.
  static const IconData clear = FluentIcons.dismiss_circle_24_filled;
  static const IconData share = FluentIcons.share_24_regular;
  static const IconData copy = FluentIcons.copy_24_regular;
  static const IconData edit = FluentIcons.edit_24_regular;
  static const IconData rename = FluentIcons.rename_24_regular;
  static const IconData check = FluentIcons.checkmark_24_regular;
  static const IconData selected = FluentIcons.checkmark_circle_24_filled;
  static const IconData unselected = FluentIcons.circle_24_regular;

  /// A solid dot (tag colours).
  static const IconData dot = FluentIcons.circle_24_filled;
  static const IconData add = FluentIcons.add_circle_24_filled;
  static const IconData remove = FluentIcons.subtract_circle_24_filled;
  static const IconData negate = FluentIcons.subtract_circle_24_regular;
  static const IconData backspace = FluentIcons.backspace_24_regular;
  static const IconData saveSearch = FluentIcons.add_square_multiple_24_regular;
  static const IconData completion = FluentIcons.text_t_24_regular;
  static const IconData recent = FluentIcons.history_24_regular;
  static const IconData info = FluentIcons.info_24_regular;
  static const IconData warning = FluentIcons.warning_24_regular;
  static const IconData error = FluentIcons.error_circle_24_regular;
  static const IconData showPassword = FluentIcons.eye_24_regular;
  static const IconData hidePassword = FluentIcons.eye_off_24_regular;
  static const IconData upload = FluentIcons.arrow_upload_24_regular;
  static const IconData download = FluentIcons.arrow_download_24_regular;
  static const IconData wrap = FluentIcons.text_wrap_24_regular;

  // People and status -------------------------------------------------------

  static const IconData person = FluentIcons.person_24_regular;
  static const IconData people = FluentIcons.people_24_regular;
  static const IconData contact = FluentIcons.person_circle_24_regular;
  static const IconData emailAddress = FluentIcons.mention_24_regular;
  static const IconData onServer = FluentIcons.cloud_24_regular;
  static const IconData offline = FluentIcons.cloud_off_24_regular;
  static const IconData synced = FluentIcons.cloud_checkmark_24_regular;
  static const IconData syncPending = FluentIcons.cloud_arrow_up_24_regular;
  static const IconData thisDevice = FluentIcons.phone_24_regular;
  static const IconData privacy = FluentIcons.shield_lock_24_regular;
  static const IconData password = FluentIcons.key_24_regular;
  static const IconData serverSettings = FluentIcons.options_24_regular;
  static const IconData verified = FluentIcons.shield_checkmark_24_filled;
  static const IconData unverified = FluentIcons.shield_error_24_filled;
  static const IconData readable = FluentIcons.sparkle_24_regular;

  // Importing accounts ------------------------------------------------------

  static const IconData qrCode = FluentIcons.qr_code_24_regular;
  static const IconData scanQrCode = FluentIcons.scan_qr_code_24_regular;
  static const IconData paste = FluentIcons.clipboard_paste_24_regular;
  static const IconData cameraOff = FluentIcons.camera_off_24_regular;

  // Settings ----------------------------------------------------------------

  static const IconData swipeActions = FluentIcons.swipe_right_24_regular;
  static const IconData conversations = FluentIcons.chat_multiple_24_regular;
  static const IconData undoSend = FluentIcons.arrow_undo_24_regular;
  static const IconData readerView = FluentIcons.immersive_reader_24_regular;
  static const IconData font = FluentIcons.text_font_24_regular;
  static const IconData images = FluentIcons.image_24_regular;
  static const IconData notifications = FluentIcons.alert_24_regular;

  // Attachments by type -----------------------------------------------------

  static const IconData file = FluentIcons.document_24_regular;
  static const IconData pdf = FluentIcons.document_pdf_24_regular;
  static const IconData image = FluentIcons.image_24_regular;
  static const IconData video = FluentIcons.video_clip_24_regular;
  static const IconData audio = FluentIcons.music_note_2_24_regular;
  static const IconData textDocument = FluentIcons.document_one_page_24_regular;
  static const IconData wordDocument = FluentIcons.document_text_24_regular;
  static const IconData spreadsheet = FluentIcons.document_table_24_regular;
  static const IconData presentation = FluentIcons.slide_text_24_regular;
  static const IconData zip = FluentIcons.folder_zip_24_regular;
  static const IconData calendar = FluentIcons.calendar_ltr_24_regular;
  static const IconData email = FluentIcons.mail_24_regular;

  // Attachment viewer -------------------------------------------------------

  /// "Open in…": hand the file to another app.
  static const IconData openIn = FluentIcons.open_24_regular;
  static const IconData save = FluentIcons.arrow_download_24_regular;
  static const IconData wrapFilled = FluentIcons.text_wrap_24_filled;
  static const IconData table = FluentIcons.table_24_regular;
  static const IconData tableFilled = FluentIcons.table_24_filled;
  static const IconData sourceFilled = FluentIcons.code_24_filled;
  static const IconData time = FluentIcons.clock_24_regular;
  static const IconData location = FluentIcons.location_24_regular;
  static const IconData mobileData = FluentIcons.cellular_data_1_24_regular;
  static const IconData fileError = FluentIcons.document_error_24_regular;
}
