import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/app/presentation/vm/stock.dart';
import 'package:my_stock/app/presentation/widget/button.dart';
import 'package:my_stock/app/presentation/widget/fit_text_field.dart';
import 'package:my_stock/app/presentation/widget/number_keyboard.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:provider/provider.dart';

import 'add_history_screen_view_model.dart';

class AddHistoryScreen extends StatelessWidget {
  final StockVM stock;
  final bool buy;

  const AddHistoryScreen(
    this.stock, {
    super.key,
    required this.buy,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat("#,###");
    return ChangeNotifierProvider(
      create: (context) => AddHistoryScreenViewModel(buy: buy),
      child: Scaffold(
        backgroundColor: BackgroundColor.defaultColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Image.asset("assets/images/arrow_back.png", width: 24),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(stock.name, style: HeaderTextStyle.nanum16.black),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${formatter.format(stock.price)}원",
                                style: BodyTextStyle.nanum12Light.black,
                              ),
                              const SizedBox(width: 10),
                              Builder(
                                builder: (context) {
                                  return Text(
                                    "-2.5%",
                                    style: BodyTextStyle.nanum12Light.copyWith(
                                      color: context.read<AddHistoryScreenViewModel>().buy
                                          ? IconColor.selected
                                          : StrokeColor.sell,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _PriceQuantityInput(stock: stock),
              ),
              Builder(
                builder: (context) {
                  FocusNode priceFocusNode =
                      context.watch<AddHistoryScreenViewModel>().priceFocusNode;
                  FocusNode quantityFocusNode =
                      context.watch<AddHistoryScreenViewModel>().quantityFocusNode;
                  TextEditingController priceController =
                      context.read<AddHistoryScreenViewModel>().priceController;
                  TextEditingController quantityController =
                      context.read<AddHistoryScreenViewModel>().quantityController;
                  TextEditingController otherController =
                      context.read<AddHistoryScreenViewModel>().otherController;
                  return NumberKeyboard(
                    controller: priceFocusNode.hasFocus
                        ? priceController
                        : quantityFocusNode.hasFocus
                            ? quantityController
                            : otherController,
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Builder(builder: (context) {
                  return Button(
                    onTap: () {},
                    text: "${context.read<AddHistoryScreenViewModel>().buy ? "구매" : "판매"}내역 추가하기",
                    borderColor: context.read<AddHistoryScreenViewModel>().buy
                        ? StrokeColor.buy
                        : StrokeColor.sell,
                  );
                }),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceQuantityInput extends StatefulWidget {
  _PriceQuantityInput({
    super.key,
    required this.stock,
  });

  final StockVM stock;

  @override
  State<_PriceQuantityInput> createState() => _PriceQuantityInputState();
}

class _PriceQuantityInputState extends State<_PriceQuantityInput> {
  final _formatter = NumberFormat("#,###");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddHistoryScreenViewModel>().priceFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${context.read<AddHistoryScreenViewModel>().buy ? "구매" : "판매"}가격",
              style: HeaderTextStyle.nanum18),
          const SizedBox(height: 8),
          Row(
            children: [
              FitTextField(
                focusNode: context.read<AddHistoryScreenViewModel>().priceFocusNode,
                controller: context.read<AddHistoryScreenViewModel>().priceController,
                textStyle: HeaderTextStyle.nanum24.black,
                hintText: _formatter.format(widget.stock.price),
              ),
              Text("원", style: HeaderTextStyle.nanum24),
            ],
          ),
          const SizedBox(height: 20),
          FitTextField(
            focusNode: context.read<AddHistoryScreenViewModel>().quantityFocusNode,
            controller: context.read<AddHistoryScreenViewModel>().quantityController,
            textStyle: HeaderTextStyle.nanum24.black,
            hintText: "몇 주 ${context.read<AddHistoryScreenViewModel>().buy ? "구매" : "판매"}하셨나요?",
            minWidth: 200,
          ),
          const SizedBox(height: 8),
          Consumer<AddHistoryScreenViewModel>(builder: (_, viewModel, __) {
            if (viewModel.priceController.text.isEmpty ||
                viewModel.quantityController.text.isEmpty) {
              return SizedBox.shrink();
            }
            int price = int.parse(viewModel.priceController.text.replaceAll(",", ""));
            int quantity = int.parse(viewModel.quantityController.text.replaceAll(",", ""));
            int total = price * quantity;
            List<String> textList = [];
            if (total >= 100000000) {
              int first = total ~/ 100000000;
              int second = (total % 100000000) ~/ 10000;
              int third = total % 10000;
              textList.add("${_formatter.format(first)}억");
              if (second != 0) textList.add(" ${_formatter.format(second)}만");
              if (third != 0) textList.add(" ${_formatter.format(third)}");
            } else if (total >= 10000) {
              int first = total ~/ 10000;
              int second = total % 10000;
              textList.add("${_formatter.format(first)}만");
              if (second != 0) textList.add(" ${_formatter.format(second)}");
            } else {
              textList.add("${_formatter.format(total)}");
            }
            return Text(
              "${textList.join()}원",
              style: HeaderTextStyle.nanum16.copyWith(
                color: context.read<AddHistoryScreenViewModel>().buy
                    ? IconColor.selected
                    : StrokeColor.sell,
              ),
            );
          }),
        ],
      ),
    );
  }
}
