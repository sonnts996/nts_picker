/*
 Created by Thanh Son on 30/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'package:nts_picker/data/model/file/media_file.model.dart';

class UIPreviewData {
  const UIPreviewData({required this.file, this.checker = false});

  final MediaFile file;
  final bool checker;
}
