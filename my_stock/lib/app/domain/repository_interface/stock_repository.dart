import 'package:my_stock/app/domain/model/stock.dart';
import 'package:my_stock/app/domain/result.dart';

abstract class StockRepository {
  Future<Result<List<Stock>, DefaultIssue>> searchStocks({required String pattern});
}
