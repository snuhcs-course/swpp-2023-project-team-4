import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';
import 'package:my_stock/app/domain/use_case/sign_in_use_case.dart';
import 'package:my_stock/di.dart';

class SignInViewModel extends ChangeNotifier {
  SignInUseCase _signInUseCase = SignInUseCase(authService: getIt<AuthService>());

  void signInByGoogle() async {
    EasyLoading.show(status: 'loading...');
    await _signInUseCase().then((value) {
      EasyLoading.dismiss();
    });
  }
}
