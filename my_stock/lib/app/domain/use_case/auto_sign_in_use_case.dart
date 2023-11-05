import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class AutoSignInUseCase {
  final AuthService _authService;

  const AutoSignInUseCase({required AuthService authService}) : _authService = authService;

  Future<void> call({
    required void Function() onSuccess,
    required void Function() onFail,
  }) async {
    final result = await _authService.autoSignIn();

    switch (result) {
      case Success():
        onSuccess();
        break;
      case Fail(:final issue):
        onFail();
        break;
    }
  }
}
