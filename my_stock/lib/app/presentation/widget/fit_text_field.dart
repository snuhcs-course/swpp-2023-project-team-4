import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:my_stock/core/theme/color_theme.dart';

class FitTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final TextStyle textStyle;
  final double minWidth;
  final String? hintText;

  const FitTextField({
    Key? key,
    this.focusNode,
    required this.controller,
    required this.textStyle,
    this.minWidth = 100,
    this.hintText,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new FitTextFieldState();
}

class FitTextFieldState extends State<FitTextField> {
  final intl.NumberFormat _formatter = intl.NumberFormat("#,###");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use TextPainter to calculate the width of our text
    TextSpan ts = new TextSpan(style: widget.textStyle, text: widget.controller.text);
    TextPainter tp = new TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();
    var textWidth = tp.width; // We will use this width for the container wrapping our TextField

    // Enforce a minimum width
    if (textWidth < widget.minWidth) {
      textWidth = widget.minWidth;
    }

    return Container(
      width: textWidth,
      child: TextFormField(
        focusNode: widget.focusNode,
        readOnly: true,
        showCursor: true,
        cursorColor: StrokeColor.writeText,
        style: widget.textStyle,
        controller: widget.controller,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: widget.textStyle.copyWith(color: StrokeColor.writeText),
        ),
      ),
    );
  }
}
