import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../../theme/theme.dart';
import '../conversation/sheets.dart';

/// Editable host settings for one protocol (the manual setup form).
class ServerSettingsController {
  ServerSettingsController(ServerConfig config)
    : protocol = config.protocol,
      host = TextEditingController(text: config.host),
      port = TextEditingController(text: '${config.port}'),
      username = TextEditingController(text: config.username ?? ''),
      security = config.security,
      trustedCertificate = config.trustedCertificateSha256;

  final ServerProtocol protocol;
  final TextEditingController host;
  final TextEditingController port;
  final TextEditingController username;
  ConnectionSecurity security;

  /// A certificate fingerprint the user chose to trust.
  String? trustedCertificate;

  /// The standard port for [protocol] with [security].
  static int defaultPort(ServerProtocol protocol, ConnectionSecurity security) => switch ((protocol, security)) {
    (ServerProtocol.smtp, ConnectionSecurity.tls) => 465,
    (ServerProtocol.smtp, _) => 587,
    (ServerProtocol.jmap, _) => 443,
    (ServerProtocol.imap, ConnectionSecurity.tls) => 993,
    (ServerProtocol.imap, _) => 143,
  };

  /// Changes the security and, if the port was the old default, the port.
  void setSecurity(ConnectionSecurity next) {
    if (int.tryParse(port.text.trim()) == defaultPort(protocol, security)) {
      port.text = '${defaultPort(protocol, next)}';
    }
    security = next;
  }

  /// Null when host or port is missing or invalid.
  ServerConfig? get config {
    final h = host.text.trim();
    final p = int.tryParse(port.text.trim());
    if (h.isEmpty || h.contains(' ') || p == null || p <= 0 || p > 65535) return null;
    final user = username.text.trim();
    return ServerConfig(
      protocol: protocol,
      host: h,
      port: p,
      security: security,
      username: user.isEmpty ? null : user,
      trustedCertificateSha256: trustedCertificate,
    );
  }

  void dispose() {
    host.dispose();
    port.dispose();
    username.dispose();
  }
}

/// A short, readable line for a server: "imap.example.com:993 · TLS".
String describeServer(ServerConfig c) => '${c.host}:${c.port} · ${securityLabel(c.security)}';

String securityLabel(ConnectionSecurity s) => switch (s) {
  ConnectionSecurity.tls => 'TLS',
  ConnectionSecurity.startTls => 'STARTTLS',
  ConnectionSecurity.none => 'None',
};

/// The manual form for one server: host, port, security and username.
class ServerSettingsForm extends StatefulWidget {
  const ServerSettingsForm({super.key, required this.title, required this.controller, this.enabled = true});

  final String title;
  final ServerSettingsController controller;
  final bool enabled;

  @override
  State<ServerSettingsForm> createState() => _ServerSettingsFormState();
}

class _ServerSettingsFormState extends State<ServerSettingsForm> {
  ServerSettingsController get _c => widget.controller;

  Future<void> _pickSecurity(ConnectionSecurity? s) async {
    if (s == null || s == _c.security) return;
    if (s == ConnectionSecurity.none && !await confirmNoEncryption(context)) return;
    setState(() => _c.setSecurity(s));
  }

  @override
  Widget build(BuildContext context) {
    final key = _c.protocol.name;
    return SheetGroup(
      header: widget.title,
      children: [
        FormRow(
          label: 'Server',
          child: TextField(
            key: ValueKey('$key-host'),
            controller: _c.host,
            enabled: widget.enabled,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: const InputDecoration.collapsed(hintText: 'mail.example.com'),
          ),
        ),
        FormRow(
          label: 'Port',
          child: TextField(
            key: ValueKey('$key-port'),
            controller: _c.port,
            enabled: widget.enabled,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration.collapsed(hintText: '993'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              SizedBox(width: 96, child: Text('Security', style: _labelStyle(context))),
              Expanded(
                child: CupertinoSlidingSegmentedControl<ConnectionSecurity>(
                  key: ValueKey('$key-security'),
                  groupValue: _c.security,
                  onValueChanged: widget.enabled ? _pickSecurity : (_) {},
                  children: {
                    for (final s in ConnectionSecurity.values)
                      s: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(securityLabel(s), style: const TextStyle(fontSize: 13)),
                      ),
                  },
                ),
              ),
            ],
          ),
        ),
        FormRow(
          label: 'Username',
          child: TextField(
            key: ValueKey('$key-username'),
            controller: _c.username,
            enabled: widget.enabled,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration.collapsed(hintText: 'Your email address'),
          ),
        ),
      ],
    );
  }
}

TextStyle? _labelStyle(BuildContext context) => Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16);

/// One labelled row of a grouped form.
class FormRow extends StatelessWidget {
  const FormRow({super.key, required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    child: Row(
      children: [
        SizedBox(width: 96, child: Text(label, style: _labelStyle(context))),
        Expanded(
          child: DefaultTextStyle.merge(style: const TextStyle(fontSize: 16), child: child),
        ),
      ],
    ),
  );
}

/// Asks before allowing a connection without encryption.
Future<bool> confirmNoEncryption(BuildContext context) async =>
    await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Connect Without Encryption?'),
        content: const Text(
          'Your password and every message would travel as plain text. Anyone on the network, such as '
          'public Wi-Fi, could read them. Only use this for a server on your own network.',
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Use Without Encryption'),
          ),
        ],
      ),
    ) ??
    false;

/// A tinted note card (provider hints, errors).
class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.icon, required this.child, this.color, this.actions = const []});

  final IconData icon;
  final Widget child;
  final Color? color;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
        decoration: BoxDecoration(color: c.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: c, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DefaultTextStyle.merge(
                      style: TextStyle(fontSize: 14, color: LoupeColors.of(context).secondaryText, height: 1.3),
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
            if (actions.isNotEmpty) Wrap(spacing: 4, children: actions),
          ],
        ),
      ),
    );
  }
}
