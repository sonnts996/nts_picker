import 'package:nts_picker/data/model/file/folder_item.model.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';
import 'package:nts_picker/data/model/file/selector.model.dart';

abstract class FileRepository {
  final List<MediaFile> mediaFiles = [];
  final List<Folder> mediaFolders = [];
  final List<MediaFile> selected = [];

  Future<void> loadData(Selector selector);

  Future<void> selectFile(MediaFile mediaFile, bool multiChoose);
}
