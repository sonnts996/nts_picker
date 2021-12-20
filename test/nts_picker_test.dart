import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nts_picker/nts_picker.dart';

void main() {
  const MethodChannel channel = MethodChannel('nts_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NtsPicker.platformVersion, '42');
  });
}
