import 'package:my_stock/app/domain/model/stock.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class MockStockRepositoryImpl implements StockRepository {
  @override
  Future<Result<void, DefaultIssue>> createTransaction(
      {required String ticker,
      required int price,
      required int quantity,
      required bool buy,
      required int userId}) async {
    return Success(true);
  }

  @override
  Future<Result<List<Stock>, DefaultIssue>> searchStocks({required String pattern}) async {
    return Success([
      Stock(ticker: "dddddd", name: "삼성전자", currentPrice: 70000, fluctuationRate: 2.5),
    ]);
  }
}

class MockStockRepositoryImplFactory implements StockRepositoryFactory {
  @override
  StockRepository createStockRepository() {
    return MockStockRepositoryImpl();
  }
}
