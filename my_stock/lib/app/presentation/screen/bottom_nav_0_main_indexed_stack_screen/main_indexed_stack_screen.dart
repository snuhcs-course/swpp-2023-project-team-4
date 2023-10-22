import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_1_graph_screen/graph_screen.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/calendar_screen.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_3_report_screen/report_screen.dart';
import 'package:my_stock/core/theme/color_theme.dart';

part 'widgets/selectable_bottom_navigation_bar_item.dart';

class MainIndexedStackScreen extends StatefulWidget {
  static const String routeName = "/main";

  const MainIndexedStackScreen({super.key});

  @override
  State<MainIndexedStackScreen> createState() => _MainIndexedStackScreenState();
}

class _MainIndexedStackScreenState extends State<MainIndexedStackScreen> {
  // 메인화면은 캘린더 화면. 인덱스 1.
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          GraphScreen(),
          CalendarScreen(),
          ReportScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: EmotionColor.notFilled,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print(currentIndex);
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: _SelectableBottomNavigationBarItem(
                isSelected: currentIndex == 0,
                asset: "assets/images/graph.png",
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _SelectableBottomNavigationBarItem(
                isSelected: currentIndex == 1,
                asset: "assets/images/calendar.png",
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _SelectableBottomNavigationBarItem(
                isSelected: currentIndex == 2,
                asset: "assets/images/report.png",
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}