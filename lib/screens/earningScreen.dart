import 'package:earningtracker/screens/transcriptScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/earning.dart';
import '../providers/earningprovider.dart';

class EarningsScreen extends StatefulWidget {
  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  final TextEditingController _tickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tickerController,
              decoration: InputDecoration(labelText: 'Enter Company Ticker'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<EarningsProvider>(context, listen: false)
                    .fetchEarnings(_tickerController.text);
              },
              child: Text('Fetch Earnings'),
            ),
            Expanded(
              child: Consumer<EarningsProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (provider.error.isNotEmpty) {
                    return Center(child: Text(provider.error));
                  }
                  if (provider.earningsData.isEmpty) {
                    return Center(child: Text('No earnings data available'));
                  }

                  // Log earnings data for debugging
                  print('Earnings Data: ${provider.earningsData}');

                  return LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: provider.earningsData.map((e) {
                            double xValue = 0.0;
                            if (e.date != null && e.date != '') {
                              try {
                                xValue = DateTime.parse(e.date!)
                                    .millisecondsSinceEpoch
                                    .toDouble();
                              } catch (err) {
                                print("Date parsing error: $err");
                              }
                            }
                            return FlSpot(
                                xValue,
                                e.estimatedEarnings ??
                                    0.0);
                          }).toList(),
                          isCurved: true,
                          color: Colors.blue,
                        ),
                        LineChartBarData(
                          spots: provider.earningsData.map((e) {
                            double xValue = 0.0;
                            if (e.date != null && e.date != 'N/A') {
                              try {
                                xValue = DateTime.parse(e.date!)
                                    .millisecondsSinceEpoch
                                    .toDouble();
                              } catch (err) {
                                xValue = 0.0;
                              }
                            }
                            return FlSpot(xValue, e.estimatedEarnings ?? 0.10);
                          }).toList(),
                          isCurved: true,
                          color: Colors.green,
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchCallback: (FlTouchEvent event,
                            LineTouchResponse? touchResponse) {
                          if (touchResponse != null &&
                              touchResponse.lineBarSpots != null) {
                            final spot = touchResponse.lineBarSpots![0];
                            _showTranscript(
                                context, provider.earningsData[spot.spotIndex]);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTranscript(BuildContext context, EarningsModel earnings) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TranscriptScreen(
          ticker: earnings.ticker,
          date: earnings.date ?? 'N/A',
        ),
      ),
    );
  }
}
