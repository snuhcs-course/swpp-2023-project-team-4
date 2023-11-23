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
    required int defaultPrice,
  }) {
    final _formatter = NumberFormat("#,###");
    priceController.text = _formatter.format(defaultPrice);
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
}
