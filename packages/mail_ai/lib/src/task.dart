import 'dart:convert';

import 'provider.dart';

/// A routing hint. Real limits are the provider's ([ProviderCapabilities]).
enum TaskSize { short, long }

/// What a task made of the model's text.
sealed class TaskParse<T> {
  const TaskParse();
}

final class Parsed<T> extends TaskParse<T> {
  const Parsed(this.value);
  final T value;
}

/// The reason is sent back to the model once, in the repair attempt, so it
/// should say what was wrong in a sentence the model can act on.
final class Rejected<T> extends TaskParse<T> {
  const Rejected(this.reason);
  final String reason;
}

/// One thing a feature asks a model for. A task is the whole contract: the
/// instructions, the bounded input, the schema and the parser that decides
/// whether the answer is usable. Features never see raw model text.
abstract base class AiTask<T> {
  const AiTask();

  /// Stable id, e.g. `search.translate`; part of every run record.
  String get type;

  /// Bumped when [instructions] or the schema change, so cached results
  /// from an older prompt are not reused.
  int get version;
  TaskSize get size;
  String get instructions;

  /// The data, already bounded and already marked as data (JSON-encoded,
  /// fenced, or otherwise set apart from the instructions).
  String get input;
  Map<String, Object?>? get schema => null;
  int get maxOutputTokens;

  /// Turns the model's text into a value, or says why it can't. Parsing is
  /// where a feature checks structure, limits and evidence; a valid shape is
  /// not proof of a correct answer.
  TaskParse<T> parse(String raw);

  AiRequest toRequest() => AiRequest(
    taskType: type,
    instructions: instructions,
    input: input,
    maxOutputTokens: maxOutputTokens,
    schema: schema,
  );
}

/// Removes a Markdown code fence around [raw], which some models add even
/// when told not to. Anything else is returned trimmed.
String unfence(String raw) {
  final text = raw.trim();
  final match = RegExp(r'^```[a-zA-Z]*\s*\n([\s\S]*?)\n?```$').firstMatch(text);
  return (match?.group(1) ?? text).trim();
}

/// Decodes [raw] as one JSON object, for tasks that ask for JSON.
TaskParse<Map<String, Object?>> parseJsonObject(String raw) {
  final text = unfence(raw);
  if (text.isEmpty) return const Rejected('The answer was empty; answer with the JSON object described.');
  final Object? decoded;
  try {
    decoded = jsonDecode(text);
  } on FormatException catch (e) {
    return Rejected('The answer is not valid JSON (${e.message}); answer with only the JSON object described.');
  }
  if (decoded is! Map<String, Object?>) {
    return const Rejected('The answer must be a JSON object, not a list or a value.');
  }
  return Parsed(decoded);
}
