/// Readable HTML for Loupe.
///
/// [ReadableMessageView] shows a message in one of three modes: Readable
/// (HTML rebuilt from an allowlist and rendered natively), Original (the
/// sender's HTML in a locked-down WebView) and Plain text (Sans or Mono).
/// Text bodies show patches as such: `git format-patch` diffs and their
/// diffstat, and diff hunks quoted in review replies.
library;

export 'src/api.dart';
