import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../settings/app_settings.dart';
import '../../shared/sheets.dart';
import '../../theme/loupe_icons.dart';
import '../conversation/sheets.dart' show showSnack;
import 'compose_args.dart';

/// What compose keeps on the device while a message is being written, so a
/// crash or a swipe-away from the app switcher loses nothing. Next launch
/// offers to continue it ([offerComposeRecovery]).
@immutable
final class ComposeRecord {
  const ComposeRecord({
    required this.session,
    required this.message,
    required this.savedAt,
    this.sendAt,
    this.attachmentsOmitted = 0,
  });

  /// The compose screen that wrote it.
  final String session;

  /// Includes the autosaved draft's id, if there is one.
  final OutgoingMessage message;
  final DateTime savedAt;
  final DateTime? sendAt;

  /// Attachments too big to keep on the side ([ComposeRecoveryStore.maxAttachmentBytes]);
  /// they are in the autosaved draft, if it was saved after they were added.
  final int attachmentsOmitted;

  String encode() {
    final total = message.attachments.fold<int>(0, (n, a) => n + a.data.length);
    final keep = total <= ComposeRecoveryStore.maxAttachmentBytes;
    Map<String, Object?> address(EmailAddress a) => {'email': a.email, 'name': a.name};
    return jsonEncode({
      'session': session,
      'savedAt': savedAt.millisecondsSinceEpoch,
      'sendAt': sendAt?.millisecondsSinceEpoch,
      'attachmentsOmitted': keep ? 0 : message.attachments.length,
      'message': {
        'accountId': message.accountId,
        'identityId': message.identityId,
        'to': [for (final a in message.to) address(a)],
        'cc': [for (final a in message.cc) address(a)],
        'bcc': [for (final a in message.bcc) address(a)],
        'subject': message.subject,
        'text': message.text,
        'html': message.html,
        'attachments': [
          if (keep)
            for (final a in message.attachments)
              {'filename': a.filename, 'mimeType': a.mimeType, 'data': base64Encode(a.data)},
        ],
        'inReplyTo': message.inReplyTo,
        'references': message.references,
        'mode': message.mode.name,
        'sourceEmailId': message.sourceEmailId,
        'draftId': message.draftId,
        if (!message.security.isPlain) 'security': message.security.toJson(),
      },
    });
  }

  /// Null if [json] isn't a record (an older format, or damaged).
  static ComposeRecord? decode(String json) {
    try {
      final j = (jsonDecode(json) as Map).cast<String, Object?>();
      final m = (j['message']! as Map).cast<String, Object?>();
      List<EmailAddress> addresses(String key) => [
        for (final a in (m[key]! as List).cast<Map<String, Object?>>())
          EmailAddress(a['email']! as String, a['name'] as String?),
      ];
      DateTime? time(Object? ms) => ms is int ? DateTime.fromMillisecondsSinceEpoch(ms) : null;
      return ComposeRecord(
        session: j['session']! as String,
        savedAt: time(j['savedAt'])!,
        sendAt: time(j['sendAt']),
        attachmentsOmitted: (j['attachmentsOmitted'] as int?) ?? 0,
        message: OutgoingMessage(
          accountId: m['accountId']! as String,
          identityId: m['identityId']! as String,
          to: addresses('to'),
          cc: addresses('cc'),
          bcc: addresses('bcc'),
          subject: m['subject']! as String,
          text: m['text']! as String,
          html: m['html'] as String?,
          attachments: [
            for (final a in (m['attachments']! as List).cast<Map<String, Object?>>())
              OutgoingAttachment(
                filename: a['filename']! as String,
                mimeType: a['mimeType']! as String,
                data: base64Decode(a['data']! as String),
              ),
          ],
          inReplyTo: m['inReplyTo'] as String?,
          references: [for (final r in m['references']! as List) r! as String],
          mode: ComposeMode.values.byName(m['mode']! as String),
          sourceEmailId: m['sourceEmailId'] as String?,
          draftId: m['draftId'] as String?,
          security: OutgoingSecurity.fromJson((m['security'] as Map?)?.cast()),
        ),
      );
    } on Object {
      return null;
    }
  }
}

/// The one compose record, in SharedPreferences (`compose.recovery`), so
/// "Start Over" forgets it too. Attachment data is kept only up to
/// [maxAttachmentBytes]; bigger ones live in the autosaved draft.
class ComposeRecoveryStore {
  ComposeRecoveryStore(this._prefs);

  static const key = 'compose.recovery';
  static const maxAttachmentBytes = 1024 * 1024;

  final SharedPreferences _prefs;
  bool _offered = false;

  ComposeRecord? read() {
    final json = _prefs.getString(key);
    return json == null ? null : ComposeRecord.decode(json);
  }

  Future<void> write(ComposeRecord record) => _prefs.setString(key, record.encode());

  /// Forgets the record, only if [session] wrote it when given.
  Future<void> clear({String? session}) async {
    if (session != null && read()?.session != session) return;
    await _prefs.remove(key);
  }
}

final composeRecoveryProvider = Provider<ComposeRecoveryStore>(
  (ref) => ComposeRecoveryStore(ref.watch(sharedPreferencesProvider)),
);

/// The compose screens open right now, by session.
abstract final class ComposeSessions {
  static final _open = <String>{};
  static final _random = Random();

  static String newId() =>
      '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}-${_random.nextInt(1 << 32).toRadixString(36)}';

  static void opened(String session) => _open.add(session);
  static void closed(String session) => _open.remove(session);
  static bool isOpen(String session) => _open.contains(session);
}

enum _Recovery { resume, save, discard }

/// Once per launch: if a message was left unsent when Loupe closed (a crash,
/// or swiped away while writing), asks "Continue editing your draft?":
/// Continue Editing reopens it, Save to Drafts keeps it there, Discard
/// deletes it and its autosaved draft. Dismissing asks again next launch.
Future<void> offerComposeRecovery(BuildContext context, WidgetRef ref) async {
  final store = ref.read(composeRecoveryProvider);
  if (store._offered) return;
  final record = store.read();
  if (record == null || ComposeSessions.isOpen(record.session)) return;
  store._offered = true;
  final m = record.message;
  final subject = m.subject.trim();
  final to = m.to.isEmpty ? '' : ' to ${m.to.first.displayName}${m.to.length > 1 ? ' and others' : ''}';
  final choice = await showActionSheet<_Recovery>(
    context,
    title: 'Continue editing your draft?',
    message: '${subject.isEmpty ? 'A message' : '“$subject”'}$to wasn’t sent when Loupe closed.',
    actions: const [
      SheetAction('Continue Editing', _Recovery.resume, icon: LoupeIcons.edit, isDefault: true),
      SheetAction('Save to Drafts', _Recovery.save, icon: LoupeIcons.drafts),
      SheetAction('Discard', _Recovery.discard, icon: LoupeIcons.trash, destructive: true),
    ],
  );
  if (choice == null || !context.mounted) return;
  final repo = ref.read(repositoryProvider);
  final messenger = ScaffoldMessenger.of(context);
  try {
    switch (choice) {
      case _Recovery.resume:
        await context.push<void>(
          Routes.compose,
          extra: ComposeArgs.restore(
            m,
            sendAt: record.sendAt,
            recoverySession: record.session,
            attachmentsFromDraft: record.attachmentsOmitted > 0,
          ),
        );
      case _Recovery.save:
        await repo.saveDraft(m);
        await store.clear(session: record.session);
        showSnack(messenger, 'Saved to Drafts');
      case _Recovery.discard:
        if (m.draftId case final id?) {
          try {
            await repo.deleteDraft(id);
          } on MailException {
            // Gone already.
          }
        }
        await store.clear(session: record.session);
    }
  } on MailException catch (e) {
    showSnack(messenger, e.message);
  }
}
