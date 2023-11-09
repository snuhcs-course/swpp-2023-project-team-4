part of '../record_emotion_screen.dart';

class _SelectableBox extends StatelessWidget {
  final double width;
  final EmotionVMEnum emotion;
  final bool isSelected;
  final void Function() onTap;

  const _SelectableBox({
    super.key,
    required this.width,
    required this.emotion,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.black : StrokeColor.writeText,
            width: isSelected ? 2 : 1,
          ),
          color: emotion.color,
        ),
      ),
    );
  }
}
