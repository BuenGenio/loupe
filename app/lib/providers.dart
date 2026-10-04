import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

/// The active repository: demo data or real accounts. Every screen reads mail
/// only through this. Overridden at startup and in tests.
final repositoryProvider = Provider<MailRepository>(
  (ref) => throw UnimplementedError('repositoryProvider must be overridden'),
);
