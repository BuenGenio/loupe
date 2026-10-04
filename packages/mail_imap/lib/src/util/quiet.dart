/// enough_mail prints diagnostics (some include message text) with `print`.
/// Everything that calls into it runs in a zone that drops prints, so nothing
/// reaches the device log.
library;

import 'dart:async';

final _spec = ZoneSpecification(print: (self, parent, zone, line) {});

/// Runs [body] in a zone that swallows `print`. Callbacks registered inside
/// (socket listeners, futures) stay in that zone.
T runQuietly<T>(T Function() body) => runZoned(body, zoneSpecification: _spec);
