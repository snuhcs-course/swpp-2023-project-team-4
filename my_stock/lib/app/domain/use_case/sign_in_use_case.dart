import 'package:my_stock/app/domain/result.dart';

import '../service_interface/auth_service.dart';

class SignInUseCase {
  AuthService _authService;

  SignInUseCase({
    required AuthService authService,
  }) : _authService = authService;

  Future<void> call({
    required void Function() onSuccess,
    required void Function() onFail,
  }) async {
    final result = await _authService.signInByGoogle();

    switch (result) {
      case Success(:final data):
        onSuccess();
      case Fail(:final issue):
        onFail();
    }
  }
}
