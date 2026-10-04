import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/notifications/new_mail.dart';
import 'package:mail_model/mail_model.dart';

import 'fakes.dart';

final t0 = DateTime(2026, 10, 4, 9);

DateTime at(int minutes) => t0.add(Duration(minutes: minutes));

void main() {
  late FakeMail mail;
  late NewMailState state;

  /// One check at [minutes] past [t0]; returns the subjects found.
  Future<List<String>> check(int minutes) async {
    final d = await detectNewMail(mail, state, now: at(minutes));
    state = d.state;
    return [for (final m in d.mail) m.email.subject];
  }

  setUp(() {
    mail = FakeMail()..account('work');
    state = const NewMailState();
  });

  test('the first check of an inbox only remembers where it stands', () async {
    mail
      ..deliver('work', at(-60), subject: 'Old')
      ..deliver('work', at(-5), subject: 'Recent');
    expect(await check(0), isEmpty, reason: 'the first sync of a new account never notifies');
    mail.deliver('work', at(10), subject: 'New');
    expect(await check(15), ['New']);
    expect(await check(30), isEmpty, reason: 'notified once');
  });

  test('an account added later stays quiet on its first sync, then notifies', () async {
    mail.deliver('work', at(1), subject: 'Work 1');
    await check(0);
    mail.account('home');
    for (var i = 0; i < 5; i++) {
      mail.deliver('home', at(-i * 60), subject: 'Home old $i');
    }
    mail.deliver('work', at(10), subject: 'Work 2');
    expect(await check(15), ['Work 2']);
    mail.deliver('home', at(20), subject: 'Home new');
    expect(await check(30), ['Home new']);
  });

  test('an inbox that was empty on its first check starts from that moment', () async {
    expect(await check(0), isEmpty);
    // The initial sync lands after the first check: all of it is older.
    mail
      ..deliver('work', at(-30), subject: 'Synced late')
      ..deliver('work', at(5), subject: 'Arrived after');
    expect(await check(15), ['Arrived after']);
  });

  test('read mail, drafts, junk and mail from me never notify', () async {
    await check(0);
    mail
      ..deliver('work', at(1), subject: 'Read elsewhere', keywords: {Keywords.seen})
      ..deliver('work', at(2), subject: 'Draft', keywords: {Keywords.draft})
      ..deliver('work', at(3), subject: 'Spam', keywords: {Keywords.junk})
      ..deliver('work', at(4), subject: 'To myself', from: 'work@example.com')
      ..deliver('work', at(5), subject: 'Real');
    expect(await check(15), ['Real']);
  });

  test('older mail turning up later stays quiet', () async {
    mail.deliver('work', at(-300), subject: 'Newest at the first check');
    await check(0);
    // Loaded by scrolling, or moved back into the inbox: dated before the
    // watermark.
    mail.deliver('work', at(-500), subject: 'Moved back');
    // After the watermark, but long before the previous check: synced late
    // from a folder, or imported with its old date.
    mail.deliver('work', at(-200), subject: 'Imported');
    expect(await check(15), isEmpty);
  });

  test('mail that arrived just before the previous check still counts once', () async {
    mail.deliver('work', at(-10), subject: 'Known');
    await check(0);
    // The server took it at 9:58, but the 10:00 check synced before that.
    mail.deliver('work', at(-2), subject: 'Late');
    expect(await check(15), ['Late']);
    expect(await check(30), isEmpty);
  });

  test('messages sharing the newest timestamp are told apart', () async {
    mail.deliver('work', at(-1), subject: 'First');
    await check(0);
    mail.deliver('work', at(-1), subject: 'Same second');
    expect(await check(15), ['Same second']);
  });

  test('VIP mail notifies from any folder, but not from Junk', () async {
    mail.vips.add('boss@example.com');
    mail.deliver('work', at(-30), path: 'Lists', from: 'boss@example.com', subject: 'Filed before');
    await check(0);
    mail
      ..deliver('work', at(5), path: 'Lists', from: 'boss@example.com', subject: 'Filed by a rule')
      ..deliver('work', at(6), path: 'Lists', from: 'list@example.com', subject: 'Not a VIP')
      ..deliver('work', at(7), path: 'Junk', from: 'boss@example.com', subject: 'Caught')
      ..deliver('work', at(8), from: 'boss@example.com', subject: 'In the inbox');
    final d = await detectNewMail(mail, state, now: at(15));
    expect({for (final m in d.mail) m.email.subject: m.fromVip}, {'Filed by a rule': true, 'In the inbox': true});
  });

  test('a sender who becomes a VIP doesn’t notify again for inbox mail', () async {
    await check(0);
    mail.deliver('work', at(5), from: 'bob@example.com', subject: 'From Bob');
    expect(await check(10), ['From Bob']);
    mail.vips.add('bob@example.com');
    expect(await check(12), isEmpty);
  });

  test('looks only at the newest messages of each list', () async {
    await check(0);
    for (var i = 1; i <= 8; i++) {
      mail.deliver('work', at(i), subject: 'M$i');
    }
    final d = await detectNewMail(mail, state, now: at(15), depth: 3);
    expect([for (final m in d.mail) m.email.subject], ['M6', 'M7', 'M8'], reason: 'oldest first');
  });

  test('the state survives a round trip through its file', () async {
    final dir = Directory.systemTemp.createTempSync('new_mail_test');
    addTearDown(() => dir.deleteSync(recursive: true));
    final store = FileNewMailStateStore(Future.value(dir));
    expect((await store.read()).marks, isEmpty, reason: 'no file yet');

    mail.vips.add('boss@example.com');
    mail
      ..deliver('work', at(-1), subject: 'A')
      ..deliver('work', at(-1), subject: 'B')
      ..deliver('work', at(-5), path: 'Lists', from: 'boss@example.com');
    await check(0);
    await store.write(state);
    final read = await store.read();
    expect(read.lastCheck, at(0));
    expect(read.marks.keys, unorderedEquals([mail.box('work', 'INBOX'), NewMailState.vipKey]));
    expect(read.marks[mail.box('work', 'INBOX')]!.newest, at(-1));
    expect(read.marks[mail.box('work', 'INBOX')]!.idsAtNewest, hasLength(2));

    File('${dir.path}/new_mail.json').writeAsStringSync('{not json');
    expect((await store.read()).marks, isEmpty, reason: 'a damaged file starts over quietly');
  });
}
