import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/entry_flow/nickname_screen/nickname_screen_view_model.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:provider/provider.dart';

part 'widget/nickname_form.dart';

class NicknameScreen extends StatefulWidget {
  static const routeName = '/nickname';

  NicknameScreen({super.key});

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final TextEditingController controller = TextEditingController();
  bool boxActive = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        if (controller.text.isEmpty) {
          boxActive = false;
        } else {
          boxActive = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NicknameScreenViewModel(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Spacer(),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Emostock',
                          style: OtherTextStyle.logo,
                        ),
                        const SizedBox(width: 18),
                        Column(
                          children: [
                            Text('에', style: OtherTextStyle.guide),
                            // "Emostock" 글자와 아래 줄을 맞추기 위해 패딩 부여
                            const SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '오신 것을 환영합니다!',
                      style: OtherTextStyle.guide,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 60),
              NicknameForm(
                controller,
              ),
              Spacer(),
              Builder(builder: (context) {
                return GestureDetector(
                  onTap: boxActive
                      ? context.read<NicknameScreenViewModel>().onArrowButtonClicked
                      : null,
                  child: Image.asset(
                    boxActive
                        ? 'assets/images/active_arrow_box.png'
                        : 'assets/images/inactive_arrow_box.png',
                    width: 60,
                  ),
                );
              }),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}