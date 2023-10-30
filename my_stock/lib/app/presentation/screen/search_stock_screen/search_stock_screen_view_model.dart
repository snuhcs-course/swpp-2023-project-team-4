import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/util/debouncer.dart';
import 'package:my_stock/app/presentation/vm/stock.dart';

const List<StockVM> originList = [
  StockVM(name: "삼성전자", imageUrl: "", price: 81000),
  StockVM(name: "SK하이닉스", imageUrl: "", price: 130000),
  StockVM(name: "NAVER", imageUrl: "", price: 400000),
  StockVM(name: "삼성바이오로직스", imageUrl: "", price: 800000),
  StockVM(name: "LG화학", imageUrl: "", price: 800000),
  StockVM(name: "LG전자", imageUrl: "", price: 50100),
  StockVM(name: "삼성SDI", imageUrl: "", price: 23200),
  StockVM(name: "LG디스플레이", imageUrl: "", price: 15000),
];

class SearchStockScreenViewModel with ChangeNotifier {
  final _searchDebouncer = Debouncer(delay: Duration(milliseconds: 500));
  final TextEditingController controller = TextEditingController();
  List<StockVM> searchedList = [];

  SearchStockScreenViewModel() {
    controller.addListener(() async {
      searchedList.clear();
      notifyListeners();

      String text = controller.text;
      String replacedText = text.replaceAll(" ", "");
      if (replacedText.isNotEmpty) {
        _searchDebouncer(() {
          searchedList = originList.where((element) => element.name.contains(text)).toList();
          notifyListeners();
        });
      }
    });
  }
}
