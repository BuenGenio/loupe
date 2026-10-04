import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../smime/smime_providers.dart';
import '../smime/smime_service.dart';
import 'openpgp_providers.dart';
import 'openpgp_service.dart';

final _statuses = Expando<PgpMessageStatus>('OpenPGP status');
final _smimeStatuses = Expando<SmimeMessageStatus>('S/MIME status');

/// The OpenPGP status of content from [ContentLoader]; null when the
/// message wasn't encrypted or signed.
PgpMessageStatus? pgpStatusOf(EmailContent content) => _statuses[content];

/// The S/MIME status of content from [ContentLoader]; null when the
/// message wasn't S/MIME.
SmimeMessageStatus? smimeStatusOf(EmailContent content) => _smimeStatuses[content];

/// Whether [content] came encrypted, and with which standard (null when it didn't).
SecurityTechnology? encryptedWith(EmailContent content) {
  if (pgpStatusOf(content)?.encrypted ?? false) return SecurityTechnology.openPgp;
  if (smimeStatusOf(content)?.encrypted ?? false) return SecurityTechnology.smime;
  return null;
}

/// Loads message bodies and attachments for reading. Wraps the
/// repository: OpenPGP and S/MIME messages come back decrypted and
/// verified (see [pgpStatusOf], [smimeStatusOf]), Autocrypt headers teach
/// the keyring new keys, and signed S/MIME mail brings its certificate.
final contentLoaderProvider = Provider<ContentLoader>(
  (ref) => ContentLoader(
    repository: ref.watch(repositoryProvider),
    openPgp: () => ref.read(openPgpServiceProvider.future),
    smime: () => ref.read(smimeServiceProvider.future),
  ),
);

/// Part ids of decrypted messages (OpenPGP and S/MIME) start with this;
/// their bytes come from the decrypted message, not the server.
const decryptedPartPrefix = 'pgp:';

final class ContentLoader {
  ContentLoader({required this.repository, required this.openPgp, this.smime});

  final MailRepository repository;

  /// The OpenPGP service, once the keyring has loaded.
  final Future<OpenPgpService> Function() openPgp;

  /// The S/MIME service, once the certificate store has loaded.
  final Future<SmimeService> Function()? smime;

  /// Decrypted messages, to serve their attachments (a few, newest last).
  final _entities = <String, MimeEntity>{};
  static const _keep = 12;

  /// The content of [emailId], decrypted when it is OpenPGP mail.
  Future<EmailContent> loadContent(String emailId) async {
    final content = await repository.loadContent(emailId);
    final smimeProtection = detectSmime(content.headers);
    if (smimeProtection != SmimeProtection.none && smime != null) return _loadSmime(emailId, content);
    final protection = detectProtection(content.headers, text: content.text);
    final autocrypt = content.headers.any((h) => h.$1.toLowerCase() == 'autocrypt');
    // Plain mail without Autocrypt never waits for the keyring.
    if (protection == PgpProtection.none && !autocrypt) return content;
    final summary = await repository.getEmail(emailId);
    if (protection == PgpProtection.none) {
      if (summary != null) unawaited(openPgp().then((pgp) => _learn(pgp, summary, content), onError: (Object _) {}));
      return content;
    }
    final OpenPgpService pgp;
    try {
      pgp = await openPgp();
    } on Object {
      return content;
    }
    // Learn the sender's key first: it may be what verifies this message.
    if (summary != null && autocrypt) await _learn(pgp, summary, content);
    final raw = await repository.loadRawSource(emailId);
    final encrypted = protection == PgpProtection.pgpMimeEncrypted || protection == PgpProtection.inlineEncrypted;
    PgpReadOutcome outcome;
    try {
      outcome = await pgp.read(emailId, raw, encrypted: encrypted);
    } on PgpException catch (e) {
      outcome = PgpReadOutcome(
        status: PgpMessageStatus(
          protection: protection,
          encrypted: encrypted,
          failure: PgpDecryptFailure.damaged,
          failureMessage: e.message,
        ),
      );
    }
    final status = outcome.status;
    final EmailContent shown;
    if (status.encrypted && status.failure != null) {
      shown = _copy(content, text: _explain(status.failure!), html: null, attachments: _withoutPlumbing(content));
    } else if (outcome.content case final decrypted?) {
      _remember(emailId, outcome.entity!);
      shown = _copy(
        decrypted,
        headers: _withProtected(content.headers, status.protectedHeaders),
        attachments: decrypted.attachments,
      );
      if (status.gossip.isNotEmpty && summary != null) {
        unawaited(
          pgp
              .learnGossip(
                status.gossip,
                recipients: {
                  for (final a in [...summary.to, ...summary.cc]) a.email.toLowerCase(),
                },
                date: summary.sentAt ?? summary.receivedAt,
              )
              .catchError((Object _) {}),
        );
      }
    } else if (outcome.text case final text?) {
      shown = _copy(content, text: text, html: null);
    } else {
      shown = _copy(content, attachments: _withoutPlumbing(content));
    }
    _statuses[shown] = status;
    return shown;
  }

  Future<EmailContent> _loadSmime(String emailId, EmailContent content) async {
    final SmimeService service;
    try {
      service = await smime!();
    } on Object {
      return content;
    }
    final summary = await repository.getEmail(emailId);
    final sender = summary?.sender?.email;
    SmimeMessageStatus status;
    SmimeReadOutcome? outcome;
    try {
      final raw = await repository.loadRawSource(emailId);
      outcome = await service.read(emailId, raw, sender: sender);
      status = outcome.status;
    } on SmimeException catch (e) {
      status = SmimeMessageStatus(
        protection: detectSmime(content.headers),
        encrypted: detectSmime(content.headers) != SmimeProtection.signedDetached,
        failure: SmimeDecryptFailure.damaged,
        failureMessage: e.message,
      );
    }
    final EmailContent shown;
    if (status.encrypted && status.failure != null) {
      shown = _copy(content, text: _explainSmime(status.failure!), html: null, attachments: _withoutPlumbing(content));
    } else if (outcome?.content case final inner?) {
      _remember(emailId, outcome!.entity!);
      shown = _copy(inner, headers: content.headers, attachments: inner.attachments);
    } else {
      shown = _copy(content, attachments: _withoutPlumbing(content));
    }
    _smimeStatuses[shown] = status;
    // Mail the user received brings its sender's certificate (not drafts, sent mail or junk).
    final signature = status.signature;
    if (signature != null && sender != null && summary != null && !summary.isDraft) {
      if (!summary.keywords.contains(Keywords.junk)) {
        unawaited(service.collect(signature, sender: sender).then((_) {}, onError: (Object _) {}));
      }
    }
    return shown;
  }

  /// The bytes of an attachment, from the decrypted message for `pgp:` parts.
  Future<Uint8List> loadAttachment(String emailId, String partId) async {
    if (!partId.startsWith(decryptedPartPrefix)) return repository.loadAttachment(emailId, partId);
    var entity = _entities[emailId];
    if (entity == null) {
      await loadContent(emailId);
      entity = _entities[emailId];
    }
    final part = entity == null ? null : partOf(entity, partId, partPrefix: decryptedPartPrefix);
    if (part == null) throw const MailException(MailErrorKind.notFound, 'This attachment is no longer available.');
    return part.decodedBody;
  }

  /// Autocrypt: messages the user received (not drafts, sent mail or junk).
  Future<void> _learn(OpenPgpService pgp, EmailSummary summary, EmailContent content) async {
    final from = summary.sender?.email;
    if (from == null || summary.isDraft || summary.keywords.contains(Keywords.junk)) return;
    try {
      await pgp.learnAutocrypt(from: from, date: summary.sentAt ?? summary.receivedAt, headers: content.headers);
    } on Object {
      // A broken header teaches nothing.
    }
  }

  void _remember(String emailId, MimeEntity entity) {
    _entities
      ..remove(emailId)
      ..[emailId] = entity;
    while (_entities.length > _keep) {
      _entities.remove(_entities.keys.first);
    }
  }

  static List<(String, String)> _withProtected(List<(String, String)> outer, List<(String, String)> inner) {
    final subject = inner.where((h) => h.$1.toLowerCase() == 'subject').firstOrNull;
    if (subject == null) return outer;
    return [
      for (final h in outer)
        if (h.$1.toLowerCase() == 'subject') subject else h,
    ];
  }

  static List<Attachment> _withoutPlumbing(EmailContent c) => [
    for (final a in c.attachments)
      if (!_plumbing.contains(a.mimeType.toLowerCase()) && !_plumbingNames.contains(a.filename?.toLowerCase())) a,
  ];

  static const _plumbing = {'application/pgp-encrypted', 'application/pgp-signature', ...smimePlumbingTypes};
  static const _plumbingNames = {'encrypted.asc', 'smime.p7s', 'smime.p7m'};

  static String _explainSmime(SmimeDecryptFailure failure) => switch (failure) {
    SmimeDecryptFailure.noKey =>
      'This message is encrypted with S/MIME, but not to any certificate on this device. Import your certificate '
          '(a .p12 or .pfx file) in Settings › End-to-End Encryption.',
    SmimeDecryptFailure.damaged => 'This encrypted message is damaged, so it can’t be decrypted safely.',
    SmimeDecryptFailure.unsupported => 'This message uses encryption that Loupe can’t read yet.',
  };

  static String _explain(PgpDecryptFailure failure) => switch (failure) {
    PgpDecryptFailure.locked => 'This message is encrypted. Unlock your OpenPGP key to read it.',
    PgpDecryptFailure.noSecretKey =>
      'This message is encrypted, but not to any OpenPGP key on this device. If you read it in '
          'Thunderbird, import your key from there: Settings › End-to-End Encryption.',
    PgpDecryptFailure.damaged => 'This encrypted message is damaged, so it can’t be decrypted safely.',
    PgpDecryptFailure.unsupported => 'This message uses encryption that Loupe can’t read yet.',
  };

  static EmailContent _copy(
    EmailContent c, {
    String? text,
    Object? html = _keepValue,
    List<Attachment>? attachments,
    List<(String, String)>? headers,
  }) => EmailContent(
    emailId: c.emailId,
    text: text ?? c.text,
    html: identical(html, _keepValue) ? c.html : html as String?,
    isFlowed: text == null && c.isFlowed,
    attachments: attachments ?? c.attachments,
    inlineData: c.inlineData,
    headers: headers ?? c.headers,
  );
}

const _keepValue = Object();
