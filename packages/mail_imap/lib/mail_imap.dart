/// IMAP/SMTP transport, MIME composer and account discovery for Loupe.
///
/// Start with [ImapTransportFactory]; it implements mail_model's
/// `TransportFactory`.
library;

export 'src/compose/mime_composer.dart' show MimeMessageComposer;
export 'src/discovery/discoverer.dart' show AccountDiscoverer, ServerProbe;
export 'src/discovery/providers.dart' show providerRule;
export 'src/factory.dart' show ImapTransportFactory;
export 'src/imap/imap_transport.dart' show ImapTransport;
export 'src/net/secure_socket.dart'
    show
        UntrustedCertificate,
        WireProtocol,
        normalizeFingerprint,
        openMailSocket,
        secureMailSocket,
        untrustedFingerprintOf;
export 'src/smtp/smtp_sender.dart' show ImapSmtpSender;
