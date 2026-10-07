/// JMAP errors as [MailException]s.
library;

import 'package:mail_model/mail_model.dart';

/// A JMAP error: a request-level problem (RFC 8620 §3.6.1), a method error
/// (§3.6.2) or a per-object error of a `/set` method (§5.3). [type] is the
/// JMAP error type, e.g. `cannotCalculateChanges` or `notFound`.
final class JmapException extends MailException {
  const JmapException(this.type, super.kind, super.message, [super.cause]);

  final String type;

  @override
  String toString() => 'JmapException($type, ${kind.name}): $message';
}

/// The [MailErrorKind] of a method error [type].
MailErrorKind methodErrorKind(String type) => switch (type) {
  // Temporary: worth trying again later.
  'serverUnavailable' || 'rateLimit' => MailErrorKind.connection,
  'unknownMethod' ||
  'accountNotSupportedByMethod' ||
  'unsupportedSort' ||
  'unsupportedFilter' ||
  'forbidden' ||
  'accountReadOnly' => MailErrorKind.unsupported,
  'accountNotFound' => MailErrorKind.authentication,
  _ => MailErrorKind.server,
};

/// A method error response's arguments as an exception.
JmapException methodError(String method, Map<String, Object?> args) {
  final type = args['type'] as String? ?? 'serverFail';
  final description = args['description'] as String?;
  return JmapException(
    type,
    methodErrorKind(type),
    '$method failed ($type)${description == null || description.isEmpty ? '' : ': $description'}',
    args,
  );
}

/// The [MailErrorKind] of a per-object [type] of a `/set` method.
MailErrorKind setErrorKind(String type) => switch (type) {
  'notFound' => MailErrorKind.notFound,
  'rateLimit' => MailErrorKind.connection,
  'forbidden' || 'forbiddenFrom' || 'forbiddenMailFrom' || 'forbiddenToSend' => MailErrorKind.unsupported,
  _ => MailErrorKind.server,
};

/// A per-object error of a `/set` (or `/import`, `/copy`) method.
JmapException setError(String what, Map<String, Object?> error) {
  final type = error['type'] as String? ?? 'serverFail';
  final description = error['description'] as String?;
  return JmapException(
    type,
    setErrorKind(type),
    '$what ($type)${description == null || description.isEmpty ? '' : ': $description'}',
    error,
  );
}

/// A request-level failure from the HTTP status and the problem details
/// (RFC 7807) the server sent.
MailException requestError(int status, String host, Map<String, Object?>? problem) {
  final type = (problem?['type'] as String? ?? '').replaceFirst('urn:ietf:params:jmap:error:', '');
  var detail = problem?['detail'] as String? ?? problem?['title'] as String?;
  // Some servers quote the whole request back.
  if (detail != null && detail.length > 200) detail = '${detail.substring(0, 200)}…';
  final suffix = detail == null || detail.isEmpty ? '' : ': $detail';
  if (status == 401) {
    return JmapException('unauthorized', MailErrorKind.authentication, '$host refused the login$suffix');
  }
  if (status == 403) {
    return JmapException('forbidden', MailErrorKind.authentication, '$host refused access$suffix');
  }
  if (type == 'unknownCapability') {
    return JmapException(type, MailErrorKind.unsupported, '$host doesn’t support what Loupe needs$suffix');
  }
  if (status == 404) return JmapException('notFound', MailErrorKind.notFound, 'Not found on $host$suffix');
  if (status == 408 || status == 429 || status == 502 || status == 503 || status == 504) {
    return JmapException(
      type.isEmpty ? 'unavailable' : type,
      MailErrorKind.connection,
      '$host is busy or unavailable (HTTP $status)$suffix',
    );
  }
  return JmapException(type.isEmpty ? 'http$status' : type, MailErrorKind.server, '$host answered HTTP $status$suffix');
}
