import 'package:flutter/material.dart';

import '../api/earningapi.dart';
import '../models/earning.dart';

import 'dart:developer';

class EarningsProvider with ChangeNotifier {
  List<EarningsModel> earningsData = [];
  bool isLoading = false;
  String error = '';

  Future<void> fetchEarnings(String ticker) async {
    isLoading = true;
    error = '';
    notifyListeners();

    try {
      log('Fetching earnings data for ticker: $ticker');
      final earningsList = await EarningsApi().getEarnings(ticker);
      earningsData =
          earningsList.map((json) => EarningsModel.fromJson(json)).toList();
      log('Fetched and parsed earnings data: $earningsData');
    } catch (e) {
      error = 'Failed to load earnings data';
      log('Error fetching earnings data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
