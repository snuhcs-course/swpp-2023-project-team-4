import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class CheckStockBoughtUseCase {
  final StockRepository _stockRepository;

  const CheckStockBoughtUseCase({required StockRepository stockRepository})
      : _stockRepository = stockRepository;

  Future<void> call({
    required String ticker,
    required void Function() onBought,
    required void Function() onNotBought,
  }) async {
    final result = await _stockRepository.getStockQuantity(ticker: ticker);
    switch (result) {
      case Success(:final data):
        if (data > 0) {
          onBought();
        } else {
          onNotBought();
        }
        return;
      case Fail(:final issue):
        return;
    }
  }
}
