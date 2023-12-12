import 'package:only_facts/model/facts_model.dart';
import 'package:only_facts/network/api_provider.dart';

class FactsRepo {
  Future<List<Facts>> getFacts() async {
    List<Facts> factsList = [];
    var endPoint = "v1/facts?limit=30";
    try {
      var data = await ApiProvider().getCall(endPoint);
      if (data['error'] != null) {
        throw data["error"];
      }
      factsList = (data["result"] as List)
          .map((facts) => Facts.fromJson(facts))
          .toList();

      return factsList;
    } catch (e) {
      print("Error is $e");
      throw "Something went wrong";
    }
  }
}
