part of '../calendar_screen.dart';

class _YearMonthChangeDialog extends StatelessWidget {
  YearMonth selectedYearMonth;
  final void Function(YearMonth yearMonth) onConfirm;

  _YearMonthChangeDialog({
    super.key,
    required this.selectedYearMonth,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 250,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        color: BackgroundColor.defaultColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: DatePickerWidget(
              initialDate: DateTime(selectedYearMonth.year, selectedYearMonth.month, 1),
              dateFormat: "yyyy년 MM월",
              pickerTheme: DateTimePickerTheme(
                backgroundColor: BackgroundColor.defaultColor,
                dividerColor: EmotionColor.happier,
                itemTextStyle: BodyTextStyle.nanum14.black,
              ),
              onChange: (DateTime dateTime, _) {
                this.selectedYearMonth = YearMonth.fromDateTime(dateTime);
              },
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: MyNavigator.pop,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                ),
                child: Text('취소', style: BodyTextStyle.nanum14.black),
              ),
              TextButton(
                onPressed: () {
                  onConfirm(selectedYearMonth);
                  MyNavigator.pop();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                ),
                child: Text('확인', style: BodyTextStyle.nanum14.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}