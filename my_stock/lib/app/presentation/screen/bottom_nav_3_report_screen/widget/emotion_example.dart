part of '../report_screen.dart';

class _EmotionExample extends StatelessWidget {
  final int index;
  final EmotionVMEnum emotion;

  const _EmotionExample({
    super.key,
    required this.index,
    required this.emotion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: emotion.color,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      const SizedBox(height: 5),
      Text("기분 $index", style: BodyTextStyle.nanum9),
      Text(emotion.text, style: BodyTextStyle.nanum9),
    ]);
  }
}
