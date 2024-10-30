import 'package:flutter/material.dart';

import '../api/transcriptapi.dart';


class TranscriptScreen extends StatelessWidget {
  final String ticker;
  final String date;

  TranscriptScreen({required this.ticker, required this.date});

  @override
  Widget build(BuildContext context) {
    // Parse year and quarter from `date`
    final year = date.split('-')[0];
    final month = int.parse(date.split('-')[1]);
    final quarter = ((month - 1) ~/ 3) + 1; // Convert month to quarter

    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings Transcript'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<String>(
          future: TranscriptApi().getTranscript(ticker, year, quarter.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load transcript'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(snapshot.data ?? ''),
              );
            }
          },
        ),
      ),
    );
  }
}

