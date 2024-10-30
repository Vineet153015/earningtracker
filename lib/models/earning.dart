class EarningsModel {
  final String ticker;
  final String? date;
  final double? estimatedEarnings;
  final double? actualEarnings;

  EarningsModel({
    required this.ticker,
    this.date,
    this.estimatedEarnings,
    this.actualEarnings,
  });

  factory EarningsModel.fromJson(Map<String, dynamic> json) {
    return EarningsModel(
      ticker: json['ticker'] ?? '',
      date: json['pricedate'] as String?,
      estimatedEarnings: (json['estimated_eps'] ?? 0.0).toDouble(),
      actualEarnings: (json['actual_eps'] ?? 0.0).toDouble(),
    );
  }
}
