import 'dart:io';

class Folder {
  const Folder({required this.path, required this.name});

  factory Folder.all() {
    return const Folder(path: '/', name: 'All');
  }

  final String name;
  final String path;

  FileSystemEntity get fileSystemEntity => Directory(path);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Folder && other.path == path;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => path.hashCode;
}
