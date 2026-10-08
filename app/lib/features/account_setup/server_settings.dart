import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
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
    (ServerProtocol.jmap, ConnectionSecurity.none) => 80,
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

  /// Null when host or port is missing or invalid. The server may be given
  /// as a URL (`https://mail.example.com`, as JMAP servers are often
  /// written): its host and port count, and `http://` only with no
  /// encryption chosen.
  ServerConfig? get config {
    var h = host.text.trim();
    var p = int.tryParse(port.text.trim());
    var chosen = security;
    if (h.contains('://')) {
      final url = Uri.tryParse(h);
      if (url == null || url.host.isEmpty || (url.scheme != 'https' && url.scheme != 'http')) return null;
      if (url.scheme == 'http' && security != ConnectionSecurity.none) return null;
      if (url.scheme == 'https' && security == ConnectionSecurity.none) chosen = ConnectionSecurity.tls;
      h = url.host;
      if (url.hasPort) p = url.port;
    }
    if (h.isEmpty || h.contains(' ') || h.contains('/') || p == null || p <= 0 || p > 65535) return null;
    final user = username.text.trim();
    return ServerConfig(
      protocol: protocol,
      host: h,
      port: p,
      security: chosen,
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
String describeServer(AppLocalizations l10n, ServerConfig c) =>
    '${c.host}:${c.port} · ${securityLabel(l10n, c.security)}';

String securityLabel(AppLocalizations l10n, ConnectionSecurity s) => switch (s) {
  ConnectionSecurity.tls => 'TLS',
  ConnectionSecurity.startTls => 'STARTTLS',
  ConnectionSecurity.none => l10n.accountSetupSecurityNone,
};

/// The manual form for one server: host, port, security and username;
/// with [onProtocol], first a choice of IMAP or JMAP.
class ServerSettingsForm extends StatefulWidget {
  const ServerSettingsForm({
    super.key,
    required this.title,
    required this.controller,
    this.enabled = true,
    this.onProtocol,
  });

  final String title;
  final ServerSettingsController controller;
  final bool enabled;

  /// Switches the incoming server between IMAP and JMAP.
  final ValueChanged<ServerProtocol>? onProtocol;

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
    final jmap = _c.protocol == ServerProtocol.jmap;
    final onProtocol = widget.onProtocol;
    final l10n = context.l10n;
    return SheetGroup(
      header: widget.title,
      children: [
        if (onProtocol != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                SizedBox(width: 96, child: Text(l10n.accountSetupProtocol, style: _labelStyle(context))),
                Expanded(
                  child: CupertinoSlidingSegmentedControl<ServerProtocol>(
                    key: const ValueKey('setup-protocol'),
                    groupValue: _c.protocol,
                    onValueChanged: (p) {
                      if (p != null && widget.enabled) onProtocol(p);
                    },
                    children: const {
                      ServerProtocol.imap: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text('IMAP', style: TextStyle(fontSize: 13)),
                      ),
                      ServerProtocol.jmap: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text('JMAP', style: TextStyle(fontSize: 13)),
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        FormRow(
          label: l10n.commonServer,
          child: TextField(
            key: ValueKey('$key-host'),
            controller: _c.host,
            enabled: widget.enabled,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: InputDecoration.collapsed(hintText: jmap ? 'https://mail.example.com' : 'mail.example.com'),
          ),
        ),
        FormRow(
          label: l10n.accountSetupPort,
          child: TextField(
            key: ValueKey('$key-port'),
            controller: _c.port,
            enabled: widget.enabled,
            keyboardType: TextInputType.number,
            decoration: InputDecoration.collapsed(
              hintText: '${ServerSettingsController.defaultPort(_c.protocol, _c.security)}',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              SizedBox(width: 96, child: Text(l10n.accountSetupSecurity, style: _labelStyle(context))),
              Expanded(
                child: CupertinoSlidingSegmentedControl<ConnectionSecurity>(
                  key: ValueKey('$key-security'),
                  groupValue: _c.security,
                  onValueChanged: widget.enabled ? _pickSecurity : (_) {},
                  children: {
                    // HTTP has no STARTTLS.
                    for (final s in ConnectionSecurity.values)
                      if (!jmap || s != ConnectionSecurity.startTls)
                        s: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(securityLabel(l10n, s), style: const TextStyle(fontSize: 13)),
                        ),
                  },
                ),
              ),
            ],
          ),
        ),
        FormRow(
          label: l10n.accountSetupUsername,
          child: TextField(
            key: ValueKey('$key-username'),
            controller: _c.username,
            enabled: widget.enabled,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration.collapsed(hintText: l10n.accountSetupUsernameHint),
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
        // Labels line up at 96 points; a longer one ("App Password") pushes the field over rather than wrapping.
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 96),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: Text(label, style: _labelStyle(context)),
          ),
        ),
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
        title: Text(context.l10n.accountSetupNoEncryptionTitle),
        content: Text(context.l10n.accountSetupNoEncryptionText),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.commonCancel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.accountSetupUseWithoutEncryption),
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
