import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_stock/app/presentation/screen/entry_flow/sign_in_screen/sign_in_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Colors.white,
        ),
        fontFamily: "pretendard",
      ),
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
      },
      initialRoute: SignInScreen.routeName,
      builder: EasyLoading.init(),
    );
  }
}
