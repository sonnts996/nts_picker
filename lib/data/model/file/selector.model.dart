
import 'package:path/path.dart' as path;

class Selector {
  const Selector({required this.extension, this.containsName, this.directory});

  final String? directory;
  final List<String> extension;
  final String? containsName;

  @override
  String toString() {
    return 'Contains $containsName and file type $extension';
  }

  bool match(String file) {
    if (extension.isEmpty) {
      return true;
    } else {
      var ext = path.extension(file);
      return extension.any((element) => ext == element);
    }
  }
}
