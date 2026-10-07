/// Sending over JMAP (RFC 8621 §7: EmailSubmission).
library;

import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:mail_model/mail_model.dart';

import 'client/errors.dart';
import 'client/request.dart';
import 'client/session.dart';
import 'transport/jmap_transport.dart';
import 'transport/mailboxes.dart';

/// Sends ready-made messages through JMAP: the message (as Loupe's composer
/// made it, signed or encrypted as asked) is uploaded and imported into
/// Drafts, then submitted from the identity of the envelope sender. The
/// copy that belongs in Sent moves there as it goes out (with `$seen`,
/// without `$draft`), every other copy is destroyed once sent.
final class JmapSender implements MailSender {
  JmapSender(this.account, CredentialsCallback credentials, {http.Client? httpClient})
    : _transport = JmapTransport(account, credentials, httpClient: httpClient);

  final MailAccount account;
  final JmapTransport _transport;

  List<Json>? _identities;
  MailboxDirectory? _boxes;

  @override
  Future<SendReceipt> send(
    Uint8List rfc822, {
    required String envelopeFrom,
    required List<String> recipients,
    bool fileInSent = false,
  }) async {
    final to = {
      for (final r in recipients)
        if (r.trim().isNotEmpty) r.trim(),
    }.toList();
    if (to.isEmpty) throw const PermanentMailException(MailErrorKind.server, 'The message has no recipients.');
    if (!_transport.isConnected) await _transport.connect();
    final session = _transport.session!;
    if (!session.has(JmapCapabilities.submission)) {
      throw PermanentMailException(
        MailErrorKind.unsupported,
        '${account.incoming.host} doesn’t offer sending over JMAP (EmailSubmission).',
      );
    }
    final mailAccount = session.primaryAccount(JmapCapabilities.mail)!;
    final submissionAccount = session.primaryAccount(JmapCapabilities.submission) ?? mailAccount;
    await _load(mailAccount, submissionAccount);
    final identity = identityFor(_identities!, envelopeFrom);
    if (identity == null) {
      throw PermanentMailException(
        MailErrorKind.server,
        '${account.incoming.host} has no sending identity for $envelopeFrom.',
      );
    }
    final boxes = _boxes!;
    final sent = boxes.withRole(MailboxRole.sent)?.id;
    final holding = boxes.withRole(MailboxRole.drafts)?.id ?? sent ?? boxes.withRole(MailboxRole.inbox)?.id;
    if (holding == null) {
      throw const PermanentMailException(MailErrorKind.server, 'The account has no Drafts or Sent folder.');
    }
    final emailId = await _transport.importMessage(rfc822, {holding}, const {Keywords.seen, Keywords.draft});
    final file = fileInSent && sent != null;
    final refused = <String, MailException>{};
    var remaining = to;
    try {
      while (true) {
        final outcome = await _submit(
          submissionAccount,
          emailId: emailId,
          identityId: identity['id']! as String,
          from: envelopeFrom,
          to: remaining,
          file: file ? (holding: holding, sent: sent) : null,
        );
        if (outcome.invalid.isEmpty) return SendReceipt(refused: refused, filed: outcome.filed);
        // The server refused some recipients: they stay behind, the
        // others get the message.
        for (final r in outcome.invalid) {
          refused[r] = PermanentMailException(MailErrorKind.server, 'The server refused the recipient $r.');
        }
        final left = {for (final r in outcome.invalid) r.toLowerCase()};
        remaining = [
          for (final r in remaining)
            if (!left.contains(r.toLowerCase())) r,
        ];
        if (remaining.isEmpty) {
          throw PermanentMailException(
            MailErrorKind.server,
            'The server refused ${outcome.invalid.length == 1 ? 'the recipient' : 'every recipient'}: '
            '${outcome.invalid.join(', ')}.',
          );
        }
      }
    } catch (_) {
      await _discard(mailAccount, emailId);
      rethrow;
    }
  }

  Future<void> _load(String mailAccount, String submissionAccount) async {
    if (_identities != null && _boxes != null) return;
    final request = JmapRequest(const [JmapCapabilities.mail, JmapCapabilities.submission]);
    final identities = request.add('Identity/get', {'accountId': submissionAccount});
    final boxes = request.add('Mailbox/get', {'accountId': mailAccount, 'properties': mailboxProperties});
    final response = await _transport.client.call(request);
    _identities = [
      for (final i in response.of(identities)['list'] as List? ?? const [])
        if (i is Map && i['id'] is String) i.cast<String, Object?>(),
    ];
    _boxes = MailboxDirectory([
      for (final m in response.of(boxes)['list'] as List? ?? const [])
        if (m is Map) JmapMailbox.fromJson(m.cast()),
    ]);
  }

  Future<({bool filed, List<String> invalid})> _submit(
    String accountId, {
    required String emailId,
    required String identityId,
    required String from,
    required List<String> to,
    ({String holding, String? sent})? file,
  }) async {
    final request = JmapRequest(const [JmapCapabilities.mail, JmapCapabilities.submission]);
    final set = request.add('EmailSubmission/set', {
      'accountId': accountId,
      'create': {
        's': {
          'identityId': identityId,
          'emailId': emailId,
          'envelope': {
            'mailFrom': {'email': from},
            'rcptTo': [
              for (final r in to) {'email': r},
            ],
          },
        },
      },
      if (file != null)
        'onSuccessUpdateEmail': {
          '#s': {
            if (file.holding != file.sent) 'mailboxIds/${file.holding}': null,
            'mailboxIds/${file.sent}': true,
            'keywords/${pointerSegment(Keywords.draft)}': null,
            'keywords/${pointerSegment(Keywords.seen)}': true,
          },
        }
      else
        'onSuccessDestroyEmail': ['#s'],
    });
    final response = await _transport.client.call(request);
    final args = response.of(set);
    if (args['created'] case {'s': Map<Object?, Object?> _}) {
      final implicit = response.implicit(set, 'Email/set');
      final updated = implicit?['updated'];
      return (filed: file != null && updated is Map && updated.containsKey(emailId), invalid: const <String>[]);
    }
    final error = ((args['notCreated'] as Map?)?['s'] as Map?)?.cast<String, Object?>() ?? const {};
    final type = error['type'] as String? ?? 'serverFail';
    final invalid = stringList(error['invalidRecipients']);
    if (type == 'invalidRecipients' && invalid.isNotEmpty) return (filed: false, invalid: invalid);
    final e = setError('Sending failed', error);
    throw switch (type) {
      'rateLimit' || 'overQuota' || 'serverFail' || 'serverUnavailable' => e,
      'forbiddenFrom' || 'forbiddenMailFrom' => PermanentMailException(
        MailErrorKind.unsupported,
        'The server doesn’t let this account send as $from.',
        e,
      ),
      _ => PermanentMailException(e.kind, e.message, e),
    };
  }

  /// Removes the imported copy of a message that didn't go out.
  Future<void> _discard(String accountId, String emailId) async {
    try {
      final request = JmapRequest();
      request.add('Email/set', {
        'accountId': accountId,
        'destroy': [emailId],
      });
      await _transport.client.call(request);
    } on Object {
      // Left in Drafts; the message stays in the Outbox either way.
    }
  }

  @override
  Future<void> close() => _transport.disconnect();
}

/// The identity to send as [from]: one with that address, else one whose
/// address is a wildcard for its domain (`*@example.org`), else the first
/// (the envelope still names [from]; a server that doesn't allow it says
/// `forbiddenFrom`). Null when the account has none.
Json? identityFor(List<Json> identities, String from) {
  final address = from.trim().toLowerCase();
  final at = address.lastIndexOf('@');
  final domain = at < 0 ? '' : address.substring(at + 1);
  Json? wildcard;
  for (final i in identities) {
    final email = (i['email'] as String? ?? '').trim().toLowerCase();
    if (email == address) return i;
    if (email == '*@$domain') wildcard ??= i;
  }
  return wildcard ?? identities.firstOrNull;
}
