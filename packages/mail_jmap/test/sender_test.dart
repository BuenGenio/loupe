import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:mail_jmap/mail_jmap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/scripted_jmap.dart';

final _message = Uint8List.fromList(utf8.encode('From: alice@example.test\r\nSubject: Hi\r\n\r\nHello\r\n'));

ScriptedJmap _server(List<Object? Function(Json args)> submissions, {List<Json>? identities}) {
  final jmap = ScriptedJmap()
    ..on('Identity/get', (_) => identities == null ? recordedArgs('identity_get') : {'list': identities})
    ..on('Mailbox/get', (_) => recordedArgs('mailbox_get'))
    ..on(
      'Email/import',
      (args) => {
        'created': {
          'm': {'id': 'e1', 'blobId': 'b', 'threadId': 't', 'size': 40},
        },
      },
    )
    ..on('Email/set', (args) => {'destroyed': args['destroy']});
  for (final s in submissions) {
    jmap.on('EmailSubmission/set', s);
  }
  return jmap;
}

JmapSender _sender(ScriptedJmap jmap) => JmapSender(scriptedAccount(), passwordCallback(), httpClient: jmap.client);

/// A successful submission, with the implicit Email/set of onSuccess….
Object? Function(Json) _ok({bool update = true}) =>
    (args) => [
      [
        'EmailSubmission/set',
        {
          'created': {
            's': {'id': 'sub1', 'undoStatus': 'pending'},
          },
        },
      ],
      [
        'Email/set',
        update
            ? {
                'updated': {'e1': null},
              }
            : {
                'destroyed': ['e1'],
              },
      ],
    ];

void main() {
  test('submits from Drafts and files the copy in Sent, seen and no longer a draft', () async {
    final jmap = _server([_ok()]);
    final receipt = await _sender(jmap).send(
      _message,
      envelopeFrom: 'alice@example.test',
      recipients: ['bob@example.test', ' bob@example.test '],
      fileInSent: true,
    );
    expect(receipt.filed, isTrue);
    expect(receipt.refused, isEmpty);
    final import = (jmap.callsOf('Email/import').single['emails']! as Map)['m'] as Map;
    expect(import['mailboxIds'], {'d': true});
    expect(import['keywords'], {Keywords.seen: true, Keywords.draft: true});
    expect(jmap.blobs[import['blobId']], _message);
    final submission = jmap.callsOf('EmailSubmission/set').single;
    expect(submission['create'], {
      's': {
        'identityId': 'b',
        'emailId': 'e1',
        'envelope': {
          'mailFrom': {'email': 'alice@example.test'},
          'rcptTo': [
            {'email': 'bob@example.test'},
          ],
        },
      },
    });
    expect(submission['onSuccessUpdateEmail'], {
      '#s': {r'mailboxIds/d': null, r'mailboxIds/e': true, r'keywords/$draft': null, r'keywords/$seen': true},
    });
    final request = jmap.requests.lastWhere((r) => r.url.path == '/jmap/');
    expect((jsonDecode((request as http.Request).body) as Map)['using'], contains(JmapCapabilities.submission));
  });

  test('a copy that isn’t filed is destroyed once sent', () async {
    final jmap = _server([_ok(update: false)]);
    final receipt = await _sender(jmap)
        .send(_message, envelopeFrom: 'alice@example.test', recipients: ['x@example.org']);
    expect(receipt.filed, isFalse);
    expect(jmap.callsOf('EmailSubmission/set').single['onSuccessDestroyEmail'], ['#s']);
  });

  test('recipients the server refuses stay behind; the others get the message', () async {
    final jmap = _server([
      (args) => {
        'notCreated': {
          's': {
            'type': 'invalidRecipients',
            'invalidRecipients': ['nobody@example.org'],
          },
        },
      },
      _ok(),
    ]);
    final receipt = await _sender(jmap).send(
      _message,
      envelopeFrom: 'alice@example.test',
      recipients: ['bob@example.test', 'nobody@example.org'],
      fileInSent: true,
    );
    expect(receipt.refused.keys, ['nobody@example.org']);
    expect(receipt.refused.values.single, isA<PermanentMailException>());
    expect(receipt.filed, isTrue);
    final second = jmap.callsOf('EmailSubmission/set').last;
    expect(((second['create']! as Map)['s'] as Map)['envelope'], {
      'mailFrom': {'email': 'alice@example.test'},
      'rcptTo': [
        {'email': 'bob@example.test'},
      ],
    });
  });

  test('a refusal for good fails permanently and removes the imported copy', () async {
    final jmap = _server([
      (args) => {
        'notCreated': {
          's': {'type': 'forbiddenFrom', 'description': 'Not your address'},
        },
      },
    ]);
    await expectLater(
      _sender(jmap).send(_message, envelopeFrom: 'boss@example.test', recipients: ['bob@example.test']),
      throwsA(isA<PermanentMailException>()),
    );
    expect(jmap.callsOf('Email/set').single['destroy'], ['e1']);
  });

  test('a temporary refusal is retried later, not held', () async {
    final jmap = _server([
      (args) => {
        'notCreated': {
          's': {'type': 'rateLimit'},
        },
      },
    ]);
    await expectLater(
      _sender(jmap).send(_message, envelopeFrom: 'alice@example.test', recipients: ['bob@example.test']),
      throwsA(isA<MailException>().having((e) => e is PermanentMailException, 'permanent', isFalse)),
    );
  });

  test('a message without recipients never reaches the server', () async {
    final jmap = _server([]);
    await expectLater(
      _sender(jmap).send(_message, envelopeFrom: 'alice@example.test', recipients: [' ']),
      throwsA(isA<PermanentMailException>()),
    );
    expect(jmap.requests, isEmpty);
  });

  test('identities: the address, else a wildcard for its domain, else the first', () {
    final ids = <Json>[
      {'id': '1', 'email': 'alice@example.test'},
      {'id': '2', 'email': '*@shop.example'},
      {'id': '3', 'email': 'Bob@Example.test'},
    ];
    expect(identityFor(ids, 'bob@example.test')?['id'], '3');
    expect(identityFor(ids, 'orders@shop.example')?['id'], '2');
    expect(identityFor(ids, 'other@else.example')?['id'], '1');
    expect(identityFor(const [], 'a@b.c'), isNull);
  });
}
