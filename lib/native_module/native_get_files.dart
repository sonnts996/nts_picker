import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';
import 'package:nts_picker/data/model/file/media_type.dart';

class NativeGetFiles {
  static const MethodChannel _channel = MethodChannel('nts_picker');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List<MediaFile>> getListFile(
      String? dir, MediaType type) async {
    final files = await _channel
        .invokeMethod('getListFile', {'dir': dir, 'type': type.name()});
    if (kDebugMode) {
      print('List file $files');
    }
    return List.generate(files.length,
        (index) => MediaFile.formJson(jsonDecode(files[index]))).toList();
  }
}
