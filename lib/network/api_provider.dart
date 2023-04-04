import 'package:http/http.dart' as http;
import 'package:only_facts/network/ap_response_handler.dart';

class ApiProvider {
  static const baseUrl = "https://api.api-ninjas.com/";

  var client = http.Client();

  Future<Map<String, dynamic>> getCall(String endPoint) async {
    String urlString = baseUrl + endPoint;
    Uri url = Uri.parse(urlString);

    try {
      var uriResponse = await client.get(
        url,
        headers: {},
      );
      return ApiResponseHandler.output(uriResponse);
    } catch (e) {
      return ApiResponseHandler.outputError();
    }
  }
}
