import 'dart:io';

import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/domain/file/file_repository.dart';
import 'package:nts_picker/native_module/android_load_file.dart';

class FileRepositoryV1 extends FileRepository {
  @override
  Future<List<String>> getListFile(Selector selector) async {
    if (selector.directory != null) {
      return getListFileInFolder(Directory(selector.directory!), selector);
    } else {
      return getListFileInFolder(null, selector);
    }
  }

  Future<List<String>> getListFileInFolder(
      Directory? dir, Selector selector) async {
    var files = await AndroidLoadFile.getListFile(dir?.path, MediaType.all);
    return files.where((element) => selector.match(element)).toList();

  }
}
