import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/core/network/api_service.dart';
import 'package:netpospricechecker/core/network/api_urls.dart';
import 'package:netpospricechecker/core/network/object_convertor.dart';
import 'package:netpospricechecker/models/product_details.dart';
import 'package:netpospricechecker/models/stock_details.dart';

class PriceCheckerViewModel extends ChangeNotifier {
  bool _isLoading = false;
  ProductDetails? productDetails;
  String productName = "PRODUCT NAME";
  StockDetails stockDetails = StockDetails();

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
    extractName(result.name!);
    productDetails = result;
    var requestUrlProductDetails = "$url${ApiUrls.stockDetailsUrl}$barcode";
    final StockDetails? stock = await APIService.callGetRequest(
      requestUrlProductDetails,
      CreateObject.stockDetails,
      isPriceCheckerUrl: true,
    );

    print("Stock Left ====> ${stock!.contain}");

    if (stock != null) {
      stockDetails = stock;
    }

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
