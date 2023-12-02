import 'package:my_stock/app/domain/model/stock_balance.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class FetchBalanceUseCase {
  final StockRepository _stockRepository;

  const FetchBalanceUseCase({required StockRepository stockRepository})
      : _stockRepository = stockRepository;

  Future<void> call({
    required void Function(List<StockBalance>) onSuccess,
  }) async {
    final result = await _stockRepository.getStockBalances();

    switch (result) {
      case Success(:final data):
        onSuccess(data);
        break;
      case Fail(:final issue):
        break;
    }
  }
}
