import 'package:mail_model/mail_model.dart';

/// The words of a mail search that a search in documents can use: its
/// plain text terms, in order. Null when it has none (only operators, such
/// as `from:dana is:unread`), so Search in Documents isn't offered.
String? documentWords(List<SearchExpr> terms) {
  final words = [
    for (final t in terms)
      if (t case TextTerm(field: SearchField.any, :final value) when value.trim().isNotEmpty) value.trim(),
  ];
  return words.isEmpty ? null : words.join(' ');
}
