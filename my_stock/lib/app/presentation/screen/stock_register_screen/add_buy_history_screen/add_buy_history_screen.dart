import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/app/presentation/vm/stock.dart';
import 'package:my_stock/app/presentation/widget/button.dart';
import 'package:my_stock/app/presentation/widget/fit_text_field.dart';
import 'package:my_stock/app/presentation/widget/number_keyboard.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:provider/provider.dart';

import 'add_buy_history_screen_view_model.dart';

class AddBuyHistoryScreen extends StatelessWidget {
  final StockVM stock;

  const AddBuyHistoryScreen(
    this.stock, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat("#,###");
    return ChangeNotifierProvider(
      create: (context) => AddBuyHistoryScreenViewModel(),
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
                              Text(
                                "-2.5%",
                                style:
                                    BodyTextStyle.nanum12Light.copyWith(color: IconColor.selected),
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
                      context.watch<AddBuyHistoryScreenViewModel>().priceFocusNode;
                  FocusNode quantityFocusNode =
                      context.watch<AddBuyHistoryScreenViewModel>().quantityFocusNode;
                  TextEditingController priceController =
                      context.read<AddBuyHistoryScreenViewModel>().priceController;
                  TextEditingController quantityController =
                      context.read<AddBuyHistoryScreenViewModel>().quantityController;
                  TextEditingController otherController =
                      context.read<AddBuyHistoryScreenViewModel>().otherController;
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
                child: Button(
                  onTap: () {},
                  text: "구매내역 추가하기",
                  borderColor: StrokeColor.buy,
                ),
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
      context.read<AddBuyHistoryScreenViewModel>().priceFocusNode.requestFocus();
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
          Text("구매가격", style: HeaderTextStyle.nanum18),
          const SizedBox(height: 8),
          Row(
            children: [
              FitTextField(
                focusNode: context.read<AddBuyHistoryScreenViewModel>().priceFocusNode,
                controller: context.read<AddBuyHistoryScreenViewModel>().priceController,
                textStyle: HeaderTextStyle.nanum24.black,
                hintText: _formatter.format(widget.stock.price),
              ),
              Text("원", style: HeaderTextStyle.nanum24),
            ],
          ),
          const SizedBox(height: 20),
          FitTextField(
            focusNode: context.read<AddBuyHistoryScreenViewModel>().quantityFocusNode,
            controller: context.read<AddBuyHistoryScreenViewModel>().quantityController,
            textStyle: HeaderTextStyle.nanum24.black,
            hintText: "몇 주 구매하셨나요?",
            minWidth: 200,
          ),
        ],
      ),
    );
  }
}
