import 'package:dio/dio.dart';
import 'package:my_stock/app/data/dto/balance_dto.dart';
import 'package:my_stock/app/data/dto/searched_stock_dto.dart';
import 'package:my_stock/app/data/util/http_util.dart';
import 'package:my_stock/app/domain/model/stock.dart';
import 'package:my_stock/app/domain/model/stock_balance.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class StockRepositoryImpl implements StockRepository {
  final HttpUtil _httpUtil = HttpUtil.I;

  @override
  Future<Result<List<Stock>, DefaultIssue>> searchStocks({required String pattern}) async {
    try {
      final response = await _httpUtil.get("/stock/", queryParameters: {"name": pattern});
      List<SearchedStockDTO> dtos = [];
      for (var map in response.data) {
        dtos.add(SearchedStockDTO.fromJson(map));
      }
      List<Stock> stockList = [];
      for (var dto in dtos) {
        if (dto.name.contains(pattern)) {
          stockList.add(
            Stock(
              ticker: dto.ticker,
              name: dto.name,
              currentPrice: dto.currentPrice,
              closingPrice: dto.closingPrice,
              fluctuationRate: dto.fluctuationRate,
            ),
          );
          print(dto.name);
          print(dto.currentPrice);
          print(dto.closingPrice);
          print(dto.fluctuationRate);
        }
      }
      return Success(stockList);
    } on DioException catch (e) {
      return Fail(DefaultIssue.badRequest);
    }
  }

  @override
  Future<Result<void, DefaultIssue>> createTransaction(
      {required String ticker,
      required int price,
      required int quantity,
      required bool buy,
      required int userId}) async {
    try {
      final result = await _httpUtil.post("/mystock/", data: {
        "stock": ticker,
        "price": price,
        "quantity": quantity,
        "transaction_type": buy ? "buy" : "sell",
        "user": userId,
      });
      return Success(null);
    } on DioException catch (e) {
      return Fail(DefaultIssue.badRequest);
    }
  }

  @override
  Future<Result<List<StockBalance>, DefaultIssue>> getStockBalances() async {
    try {
      var future1 = _httpUtil.get("/stock/");
      var future2 = _httpUtil.get("/balance/");
      var futures = await Future.wait([future1, future2]);
      List<SearchedStockDTO> dtos =
          futures[0].data.map<SearchedStockDTO>((e) => SearchedStockDTO.fromJson(e)).toList();
      List<BalanceDTO> balances =
          futures[1].data.map<BalanceDTO>((e) => BalanceDTO.fromJson(e)).toList();
      Map<String, String> tickerToNameMap = {};
      for (var dto in dtos) {
        tickerToNameMap[dto.ticker] = dto.name;
      }

      List<StockBalance> stockBalances = [];
      for (var balance in balances) {
        stockBalances.add(
          StockBalance(
            ticker: balance.ticker,
            name: tickerToNameMap[balance.ticker]!,
            quantity: balance.quantity,
            balance: balance.balance,
            profitAndLoss: balance.returnAmount,
          ),
        );
      }
      stockBalances.sort((a, b) => a.name.compareTo(b.name));
      return Success(stockBalances);
    } on DioException catch (e) {
      return Fail(DefaultIssue.badRequest);
    }
  }
}

class StockRepositoryFactoryImpl implements StockRepositoryFactory {
  @override
  StockRepository createStockRepository() {
    return StockRepositoryImpl();
  }
}
