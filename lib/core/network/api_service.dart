import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:netpospricechecker/core/network/api_urls.dart';
import 'package:netpospricechecker/core/network/object_convertor.dart';

class APIService {
  static Future<dynamic> callPostRequest(
      String requestUrl, String modelName) async {
    try {
      const baseUrl = ApiUrls.baseUrl;

      final url = Uri.parse('$baseUrl$requestUrl');
      final response = await http.post(url);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
      
        return CreateObject.getObject(jsonResponse, modelName);
      } else {
        print('Bad request');
      }
    } catch (e) {
     print('Something went wrong');
    }
  }
}
