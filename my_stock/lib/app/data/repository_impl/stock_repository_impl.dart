import 'package:dio/dio.dart';
import 'package:my_stock/app/data/dto/searched_stock_dto.dart';
import 'package:my_stock/app/data/util/http_util.dart';
import 'package:my_stock/app/domain/model/stock.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class StockRepositoryImpl implements StockRepository {
  final HttpUtil _httpUtil = HttpUtil.I;

  @override
  Future<Result<List<Stock>, DefaultIssue>> searchStocks({required String pattern}) async {
    try {
      final response = await _httpUtil.get("/stock/", queryParameters: {"name": pattern});
      List<SearchedStockDTO> dtos = response.data.map((e) => SearchedStockDTO.fromJson(e));
      List<Stock> stockList = [];
      for (var dto in dtos) {
        if (dto.name.contains(pattern))
          stockList.add(
            Stock(
                ticker: dto.ticker,
                name: dto.name,
                currentPrice: dto.currentPrice,
                fluctuationRate: dto.fluctuationRate),
          );
      }
      return Success(stockList);
    } on DioException catch (e) {
      return Fail(DefaultIssue.badRequest);
    }
  }
}
