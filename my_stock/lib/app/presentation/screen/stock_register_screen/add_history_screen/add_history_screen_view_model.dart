import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/use_case/check_stock_quantity_use_case.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/app/presentation/util/my_snackbar.dart';
import 'package:my_stock/app/presentation/vm/stock.dart';
import 'package:my_stock/app/presentation/vm/stock_transaction.dart';

class AddHistoryScreenViewModel with ChangeNotifier {
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  FocusNode priceFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();

  final bool buy;
  final StockVM stock;

  final CheckStockQuantityUseCase _checkStockQuantityUseCase = CheckStockQuantityUseCase(
    stockRepository: GetIt.I<StockRepository>(),
  );

  AddHistoryScreenViewModel({
    required this.buy,
    required this.stock,
  }) {
    final _formatter = NumberFormat("#,###");
    priceController.text = _formatter.format(stock.price);
    priceFocusNode.addListener(() {
      notifyListeners();
    });
    quantityFocusNode.addListener(() {
      notifyListeners();
    });
    priceController.addListener(() {
      String text = priceController.text.replaceAll(",", "");
      if (text.length > 6) {
        text = text.substring(0, 6);
        priceController.text = _formatter.format(int.parse(text));
      }
      priceController.selection =
          TextSelection.fromPosition(TextPosition(offset: priceController.text.length));
      notifyListeners();
    });
    quantityController.addListener(() {
      String text = quantityController.text.replaceAll(",", "");
      if (text.length > 6) {
        text = text.substring(0, 6);
        quantityController.text = _formatter.format(int.parse(text));
      }
      quantityController.selection =
          TextSelection.fromPosition(TextPosition(offset: quantityController.text.length));
      notifyListeners();
    });
  }

  void onTap() {
    if (priceController.text.isEmpty) {
      MySnackBar.show("가격을 입력하세요");
      return;
    }
    if (quantityController.text.isEmpty) {
      MySnackBar.show("수량을 입력하세요");
      return;
    }
    StockTransactionVM transactionVM = StockTransactionVM(
      ticker: stock.ticker,
      imageUrl: stock.imageUrl,
      name: stock.name,
      price: int.parse(priceController.text.replaceAll(",", "")),
      quantity: int.parse(quantityController.text.replaceAll(",", "")),
      buy: buy,
    );

    if (!buy) {
      EasyLoading.show(status: "Loading...");
      _checkStockQuantityUseCase(
        ticker: stock.ticker,
        quantity: int.parse(quantityController.text.replaceAll(",", "")),
        onCanSell: () {
          MyNavigator.pop(transactionVM);
        },
        onCannotSell: (maxQuantity) {
          MySnackBar.show("최대 ${maxQuantity}주 판매할 수 있습니다.");
        },
      ).then((value) {
        EasyLoading.dismiss();
      });
    } else {
      MyNavigator.pop(transactionVM);
    }
  }
}
