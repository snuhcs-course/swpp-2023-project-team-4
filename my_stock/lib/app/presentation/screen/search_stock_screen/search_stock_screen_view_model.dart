import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/stock.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/use_case/stock_search_use_case.dart';
import 'package:my_stock/app/presentation/util/debouncer.dart';
import 'package:my_stock/app/presentation/vm/stock.dart';

class SearchStockScreenViewModel with ChangeNotifier {
  final StockSearchUseCase _stockSearchUseCase =
      StockSearchUseCase(stockRepository: GetIt.I.get<StockRepository>());
  final _searchDebouncer = Debouncer(delay: Duration(milliseconds: 200));
  String prevStr = "";
  final TextEditingController controller = TextEditingController();
  List<StockVM> searchedList = [];

  SearchStockScreenViewModel() {
    controller.addListener(() {
      if (prevStr == controller.text) return;
      searchedList.clear();
      notifyListeners();
      _searchDebouncer(
        () {
          String text = controller.text;
          String replacedText = text.replaceAll(" ", "");
          if (replacedText.isEmpty) return;
          prevStr = text;
          _stockSearchUseCase(
            pattern: text,
            onSuccess: (List<Stock> stockList) {
              searchedList.clear();
              for (Stock stock in stockList) {
                searchedList.add(
                  StockVM(
                    ticker: stock.ticker,
                    name: stock.name,
                    imageUrl: "",
                    price: stock.currentPrice,
                    fluctuationRate: stock.fluctuationRate,
                  ),
                );
              }
              notifyListeners();
            },
          );
        },
      );
    });
  }
}
