import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nts_picker/data/model/file/media_type.dart';
import 'package:nts_picker/native_module/native_get_files.dart';
import 'package:nts_picker/nts_picker.dart';

void main() {
  const MethodChannel channel = MethodChannel('nts_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getListFile') {
        return ['{"path":"/path/to/file", "mediaType":"image"}'];
      } else {
        // getPlatformVersion
        return '42';
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NativeGetFiles.platformVersion, '42');
  });

  test('getListFile', () async {
    expect(await NativeGetFiles.getListFile(null, MediaType.all),
        [const MediaFile('/path/to/file', mediaType: MediaType.image)]);
  });
}
