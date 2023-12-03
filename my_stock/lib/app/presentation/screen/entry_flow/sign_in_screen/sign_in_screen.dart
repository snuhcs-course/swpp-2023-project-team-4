import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/entry_flow/sign_in_screen/sign_in_view_model.dart';
import 'package:my_stock/app/presentation/util/my_snackbar.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = "/sign-in";

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInViewModel(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 180,
                ),
                const SizedBox(height: 100),
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      context.read<SignInViewModel>().signInByGoogle();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blue,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/google_logo.png",
                            width: 30,
                            height: 30,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            "Google로 로그인",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Pretendard",
                            ),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 5),
                Builder(
                  builder: (context) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: context.read<SignInViewModel>().testSignIn,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "테스트 계정으로 로그인 >",
                          style: BodyTextStyle.nanum14.copyWith(color: Colors.grey),
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
