/// JMAP transport for Loupe (RFC 8620, RFC 8621): Stalwart, Fastmail, Cyrus.
///
/// Start with [CompositeTransportFactory]: it implements mail_model's
/// `TransportFactory` for IMAP and JMAP accounts alike, by each account's
/// incoming protocol.
library;

export 'src/client/client.dart' show JmapBlob, JmapClient, looksLikeApiToken;
export 'src/client/errors.dart' show JmapException;
export 'src/client/event_source.dart' show ServerEvent, parseServerEvents, stateChangesOf;
export 'src/client/request.dart' show JmapCall, JmapRequest, JmapResponse;
export 'src/client/session.dart' show JmapAccount, JmapCapabilities, JmapSession;
export 'src/discovery.dart' show JmapDiscoverer, JmapNotes, fastmailJmapDiscovery;
export 'src/factory.dart' show CompositeTransportFactory, JmapTransportFactory;
export 'src/sender.dart' show JmapSender, identityFor;
export 'src/sieve.dart' show JmapSieveConnector, JmapSieveSession;
export 'src/transport/jmap_transport.dart' show JmapTransport;
