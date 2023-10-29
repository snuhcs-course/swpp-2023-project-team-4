import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/util/debouncer.dart';

const List<String> originList = [
  "삼성전자",
  "SK하이닉스",
  "NAVER",
  "삼성바이오로직스",
  "LG화학",
  "LG전자",
  "삼성SDI",
  "LG디스플레이",
];

class SearchStockScreenViewModel with ChangeNotifier {
  final _searchDebouncer = Debouncer(delay: Duration(milliseconds: 200));
  final TextEditingController controller = TextEditingController();
  List<String> searchedList = [];

  SearchStockScreenViewModel() {
    controller.addListener(() async {
      searchedList.clear();
      notifyListeners();

      String text = controller.text;
      String replacedText = text.replaceAll(" ", "");
      if (replacedText.isNotEmpty) {
        _searchDebouncer(() {
          searchedList = originList.where((element) => element.contains(text)).toList();
          notifyListeners();
        });
      }
    });
  }
}
