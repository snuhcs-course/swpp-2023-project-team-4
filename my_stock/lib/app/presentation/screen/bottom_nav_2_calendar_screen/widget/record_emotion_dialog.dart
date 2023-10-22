part of '../calendar_screen.dart';

class _RecordEmotionDialog extends StatelessWidget {
  final List<EmotionVMEnum> emotions = [
    EmotionVMEnum.happier,
    EmotionVMEnum.happy,
    EmotionVMEnum.neutral,
    EmotionVMEnum.sad,
    EmotionVMEnum.sadder,
  ];

  _RecordEmotionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 27).copyWith(
        top: 26,
        bottom: 33,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: BackgroundColor.defaultColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("오늘 하루를 기록해주세요", style: BodyTextStyle.nanum14.writeText),
          const SizedBox(height: 24),
          _buildEmotionRow(),
        ],
      ),
    );
  }

  Widget _buildEmotionRow() {
    List<Widget> children = [];
    for (int i = 0; i < emotions.length; i++) {
      children.add(
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: emotions[i].color,
              ),
            ),
          ),
        ),
      );
      if (i != emotions.length - 1) {
        children.add(const SizedBox(width: 10));
      }
    }
    return Row(children: children);
  }
}