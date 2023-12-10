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
                          if (viewModel.stockBalanceListVM.isEmpty)
                            Text("보유 주식이 없습니다.", style: BodyTextStyle.nanum12.black),
                          if (!viewModel.stockBalanceListVM.isEmpty)
                            Text(_numberFormat.format(viewModel.stockBalanceListVM.totalBalance),
                                style: HeaderTextStyle.nanum18.black),
                          if (!viewModel.stockBalanceListVM.isEmpty)
                            Text(
                              "${viewModel.stockBalanceListVM.totalProfitAndLoss >= 0 ? "+" : ""}${viewModel.stockBalanceListVM.totalProfitAndLossRate}% (${_numberFormat.format(viewModel.stockBalanceListVM.totalProfitAndLoss.abs())}원)",
                              style: BodyTextStyle.nanum12.copyWith(
                                  color: viewModel.stockBalanceListVM.isProfit
                                      ? EmotionColor.happier
                                      : EmotionColor.sadder),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (!viewModel.stockBalanceListVM.isEmpty)
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
                              children: viewModel.stockBalanceListVM.stockBalanceList
                                  .map(
                                    (e) => Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e.name, style: HeaderTextStyle.nanum16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text("${_numberFormat.format(e.balance)}원",
                                                style: HeaderTextStyle.nanum16),
                                            Text(
                                              "${e.profitAndLossRate >= 0 ? "+${e.profitAndLossRate}" : "${e.profitAndLossRate}"}% (${_numberFormat.format(e.profitAndLoss.abs())}원)",
                                              style: BodyTextStyle.nanum12.copyWith(
                                                  color: e.isProfit
                                                      ? EmotionColor.happier
                                                      : EmotionColor.sadder),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
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
                      child: viewModel.isReportLoading
                          ? CupertinoActivityIndicator()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Emostock만의 주식 분석", style: PretendardTextStyle.semiBold15),
                                const SizedBox(height: 3),
                                Text("관련 레포트가 없을 경우, 시가총액 TOP5의 레포트가 노출됩니다!",
                                    style: BodyTextStyle.nanum12),
                                const SizedBox(height: 30),
                                GapColumn(
                                  gap: 30,
                                  children: viewModel.reportList.map((e) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(e.title, style: PretendardTextStyle.semiBold14.black),
                                        const SizedBox(height: 10),
                                        Text(e.body, style: PretendardTextStyle.light13.black),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 20),
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
