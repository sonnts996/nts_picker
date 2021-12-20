import 'package:flutter/services.dart';

enum MediaType{
  image,
  video,
  all,
}

extension MediaTypeX on MediaType{
  String name(){
    switch(this){
      case MediaType.image:
        return "image";
      case MediaType.video:
        return "video";
      case MediaType.all:
        return "all";
    }
  }
}

class AndroidLoadFile {
  static const MethodChannel _channel = MethodChannel('nts_picker');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List<String>>  getListFile(String? dir, MediaType type) async {
    final files = await _channel.invokeMethod('getListFile', {'dir': dir, 'type': type.name()});
    print('Files: $files');
    return List.generate(files.length, (index) => files[index] as String)
        .toList();
  }
}
