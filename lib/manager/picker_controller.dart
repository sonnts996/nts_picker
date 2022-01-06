/*
 Created by Thanh Son on 27/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'dart:async';
import 'dart:core';

import 'package:nts_picker/data/model/file/folder_item.model.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';
import 'package:rxdart/rxdart.dart';

class NTSPickerController {
  NTSPickerController({
    List<MediaFile> selected = const [],
  }) {
    _selected.add(selected);
  }

  final BehaviorSubject<Folder> _currentFolder = BehaviorSubject();
  final BehaviorSubject<List<MediaFile>> _selected = BehaviorSubject.seeded([]);

  void close() {
    _currentFolder.close();
    _selected.close();
  }

  Stream<Folder> get currentFolderStream =>
      _currentFolder.stream.asBroadcastStream();

  set currentFolder(Folder folder) => _currentFolder.add(folder);

  Folder get currentFolder => _currentFolder.valueOrNull ?? Folder.all();

  Stream<List<MediaFile>> get selectedStream =>
      _selected.stream.asBroadcastStream();

  set selected(List<MediaFile> selected) => _selected.add(selected);

  List<MediaFile> get selected => _selected.valueOrNull ?? [];
}
