import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class CheckStockQuantityUseCase {
  final StockRepository _stockRepository;

  CheckStockQuantityUseCase({required StockRepository stockRepository})
      : _stockRepository = stockRepository;

  Future<void> call({
    required String ticker,
    required int quantity,
    required void Function() onCanSell,
    required void Function(int) onCannotSell,
  }) async {
    final result = await _stockRepository.getStockQuantity(ticker: ticker);
    switch (result) {
      case Success(:final data):
        if (data >= quantity) {
          onCanSell();
        } else {
          onCannotSell(data);
        }
        return;
      case Fail(:final issue):
        return;
    }
  }
}
