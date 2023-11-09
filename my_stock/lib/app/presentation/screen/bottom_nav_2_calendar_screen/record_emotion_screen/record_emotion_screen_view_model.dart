import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/app/presentation/vm/stock_transaction.dart';
import 'package:my_stock/core/util/pair.dart';

class RecordEmotionScreenViewModel with ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  final List<StockTransactionVM> transactionList = [];

  List<Pair<EmotionVMEnum, bool>> selectList = [
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.happier, false),
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.happy, false),
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.neutral, false),
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.sad, false),
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.sadder, false),
  ];

  void Function() onTap(int index) {
    return () {
      for (int i = 0; i < 5; i++) {
        if (index == i) {
          selectList[i].second = true;
        } else {
          selectList[i].second = false;
        }
      }
      notifyListeners();
    };
  }

  void addTransaction(StockTransactionVM transaction) {
    transactionList.add(transaction);
    notifyListeners();
  }
}
