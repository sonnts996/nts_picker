import 'package:permission_handler/permission_handler.dart';

class RequestPermission {
  List<Permission> permissions = [Permission.storage, Permission.camera];

  Future request() async {
    for (var permission in permissions) {
      var rs = await permission.isDenied;
      if (rs) {
        await permission.request();
      }
    }
  }

  Future<bool> checkPermisstion() async {
    var permission = await Future.wait(permissions.map((e) => e.isDenied));
    return permission.any((element) => element);
  }

  Future<bool> checkStorage() async {
    return await Permission.storage.isDenied;
  }

  Future<bool> checkCamera() async {
    return await Permission.camera.isDenied;
  }
}
