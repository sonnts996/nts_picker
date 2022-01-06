/*
 Created by Thanh Son on 30/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'dart:typed_data';

import 'package:flutter_video_info/flutter_video_info.dart';

class UIVideoData {
  UIVideoData({this.data, this.info});

  final Uint8List? data;
  final VideoData? info;
}
