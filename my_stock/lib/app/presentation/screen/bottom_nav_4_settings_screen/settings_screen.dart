import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_4_settings_screen/settings_screen_view_model.dart';
import 'package:my_stock/app/presentation/util/my_snackbar.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:provider/provider.dart';

part 'widget/content_box.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsScreenViewModel>(
      create: (_) => SettingsScreenViewModel(),
      child: Scaffold(
        backgroundColor: BackgroundColor.defaultColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Builder(builder: (context) {
                  return _ContentBox(
                    title: "계정",
                    contents: [
                      _ContentVM(
                        icon: Icons.person,
                        text: GetIt.I<User>().nickname,
                        buttonText: "로그아웃하기",
                        onTap: context.read<SettingsScreenViewModel>().signOut,
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                _ContentBox(
                  title: "고객센터",
                  contents: [
                    _ContentVM(
                      icon: Icons.star,
                      text: "별점 남기기",
                      onTap: () {
                        MySnackBar.show("별점 5점 감사합니다!");
                      },
                    ),
                    _ContentVM(
                      icon: Icons.question_answer_outlined,
                      text: "문의하기",
                      onTap: () {
                        MySnackBar.show("답변드렸습니다~");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _ContentBox(
                  title: "이용안내",
                  contents: [
                    _ContentVM(
                      icon: Icons.announcement_outlined,
                      text: "공지사항",
                      onTap: () {
                        MySnackBar.show("공지사항");
                      },
                    ),
                    _ContentVM(
                      icon: Icons.article_outlined,
                      text: "사용방법",
                      onTap: () {},
                    ),
                    _ContentVM(
                      icon: Icons.help,
                      text: "FAQ",
                      onTap: () {
                        MySnackBar.show("FAQ");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
