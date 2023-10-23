import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/app_constants/strings.dart';
import 'package:netpospricechecker/core/network/api_service.dart';
import 'package:netpospricechecker/core/network/api_urls.dart';
import 'package:netpospricechecker/core/network/object_convertor.dart';
import 'package:netpospricechecker/models/product_details.dart';

class PriceCheckerViewModel extends ChangeNotifier {
  bool _isLoading = false;
  ProductDetails? productDetails;
  String productName = "PRODUCT NAME";

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> checkPrice(String barcode) async {
    var url = Hive.box(HiveBoxes.urlBox)
        .get(HiveBoxes.urlBoxKey);
    var requestUrl = "$url${ApiUrls.priceCheckerUrl}$barcode";
    final ProductDetails result = await APIService.callGetRequest(
      requestUrl,
      CreateObject.priceChecker,
      isPriceCheckerUrl: true,
    );
    extractName(result.name!);
    productDetails = result;
    notifyListeners();
  }

  void extractName(String input) {
    List<String> parts = input.split('|');
    if (parts.isNotEmpty) {
      String name = parts[0].trim();
      productName = name;
    }
  }
}
