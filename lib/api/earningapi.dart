import 'dart:convert';
import 'package:earningtracker/apiKey/api_keys.dart';
import 'package:http/http.dart' as http;

class EarningsApi {
  static const String apiUrl = 'https://api.api-ninjas.com/v1/earningscalendar';  // Replace with your API key

  Future<List<dynamic>> getEarnings(String ticker) async {
    final url = Uri.parse('$apiUrl?ticker=$ticker');

    final response = await http.get(url, headers: {
      'X-Api-Key': ApiKeys.apiNinjasKey,
    });

    if (response.statusCode == 200) {

      return json.decode(response.body);
    } else {
      throw Exception('Failed to load earnings data');
    }
  }
}
