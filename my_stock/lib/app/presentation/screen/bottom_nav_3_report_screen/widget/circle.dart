part of '../report_screen.dart';

class _Circle extends StatelessWidget {
  final Color color;

  const _Circle(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
    );
  }
}
