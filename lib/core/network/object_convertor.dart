import 'dart:convert';

import 'package:http/http.dart';
import 'package:netpospricechecker/models/activation_key.dart';
import 'package:netpospricechecker/models/product_details.dart';
import 'package:netpospricechecker/models/result_model.dart';

class CreateObject {
  static const validateModel = 'validate';
  static const activationKeyModel = 'activation';
  static const priceChecker = 'price_checker';

  static dynamic decodeObject(
    String response,
    String modelName,
    bool isPricechecker,
    bool isUserUrlValidation,
  ) {
    if (!isPricechecker) {
      var jsonResponse = jsonDecode(response);
      return getObject(jsonResponse, modelName);
    } else if (isUserUrlValidation) {
      var jsonResponse = jsonDecode(response);
      return getObject(jsonResponse, modelName);
    } else {
      var jsonResponse = jsonDecode(jsonDecode(response));
      return getObject(jsonResponse, modelName);
    }
  }

  static dynamic getObject(dynamic data, String modelName) {
    switch (modelName) {
      case validateModel:
        return Result.fromJson(data);
      case activationKeyModel:
        return ActivationKey.fromJson(data);
      case priceChecker:
        return ProductDetails.fromJson(data);
      default:
        return 'No model Fonund';
    }
  }
}
