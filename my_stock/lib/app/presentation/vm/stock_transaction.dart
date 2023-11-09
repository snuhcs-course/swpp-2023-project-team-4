class StockTransactionVM {
  final String ticker;
  final String imageUrl;
  final String name;
  final bool buy;
  final int price;
  final int quantity;

  const StockTransactionVM({
    required this.ticker,
    required this.imageUrl,
    required this.name,
    required this.buy,
    required this.price,
    required this.quantity,
  });
}
