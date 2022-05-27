import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_information/device_information.dart';

class DeviceInfo {
  static Future<String> getSignUUID() async {
    String? uuid;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      uuid = androidDeviceInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      uuid = iosDeviceInfo.identifierForVendor!;
    }

    return uuid ?? '';
  }

  static Future<String> getImei() async {
    try {
      return await DeviceInformation.deviceIMEINumber;
    } catch (e) {
      return "";
    }
  }

  static Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String? manufacturer;
    String? model;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      manufacturer = androidInfo.manufacturer!;
      model = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      manufacturer = iosInfo.name!;
      model = iosInfo.model;
    }

    if (model != null && model.startsWith(manufacturer ?? '')) {
      return model;
    } else {
      return '$manufacturer $model';
    }
  }

  Future<String> getSerialNumber() async {
    String serialNumber = await getSignUUID();
    if (serialNumber.isNotEmpty) {
      return serialNumber;
    }

    const String defaultImei = '000000000000';
    serialNumber = await getImei();
    if (serialNumber.isNotEmpty && serialNumber != defaultImei) {
      return serialNumber;
    }

    return defaultImei;
  }
}
