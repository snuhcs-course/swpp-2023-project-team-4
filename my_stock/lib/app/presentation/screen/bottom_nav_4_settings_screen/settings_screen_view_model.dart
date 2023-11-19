import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';
import 'package:my_stock/app/domain/use_case/sign_out_use_case.dart';
import 'package:my_stock/app/presentation/screen/entry_flow/sign_in_screen/sign_in_screen.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';

class SettingsScreenViewModel {
  final SignOutUseCase _signOutUseCase = SignOutUseCase(
    authService: GetIt.I.get<AuthService>(),
  );

  Future<void> signOut() async {
    EasyLoading.show(status: "로그아웃 중...");
    _signOutUseCase(
      onSuccess: () {
        MyNavigator.pushReplacementNamed(SignInScreen.routeName);
      },
    ).then((value) {
      EasyLoading.dismiss();
    });
  }
}
