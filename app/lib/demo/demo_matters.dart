import 'dart:convert';

import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import 'demo_data.dart';
import 'demo_private_ai.dart';

/// The demo's matter: Sam's purchase of 14 Quay Street, the storyline's
/// four conversations (adviser, solicitor, lender, removal firm), and two
/// messages that test the suggestions. A home insurance quote mentions the
/// address: a good candidate, with that as its reason. A note from the same
/// adviser about Sam's brother's application shares only the sender: shown
/// lower, saying a shared sender isn't evidence. The bookshop's order with
/// its invoice is not suggested at all, though the removals mail has an
/// invoice too.
abstract final class DemoMatters {
  static const quayStreet = 'demo-quay-street';
  static const quayStreetName = 'Buying 14 Quay Street';

  static const insurer = EmailAddress('quotes@brightsidehome.example', 'Brightside Home Insurance');

  /// Thread keys of the two candidates; `T-personal-<key>`.
  static const insuranceThread = 'insurance';
  static const referralThread = 'referral';
}

extension DemoMatterCases on DemoSeed {
  /// Adds the candidates to the personal inbox. Called after
  /// [DemoPrivateAiCases.privateAiCases], so no other demo id moves.
  void matterCases() {
    const a = DemoAccounts.personal;
    add(
      account: a,
      box: 'INBOX',
      at: at(2, 14, 5),
      from: DemoMatters.insurer,
      subject: 'Your buildings insurance quote',
      thread: DemoMatters.insuranceThread,
      text:
          'Hello Sam,\n\n'
          'Thank you for asking us for a quote for 14 Quay Street. Buildings and contents cover starts from £27.40 '
          'a month, with a £250 excess.\n\n'
          'Your lender will want buildings cover in place from the day you exchange contracts. Your quote reference '
          'is BHI-77310 and it is valid for 30 days.\n\n'
          'Brightside Home Insurance',
    );
    add(
      account: a,
      box: 'INBOX',
      at: at(9, 12, 15),
      from: DemoPrivateAi.adviser,
      subject: 'Thank you for the introduction',
      thread: DemoMatters.referralThread,
      text:
          'Hi Sam,\n\n'
          'Thank you for passing my details on to your brother Marcus. I will call him this week about his '
          'application for the flat on Elm Row. It is a separate case from yours, so I will keep the two apart.\n\n'
          'Rhea',
    );
  }

  /// "Buying 14 Quay Street", made just after the adviser's first message,
  /// each conversation added a few minutes after it began.
  List<Matter> seedMatters() {
    var matter = Matter.create(id: DemoMatters.quayStreet, name: DemoMatters.quayStreetName, at: at(6, 15, 30));
    for (final threadId in DemoPrivateAi.threadIds) {
      final first =
          (messages.where((m) => m.summary.threadId == threadId).toList()
                ..sort((x, y) => x.summary.receivedAt.compareTo(y.summary.receivedAt)))
              .first
              .summary;
      final addedAt = first.receivedAt.add(const Duration(minutes: 20));
      matter = matter.adding(
        MatterMember.of(first, at: addedAt.isBefore(matter.updatedAt) ? matter.updatedAt : addedAt),
        subject: first.subject,
      );
    }
    return [matter];
  }
}

final _greeting = RegExp(r'^(dear|hi|hello)\b[^.!?]*,?$', caseSensitive: false);
final _signOff = RegExp(
  r'^(kind regards|regards|best wishes|best|many thanks|thanks|thank you|cheers|yours sincerely|yours)[,!.]?$',
  caseSensitive: false,
);
final _secretWords = RegExp(
  r'\b(password|passcode|pin|otp|one-time code|login code|verification code|access code)\b',
  caseSensitive: false,
);
final _date = RegExp(
  r'\b\d{1,2} (January|February|March|April|May|June|July|August|September|October|November|December)\b',
);
final _money = RegExp(r'£\d|\d%');
final _progress = RegExp(
  r'\b(booked|confirm|due|pay|sign|send|arrived|submit|submitted|offer|deposit|valuation)\b',
  caseSensitive: false,
);
final _outstanding = RegExp(r'\bto go\b|\bstill need\b|\boutstanding\b', caseSensitive: false);

/// The built-in demo's answer to `matters.status` ([MatterStatusTask]): a few
/// rules instead of a model. For the newest message of each conversation,
/// then for the others, it takes the sentence that says the most about the
/// position (a date, an amount, a booking, a request, what is left to do),
/// quotes it exactly and says who wrote it, so the task's parser checks it
/// as it would a model's answer. Lines with sign-in details are never used.
String demoMatterStatus(AiRequest request, DateTime now) {
  final List<Map<String, Object?>> messages;
  try {
    final data = jsonDecode(request.input.split('\n').first) as Map<String, Object?>;
    messages = [for (final m in data['messages'] as List<Object?>) m! as Map<String, Object?>];
  } on Object {
    return jsonEncode({'statements': <Object?>[]});
  }
  const most = 5;
  final statements = <Map<String, Object?>>[];
  final conversations = <Object?>{};
  final used = <Object?>{};
  for (final newestOfEach in [true, false]) {
    for (final m in messages) {
      if (statements.length >= most) break;
      if (used.contains(m['id']) || (newestOfEach && conversations.contains(m['conversation']))) continue;
      conversations.add(m['conversation']);
      final sentence = _bestSentence((m['text'] as String?) ?? '');
      if (sentence == null) continue;
      used.add(m['id']);
      final who = m['from_me'] == true ? 'You' : _name((m['from'] as String?) ?? '');
      var text = '$who: $sentence';
      if (text.length > 200) {
        final cut = text.lastIndexOf(' ', 199);
        text = '${text.substring(0, cut > 0 ? cut : 199)}…';
      }
      statements.add({'text': text, 'message': m['id'], 'quote': sentence});
    }
  }
  return jsonEncode({'statements': statements});
}

String _name(String from) {
  final lt = from.indexOf('<');
  final name = (lt > 0 ? from.substring(0, lt) : from).replaceAll('"', '').trim();
  return name.isEmpty ? 'The sender' : name;
}

/// The sentence of [text] that says the most about where things stand, as
/// it is written there, or null when none says anything.
String? _bestSentence(String text) {
  String? best;
  var bestScore = 0;
  for (final raw in text.split('\n')) {
    final line = raw.trim();
    if (line.length < 20 || line.startsWith('>') || _greeting.hasMatch(line) || _signOff.hasMatch(line)) continue;
    if (_secretWords.hasMatch(line)) continue;
    for (var sentence in line.split(RegExp(r'(?<=[.!?])\s+'))) {
      sentence = sentence.replaceFirst(RegExp(r'^[-*•]\s+'), '').trim();
      if (sentence.length < 20) continue;
      var score = 0;
      if (_date.hasMatch(sentence)) score += 3;
      if (_money.hasMatch(sentence)) score += 2;
      if (_progress.hasMatch(sentence)) score += 2;
      if (_outstanding.hasMatch(sentence)) score += 3;
      if (sentence.toLowerCase().startsWith('please')) score += 1;
      if (score > bestScore) {
        best = sentence;
        bestScore = score;
      }
    }
  }
  return best;
}
