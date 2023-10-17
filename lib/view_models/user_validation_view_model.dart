import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netpospricechecker/core/network/api_service.dart';
import 'package:netpospricechecker/core/network/object_convertor.dart';
import 'package:netpospricechecker/models/validate_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UserValidationViewModel extends ChangeNotifier {
  bool _isLoading = false;
  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> validateUser(
    String customerCode,
    String companyName,
    String qrCodeProductKey,
  ) async {
    setLoading(true);
    String requestUrl = "";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    try {
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
        print('Device Name: ${androidInfo.model}');
        print('Device Model: ${androidInfo.device}');
        requestUrl =
            '$customerCode/$companyName/${androidInfo.device}/${androidInfo.model}/PRICE CHECKER/$qrCodeProductKey/${packageInfo.version}';
      } else if (Platform.isIOS) {
        iosInfo = await deviceInfo.iosInfo;
        print('Device Name: ${iosInfo.name}');
        print('Device Model: ${iosInfo.model}');
        requestUrl =
            '$customerCode/$companyName/${iosInfo.name}/${iosInfo.model}/PRICE CHECKER/$qrCodeProductKey/${packageInfo.version}';
      }
    } catch (e) {
      print('Error getting device info: $e');
    }

    final dynamic validationModel = await APIService.callPostRequest(
      requestUrl,
      CreateObject.validateModel,
    );
    if (validationModel.result == true) {
      Fluttertoast.showToast(
          msg: "Successfully activated, Please Fetch key",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error Activating",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setLoading(false);
  }

  Future<BaseDeviceInfo?> getDeviceDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;

    try {
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
        print('Device Name: ${androidInfo.model}');
        print('Device Model: ${androidInfo.device}');
        return androidInfo;
      } else if (Platform.isIOS) {
        iosInfo = await deviceInfo.iosInfo;
        print('Device Name: ${iosInfo.name}');
        print('Device Model: ${iosInfo.model}');
        return iosInfo;
      }
    } catch (e) {
      print('Error getting device info: $e');
    }

    return null;
  }
}
