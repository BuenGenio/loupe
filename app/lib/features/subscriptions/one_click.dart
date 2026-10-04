import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:readable/readable.dart' show isIpLiteral;

// RFC 8058 one-click unsubscribe: besides account setup, the only request
// Loupe makes outside the mail protocols, and only when the user taps
// Unsubscribe.

/// The POST that unsubscribes: `List-Unsubscribe=One-Click` to the sender's
/// URI and nothing else. No cookies, credentials, referrer, user agent or
/// language go with it, so the sender learns nothing the URI doesn't
/// already say.
@immutable
final class OneClickRequest {
  const OneClickRequest(this.uri);

  final Uri uri;

  static const method = 'POST';
  static const body = 'List-Unsubscribe=One-Click';
  static const contentType = 'application/x-www-form-urlencoded';

  /// Every header the request sends besides Host and Content-Length.
  static const headers = {'content-type': contentType};

  List<int> get bodyBytes => utf8.encode(body);

  /// RFC 8058 needs HTTPS. User names and passwords in the URI are refused,
  /// and so are IP addresses and local names, so a message can't make the
  /// phone post to a device on its own network.
  static bool isAllowed(Uri uri) {
    final host = uri.host.toLowerCase();
    return uri.scheme.toLowerCase() == 'https' &&
        host.contains('.') &&
        uri.userInfo.isEmpty &&
        !isIpLiteral(host) &&
        !const ['.local', '.localhost', '.internal', '.home.arpa', '.lan'].any(host.endsWith);
  }
}

/// What came back: the status, and where a redirect points.
@immutable
final class OneClickResponse {
  const OneClickResponse(this.statusCode, {this.location});

  final int statusCode;
  final String? location;
}

/// Sends one [OneClickRequest] as it is and returns the status, without
/// following redirects or reading the page.
abstract interface class OneClickTransport {
  Future<OneClickResponse> send(OneClickRequest request, {required Duration timeout});
}

enum OneClickOutcome {
  unsubscribed,

  /// The server answered with an error.
  refused,

  /// It sent the request on to another site, which Loupe doesn't follow.
  redirectedAway,

  /// No answer: offline, a bad certificate, a timeout.
  failed,
}

@immutable
final class OneClickResult {
  const OneClickResult(this.outcome, {this.statusCode, this.message});

  final OneClickOutcome outcome;
  final int? statusCode;

  /// Why it didn't work, for the user.
  final String? message;

  bool get ok => outcome == OneClickOutcome.unsubscribed;
}

/// Unsubscribes with one POST (RFC 8058).
///
/// A 2xx answer, or 303 See Other (the server took the POST and points to a
/// page Loupe doesn't load), means done. Other redirects are followed with
/// the same POST, at most [maxRedirects] times, and only on the same host.
final class OneClickUnsubscriber {
  const OneClickUnsubscriber(this.transport, {this.timeout = const Duration(seconds: 20), this.maxRedirects = 3});

  final OneClickTransport transport;
  final Duration timeout;
  final int maxRedirects;

  Future<OneClickResult> unsubscribe(Uri uri) async {
    final host = uri.host;
    if (!OneClickRequest.isAllowed(uri)) {
      return const OneClickResult(
        OneClickOutcome.failed,
        message: 'The unsubscribe link isn’t a secure address on the internet.',
      );
    }
    var request = OneClickRequest(uri);
    for (var hop = 0; ; hop++) {
      final OneClickResponse response;
      try {
        response = await transport.send(request, timeout: timeout);
      } on TimeoutException {
        return OneClickResult(OneClickOutcome.failed, message: '$host didn’t answer in time.');
      } on IOException {
        return OneClickResult(OneClickOutcome.failed, message: 'Couldn’t reach $host.');
      }
      final status = response.statusCode;
      if ((status >= 200 && status < 300) || status == 303) {
        return OneClickResult(OneClickOutcome.unsubscribed, statusCode: status);
      }
      if (const {301, 302, 307, 308}.contains(status)) {
        final location = response.location;
        final next = location == null ? null : Uri.tryParse(location);
        final target = next == null ? null : request.uri.resolveUri(next);
        if (target == null ||
            target.host.toLowerCase() != host.toLowerCase() ||
            !OneClickRequest.isAllowed(target) ||
            hop >= maxRedirects) {
          return OneClickResult(
            OneClickOutcome.redirectedAway,
            statusCode: status,
            message: '$host sent the request on to another page, which Loupe doesn’t follow.',
          );
        }
        request = OneClickRequest(target);
        continue;
      }
      return OneClickResult(
        OneClickOutcome.refused,
        statusCode: status,
        message: '$host refused the request (error $status).',
      );
    }
  }
}

/// [OneClickTransport] over dart:io. dart:io keeps no cookies; the user
/// agent and Accept-Encoding headers it would add are removed, and the
/// answer's body isn't read.
final class IoOneClickTransport implements OneClickTransport {
  const IoOneClickTransport();

  @override
  Future<OneClickResponse> send(OneClickRequest request, {required Duration timeout}) async {
    final client = HttpClient()
      ..userAgent = null
      ..autoUncompress = false
      ..connectionTimeout = timeout;
    try {
      return await () async {
        final req = await client.openUrl(OneClickRequest.method, request.uri);
        req
          ..followRedirects = false
          ..persistentConnection = false;
        req.headers.removeAll(HttpHeaders.acceptEncodingHeader);
        OneClickRequest.headers.forEach(req.headers.set);
        final body = request.bodyBytes;
        req
          ..contentLength = body.length
          ..add(body);
        final res = await req.close();
        final location = res.headers.value(HttpHeaders.locationHeader);
        // The page isn't wanted (it may carry trackers); stop reading.
        await res.listen(null).cancel();
        return OneClickResponse(res.statusCode, location: location);
      }().timeout(timeout);
    } finally {
      client.close(force: true);
    }
  }
}

/// Demo mode: no network; every request "works" after a moment.
final class DemoOneClickTransport implements OneClickTransport {
  const DemoOneClickTransport({this.delay = const Duration(milliseconds: 700)});

  final Duration delay;

  @override
  Future<OneClickResponse> send(OneClickRequest request, {required Duration timeout}) async {
    await Future<void>.delayed(delay);
    return const OneClickResponse(200);
  }
}
