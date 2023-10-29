import 'package:flutter/material.dart';
import 'package:my_stock/core/theme/text_theme.dart';

class Button extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color borderColor;

  const Button({
    super.key,
    required this.onTap,
    required this.text,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(text, style: OtherTextStyle.button.black),
      ),
    );
  }
}
