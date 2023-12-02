import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_1_balance_screen/balance_screen_view_model.dart';
import 'package:my_stock/app/presentation/widget/gap_layout.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:provider/provider.dart';

class BalanceScreen extends StatelessWidget {
  final _numberFormat = NumberFormat("#,###");

  BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BalanceScreenViewModel(),
      child: Scaffold(
        backgroundColor: BackgroundColor.defaultColor,
        body: SafeArea(
          child: Consumer<BalanceScreenViewModel>(builder: (_, viewModel, __) {
            if (viewModel.isLoading) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "나의 잔고",
                        style: HeaderTextStyle.nanum20Bold,
                      ),
                    ),
                    Expanded(child: CupertinoActivityIndicator()),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "나의 잔고",
                        style: HeaderTextStyle.nanum20Bold,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: StrokeColor.writeText,
                          width: 1,
                        ),
                        color: BackgroundColor.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("보유 주식", style: PretendardTextStyle.semiBold15.black),
                          const SizedBox(height: 10),
                          Text(_numberFormat.format(635800), style: HeaderTextStyle.nanum18.black),
                          Text(
                            "-23.68% (197,350원)",
                            style: BodyTextStyle.nanum12.copyWith(color: EmotionColor.sadder),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: StrokeColor.writeText,
                          width: 1,
                        ),
                        color: BackgroundColor.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("가나다 순", style: PretendardTextStyle.semiBold15),
                          const SizedBox(height: 20),
                          GapColumn(
                            gap: 10,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("CJ ENM", style: HeaderTextStyle.nanum16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("432,800원", style: HeaderTextStyle.nanum16),
                                      Text(
                                        "+23.68% (197,350원)",
                                        style: BodyTextStyle.nanum12
                                            .copyWith(color: EmotionColor.happier),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("카카오뱅크", style: HeaderTextStyle.nanum16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("203,000원", style: HeaderTextStyle.nanum16),
                                      Text(
                                        "-23.68% (197,350원)",
                                        style: BodyTextStyle.nanum12
                                            .copyWith(color: EmotionColor.sadder),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text("+ 주식 추가하기", style: BodyTextStyle.nanum14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: StrokeColor.writeText,
                          width: 1,
                        ),
                        color: BackgroundColor.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Emostock만의 주식 분석", style: PretendardTextStyle.semiBold15),
                          const SizedBox(height: 20),
                          Text("대충 텍스트"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
