import 'package:http/http.dart' as http;
import 'package:only_facts/env.dart';
import 'package:only_facts/network/ap_response_handler.dart';

class ApiProvider {
  static const baseUrl = "https://api.api-ninjas.com/";

  var client = http.Client();

  Future<Map<String, dynamic>> getCall(String endPoint) async {
    String urlString = baseUrl + endPoint;
    Uri url = Uri.parse(urlString);
    const apiKey = bool.hasEnvironment("API_KEY")
        ? String.fromEnvironment("API_KEY")
        : apiKeyENV;

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
