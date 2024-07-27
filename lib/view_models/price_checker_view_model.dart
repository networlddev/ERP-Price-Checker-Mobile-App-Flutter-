import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/app_constants/images_paths.dart';
import 'package:netpospricechecker/app_constants/strings.dart';
import 'package:netpospricechecker/core/network/api_service.dart';
import 'package:netpospricechecker/core/network/api_urls.dart';
import 'package:netpospricechecker/core/network/object_convertor.dart';
import 'package:netpospricechecker/core/utils/utility.dart';
import 'package:netpospricechecker/models/company_logo_state_model.dart';
import 'package:netpospricechecker/models/images_model.dart';
import 'package:netpospricechecker/models/product_details.dart';
import 'package:netpospricechecker/models/stock_details.dart';

import '../core/utils/toast_utility.dart';

class PriceCheckerViewModel extends ChangeNotifier {
  bool _isLoading = false;
  ProductDetails? productDetails;
  String productName = "";
  String price = '';
  StockDetails stockDetails = StockDetails();
  FlutterTts flutterTts = FlutterTts();
  Timer? timer;
  List<Item>? images;
  Timer? imagesTimer;
  bool showImages = false;
  bool imagesFetched = false;
  String status = '0';
  String decimalState = "2";

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> refreshData() async {
    await fetchImages(isRefreshed: true);
    clearScannedValue();
  }

  Future<void> fetchImages({bool isRefreshed = false}) async {
    if (!imagesFetched || isRefreshed) {
      var url = Hive.box(HiveBoxes.urlBox).get(HiveBoxes.urlBoxKey);
      final Images? result = await APIService.callGetRequest(
          "$url${ApiUrls.priceCheckerUrl}GetPriceCheckerImages/1",
          CreateObject.imagesObject) as Images?;

      if (result != null) {
        if (result.item != null) {
          if (result.item!.isNotEmpty) {
           
            images = result.item;
            print("runnnig ====>> ${images!.length}");
            notifyListeners();
          }
        }
      }
      imagesFetched = true;

      final CompanyLogoState resultForDecimalState =
          await APIService.callGetRequest(
        "$url${ApiUrls.priceCheckerUrl}ParamDecimalCount",
        CreateObject.companyLogo,
        isPriceCheckerUrl: true,
        isValidationUrl: false,
      );

      if (resultForDecimalState.state != null) {
        decimalState = resultForDecimalState.state!;
      }
    }
  }

  Future<String?> fetchCompanyImageStatus() async {
    var url = Hive.box(HiveBoxes.urlBox).get(HiveBoxes.urlBoxKey);

    final CompanyLogoState resultForCompanyLogo =
        await APIService.callGetRequest(
      "$url${ApiUrls.priceCheckerUrl}ParamNetworldNogo",
      CreateObject.companyLogo,
      isPriceCheckerUrl: true,
      isValidationUrl: false,
    );
    if (resultForCompanyLogo.state != null) {
      if (resultForCompanyLogo.state == "1") {
        return ImagesPath.networldLogoImage1;
      } else {
        return ImagesPath.networldLogoImage;
      }
    }
    return null;
  }

  Future<void> checkPrice(String barcode) async {
    var url = Hive.box(HiveBoxes.urlBox).get(HiveBoxes.urlBoxKey);
    var requestUrlPriceChecker = "$url${ApiUrls.priceCheckerUrl}$barcode";
    //  var requestUrlPriceChecker = "http://192.168.0.250:1004${ApiUrls.priceCheckerUrl}$barcode";
    final dynamic result = await APIService.callGetRequest(
      requestUrlPriceChecker,
      CreateObject.priceChecker,
      isPriceCheckerUrl: true,
    );

    if (result == null) {
      await configureTts();
      speakText(AppConstantsStrings.itemNotFound);
      ToastUtility.show(AppConstantsStrings.itemNotFound, ToastType.error);
      clearScannedValue();
      return;
    } else if (result != null && result is String) {
      await configureTts();
      speakText(result);
      ToastUtility.show(result, ToastType.error);
      clearScannedValue();
      return;
    }

    String? name = extractName(result.name!);
    productDetails = result;

    price = Utility.formatPrice(result.salesPrice!.toString(), state: decimalState);
    //salesPrice
    var requestUrlProductDetails = "$url${ApiUrls.stockDetailsUrl}$barcode";
    final StockDetails? stock = await APIService.callGetRequest(
      requestUrlProductDetails,
      CreateObject.stockDetails,
      isPriceCheckerUrl: true,
    );

    if (stock != null && productDetails != null) {
      stockDetails = stock;
      productName = name!;
    }

    handleBarcodeScan();
    handleAdsImage(true);
    notifyListeners();
    String textToSpeak = Utility.formatTextToSpeech(
        result.salesPrice.toString(),
        state: decimalState);
    await configureTts();
    speakText(textToSpeak);
  }

  void handleBarcodeScan() {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(const Duration(seconds: 10), clearScannedValue);
  }

  void handleAdsImage(bool hideImages) {
    if (imagesTimer != null) {
      imagesTimer!.cancel();
    }
    if (hideImages) {
      showImages = false;
      notifyListeners();
    }
    imagesTimer = Timer(const Duration(seconds: 12), () {
      showImages = !showImages;
      notifyListeners();
    });
  }

  void clearScannedValue() {
    stockDetails = StockDetails();
    productName = "";
    productDetails = null;
    notifyListeners();
  }

  Future<void> configureTts() async {
    await flutterTts.setLanguage('en-us');
    await flutterTts.setSpeechRate(0.0);
    await flutterTts.setVolume(1.0);
  }

  void speakText(String text) async {
    await flutterTts.speak(text);
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }

  String? extractName(String input) {
    List<String> parts = input.split('|');
    if (parts.isNotEmpty) {
      String name = parts[0].trim();
      return name;
    }
    return null;
  }
}
