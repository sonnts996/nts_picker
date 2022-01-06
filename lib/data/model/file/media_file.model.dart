/*
 Created by Thanh Son on 28/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'dart:io';

import 'package:nts_picker/data/model/file/folder_item.model.dart';
import 'package:path/path.dart' as p;

import 'media_type.dart';

class MediaFile {
  const MediaFile(this.path,
      {this.mediaType = MediaType.all, this.selected = false});

  factory MediaFile.formJson(Map<String, dynamic> json) {
    return MediaFile(json['path'] ?? '',
        mediaType: MediaTypeX.fromJson(json['mediaType']));
  }

  final String path;
  final MediaType mediaType;
  final bool selected;

  MediaFile select() {
    return MediaFile(path, selected: true, mediaType: mediaType);
  }

  MediaFile unselect() {
    return MediaFile(path, selected: false, mediaType: mediaType);
  }

  MediaFile toggle() {
    return MediaFile(path, selected: !selected, mediaType: mediaType);
  }

  FileSystemEntity get fileSystemEntity => File(path);

  bool inFolder(Folder folder) {
    var dir = p.dirname(path);
    return folder.path == dir;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MediaFile && other.path == path;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => path.hashCode;
}
