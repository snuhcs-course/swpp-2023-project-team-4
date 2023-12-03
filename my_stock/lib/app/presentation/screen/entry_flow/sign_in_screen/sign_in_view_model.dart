import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';
import 'package:my_stock/app/domain/use_case/sign_in_use_case.dart';
import 'package:my_stock/app/domain/use_case/test_sign_in_use_case.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_0_main_indexed_stack_screen/main_indexed_stack_screen.dart';
import 'package:my_stock/app/presentation/screen/entry_flow/nickname_screen/nickname_screen.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/di.dart';

class SignInViewModel extends ChangeNotifier {
  SignInUseCase _signInUseCase = SignInUseCase(
    authService: getIt<AuthService>(),
    userRepository: getIt<UserRepository>(),
  );
  TestSignInUseCase _testSignInUseCase = TestSignInUseCase(
    authService: getIt<AuthService>(),
    userRepository: getIt<UserRepository>(),
  );

  void signInByGoogle() async {
    EasyLoading.show(status: 'loading...');
    await _signInUseCase(
      onSuccess: () {
        MyNavigator.pushReplacementNamed(MainIndexedStackScreen.routeName);
      },
      onFail: () {},
      needRegister: () {
        MyNavigator.pushReplacementNamed(NicknameScreen.routeName);
      },
    ).then((value) {
      EasyLoading.dismiss();
    });
  }

  void testSignIn() async {
    EasyLoading.show(status: 'loading...');
    await _testSignInUseCase(
      onSuccess: () {
        MyNavigator.pushReplacementNamed(MainIndexedStackScreen.routeName);
      },
    ).then((value) {
      EasyLoading.dismiss();
    });
  }
}
