import 'package:my_stock/app/domain/model/stock_balance.dart';

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
