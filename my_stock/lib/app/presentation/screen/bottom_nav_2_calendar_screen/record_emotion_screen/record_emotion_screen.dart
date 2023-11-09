import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/record_emotion_screen/record_emotion_screen_view_model.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/app/presentation/vm/stock_transaction.dart';
import 'package:my_stock/app/presentation/widget/gap_layout.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:my_stock/core/util/date.dart';
import 'package:provider/provider.dart';

part 'widget/selectable_box.dart';
part 'widget/transaction_tile.dart';

class RecordEmotionScreen extends StatelessWidget {
  final Date date;

  const RecordEmotionScreen({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecordEmotionScreenViewModel(),
      child: Scaffold(
        backgroundColor: BackgroundColor.defaultColor,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 37),
                      child: Text("${date.month}월 ${date.day}일 ${date.dayOfWeek}요일",
                          style: HeaderTextStyle.nanum16),
                    ),
                    Positioned(
                      right: 5,
                      top: 20,
                      child: IconButton(
                        onPressed: () {
                          MyNavigator.pop();
                        },
                        icon: Icon(Icons.close, size: 32),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: StrokeColor.writeText, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("오늘 하루를 기록해주세요", style: PretendardTextStyle.semiBold15.black),
                            const SizedBox(height: 18),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                double maxWidth = constraints.maxWidth;
                                double containerMaxWidth = (maxWidth - 40) / 5;
                                List<Widget> selectBoxList = [];
                                for (int i = 0; i < 5; i++) {
                                  selectBoxList.add(
                                    _SelectableBox(
                                      width: containerMaxWidth,
                                      emotion: context
                                          .watch<RecordEmotionScreenViewModel>()
                                          .selectList[i]
                                          .first,
                                      isSelected: context
                                          .watch<RecordEmotionScreenViewModel>()
                                          .selectList[i]
                                          .second,
                                      onTap: context.read<RecordEmotionScreenViewModel>().onTap(i),
                                    ),
                                  );
                                }
                                return GapRow(
                                  gap: 10,
                                  children: selectBoxList,
                                );
                              },
                            ),
                            const SizedBox(height: 18),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: StrokeColor.writeText, width: 1),
                              ),
                              child: Builder(builder: (context) {
                                return TextFormField(
                                  controller: context
                                      .read<RecordEmotionScreenViewModel>()
                                      .textEditingController,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "오늘 하루를 기록해주세요\n너무슬프다흑흑",
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: StrokeColor.writeText, width: 1),
                        ),
                        child: Column(
                          children: [
                            Text("추가할 거래내역이 있으신가요?", style: PretendardTextStyle.semiBold15.black),
                            const SizedBox(height: 18),
                            GapColumn(
                              gap: 10,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: EmotionColor.notFilled,
                                      ),
                                      child: Icon(Icons.add, size: 25, color: Colors.grey),
                                    ),
                                    const SizedBox(width: 10),
                                    Text("주식 거래내역 추가하기", style: PretendardTextStyle.light13.black),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
