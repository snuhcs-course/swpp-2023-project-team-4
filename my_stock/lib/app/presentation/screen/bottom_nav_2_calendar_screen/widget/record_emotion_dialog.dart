part of '../calendar_screen.dart';

class _RecordEmotionDialog extends StatelessWidget {
  final List<EmotionVMEnum> emotions = [
    EmotionVMEnum.happier,
    EmotionVMEnum.happy,
    EmotionVMEnum.neutral,
    EmotionVMEnum.sad,
    EmotionVMEnum.sadder,
  ];

  final void Function(EmotionVMEnum emotion) onEmotionSelected;

  _RecordEmotionDialog({
    super.key,
    required this.onEmotionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 27).copyWith(
        top: 26,
        bottom: 30,
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
          const SizedBox(height: 24),
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: StrokeColor.writeText,
                width: 1,
              ),
            ),
            child: TextFormField(
              maxLines: null,
              style: BodyTextStyle.nanum14.writeText,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: "당신의 오늘 하루는 어땠나요?",
                hintStyle: BodyTextStyle.nanum14.writeText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionRow() {
    List<Widget> children = [];
    for (int i = 0; i < emotions.length; i++) {
      children.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              onEmotionSelected(emotions[i]);
              MyNavigator.pop();
            },
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
        ),
      );
      if (i != emotions.length - 1) {
        children.add(const SizedBox(width: 10));
      }
    }
    return Row(children: children);
  }
}
