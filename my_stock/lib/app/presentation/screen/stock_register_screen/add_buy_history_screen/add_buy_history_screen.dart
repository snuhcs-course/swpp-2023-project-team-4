import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/widget/number_keyboard.dart';
import 'package:my_stock/core/theme/color_theme.dart';

class AddBuyHistoryScreen extends StatelessWidget {
  const AddBuyHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.defaultColor,
      body: Center(
        child: NumberKeyboard(
          controller: TextEditingController(),
        ),
      ),
    );
  }
}
