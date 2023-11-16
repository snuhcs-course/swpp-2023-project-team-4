import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/use_case/record_emotion_stock_use_case.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/app/presentation/util/my_snackbar.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/app/presentation/vm/stock_transaction.dart';
import 'package:my_stock/core/util/date.dart';
import 'package:my_stock/core/util/pair.dart';

class RecordEmotionScreenViewModel with ChangeNotifier {
  final RecordEmotionStockUseCase _recordEmotionStockUseCase = RecordEmotionStockUseCase(
    stockRepository: GetIt.I<StockRepository>(),
    emotionRepository: GetIt.I<EmotionRepository>(),
  );
  final TextEditingController textEditingController = TextEditingController();
  final List<StockTransactionVM> transactionList = [];

  List<Pair<EmotionVMEnum, bool>> selectList = [
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.happier, false),
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.happy, false),
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.neutral, false),
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.sad, false),
    Pair<EmotionVMEnum, bool>(EmotionVMEnum.sadder, false),
  ];

  final Date date;

  RecordEmotionScreenViewModel({required this.date});

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

  void onSubmitButtonTap() async {
    EmotionVMEnum selectedEmotionVM;
    try {
      selectedEmotionVM = selectList.firstWhere((element) => element.second).first;
    } catch (e) {
      MySnackBar.show("감정을 선택해주세요.");
      return;
    }
    EasyLoading.show();
    await _recordEmotionStockUseCase(
      date: date,
      transactionList: transactionList,
      emotion: selectedEmotionVM.toEmotionEnum,
      text: textEditingController.text,
      onSuccess: () {
        MyNavigator.pop();
      },
      onFail: () {},
      beforeThisWeek: () {},
    ).then((value) {
      EasyLoading.dismiss();
    });
  }
}
