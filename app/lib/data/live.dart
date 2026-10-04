import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

/// Builds the real repository (mail_sync's LiveMailRepository with the store,
/// the IMAP transport factory and the platform credential store).
///
/// Not wired yet: the app only offers demo mail until this is implemented.
Future<MailRepository> createLiveRepository(Ref ref) async =>
    throw UnimplementedError('Live accounts are not wired up yet.');
