import 'package:my_stock/app/domain/model/stock.dart';
import 'package:my_stock/app/domain/result.dart';

abstract class StockRepository {
  Future<Result<List<Stock>, DefaultIssue>> searchStocks({required String pattern});

  Future<Result<void, DefaultIssue>> createTransaction({
    required String ticker,
    required int price,
    required int quantity,
    required bool buy,
    required int userId,
  });
}

abstract class StockRepositoryFactory {
  StockRepository createStockRepository();
}
