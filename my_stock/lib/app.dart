import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_0_main_indexed_stack_screen/main_indexed_stack_screen.dart';
import 'package:my_stock/app/presentation/screen/entry_flow/nickname_screen/nickname_screen.dart';
import 'package:my_stock/app/presentation/screen/entry_flow/sign_in_screen/sign_in_screen.dart';
import 'package:my_stock/app/presentation/screen/search_stock_screen/search_stock_screen.dart';
import 'package:my_stock/app/presentation/screen/splash_screen/splash_screen.dart';
import 'package:my_stock/app/presentation/util/navigator_key.dart';
import 'package:my_stock/core/theme/color_theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: EmotionColor.notFilled,
    ));
    return MaterialApp(
      navigatorKey: NavigatorKey.key,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Colors.white,
        ),
        fontFamily: "NanumBarunGothic",
      ),
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
        NicknameScreen.routeName: (context) => NicknameScreen(),
        MainIndexedStackScreen.routeName: (context) => MainIndexedStackScreen(),
        SearchStockScreen.routeName: (context) => SearchStockScreen(),
      },
      initialRoute: SplashScreen.routeName,
      builder: EasyLoading.init(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: ScrollConfiguration(
              behavior: _MyScrollBehavior(),
              child: child!,
            ),
          );
        },
      ),
    );
  }
}

class _MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
