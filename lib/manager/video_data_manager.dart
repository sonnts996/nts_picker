/*
 Created by Thanh Son on 30/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'package:nts_picker/data/model/data/video_data.model.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';

class VideoDataManager {
  static VideoDataManager? _inst;

  static VideoDataManager get instance {
    _inst ??= VideoDataManager();
    return _inst!;
  }

  final _videoData = <MediaFile, UIVideoData>{};

  void putData(MediaFile file, UIVideoData videoData) {
    _videoData[file] = videoData;
  }

  UIVideoData? getData(MediaFile file) {
    return _videoData[file];
  }

  bool exist(MediaFile file) {
    return _videoData.containsKey(file);
  }
}
