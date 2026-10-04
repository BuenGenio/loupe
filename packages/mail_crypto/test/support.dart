import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';

const pgp = DartPgBackend();

Uint8List fixture(String path) => File('test/fixtures/$path').readAsBytesSync();

String fixtureText(String path) => utf8.decode(fixture(path));

PgpKey key(String path) => pgp.readKeys(fixture(path)).single;

/// Thunderbird's test keys (comm-central mail/test/browser/openpgp/data/keys).
PgpKey tbKey(String name) => key('thunderbird/keys/$name');

final aliceSecret = tbKey('alice@openpgp.example-0xf231550c4f47e38e-secret.asc');
final alicePublic = tbKey('alice@openpgp.example-0xf231550c4f47e38e-pub.asc');
final bobSecret = tbKey('bob@openpgp.example-0xfbfcc82a015e7330-secret.asc');
final bobPublic = tbKey('bob@openpgp.example-0xfbfcc82a015e7330-pub.asc');
final carolPublic = tbKey('carol@example.com-0x3099ff1238852b9f-pub.asc');

/// A Thunderbird test message.
Uint8List tbMail(String name) => fixture('thunderbird/eml/$name');

Uint8List bytes(String s) => Uint8List.fromList(utf8.encode(s));

/// Runs gpg in a throwaway home under .dart_tool (never the user's keyring);
/// null when gpg isn't installed.
final class Gpg {
  Gpg._(this.home);

  final Directory home;

  static Gpg? create() {
    try {
      if (Process.runSync('gpg', ['--version']).exitCode != 0) return null;
    } on ProcessException {
      return null;
    }
    final base = Directory('.dart_tool/gpg-test')..createSync(recursive: true);
    final home = base.createTempSync('home-');
    Process.runSync('chmod', ['700', home.path]);
    return Gpg._(home);
  }

  ProcessResult run(List<String> args, {List<int>? stdin}) {
    final env = {'GNUPGHOME': home.path};
    if (stdin == null) {
      return Process.runSync('gpg', ['--batch', '--yes', ...args], environment: env, stdoutEncoding: null);
    }
    final dir = home.createTempSync('in-');
    final input = File('${dir.path}/input')..writeAsBytesSync(stdin);
    return Process.runSync('gpg', ['--batch', '--yes', ...args, input.path], environment: env, stdoutEncoding: null);
  }

  void import(String armored) => run(['--import'], stdin: utf8.encode(armored));

  void dispose() {
    Process.runSync('gpgconf', ['--kill', 'all'], environment: {'GNUPGHOME': home.path});
    home.deleteSync(recursive: true);
  }
}
