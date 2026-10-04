import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

import '../../../providers.dart';
import '../../../settings/app_mode.dart';
import '../../../settings/app_settings.dart';
import 'assessment.dart';
import 'sender_facts.dart';

/// One message's check: its summary and its loaded content (by identity, so
/// a reloaded body is checked again).
@immutable
final class SecurityKey {
  const SecurityKey(this.message, this.content);
  final EmailSummary message;
  final EmailContent content;

  @override
  bool operator ==(Object other) =>
      other is SecurityKey && other.message.id == message.id && identical(other.content, content);

  @override
  int get hashCode => Object.hash(message.id, identityHashCode(content));
}

/// The phishing check of a message, from local signals only. The badge, the
/// sheet and the body's gate share one computation.
final securityReportProvider = FutureProvider.autoDispose.family<SecurityReport, SecurityKey>((ref, key) async {
  final repo = ref.watch(repositoryProvider);
  final (analysis, facts) = await (analyzeContent(key.content), gatherSenderFacts(repo, key.message)).wait;
  return assessMessage(message: key.message, headers: key.content.headers, analysis: analysis, facts: facts);
});

/// "Open Links Directly": a tapped link that goes through a known click
/// tracker opens its destination. On by default. Persisted as
/// `settings.openLinksDirectly`.
final openLinksDirectlyProvider = NotifierProvider<OpenLinksDirectlyController, bool>(OpenLinksDirectlyController.new);

class OpenLinksDirectlyController extends Notifier<bool> {
  static const key = 'settings.openLinksDirectly';

  @override
  bool build() {
    ref.watch(prefsEpochProvider);
    return ref.watch(sharedPreferencesProvider).getBool(key) ?? true;
  }

  Future<void> set(bool value) async {
    state = value;
    await ref.read(sharedPreferencesProvider).setBool(key, value);
  }
}
