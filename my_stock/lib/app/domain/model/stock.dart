class Stock {
  final String ticker;
  final String name;
  final int currentPrice;
  final double fluctuationRate;

  const Stock({
    required this.ticker,
    required this.name,
    required this.currentPrice,
    required this.fluctuationRate,
  });
}
