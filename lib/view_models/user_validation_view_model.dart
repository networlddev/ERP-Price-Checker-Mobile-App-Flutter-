import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/core/network/api_service.dart';
import 'package:netpospricechecker/core/network/api_urls.dart';
import 'package:netpospricechecker/core/network/object_convertor.dart';
import 'package:netpospricechecker/core/utils/toast_utility.dart';
import 'package:netpospricechecker/core/utils/utility.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UserValidationViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool isSendRequestEnabled = true;
  bool isFetchKeyEnabled = false;
  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setSendRequestButton(bool enabled) {
    isSendRequestEnabled = enabled;
    notifyListeners();
  }

  void setSendFetchKeyButton(bool enabled) {
    isFetchKeyEnabled = enabled;
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
    String lastFourCharacters = Utility.getLastFourCharacters(qrCodeProductKey);
    String productKey = Utility.convertIpAddress(qrCodeProductKey);

    try {
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;

        requestUrl =
            '${ApiUrls.baseUrl}PriceChecker/$customerCode/$companyName/${androidInfo.device}-$lastFourCharacters/${androidInfo.model}/PRICECHEAKER/$productKey/${packageInfo.version}';
      } else if (Platform.isIOS) {
        iosInfo = await deviceInfo.iosInfo;

        requestUrl =
            '${ApiUrls.baseUrl}PriceChecker/$customerCode/$companyName/${iosInfo.name}-$lastFourCharacters/${iosInfo.model}/PRICECHEAKER/$productKey/${packageInfo.version}';
      }
    } catch (e) {
      print('Error getting device info: $e');
    }

    final dynamic validationModel = await APIService.callGetRequest(
      requestUrl,
      CreateObject.validateModel,
    );
    if (validationModel?.result == true) {
      ToastUtility.show("${validationModel?.message}, Please fetch your key",
          ToastType.success);
      setSendFetchKeyButton(true);
      setSendRequestButton(false);
    } else {
      ToastUtility.show(
          validationModel?.message ?? "Failed to activate", ToastType.error);
    }

    setLoading(false);
  }

  Future<bool> fetchKey(
    String customerCode,
    String qrCodeProductKey,
  ) async {
    setLoading(true);
    String productKey = Utility.convertIpAddress(qrCodeProductKey);

    String requestUrl =
        "${ApiUrls.baseUrl}PriceChecker/$customerCode/$productKey/PRICECHEAKER";

    final dynamic validationModel = await APIService.callGetRequest(
      requestUrl,
      CreateObject.validateModel,
    );
    if (validationModel?.message != "") {
      ToastUtility.show("Key Fetched", ToastType.success);
      Hive.box(HiveBoxes.authenticationBox)
          .put(HiveBoxes.authenticationBoxKey, validationModel?.message);
      print("Activation Key ====> ${validationModel?.message}");
      DateTime? expiryDate =
          Utility.calculateExpiryDate(validationModel?.message);
      if (expiryDate != null) {
        Utility.storeExpiryDate(expiryDate);
      }

      setLoading(false);
      return true;
    } else {
      ToastUtility.show(
          "${validationModel?.message} Failed to activate", ToastType.error);
      setLoading(false);
      return false;
    }
  }

  Future<bool> validateBaseUrl(String url) async {
    setLoading(true);
    String requestUrl = "$url${ApiUrls.priceCheckerUrl}qas/sw";
    final dynamic validationModel = await APIService.callGetRequest(
        requestUrl, CreateObject.validateModel,
        isValidationUrl: true);
    if (validationModel != null) {
      Hive.box(HiveBoxes.urlBox).put(HiveBoxes.urlBoxKey, url);

      setLoading(false);

      return true;
    } else {
      ToastUtility.show("Invalid url", ToastType.error);
      setLoading(false);

      return false;
    }
  }
}
