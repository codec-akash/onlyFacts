import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:only_facts/network/ap_response_handler.dart';

class ApiProvider {
  static const baseUrl = "https://api.api-ninjas.com/";

  var client = http.Client();

  Future<Map<String, dynamic>> getCall(String endPoint) async {
    String urlString = baseUrl + endPoint;
    Uri url = Uri.parse(urlString);
    final apiKey = dotenv.get("API_KEY");

    try {
      var uriResponse = await client.get(
        url,
        headers: {"X-Api-Key": apiKey},
      );
      return ApiResponseHandler.output(uriResponse);
    } catch (e) {
      return ApiResponseHandler.outputError();
    }
  }
}
