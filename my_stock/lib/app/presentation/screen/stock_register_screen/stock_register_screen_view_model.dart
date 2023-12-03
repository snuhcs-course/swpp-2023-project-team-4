import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/use_case/check_stock_bought_use_case.dart';
import 'package:my_stock/app/presentation/vm/stock.dart';

class StockRegisterScreenViewModel with ChangeNotifier {
  final CheckStockBoughtUseCase _checkStockBoughtUseCase = CheckStockBoughtUseCase(
    stockRepository: GetIt.I<StockRepository>(),
  );

  final StockVM stock;
  bool canSell = true;

  StockRegisterScreenViewModel({required this.stock}) {
    EasyLoading.show(status: "Loading...");
    _checkStockBoughtUseCase(
      ticker: stock.ticker,
      onBought: () {
        canSell = true;
        notifyListeners();
      },
      onNotBought: () {
        canSell = false;
        notifyListeners();
      },
    ).then((value) {
      EasyLoading.dismiss();
    });
  }
}
