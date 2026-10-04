import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

import '../providers.dart';

/// "Sign in with Google" and "Sign in with Microsoft" for account setup, the
/// Thunderbird import and "Sign In Again". The client ids come from
/// `--dart-define` (docs/oauth-setup.md); without one, that provider's
/// button stays hidden. Tests override this with a fake browser.
final oauthSignInProvider = Provider<OAuthSignIn>((ref) => OAuthSignIn());

/// The repository's sign-in renewal: the live repository has one, the demo
/// mailbox doesn't.
SignInRenewal? signInRenewalOf(MailRepository repository) => switch (repository) {
  final SignInRenewal renewal => renewal,
  _ => null,
};

/// Ids of the accounts whose provider no longer accepts their sign-in.
final signInRequiredProvider = StreamProvider<Set<String>>(
  (ref) => signInRenewalOf(ref.watch(repositoryProvider))?.watchSignInRequired() ?? Stream.value(const <String>{}),
);
