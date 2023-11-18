import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/presentation/util/my_snackbar.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.defaultColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("계정", style: HeaderTextStyle.nanum18.writeText),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: StrokeColor.writeText, width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person, size: 24, color: Colors.black.withOpacity(0.7)),
                          const SizedBox(width: 10),
                          Text("${GetIt.I.get<User>().nickname}",
                              style: BodyTextStyle.nanum15.writeText),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              print("로그아웃");
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                "로그아웃하기",
                                style: BodyTextStyle.nanum15.copyWith(color: StrokeColor.sell),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("고객센터", style: HeaderTextStyle.nanum18.writeText),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: StrokeColor.writeText, width: 1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.message, size: 24, color: Colors.black.withOpacity(0.7)),
                              const SizedBox(width: 10),
                              Text("의견 보내기", style: BodyTextStyle.nanum15.writeText),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  MySnackBar.show("의견 잘 받았습니다!");
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    "보내러 가기",
                                    style: BodyTextStyle.nanum15.copyWith(color: StrokeColor.sell),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: 13),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: StrokeColor.writeText,
                          ),
                          const SizedBox(height: 13),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.star, size: 24, color: Colors.black.withOpacity(0.7)),
                              const SizedBox(width: 10),
                              Text("개발자 응원하기", style: BodyTextStyle.nanum15.writeText),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  MySnackBar.show("별점 5점 잘 받았습니다!");
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    "별점 남기러 가기",
                                    style: BodyTextStyle.nanum15.copyWith(color: StrokeColor.sell),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
