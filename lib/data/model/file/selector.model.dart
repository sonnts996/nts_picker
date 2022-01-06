import 'package:path/path.dart' as path;

import 'media_type.dart';

class Selector {
  const Selector(
      {this.mediaType = MediaType.all,
      this.extension = const [],
      this.directory});

  final String? directory;
  final List<String> extension;
  final MediaType mediaType;

  bool match(String file) {
    if (extension.isEmpty) {
      return true;
    } else {
      var ext = path.extension(file).toLowerCase();
      return extension.any((element) => ext == element.toLowerCase());
    }
  }
}
