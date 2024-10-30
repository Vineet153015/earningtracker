import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class TranscriptApi {
  static const String apiUrl = 'https://api.api-ninjas.com/v1/earningstranscript';
  static const String apiKey = 'jNLK09hqTeJnRu9RO3Oecw==6KeFQFuLPGLuXVbQ';  // Replace with your API key

  Future<String> getTranscript(String ticker, String year, String quarter) async {
    final url = Uri.parse('$apiUrl?ticker=$ticker&year=$year&quarter=$quarter');

    // Log the API request details
    log('Requesting transcript from: $url');

    final response = await http.get(url, headers: {
      'X-Api-Key': apiKey,
    });

    // Log the response status code and body
    log('Response Status Code: ${response.statusCode}');
    log('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        // Decode the response body and log it
        final data = json.decode(response.body);
        log('Decoded API Response: $data');

        // Check if 'transcript' exists within the decoded data
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
