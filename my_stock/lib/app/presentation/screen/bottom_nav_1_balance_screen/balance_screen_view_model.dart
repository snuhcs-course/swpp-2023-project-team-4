import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/use_case/fetch_balance_use_case.dart';
import 'package:my_stock/app/presentation/stream/balance_update.dart';
import 'package:my_stock/app/presentation/vm/stock_balance.dart';

class BalanceScreenViewModel with ChangeNotifier {
  bool isLoading = true;
  bool isReportLoading = true;
  StockBalanceListVM stockBalanceListVM = StockBalanceListVM(stockBalanceList: []);

  final FetchBalanceUseCase _fetchBalanceUseCase = FetchBalanceUseCase(
    stockRepository: GetIt.I<StockRepository>(),
  );

  BalanceScreenViewModel() {
    _fetchBalance();
    BalanceUpdateStream.stream.listen((event) {
      _fetchBalance();
    });
  }

  void _fetchBalance() async {
    isLoading = true;
    notifyListeners();
    _fetchBalanceUseCase(onSuccess: (balances) {
      stockBalanceListVM = StockBalanceListVM.fromDomainList(balances);
      isLoading = false;
      notifyListeners();
    });
  }
}
