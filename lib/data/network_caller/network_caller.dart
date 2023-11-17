import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content': 'Application/json',
      });

      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      } else {
        return NetworkResponse(
            isSuccess: false,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
