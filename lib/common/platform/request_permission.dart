import 'package:permission_handler/permission_handler.dart';

class RequestPermission {
  Future<bool> checkPermission(Permission permission) async {
    var status = await permission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return false;
    }
  }

  Future<void> checkMultiplePermission(List<Permission> permissions) async {
    for (var item in permissions) {
      await checkPermission(item);
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestMultiplePermission(List<Permission> permissions) async {
    final Map<Permission, PermissionStatus> statuses =
        await permissions.request();
    for (Permission permission in permissions) {
      final status = await checkPermission(permission);
      if (!status) return false;
    }
    return true;
  }
}

List<Permission> permissionList = [
  Permission.camera,
  Permission.location,
  Permission.storage,
  Permission.mediaLibrary,
  Permission.bluetooth,
];
