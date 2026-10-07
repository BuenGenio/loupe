/// Components (VCALENDAR, VEVENT, VTIMEZONE, …) as a tree of properties.
library;

import 'content_line.dart';

/// A component: `BEGIN:NAME` … `END:NAME`, with its properties and nested
/// components in order.
final class Component {
  Component(String name, {List<Property>? properties, List<Component>? components})
    : name = name.toUpperCase(),
      properties = properties ?? [],
      components = components ?? [];

  final String name;
  final List<Property> properties;
  final List<Component> components;

  /// The first property called [name], or null.
  Property? property(String name) {
    final n = name.toUpperCase();
    for (final p in properties) {
      if (p.name == n) return p;
    }
    return null;
  }

  /// Every property called [name].
  Iterable<Property> all(String name) {
    final n = name.toUpperCase();
    return properties.where((p) => p.name == n);
  }

  /// The nested components called [name].
  Iterable<Component> children(String name) {
    final n = name.toUpperCase();
    return components.where((c) => c.name == n);
  }

  /// The component as iCalendar text: CRLF line ends, folded at 75 octets.
  String toIcs() {
    final out = StringBuffer();
    _write(out);
    return out.toString();
  }

  void _write(StringBuffer out) {
    out.write('BEGIN:$name\r\n');
    for (final p in properties) {
      out
        ..write(foldLine(p.toLine()))
        ..write('\r\n');
    }
    for (final c in components) {
      c._write(out);
    }
    out.write('END:$name\r\n');
  }
}

/// Limits that keep hostile input cheap to parse.
abstract final class ParseLimits {
  /// Nesting depth of components.
  static const depth = 12;

  /// Components in one file.
  static const components = 5000;

  /// Properties in one file.
  static const properties = 50000;
}

/// Parses iCalendar text into its top-level components (usually one
/// VCALENDAR), leniently: lines that aren't content lines are skipped, an
/// END without its BEGIN is ignored, an END closes what is still open
/// inside it, and components left open at the end are closed. Properties
/// outside any component are dropped; a bare VEVENT (without VCALENDAR)
/// comes back as a top-level component.
List<Component> parseComponents(String text) {
  final roots = <Component>[];
  final stack = <Component>[];
  var components = 0;
  var properties = 0;
  for (final line in unfoldLines(text)) {
    final p = parseContentLine(line);
    if (p == null) continue;
    if (p.name == 'BEGIN') {
      final name = p.value.trim().toUpperCase();
      if (name.isEmpty || stack.length >= ParseLimits.depth || ++components > ParseLimits.components) {
        // Too deep or too many: stop here, keeping what was read.
        break;
      }
      final c = Component(name);
      (stack.isEmpty ? roots : stack.last.components).add(c);
      stack.add(c);
      continue;
    }
    if (p.name == 'END') {
      final name = p.value.trim().toUpperCase();
      final at = stack.lastIndexWhere((c) => c.name == name);
      if (at >= 0) stack.removeRange(at, stack.length);
      continue;
    }
    if (stack.isEmpty) continue;
    if (++properties > ParseLimits.properties) break;
    stack.last.properties.add(p);
  }
  return roots;
}
