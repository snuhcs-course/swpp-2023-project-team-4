import 'package:my_stock/app/domain/model/stock.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class StockSearchUseCase {
  final StockRepository _stockRepository;

  const StockSearchUseCase({
    required StockRepository stockRepository,
  }) : _stockRepository = stockRepository;

  Future<void> call({
    required String pattern,
    required void Function(List<Stock>) onSuccess,
  }) async {
    final result = await _stockRepository.searchStocks(pattern: pattern);

    switch (result) {
      case Success(:final data):
        onSuccess(data);
      case Fail(:final issue):
        return;
    }
  }
}
