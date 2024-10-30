import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class EarningsApi {
  static const String apiUrl = 'https://api.api-ninjas.com/v1/earningscalendar';
  static const String apiKey = 'jNLK09hqTeJnRu9RO3Oecw==6KeFQFuLPGLuXVbQ';  // Replace with your API key

  Future<List<dynamic>> getEarnings(String ticker) async {
    final url = Uri.parse('$apiUrl?ticker=$ticker');
    log('Requesting data from: $url'); // Log the request URL

    final response = await http.get(url, headers: {
      'X-Api-Key': apiKey,
    });

    if (response.statusCode == 200) {
      log('API Response: ${response.body}'); // Log the response body
      return json.decode(response.body);
    } else {
      log('Failed to load data. Status Code: ${response.statusCode}');
      throw Exception('Failed to load earnings data');
    }
  }
}
