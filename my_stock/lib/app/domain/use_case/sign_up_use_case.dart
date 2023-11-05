import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class SignUpUseCase {
  final AuthService _authService;

  const SignUpUseCase({
    required AuthService authService,
  }) : _authService = authService;

  Future<void> call({
    required String nickname,
    required void Function() onSuccess,
  }) async {
    final result = await _authService.signUpByGoogle(nickname: nickname);

    switch (result) {
      case Success():
        onSuccess();
      case Fail(:final issue):
        break;
    }
  }
}
