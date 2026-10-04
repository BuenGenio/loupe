import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

/// The app support directory, where the database, the sync leases and the
/// new-mail watermarks live. Background isolates use the same one.
final supportDirectoryProvider = FutureProvider<Directory>((ref) => getApplicationSupportDirectory());
