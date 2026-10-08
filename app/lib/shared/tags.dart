import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../l10n/l10n.dart';

/// Colour of a tag keyword; unknown tags get a neutral grey.
Color tagColor(String keyword, [List<TagDefinition> tags = TagDefinition.thunderbirdDefaults]) {
  for (final t in tags) {
    if (t.keyword == keyword) return Color(t.colorArgb);
  }
  return const Color(0xFF8E8E93);
}

/// Display label of a tag keyword: Thunderbird's default tags in the app's
/// language ([l10n], else the device's), others by their definition's label
/// or the keyword itself.
String tagLabel(
  String keyword, {
  List<TagDefinition> tags = TagDefinition.thunderbirdDefaults,
  AppLocalizations? l10n,
}) {
  if (identical(tags, TagDefinition.thunderbirdDefaults)) {
    final strings = l10n ?? deviceL10n();
    switch (keyword) {
      case Keywords.label1:
        return strings.sharedTagImportant;
      case Keywords.label2:
        return strings.sharedTagWork;
      case Keywords.label3:
        return strings.sharedTagPersonal;
      case Keywords.label4:
        return strings.sharedTagToDo;
      case Keywords.label5:
        return strings.sharedTagLater;
    }
  }
  return tagName(keyword, tags);
}

/// A tag keyword's name as its definition has it (English for Thunderbird's
/// defaults), for search syntax (`tag:work`); the keyword itself without one.
String tagName(String keyword, [List<TagDefinition> tags = TagDefinition.thunderbirdDefaults]) {
  for (final t in tags) {
    if (t.keyword == keyword) return t.label;
  }
  return keyword.startsWith(r'$') ? keyword.substring(1) : keyword;
}
