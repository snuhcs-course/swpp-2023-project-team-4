import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';
import 'package:my_stock/app/domain/use_case/sign_up_use_case.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_0_main_indexed_stack_screen/main_indexed_stack_screen.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/app/presentation/util/my_snackbar.dart';

class NicknameScreenViewModel extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final SignUpUseCase _signUpUseCase = SignUpUseCase(
    authService: GetIt.I.get<AuthService>(),
    userRepository: GetIt.I.get<UserRepository>(),
  );
  bool boxActive = false;

  NicknameScreenViewModel() {
    controller.addListener(() {
      if (controller.text.length > 0) {
        boxActive = true;
      } else {
        boxActive = false;
      }
      notifyListeners();
    });
  }

  void onArrowButtonClicked() {
    if (!boxActive) {
      MySnackBar.show("닉네임을 입력해주세요!");
    }
    EasyLoading.show(status: 'loading...');
    _signUpUseCase
        .call(
            nickname: controller.text,
            onSuccess: () {
              MyNavigator.pushReplacementNamed(MainIndexedStackScreen.routeName);
            })
        .then((value) {
      EasyLoading.dismiss();
    });
  }
}
