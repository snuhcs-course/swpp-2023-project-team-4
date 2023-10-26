part of '../calendar_screen.dart';

class _CalendarDate extends StatelessWidget {
  final bool isSelected;
  final DateEmotionVM dateEmotionVM;
  final void Function(Date) onTap;

  const _CalendarDate({
    super.key,
    required this.isSelected,
    required this.dateEmotionVM,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (dateEmotionVM.date == null) return;
        if (dateEmotionVM.emotion == null) return;
        onTap(dateEmotionVM.date!);
      },
      child: Column(
        children: [
          Container(
            width: 22,
            padding: EdgeInsets.symmetric(vertical: 1),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isSelected ? EmotionColor.happier : null,
            ),
            child: Text(
              dateEmotionVM.date?.day.toString() ?? '',
              style: BodyTextStyle.nanum10.copyWith(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 2),
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              return Container(
                width: maxWidth,
                height: maxWidth,
                decoration: BoxDecoration(
                  color: dateEmotionVM.emotion?.color,
                  borderRadius: BorderRadius.circular(maxWidth / 3),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
