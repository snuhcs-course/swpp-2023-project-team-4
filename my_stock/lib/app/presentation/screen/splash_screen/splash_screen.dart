import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';
import 'package:my_stock/app/domain/use_case/auto_sign_in_use_case.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_0_main_indexed_stack_screen/main_indexed_stack_screen.dart';
import 'package:my_stock/app/presentation/screen/entry_flow/sign_in_screen/sign_in_screen.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/di.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AutoSignInUseCase _autoSignInUseCase = AutoSignInUseCase(
    authService: getIt<AuthService>(),
    userRepository: getIt<UserRepository>(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoSignInUseCase(
        onSuccess: () {
          MyNavigator.pushReplacementNamed(MainIndexedStackScreen.routeName);
        },
        onFail: () {
          MyNavigator.pushReplacementNamed(SignInScreen.routeName);
        },
      ).then((value) {
        FlutterNativeSplash.remove();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: BackgroundColor.defaultColor);
  }
}
