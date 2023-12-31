part of '../report_screen.dart';

class _CalendarDialog extends StatefulWidget {
  _CalendarDialog({super.key});

  @override
  State<_CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<_CalendarDialog> {
  List<DateTime> _dates = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.range,
              selectedDayHighlightColor: EmotionColor.happier,
            ),
            value: _dates,
            onValueChanged: (dates) {
              if (dates.length == 1) {
                Date date = Date.fromDateTime(dates[0]!);
                Date currentDate = Date.now();
                if (date.isSameWeek(currentDate) && currentDate <= currentDate.friday) {
                  setState(() {
                    _dates.clear();
                  });
                  MySnackBar.show("이번 주 리포트는 금요일 이후 확인할 수 있습니다");
                  return;
                } else if (date > currentDate.lastDayOfWeek) {
                  setState(() {
                    _dates.clear();
                  });
                  MySnackBar.show("미래의 주는 확인할 수 없습니다");
                  return;
                }
                setState(
                  () {
                    _dates = [
                      date.firstDayOfWeek.toDateTime(),
                      date.lastDayOfWeek.toDateTime(),
                    ];
                  },
                );
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    MyNavigator.pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text("취소", style: BodyTextStyle.nanum14.black),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (_dates.isEmpty) {
                      MySnackBar.show("주를 선택해주세요");
                    } else {
                      MyNavigator.pop(
                          (Date.fromDateTime(_dates[0]), Date.fromDateTime(_dates[1]).friday));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text("확인", style: BodyTextStyle.nanum14.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
