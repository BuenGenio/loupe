// No new hard-coded English in lib/: the app's text comes from
// lib/l10n/app_<lang>.arb (docs/localisation.md). Files whose strings haven't
// moved there yet are listed in `pending`, and that list only shrinks.
//
// It catches the usual places (a widget's text, a named argument that labels
// something, a snack bar), not every string: moving a file means moving all
// of its user-visible text, whether this test sees it or not.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Files with English still in the code, grouped like app_en.arb's sections.
/// Take a file off once its strings are in app_en.arb.
const pending = <String>{
  // Reading

  // Security
  'lib/features/app_lock/app_lock.dart',
  'lib/features/openpgp/address_settings_screens.dart',
  'lib/features/openpgp/compose_security.dart',
  'lib/features/openpgp/encryption_settings_screen.dart',
  'lib/features/openpgp/key_import.dart',
  'lib/features/openpgp/passphrase_dialog.dart',
  'lib/features/openpgp/pgp_status.dart',
  'lib/features/smime/smime_import.dart',
  'lib/features/smime/smime_passphrase.dart',
  'lib/features/smime/smime_settings.dart',
  'lib/features/smime/smime_status.dart',

  // Settings

  // Accounts and writing
  'lib/features/account_import/account_import_screen.dart',
  'lib/features/account_setup/account_setup_screen.dart',
  'lib/features/account_setup/server_settings.dart',
  'lib/features/account_setup/sign_in_again.dart',
  'lib/features/compose/compose_recovery.dart',
  'lib/features/compose/compose_screen.dart',
  'lib/features/compose/send_later.dart',
  'lib/features/outbox/outbox_screen.dart',
  'lib/platform/error_log.dart',
};

/// A literal that starts like a word (`'Archive'`, `"Don't"`) where
/// user-visible text goes.
final _uiString = RegExp(
  r'''(?:\b(?:Text|SelectableText|Tooltip)\(\s*'''
  r'''|\b(?:label|labelText|hintText|helperText|errorText|tooltip|semanticLabel|semanticsLabel|title|subtitle'''
  r'''|message|text|placeholder|description|header|footer|caption|actionLabel|confirmLabel)\s*:\s*'''
  r'''|\bshowSnack\([^,()]+,\s*)['"][A-Z][a-z]''',
);

/// The hard-coded strings in [source], as `line: code`. A line marked
/// `l10n-ignore` (a name, a protocol), or after a `// l10n-ignore` line,
/// doesn't count.
List<String> hardCoded(String source) {
  final lines = source.split('\n');
  final starts = [0];
  for (var i = 0; i < source.length; i++) {
    if (source.codeUnitAt(i) == 0x0a) starts.add(i + 1);
  }
  final found = <String>[];
  for (final m in _uiString.allMatches(source)) {
    var line = starts.lastIndexWhere((s) => s <= m.end - 1);
    if (lines[line].contains('l10n-ignore')) continue;
    if (line > 0 && lines[line - 1].trimLeft().startsWith('// l10n-ignore')) continue;
    found.add('${line + 1}: ${lines[line].trim()}');
  }
  return found;
}

/// lib/ without what isn't the app's own text: the generated strings, and the
/// demo mailbox (its mail is content, like a real mailbox's).
Map<String, String> _sources() => {
  for (final f in Directory('lib').listSync(recursive: true).whereType<File>())
    if (f.path.endsWith('.dart'))
      if (f.path.replaceAll(r'\', '/') case final path
          when !path.startsWith('lib/l10n/') && !path.startsWith('lib/demo/'))
        path: f.readAsStringSync(),
};

void main() {
  test('only pending files have hard-coded strings', () {
    final offenders = <String, List<String>>{
      for (final MapEntry(key: path, value: source) in _sources().entries)
        if (!pending.contains(path))
          if (hardCoded(source) case final found when found.isNotEmpty) path: found,
    };
    expect(
      offenders,
      isEmpty,
      reason:
          'Move these strings to lib/l10n/app_en.arb (docs/localisation.md), '
          'or mark a name with // l10n-ignore:\n'
          '${[for (final MapEntry(:key, :value) in offenders.entries) '$key\n  ${value.join('\n  ')}'].join('\n')}',
    );
  });

  test('pending files still have hard-coded strings', () {
    final sources = _sources();
    final done = [
      for (final path in pending)
        if (sources[path] == null || hardCoded(sources[path]!).isEmpty) path,
    ];
    expect(done, isEmpty, reason: 'Take these off `pending` in this test: they are done, or gone.');
  });

  group('hardCoded', () {
    test('finds text in widgets, labels and snack bars', () {
      expect(hardCoded("Text('Archive')"), hasLength(1));
      expect(hardCoded("const Text(\n  'Try Again',\n)"), ['2: \'Try Again\',']);
      expect(hardCoded('Text("Don\'t")'), hasLength(1));
      expect(hardCoded("ListTile(title: Text(x), subtitle: 'Signed by Alice')"), hasLength(1));
      expect(hardCoded("InputDecoration(labelText: 'Password')"), hasLength(1));
      expect(hardCoded("showSnack(messenger, 'Saved')"), hasLength(1));
    });

    test('leaves strings from l10n, interpolations, acronyms and ignored lines', () {
      expect(hardCoded('Text(l10n.commonCancel)'), isEmpty);
      expect(hardCoded(r"Text('$name <$email>')"), isEmpty);
      expect(hardCoded("Text('IMAP')"), isEmpty);
      expect(hardCoded("Text('Loupe') // l10n-ignore: the name"), isEmpty);
      expect(hardCoded("// l10n-ignore: the provider's name\nText('Gmail')"), isEmpty);
      expect(hardCoded("Key('Archive')"), isEmpty);
    });
  });
}
