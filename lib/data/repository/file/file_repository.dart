import 'dart:async';
import 'dart:io';

import 'package:nts_picker/data/model/file/folder_item.model.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';
import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/domain/file/file_repository.dart';
import 'package:nts_picker/native_module/native_get_files.dart';
import 'package:path/path.dart' as path;

class FileRepositoryV1 extends FileRepository {
  @override
  Future<void> loadData(Selector selector) async {
    if (mediaFiles.isEmpty) {
      var listFile = await _getListFileInFolder(
          selector.directory != null ? Directory(selector.directory!) : null,
          selector);

      mediaFiles
        ..clear()
        ..addAll(listFile);
      mediaFolders
        ..clear()
        ..addAll(_getFolder(listFile));
    }
  }

  Future<List<MediaFile>> _getListFileInFolder(
      Directory? dir, Selector selector) async {
    var files = await NativeGetFiles.getListFile(dir?.path, selector.mediaType);
    return files.where((element) => selector.match(element.path)).toList();
  }

  List<Folder> _getFolder(List<MediaFile> files) {
    var temp = [Folder.all()];
    for (var e in files) {
      var dir = path.dirname(e.path);
      if (!temp.any((element) => element.path == dir)) {
        var name = path.basename(dir);
        temp.add(Folder(path: dir, name: name));
      }
    }
    return temp;
  }

  @override
  Future<void> selectFile(MediaFile mediaFile, bool multiChoose) async {
    if (multiChoose) {
      if (selected.contains(mediaFile)) {
        selected.remove(mediaFile);
      } else {
        selected.add(mediaFile);
      }
    } else {
      selected.clear();
      selected.add(mediaFile);
    }
    _refreshList();
  }

  void _refreshList() {
    var temp = mediaFiles
        .map((e) => selected.contains(e) ? e.select() : e.unselect())
        .toList();
    mediaFiles.clear();
    mediaFiles.addAll(temp);
  }
}
