// Link and privacy findings of a rebuilt message, for the app's phishing
// check and privacy report. Runs in the pipeline, next to the document.

import '../model/analysis.dart';
import '../model/document.dart';
import 'hosts.dart';

/// URL shorteners: the destination is unknown until the link is opened.
const urlShorteners = {
  'bit.ly',
  'bitly.com',
  'j.mp',
  't.co',
  'tinyurl.com',
  'goo.gl',
  'ow.ly',
  'buff.ly',
  'is.gd',
  'v.gd',
  'rebrand.ly',
  'cutt.ly',
  'shorturl.at',
  'tiny.cc',
  'rb.gy',
  't.ly',
  'lnkd.in',
  's.id',
  'bl.ink',
  'short.io',
  'shorte.st',
  'adf.ly',
  'bc.vc',
  'soo.gd',
  'qrco.de',
  'x.co',
  'tr.im',
  'po.st',
  'mcaf.ee',
  'amzn.to',
  'aka.ms',
  'fb.me',
  'forms.gle',
  'dlvr.it',
  'ift.tt',
  'trib.al',
  'hubs.ly',
  'hubs.la',
  'mailchi.mp',
  'urlz.fr',
  'shorturl.com',
  'tinyurl.is',
};

bool isUrlShortener(String host) {
  final h = host.toLowerCase();
  return urlShorteners.contains(h) || urlShorteners.contains(h.startsWith('www.') ? h.substring(4) : h);
}

/// The findings for [doc]. [trackerHosts] are the hosts of removed tracking
/// pixels, [removedLinks] the schemes of links the reader disabled.
ReadableAnalysis analyzeDocument(
  ReaderDocument doc, {
  Iterable<String> trackerHosts = const [],
  List<String> removedLinks = const [],
  int passwordFields = 0,
}) {
  final findings = <LinkFinding>[];
  final reported = <(LinkIssue, String)>{};
  void add(LinkFinding f) {
    if (reported.add((f.issue, '${f.host ?? f.url}|${f.detail ?? ''}'))) findings.add(f);
  }

  final infos = <String, HostInfo>{};
  HostInfo info(String host) => infos.putIfAbsent(host.toLowerCase(), () => inspectHost(host));

  final urls = <String>{};
  final hosts = <String>{};
  final trackedUrls = <String>{};
  final services = <String>{};
  for (final link in doc.links) {
    final uri = Uri.tryParse(link.url);
    if (uri == null) continue;
    final scheme = uri.scheme.toLowerCase();
    if (scheme != 'http' && scheme != 'https' || uri.host.isEmpty) continue;
    urls.add(link.url);
    final redirect = link.redirect;
    if (redirect != null && redirect.tracking) {
      trackedUrls.add(link.url);
      services.addAll(redirect.trackingServices);
    }
    final known = redirect != null && redirect.known && redirect.resolved;
    final destination = known ? Uri.tryParse(redirect.target!) ?? uri : uri;
    final destinationInfo = info(destination.host);
    hosts.add(destinationInfo.display);

    if (link.namedDomain case final named?) {
      add(
        LinkFinding(
          LinkIssue.textMismatch,
          url: link.url,
          text: link.text,
          host: destinationInfo.display,
          detail: named,
          viaTracker: redirect != null && redirect.known && redirect.hidden,
        ),
      );
    }
    for (final u in {uri, destination}) {
      final h = info(u.host);
      if (h.homograph) {
        add(LinkFinding(LinkIssue.homograph, url: link.url, text: link.text, host: h.display, detail: h.looksLike));
      } else if (h.international) {
        add(LinkFinding(LinkIssue.international, url: link.url, text: link.text, host: h.display));
      }
      if (h.ipAddress) add(LinkFinding(LinkIssue.ipAddress, url: link.url, text: link.text, host: h.display));
      if (isUrlShortener(h.host)) {
        add(LinkFinding(LinkIssue.shortener, url: link.url, text: link.text, host: h.display));
      }
      if (u.userInfo.isNotEmpty) {
        add(
          LinkFinding(
            LinkIssue.userInfo,
            url: link.url,
            text: link.text,
            host: h.display,
            detail: Uri.decodeComponent(u.userInfo.split(':').first),
          ),
        );
      }
    }
  }
  for (final scheme in removedLinks) {
    add(LinkFinding(scheme == 'data' ? LinkIssue.dataUrl : LinkIssue.script, url: '$scheme:'));
  }

  final imageHosts = <String>{};
  for (final image in doc.images) {
    if (image.source case RemoteImageSource(:final url)) {
      final host = Uri.tryParse(url)?.host;
      if (host != null && host.isNotEmpty) imageHosts.add(info(host).display);
    }
  }
  final stats = doc.stats;
  return ReadableAnalysis(
    links: findings,
    linkCount: urls.length,
    linkHosts: hosts.toList()..sort(),
    hiddenElements: stats.hiddenElements,
    hiddenTextLength: stats.hiddenTextLength,
    keptTextLength: stats.keptTextLength,
    passwordFields: passwordFields,
    privacy: PrivacyReport(
      trackers: stats.trackers,
      trackerHosts: trackerHosts.toSet().toList()..sort(),
      remoteImages: stats.remoteImages,
      remoteImageHosts: imageHosts.toList()..sort(),
      trackedLinks: trackedUrls.length,
      trackingServices: services.toList(),
    ),
  );
}
