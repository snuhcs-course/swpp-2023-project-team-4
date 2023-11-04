import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddHistoryScreenViewModel with ChangeNotifier {
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  FocusNode priceFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();

  final bool buy;

  AddHistoryScreenViewModel({
    required this.buy,
  }) {
    final _formatter = NumberFormat("#,###");
    priceFocusNode.addListener(() {
      notifyListeners();
    });
    quantityFocusNode.addListener(() {
      notifyListeners();
    });
    priceController.addListener(() {
      priceController.selection =
          TextSelection.fromPosition(TextPosition(offset: priceController.text.length));
      notifyListeners();
    });
    quantityController.addListener(() {
      quantityController.selection =
          TextSelection.fromPosition(TextPosition(offset: quantityController.text.length));
      notifyListeners();
    });
  }
}