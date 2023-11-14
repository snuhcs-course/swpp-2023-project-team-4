import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/app/presentation/screen/stock_register_screen/add_history_screen/add_history_screen.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/app/presentation/vm/stock.dart';
import 'package:my_stock/app/presentation/widget/button.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';

class StockRegisterScreen extends StatelessWidget {
  final StockVM stock;

  const StockRegisterScreen(this.stock, {super.key});

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat("#,###");
    return Scaffold(
      backgroundColor: BackgroundColor.defaultColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Image.asset("assets/images/arrow_back.png", width: 24),
                  ),
                ),
              ],
            ),
            Spacer(flex: 1),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  width: 150,
                  height: 150,
                  imageUrl: stock.imageUrl,
                  errorWidget: (context, url, error) => Container(
                    width: 150,
                    height: 150,
                    color: StrokeColor.writeText,
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
            Column(
              children: [
                const SizedBox(height: 10),
                Text(stock.name, style: HeaderTextStyle.nanum18.black),
                const SizedBox(height: 8),
                Text("${formatter.format(stock.price)}원", style: HeaderTextStyle.nanum20Bold.black),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("어제보다", style: BodyTextStyle.nanum12Light.black),
                    const SizedBox(width: 5),
                    Text(
                      "${stock.fluctuationRate > 0 ? "+" : "-"}원 (${stock.fluctuationRate}}%)",
                      style: BodyTextStyle.nanum12Light.copyWith(
                        color:
                            stock.fluctuationRate >= 0 ? EmotionColor.happier : EmotionColor.sadder,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
            Spacer(flex: 2),
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                children: [
                  Button(
                    onTap: () {
                      MyNavigator.push(
                        AddHistoryScreen(stock, buy: true),
                      ).then((value) {
                        if (value != null) {
                          MyNavigator.pop(value);
                        }
                      });
                    },
                    text: "구매내역 추가하기",
                    borderColor: StrokeColor.buy,
                  ),
                  const SizedBox(height: 20),
                  Button(
                    onTap: () {
                      MyNavigator.push(
                        AddHistoryScreen(stock, buy: false),
                      ).then((value) {
                        if (value != null) {
                          MyNavigator.pop(value);
                        }
                      });
                    },
                    text: "판매내역 추가하기",
                    borderColor: StrokeColor.sell,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
