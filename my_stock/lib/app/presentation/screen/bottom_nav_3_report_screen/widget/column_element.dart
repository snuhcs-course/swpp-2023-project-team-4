part of '../report_screen.dart';

class _ColumnElement extends StatelessWidget {
  final double width;
  final Date date;

  const _ColumnElement({
    super.key,
    required this.width,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        children: [
          Container(
            width: 1,
            height: 140,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          Text("${date.month}/${date.day}", style: BodyTextStyle.nanum10.black),
        ],
      ),
    );
  }
}
