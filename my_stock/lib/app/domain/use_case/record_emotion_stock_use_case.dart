import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/emotion.dart';
import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/app/presentation/vm/stock_transaction.dart';
import 'package:my_stock/core/util/date.dart';

class RecordEmotionStockUseCase {
  final StockRepository _stockRepository;
  final EmotionRepository _emotionRepository;

  const RecordEmotionStockUseCase({
    required StockRepository stockRepository,
    required EmotionRepository emotionRepository,
  })  : _stockRepository = stockRepository,
        _emotionRepository = emotionRepository;

  Future<void> call({
    required Date date,
    required List<StockTransactionVM> transactionList,
    required EmotionEnum emotion,
    required String text,
    required void Function() onSuccess,
    required void Function() onFail,
    required void Function() beforeThisWeek,
  }) async {
    final result1 =
        await _emotionRepository.createEmotionRecord(date: date, emotion: emotion, text: text);

    if (result1 is Fail) {
      final issue = (result1 as Fail).issue;
      if (issue == CreateEmotionIssue.beforeThisWeek) {
        beforeThisWeek();
      } else {
        onFail();
      }
      return;
    }

    for (StockTransactionVM transaction in transactionList) {
      await _stockRepository.createTransaction(
        ticker: transaction.ticker,
        price: transaction.price,
        quantity: transaction.quantity,
        buy: transaction.buy,
        userId: GetIt.I.get<User>().id,
      );
    }

    onSuccess();
  }
}
