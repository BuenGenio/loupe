// What the pipeline learned about a message's links and privacy while
// rebuilding it: facts for the app's phishing check and privacy report.
// Pure Dart, so it is computed in the background isolate with the document.

/// Why a link deserves a closer look.
enum LinkIssue {
  /// The text shows one domain, the link opens another.
  textMismatch,

  /// The host mixes alphabets or imitates Latin letters (IDN homograph).
  homograph,

  /// An international (punycode) host that is not a homograph.
  international,

  /// The host is an IP address instead of a name.
  ipAddress,

  /// A URL shortener: the destination is unknown until it is opened.
  shortener,

  /// `https://paypal.com@evil.example/`: text before an `@` that looks like
  /// a host but isn't one.
  userInfo,

  /// A `javascript:` (or `vbscript:`) link; removed by the reader.
  script,

  /// A `data:` link (an embedded page); removed by the reader.
  dataUrl,
}

/// One link that deserves a closer look.
final class LinkFinding {
  const LinkFinding(this.issue, {required this.url, this.text = '', this.host, this.detail, this.viaTracker = false});

  final LinkIssue issue;

  /// The link as written; for removed links only the scheme (`javascript:`).
  final String url;

  /// The visible text of the link.
  final String text;

  /// The host the finding is about, in Unicode (the destination's when the
  /// link goes through a redirect).
  final String? host;

  /// The domain the text shows ([LinkIssue.textMismatch]), the name a
  /// homograph imitates, or the user name before the `@`.
  final String? detail;

  /// The link goes through a click tracker that hides the destination, so a
  /// text mismatch can't be checked.
  final bool viaTracker;

  @override
  String toString() => 'LinkFinding(${issue.name} $host${detail == null ? '' : ' ($detail)'})';
}

/// What the reader blocked or noticed for the user's privacy.
final class PrivacyReport {
  const PrivacyReport({
    this.trackers = 0,
    this.trackerHosts = const [],
    this.remoteImages = 0,
    this.remoteImageHosts = const [],
    this.trackedLinks = 0,
    this.trackingServices = const [],
  });

  /// Tracking pixels removed.
  final int trackers;

  /// Their hosts, distinct and sorted.
  final List<String> trackerHosts;

  /// Remote images (blocked unless the user loads them).
  final int remoteImages;
  final List<String> remoteImageHosts;

  /// Links that go through a click-tracking redirect.
  final int trackedLinks;

  /// The services behind them ("Mailchimp", "Google"…), distinct.
  final List<String> trackingServices;

  /// Trackers in the message: pixels plus tracked links.
  int get total => trackers + trackedLinks;

  bool get isEmpty => trackers == 0 && remoteImages == 0 && trackedLinks == 0;
}

/// Link and privacy findings for one message.
final class ReadableAnalysis {
  const ReadableAnalysis({
    this.links = const [],
    this.privacy = const PrivacyReport(),
    this.linkCount = 0,
    this.linkHosts = const [],
    this.hiddenElements = 0,
    this.hiddenTextLength = 0,
    this.keptTextLength = 0,
    this.passwordFields = 0,
  });

  static const empty = ReadableAnalysis();

  /// Links that deserve a closer look, in document order.
  final List<LinkFinding> links;
  final PrivacyReport privacy;

  /// Distinct links in the message.
  final int linkCount;

  /// Where the links lead (destinations of known redirects), distinct and
  /// sorted, in Unicode.
  final List<String> linkHosts;

  /// Hidden elements (and their text) the reader removed: preheaders, but
  /// also text meant to fool spam filters.
  final int hiddenElements;
  final int hiddenTextLength;

  /// Visible text the reader kept.
  final int keptTextLength;

  /// Password fields of forms the reader removed.
  final int passwordFields;
}
