import 'dart:convert';

import 'package:http/http.dart';

class ApiResponseHandler {
  static Map<String, dynamic> output(Response uriResponse) {
    Map<String, dynamic> res = Map<String, dynamic>();

    if (uriResponse.statusCode == 200) {
      res['statusCode'] = uriResponse.statusCode;
      res['result'] = json.decode(uriResponse.body);
      res['error'] = null;
    } else if (uriResponse.statusCode >= 400 && uriResponse.statusCode <= 500) {
      res['statusCode'] = uriResponse.statusCode;
      res['result'] = null;
      res['error'] = json.decode(uriResponse.body);
    } else {
      res['result'] = null;
      res['error'] = "something went wrong";
    }

    return res;
  }

  static Map<String, dynamic> outputError() {
    Map<String, dynamic> res = Map<String, dynamic>();
    res['result'] = null;
    res['error'] = "Something went wrong";
    return res;
  }
}
