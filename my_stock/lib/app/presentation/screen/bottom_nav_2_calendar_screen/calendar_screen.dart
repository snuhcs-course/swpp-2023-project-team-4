import 'package:flutter/material.dart';import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/calendar_screen_view_model.dart';import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/date_emotion.dart';import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/record_emotion_screen/record_emotion_screen.dart';import 'package:my_stock/app/presentation/util/my_navigator.dart';import 'package:my_stock/app/presentation/util/my_snackbar.dart';import 'package:my_stock/core/theme/color_theme.dart';import 'package:my_stock/core/theme/text_theme.dart';import 'package:my_stock/core/util/date.dart';import 'package:my_stock/core/util/year_month.dart';import 'package:provider/provider.dart';part 'widget/calendar_date.dart';part 'widget/year_month_change_dialog.dart';class CalendarScreen extends StatelessWidget {  const CalendarScreen({super.key});  @override  Widget build(BuildContext context) {    return ChangeNotifierProvider(      create: (_) => CalendarScreenViewModel(),      child: Scaffold(        backgroundColor: BackgroundColor.defaultColor,        body: SafeArea(          child: SingleChildScrollView(            physics: const ClampingScrollPhysics(),            child: Padding(              padding: EdgeInsets.symmetric(horizontal: 14),              child: Column(                children: [                  const SizedBox(height: 23),                  Consumer<CalendarScreenViewModel>(builder: (context, viewModel, child) {                    return GestureDetector(                      behavior: HitTestBehavior.opaque,                      onTap: () {                        showDialog(                          context: context,                          builder: (innerContext) => Dialog(                            child: _YearMonthChangeDialog(                              selectedYearMonth: context.read<CalendarScreenViewModel>().yearMonth,                              onConfirm: context.read<CalendarScreenViewModel>().setYearMonth,                            ),                            shape: RoundedRectangleBorder(                              borderRadius: BorderRadius.circular(20),                            ),                          ),                          barrierDismissible: true,                        );                      },                      child: Row(                        mainAxisAlignment: MainAxisAlignment.center,                        mainAxisSize: MainAxisSize.min,                        children: [                          // 터치영역 확장용 const SizedBox(width: 5),                          Text(                            "${viewModel.yearMonth.year}년 ${viewModel.yearMonth.month}월",                            style: HeaderTextStyle.nanum16.writeText,                          ),                          Padding(                            padding: const EdgeInsets.symmetric(horizontal: 10),                            child: Image.asset('assets/images/downward_arrow.png'),                          ), // 터치영역 확장용                          const SizedBox(width: 5),                        ],                      ),                    );                  }),                  const SizedBox(height: 25),                  _Calendar(),                  const SizedBox(height: 70),                  Consumer<CalendarScreenViewModel>(builder: (_, viewModel, __) {                    if (viewModel.selectedDate == null) return SizedBox.shrink();                    return Container(                      width: double.infinity,                      padding: EdgeInsets.symmetric(                        horizontal: 15,                        vertical: 20,                      ),                      decoration: BoxDecoration(                        color: BackgroundColor.white,                        border: Border.all(                          color: StrokeColor.writeText,                          width: 1,                        ),                        borderRadius: BorderRadius.circular(20),                      ),                      child: Row(                        children: [                          Container(                            padding: EdgeInsets.symmetric(vertical: 7.5).copyWith(                              right: 10,                            ),                            decoration: BoxDecoration(                              border: Border(                                right: BorderSide(                                  color: StrokeColor.writeText,                                  width: 1,                                ),                              ),                            ),                            child: Column(                              children: [                                Container(                                  width: 45,                                  height: 45,                                  decoration: BoxDecoration(                                    borderRadius: BorderRadius.circular(15),                                    color: viewModel.selectedEmotion.color,                                  ),                                ),                                const SizedBox(height: 10),                                Text(                                  "${viewModel.selectedDate!.day}(${viewModel.selectedDate!.dayOfWeek})",                                  style: BodyTextStyle.nanum12.black,                                ),                              ],                            ),                          ),                          const SizedBox(width: 10),                          Expanded(                            child: Text(                              viewModel.selectedText,                              style: BodyTextStyle.nanum12.black,                              maxLines: 5,                              overflow: TextOverflow.ellipsis,                            ),                          ),                        ],                      ),                    );                  }),                  const SizedBox(height: 80),                ],              ),            ),          ),        ),      ),    );  }}class _Calendar extends StatelessWidget {  const _Calendar({super.key});  @override  Widget build(BuildContext context) {    return Container(      width: double.infinity,      child: Column(        crossAxisAlignment: CrossAxisAlignment.start,        children: [          Row(            children: [              Expanded(child: Center(child: Text("일"))),              const SizedBox(width: 3),              Expanded(child: Center(child: Text("월"))),              const SizedBox(width: 3),              Expanded(child: Center(child: Text("화"))),              const SizedBox(width: 3),              Expanded(child: Center(child: Text("수"))),              const SizedBox(width: 3),              Expanded(child: Center(child: Text("목"))),              const SizedBox(width: 3),              Expanded(child: Center(child: Text("금"))),              const SizedBox(width: 3),              Expanded(child: Center(child: Text("토"))),            ],          ),          const SizedBox(height: 20),          _CalendarBody(),        ],      ),    );  }}class _CalendarBody extends StatelessWidget {  const _CalendarBody({super.key});  @override  Widget build(BuildContext context) {    List<DateEmotionVM> list = context.watch<CalendarScreenViewModel>().dateEmotionList;    Map<Date, bool> isSelectedMap = context.watch<CalendarScreenViewModel>().isSelectedMap;    void Function(Date) onDateSelected =        context.read<CalendarScreenViewModel>().onCalendarDateSelected;    List<Widget> children = [];    void Function(DateEmotionVM) updateDateEmotion =        context.read<CalendarScreenViewModel>().updateDateEmotion;    List<Widget> rowChildren = [];    bool Function(Date) hasRecord = context.read<CalendarScreenViewModel>().hasRecord;    for (int i = 0; i < list.length; i++) {      rowChildren.add(        Expanded(          child: _CalendarDate(            dateEmotionVM: list[i],            isSelected: isSelectedMap[list[i].date] ?? false,            onTap: (Date date) async {              onDateSelected(date);              Date currentDate = Date.fromDateTime(DateTime.now());              bool sameWeek = date.isSameWeek(currentDate);              if (!sameWeek) {                MySnackBar.show("이전 주는 기록할 수 없습니다.");                return;              }              if (hasRecord(date)) {                return;              }              await Future.delayed(Duration(milliseconds: 70));              MyNavigator.push(                RecordEmotionScreen(date: date),                name: "record",              ).then((value) {                if (value is DateEmotionVM) {                  updateDateEmotion(value);                }              });            },          ),        ),      );      rowChildren.add(const SizedBox(width: 3));      if (i % 7 == 6) {        rowChildren.removeLast();        children.add(Row(children: rowChildren)); // i가 마지막 인덱스가 아니면, 원소가 더 있을 것이다.        if (i != list.length - 1) children.add(const SizedBox(height: 15));        rowChildren = [];      }    }    if (rowChildren.isNotEmpty) {      children.add(Row(children: rowChildren));    }    return Column(children: children);  }}