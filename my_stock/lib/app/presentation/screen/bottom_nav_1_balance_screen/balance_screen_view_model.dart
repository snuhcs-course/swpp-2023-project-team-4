import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/repository_interface/report_repository.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/use_case/fetch_balance_use_case.dart';
import 'package:my_stock/app/domain/use_case/fetch_reports_use_case.dart';
import 'package:my_stock/app/presentation/stream/balance_update.dart';
import 'package:my_stock/app/presentation/vm/report.dart';
import 'package:my_stock/app/presentation/vm/stock_balance.dart';

class BalanceScreenViewModel with ChangeNotifier {
  bool isLoading = true;
  bool isReportLoading = true;
  StockBalanceListVM stockBalanceListVM = StockBalanceListVM(stockBalanceList: []);
  List<ReportVM> reportList = [];

  final FetchBalanceUseCase _fetchBalanceUseCase = FetchBalanceUseCase(
    stockRepository: GetIt.I<StockRepository>(),
  );
  final FetchReportsUseCase _fetchReportsUseCase = FetchReportsUseCase(
    reportRepository: GetIt.I<ReportRepository>(),
  );

  Timer? _timer;

  BalanceScreenViewModel() {
    _fetchBalance();
    _fetchRecords();
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _fetchBalance();
      _fetchRecords();
    });
    BalanceUpdateStream.stream.listen((event) {
      _fetchBalance();
    });
  }

  void _fetchBalance() async {
    _fetchBalanceUseCase(onSuccess: (balances) {
      stockBalanceListVM = StockBalanceListVM.fromDomainList(balances);
      isLoading = false;
      notifyListeners();
    });
  }

  void _fetchRecords() async {
    _fetchReportsUseCase(onSuccess: (reports) {
      reportList = reports.map((e) => ReportVM.fromDomain(e)).toList();
      isReportLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
