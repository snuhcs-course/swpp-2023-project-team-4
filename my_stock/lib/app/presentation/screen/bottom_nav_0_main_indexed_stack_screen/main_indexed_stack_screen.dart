import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_1_balance_screen/balance_screen.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/calendar_screen.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_3_report_screen/report_screen.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_4_settings_screen/settings_screen.dart';
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
        children: [
          BalanceScreen(),
          const CalendarScreen(),
          const ReportScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: EmotionColor.notFilled,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: _SelectableBottomNavigationBarItem(
              isSelected: currentIndex == 0,
              icon: Icons.auto_graph_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _SelectableBottomNavigationBarItem(
              isSelected: currentIndex == 1,
              icon: Icons.calendar_today_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _SelectableBottomNavigationBarItem(
              isSelected: currentIndex == 2,
              icon: Icons.article_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _SelectableBottomNavigationBarItem(
              isSelected: currentIndex == 3,
              icon: Icons.settings_outlined,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
