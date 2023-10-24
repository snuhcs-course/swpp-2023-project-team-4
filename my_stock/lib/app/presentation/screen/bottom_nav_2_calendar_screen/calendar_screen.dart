import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/calendar_screen_view_model.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/date_emotion.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:my_stock/core/util/date.dart';
import 'package:my_stock/core/util/year_month.dart';
import 'package:provider/provider.dart';

part 'widget/calendar_date.dart';

part 'widget/record_emotion_dialog.dart';

part 'widget/year_month_change_dialog.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalendarScreenViewModel(),
      child: Scaffold(
        backgroundColor: BackgroundColor.defaultColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  const SizedBox(height: 23),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<CalendarScreenViewModel>(builder: (context, viewModel, child) {
                        return Text(
                          "${viewModel.yearMonth.year}년 ${viewModel.yearMonth.month}월",
                          style: HeaderTextStyle.nanum16.writeText,
                        );
                      }),
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (innerContext) => Dialog(
                                child: _YearMonthChangeDialog(
                                  selectedYearMonth:
                                      context.read<CalendarScreenViewModel>().yearMonth,
                                  onConfirm: context.read<CalendarScreenViewModel>().setYearMonth,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              barrierDismissible: true,
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset('assets/images/downward_arrow.png'),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 25),
                  _Calendar(),
                  const SizedBox(height: 70),
                  Container(
                    width: double.infinity,
                    height: 115,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: BackgroundColor.white,
                      border: Border.all(
                        color: StrokeColor.writeText,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Calendar extends StatelessWidget {
  const _Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Center(child: Text("일"))),
              const SizedBox(width: 3),
              Expanded(child: Center(child: Text("월"))),
              const SizedBox(width: 3),
              Expanded(child: Center(child: Text("화"))),
              const SizedBox(width: 3),
              Expanded(child: Center(child: Text("수"))),
              const SizedBox(width: 3),
              Expanded(child: Center(child: Text("목"))),
              const SizedBox(width: 3),
              Expanded(child: Center(child: Text("금"))),
              const SizedBox(width: 3),
              Expanded(child: Center(child: Text("토"))),
            ],
          ),
          const SizedBox(height: 20),
          _CalendarBody(),
        ],
      ),
    );
  }
}

class _CalendarBody extends StatelessWidget {
  const _CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateEmotionVM> list = context.watch<CalendarScreenViewModel>().dateEmotionList;
    Map<Date, bool> isSelectedMap = context.watch<CalendarScreenViewModel>().isSelectedMap;
    void Function(Date) onDateSelected =
        context.read<CalendarScreenViewModel>().onCalendarDateSelected;

    List<Widget> children = [];

    List<Widget> rowChildren = [];
    for (int i = 0; i < list.length; i++) {
      rowChildren.add(
        Expanded(
          child: _CalendarDate(
            dateEmotionVM: list[i],
            isSelected: isSelectedMap[list[i].date] ?? false,
            onTap: (Date date) async {
              onDateSelected(date);
              await Future.delayed(Duration(milliseconds: 70));
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: _RecordEmotionDialog(
                    onEmotionSelected:
                        context.read<CalendarScreenViewModel>().onSelectEmotion(date),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            },
          ),
        ),
      );
      rowChildren.add(const SizedBox(width: 3));
      if (i % 7 == 6) {
        rowChildren.removeLast();
        children.add(Row(children: rowChildren));
        // i가 마지막 인덱스가 아니면, 원소가 더 있을 것이다.
        if (i != list.length - 1) children.add(const SizedBox(height: 15));
        rowChildren = [];
      }
    }
    if (rowChildren.isNotEmpty) {
      children.add(Row(children: rowChildren));
    }

    return Column(children: children);
  }
}
