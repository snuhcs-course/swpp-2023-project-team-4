import 'package:flutter/material.dart';
import 'package:my_stock/core/theme/text_theme.dart';

class _KeyboardTile extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final void Function()? onTap;
  final bool disabled;

  const _KeyboardTile({
    super.key,
    required this.controller,
    required this.text,
    this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            if (disabled) return;
            controller.text = controller.text + text;
          },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(text, style: HeaderTextStyle.nanum24),
      ),
    );
  }
}

class NumberKeyboard extends StatelessWidget {
  final TextEditingController controller;

  const NumberKeyboard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "1",
              ),
            ),
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "2",
              ),
            ),
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "3",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "4",
              ),
            ),
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "5",
              ),
            ),
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "6",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "7",
              ),
            ),
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "8",
              ),
            ),
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "9",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: " ",
                disabled: true,
              ),
            ),
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "0",
              ),
            ),
            Expanded(
              child: _KeyboardTile(
                controller: controller,
                text: "←",
                onTap: () {
                  if (controller.text.isEmpty) return;
                  controller.text = controller.text.substring(0, controller.text.length - 1);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
