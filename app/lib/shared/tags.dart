import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

/// Colour of a tag keyword; unknown tags get a neutral grey.
Color tagColor(String keyword, [List<TagDefinition> tags = TagDefinition.thunderbirdDefaults]) {
  for (final t in tags) {
    if (t.keyword == keyword) return Color(t.colorArgb);
  }
  return const Color(0xFF8E8E93);
}

/// Display label of a tag keyword.
String tagLabel(String keyword, [List<TagDefinition> tags = TagDefinition.thunderbirdDefaults]) {
  for (final t in tags) {
    if (t.keyword == keyword) return t.label;
  }
  return keyword.startsWith(r'$') ? keyword.substring(1) : keyword;
}
