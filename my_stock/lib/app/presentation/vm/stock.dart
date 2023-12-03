class StockVM {
  final String ticker;
  final String name;
  final String imageUrl;
  final int price;
  final int closingPrice;
  final double fluctuationRate;

  const StockVM({
    required this.ticker,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.closingPrice,
    required this.fluctuationRate,
  });
}
