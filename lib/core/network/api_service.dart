import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:netpospricechecker/core/network/object_convertor.dart';

class APIService {
  static Future<dynamic> callGetRequest(
    String requestUrl,
    String modelName, {
    bool isPriceCheckerUrl = false,
    bool isValidationUrl = false,
  }) async {
    try {
      var url = Uri.parse(requestUrl);

      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(url, headers: header);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 500) {
        //   var jsonDataString = response.body.toString();
        if (!isPriceCheckerUrl) {
          var jsonResponse = jsonDecode(response.body);
          return CreateObject.getObject(jsonResponse, modelName);
        } else if (isValidationUrl) {
          var jsonResponse = jsonDecode(response.body);
          return CreateObject.getObject(jsonResponse, modelName);
        } else {
          var jsonResponse = jsonDecode(jsonDecode(response.body));
          return CreateObject.getObject(jsonResponse, modelName);
        }
      } else {
        print('Bad request');
      }
    } catch (e) {
      return "Sorry the server is temporarily unavailable";
    }
  }


    static Future<dynamic> callPostRequest(
    String requestUrl,
    String modelName,{
    Map<String,dynamic>? body}) async {
    try {
      var url = Uri.parse(requestUrl);

      var header = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };
      final response = await http.post(url, headers: header ,body: json.encode(body));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 500) {
              var jsonResponse = jsonDecode(response.body);
          return CreateObject.getObject(jsonResponse, modelName);
        //   var jsonDataString = response.body.toString();
        // if (!isPriceCheckerUrl) {
        //   var jsonResponse = jsonDecode(response.body);
        //   return CreateObject.getObject(jsonResponse, modelName);
        // } else if (isValidationUrl) {
        //   var jsonResponse = jsonDecode(response.body);
        //   return CreateObject.getObject(jsonResponse, modelName);
        // } else {
        //   var jsonResponse = jsonDecode(jsonDecode(response.body));
        //   return CreateObject.getObject(jsonResponse, modelName);
        // }
      } else {
        print('Bad request');
      }
    } catch (e) {
      return "Sorry the server is temporarily unavailable";
    }
  }
}
