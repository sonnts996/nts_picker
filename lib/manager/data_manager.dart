/*
 Created by Thanh Son on 06/01/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:nts_picker/data/model/file/folder_item.model.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';
import 'package:rxdart/rxdart.dart';

class DataManager {
  final BehaviorSubject<List<Folder>> _folders = BehaviorSubject.seeded([]);
  final BehaviorSubject<List<MediaFile>> _mediaFiles =
      BehaviorSubject.seeded([]);

  static DataManager? _inst;

  static DataManager get instance {
    _inst ??= DataManager();
    return _inst!;
  }

  Stream<List<Folder>> get folderStream => _folders.stream.asBroadcastStream();

  List<Folder> get folders => _folders.valueOrNull ?? [];

  set folders(List<Folder> folders) => _folders.add(folders);

  Stream<List<MediaFile>> get mediaFileStream =>
      _mediaFiles.stream.asBroadcastStream();

  List<MediaFile> get mediaFiles => _mediaFiles.valueOrNull ?? [];

  set mediaFiles(List<MediaFile> mediaFiles) => _mediaFiles.add(mediaFiles);
}
