import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart';

import '../../data/oauth.dart';
import '../../providers.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart' show showSnack;
import 'oauth_accounts.dart';
import 'server_settings.dart' show NoteCard;

/// Whether "Sign In Again" can be offered for [account]: it signs in with
/// OAuth, this build has the provider's client id, and the repository can
/// take new credentials.
bool canSignInAgain(WidgetRef ref, MailAccount account) =>
    account.authKind == AuthKind.oauth2 &&
    ref.read(oauthSignInProvider).isConfigured(account.provider) &&
    signInRenewalOf(ref.read(repositoryProvider)) != null;

/// Signs [account] in again with its provider in the browser and hands the
/// new tokens to the repository, which checks them against the server
/// first. Says how it went in a snack bar; returns whether it worked.
Future<bool> signInAgain(BuildContext context, WidgetRef ref, MailAccount account) async {
  final messenger = ScaffoldMessenger.of(context);
  final renewal = signInRenewalOf(ref.read(repositoryProvider));
  final oauth = ref.read(oauthSignInProvider);
  if (renewal == null || !oauth.isConfigured(account.provider)) {
    showSnack(messenger, 'Sign-in with ${oauthProviderName(account.provider)} isn’t available in this version.');
    return false;
  }
  try {
    final credentials = await oauth.signIn(account.provider, loginHint: account.email);
    await renewal.renewSignIn(account.id, credentials);
    showSnack(messenger, 'Signed in again. ${account.displayName} is syncing.');
    return true;
  } on MailException catch (e) {
    final cancelled = e is OAuthSignInException && e.failure == OAuthFailure.cancelled;
    if (!cancelled) {
      showSnack(messenger, describeOAuthError(e, account.provider), duration: const Duration(seconds: 8));
    }
    return false;
  }
}

/// At the top of Mailboxes: one card per account whose provider no longer
/// accepts its sign-in, with "Sign In Again". Nothing otherwise.
class SignInBanner extends ConsumerStatefulWidget {
  const SignInBanner({super.key});

  @override
  ConsumerState<SignInBanner> createState() => _SignInBannerState();
}

class _SignInBannerState extends ConsumerState<SignInBanner> {
  /// The account being signed in, while the browser is open.
  String? _busy;

  @override
  Widget build(BuildContext context) {
    final required = ref.watch(signInRequiredProvider).value ?? const <String>{};
    if (required.isEmpty) return const SizedBox.shrink();
    final accounts = [
      for (final a in ref.watch(accountsProvider).value ?? const <MailAccount>[])
        if (required.contains(a.id)) a,
    ];
    final colors = LoupeColors.of(context);
    return Column(
      children: [
        for (final a in accounts)
          NoteCard(
            key: ValueKey('sign-in-banner-${a.id}'),
            icon: LoupeIcons.warning,
            color: colors.flag,
            actions: [
              if (canSignInAgain(ref, a))
                TextButton(
                  key: ValueKey('sign-in-again-${a.id}'),
                  onPressed: _busy != null
                      ? null
                      : () async {
                          setState(() => _busy = a.id);
                          await signInAgain(context, ref, a);
                          if (mounted) setState(() => _busy = null);
                        },
                  child: Text(_busy == a.id ? 'Signing In…' : 'Sign In Again'),
                ),
            ],
            child: Text(
              '${oauthProviderName(a.provider)} no longer accepts Loupe’s sign-in for ${a.email}, so '
              '${a.displayName} isn’t syncing. Sign in again to get its mail.',
            ),
          ),
      ],
    );
  }
}
