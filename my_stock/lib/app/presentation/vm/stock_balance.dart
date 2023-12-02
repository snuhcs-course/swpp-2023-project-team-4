import 'package:my_stock/app/domain/model/stock_balance.dart';

class StockBalanceListVM {
  final List<StockBalanceVM> stockBalanceList;

  const StockBalanceListVM({required this.stockBalanceList});

  factory StockBalanceListVM.fromDomainList(List<StockBalance> stockBalanceList) {
    return StockBalanceListVM(
      stockBalanceList: stockBalanceList.map((e) => StockBalanceVM.fromDomain(e)).toList(),
    );
  }

  int get totalBalance =>
      stockBalanceList.fold(0, (previousValue, element) => previousValue + element.balance);

  int get totalProfitAndLoss =>
      stockBalanceList.fold(0, (previousValue, element) => previousValue + element.profitAndLoss);

  double get totalProfitAndLossRate =>
      double.parse((totalProfitAndLoss / totalBalance).toStringAsFixed(2));

  bool get isProfit => totalProfitAndLoss >= 0;

  void clear() {
    stockBalanceList.clear();
  }
}

class StockBalanceVM {
  final String name;
  final int quantity;
  final int balance;
  final int profitAndLoss;

  StockBalanceVM({
    required this.name,
    required this.quantity,
    required this.balance,
    required this.profitAndLoss,
  });

  factory StockBalanceVM.fromDomain(StockBalance stockBalance) {
    return StockBalanceVM(
      name: stockBalance.name,
      quantity: stockBalance.quantity,
      balance: stockBalance.balance,
      profitAndLoss: stockBalance.profitAndLoss,
    );
  }

  bool get isProfit => profitAndLoss >= 0;

  double get profitAndLossRate => double.parse((profitAndLoss / balance).toStringAsFixed(2));
}
