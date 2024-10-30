import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:earningtracker/apiKey/api_keys.dart';

class TranscriptApi {
  static const String apiUrl =
      'https://api.api-ninjas.com/v1/earningstranscript';

  Future<String> getTranscript(
      String ticker, String year, String quarter) async {
    final url = Uri.parse('$apiUrl?ticker=$ticker&year=$year&quarter=$quarter');

    final response = await http.get(url, headers: {
      'X-Api-Key': ApiKeys.apiNinjasKey,
    });

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);

        // Test Code if transcript available
        if (data is Map<String, dynamic> && data.containsKey('transcript')) {
          log('Transcript fetched: ${data['transcript']}');
          return data['transcript'];
        } else {
          log('No "transcript" key found in the API response');
          throw Exception('Transcript data not available in the API response');
        }
      } catch (e) {
        log('Error parsing transcript: $e');
        throw Exception('Failed to parse earnings transcript');
      }
    } else {
      throw Exception('Failed to load earnings transcript');
    }
  }
}
