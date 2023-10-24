import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/core/network/api_service.dart';
import 'package:netpospricechecker/core/network/api_urls.dart';
import 'package:netpospricechecker/core/network/object_convertor.dart';
import 'package:netpospricechecker/core/utils/utility.dart';
import 'package:netpospricechecker/models/product_details.dart';
import 'package:netpospricechecker/models/stock_details.dart';

class PriceCheckerViewModel extends ChangeNotifier {
  bool _isLoading = false;
  ProductDetails? productDetails;
  String productName = "";
  StockDetails stockDetails = StockDetails();
  FlutterTts flutterTts = FlutterTts();
  Timer? timer;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> checkPrice(String barcode) async {
    var url = Hive.box(HiveBoxes.urlBox).get(HiveBoxes.urlBoxKey);
    var requestUrlPriceChecker = "$url${ApiUrls.priceCheckerUrl}$barcode";
    final ProductDetails result = await APIService.callGetRequest(
      requestUrlPriceChecker,
      CreateObject.priceChecker,
      isPriceCheckerUrl: true,
    );
    String? name = extractName(result.name!);

    productDetails = result;
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
    notifyListeners();
    String textToSpeak =
        Utility.formatTextToSpeech(result.salesPrice.toString());
    await configureTts();
    speakText(textToSpeak);
  }

  void handleBarcodeScan() {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(const Duration(seconds: 50), clearScannedValue);
  }

  void clearScannedValue() {
    stockDetails = StockDetails();
    productName = "";
    productDetails = null;
    notifyListeners();
  }

  

  Future<void> configureTts() async {
    await flutterTts.setLanguage('en-gb');
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
