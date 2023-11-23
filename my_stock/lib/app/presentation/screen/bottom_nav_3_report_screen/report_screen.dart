import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/date_emotion.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_3_report_screen/report_screen_view_model.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/app/presentation/util/my_snackbar.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:my_stock/core/util/date.dart';
import 'package:provider/provider.dart';

part 'widget/calendar.dart';
part 'widget/circle.dart';
part 'widget/column_element.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportScreenViewModel(),
      child: Scaffold(
        backgroundColor: BackgroundColor.defaultColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Builder(builder: (context) {
                  void Function(Date, Date) setDate = context.read<ReportScreenViewModel>().setDate;
                  return GestureDetector(
                    onTap: () {
                      showDialog(context: context, builder: (_) => Dialog(child: _CalendarDialog()))
                          .then((value) {
                        if (value == null) return;
                        setDate(value.$1, value.$2);
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Consumer<ReportScreenViewModel>(
                            builder: (_, viewModel, __) {
                              (int, int, int) selectedNthWeek = viewModel.selectedNthWeek;
                              int year = selectedNthWeek.$1;
                              int month = selectedNthWeek.$2;
                              int week = selectedNthWeek.$3;
                              return Text(
                                "$year년 $month월 $week주차",
                                style: HeaderTextStyle.nanum16.writeText,
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          Image.asset("assets/images/downward_arrow.png"),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 29.5).copyWith(
                    top: 15,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text("기분 흐름 그래프", style: BodyTextStyle.nanum12),
                      const SizedBox(height: 9),
                      Container(width: double.infinity, height: 1, color: Colors.black),
                      const SizedBox(height: 11),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 4),
                          Column(
                            children: [
                              _Circle(EmotionColor.happier),
                              const SizedBox(height: 10),
                              _Circle(EmotionColor.happy),
                              const SizedBox(height: 10),
                              _Circle(EmotionColor.neutral),
                              const SizedBox(height: 10),
                              _Circle(EmotionColor.sad),
                              const SizedBox(height: 10),
                              _Circle(EmotionColor.sadder),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double maxWidth = constraints.maxWidth;
                                double width = maxWidth / 7;
                                return Consumer<ReportScreenViewModel>(builder: (_, viewModel, __) {
                                  return Stack(
                                    children: [
                                      Row(
                                        children: viewModel.dates.map((date) {
                                          return _ColumnElement(
                                            date: date,
                                            width: width,
                                          );
                                        }).toList(),
                                      ),
                                      _graphLine(maxWidth, viewModel.dateEmotions),
                                      ..._graphCircles(viewModel.dateEmotions, width),
                                    ],
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 3),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Container(width: double.infinity, height: 1, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getTop(EmotionVMEnum emotion) {
    switch (emotion) {
      case EmotionVMEnum.happier:
        // (circle size + spacing) * nth + circle size / 2
        return ((20 + 10) * 0 + 20 / 2) - 10 / 2;
      case EmotionVMEnum.happy:
        return ((20 + 10) * 1 + 20 / 2) - 10 / 2;
      case EmotionVMEnum.neutral:
        return ((20 + 10) * 2 + 10) - 10 / 2;
      case EmotionVMEnum.sad:
        return ((20 + 10) * 3 + 10) - 10 / 2;
      case EmotionVMEnum.sadder:
        return ((20 + 10) * 4 + 10) - 10 / 2;
      default:
        throw Exception("Unhandled emotion: $emotion");
    }
  }

  List<Widget> _graphCircles(List<DateEmotionVM> dateEmotions, double width) {
    List<Widget> list = [];
    for (int i = 0; i < 7; i++) {
      DateEmotionVM dateEmotion = dateEmotions[i];
      if (dateEmotion.emotion != null) {
        double top = getTop(dateEmotion.emotion!);
        list.add(
          Positioned(
            left: width / 2 + width * i - 5,
            top: top,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: EmotionColor.happier, width: 2),
              ),
            ),
          ),
        );
      }
    }
    return list;
  }

  Widget _graphLine(double fullWidth, List<DateEmotionVM> dateEmotions) {
    return CustomPaint(
      size: Size(fullWidth, 1),
      painter: MyPainter(
        dateEmotions: dateEmotions,
        getTop: getTop,
      ),
    );
  }
}

class MyPainter implements CustomPainter {
  final List<DateEmotionVM> dateEmotions;
  final double Function(EmotionVMEnum) getTop;

  MyPainter({
    required this.dateEmotions,
    required this.getTop,
  });

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  bool? hitTest(Offset position) {
    // TODO: implement hitTest
    throw UnimplementedError();
  }

  @override
  void paint(Canvas canvas, Size size) {
    List<(double, double)> points = [];
    for (int i = 0; i < 7; i++) {
      DateEmotionVM dateEmotion = dateEmotions[i];
      if (dateEmotion.emotion != null) {
        double top = getTop(dateEmotion.emotion!);
        points.add((size.width / 14 + size.width / 7 * i, top + 4));
      }
    }
    final paint = Paint()
      ..color = EmotionColor.happier
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(
          Offset(points[i].$1, points[i].$2), Offset(points[i + 1].$1, points[i + 1].$2), paint);
    }
    // canvas.drawLine(Offset(0, 0), Offset(size.width, 40), paint);
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  // TODO: implement semanticsBuilder
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
