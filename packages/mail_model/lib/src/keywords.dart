/// Message keywords (IMAP flags and keywords, JMAP keywords).
///
/// Keywords are stored lower-cased, as JMAP does. IMAP adapters map system
/// flags (`\Seen`, …) to the `$`-prefixed forms below.
abstract final class Keywords {
  static const seen = r'$seen';
  static const flagged = r'$flagged';
  static const answered = r'$answered';
  static const draft = r'$draft';
  static const forwarded = r'$forwarded';

  /// Thunderbird and many servers use these for junk classification.
  static const junk = r'$junk';
  static const notJunk = r'$notjunk';

  /// Thunderbird's default tags.
  static const label1 = r'$label1';
  static const label2 = r'$label2';
  static const label3 = r'$label3';
  static const label4 = r'$label4';
  static const label5 = r'$label5';

  /// RFC 9979 `$new`: show the message as new although it isn't, e.g. after
  /// it woke from snooze (see `Snooze`).
  static const newAgain = r'$new';

  /// Keywords that are state rather than user-visible tags. Snooze
  /// keywords (`$snoozed-…`) are state too; see `EmailSummary.tags`.
  static const system = {seen, flagged, answered, draft, forwarded, junk, notJunk, newAgain, r'$mdnsent', r'$phishing'};

  /// Lower-cases a keyword; JMAP keywords are case-insensitive.
  static String normalize(String keyword) => keyword.toLowerCase();
}

/// A user-visible tag, shown as a coloured dot or chip.
final class TagDefinition {
  const TagDefinition({required this.keyword, required this.label, required this.colorArgb});

  final String keyword;
  final String label;

  /// Colour as 0xAARRGGBB.
  final int colorArgb;

  /// Thunderbird's default tags and colours.
  static const thunderbirdDefaults = [
    TagDefinition(keyword: Keywords.label1, label: 'Important', colorArgb: 0xFFFF0000),
    TagDefinition(keyword: Keywords.label2, label: 'Work', colorArgb: 0xFFFF9900),
    TagDefinition(keyword: Keywords.label3, label: 'Personal', colorArgb: 0xFF009900),
    TagDefinition(keyword: Keywords.label4, label: 'To Do', colorArgb: 0xFF3333FF),
    TagDefinition(keyword: Keywords.label5, label: 'Later', colorArgb: 0xFF993399),
  ];
}
