import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';

import '../../settings/app_settings.dart';
import 'demo_ai_provider.dart';

/// The model behind Private AI, or null when it is off (Settings › Private
/// AI). Off means nothing asks a model for anything. Until a real provider
/// ships, on means the built-in demo translator: a few rules, no model, no
/// network; results say so.
final aiProviderProvider = Provider<AiProvider?>((ref) {
  if (!ref.watch(appSettingsProvider.select((s) => s.aiAssist))) return null;
  return DemoAiProvider();
});
