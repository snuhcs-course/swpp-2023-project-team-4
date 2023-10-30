import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddBuyHistoryScreenViewModel with ChangeNotifier {
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  FocusNode priceFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();

  AddBuyHistoryScreenViewModel() {
    final _formatter = NumberFormat("#,###");
    priceFocusNode.addListener(() {
      notifyListeners();
    });
    quantityFocusNode.addListener(() {
      notifyListeners();
    });
    priceController.addListener(() {
      if (priceController.text.isEmpty) return;
      priceController.text = _formatter.format(int.parse(priceController.text.replaceAll(",", "")));
      priceController.selection =
          TextSelection.fromPosition(TextPosition(offset: priceController.text.length));
      notifyListeners();
    });
    quantityController.addListener(() {
      if (quantityController.text.isEmpty) return;
      quantityController.text =
          _formatter.format(int.parse(quantityController.text.replaceAll(",", "")));
      quantityController.selection =
          TextSelection.fromPosition(TextPosition(offset: quantityController.text.length));
      notifyListeners();
    });
  }
}
