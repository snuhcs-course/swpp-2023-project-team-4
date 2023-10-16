import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/entry_flow/sign_in_screen/sign_in_view_model.dart';
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Image.asset("assets/images/logo.png"),
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
                        vertical: 17,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blue,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/google_logo.png",
                            width: 30,
                            height: 30,
                          ),
                          Spacer(),
                          Text(
                            "Google로 로그인",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
