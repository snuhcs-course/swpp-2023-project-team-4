import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class AutoSignInUseCase {
  final AuthService _authService;

  const AutoSignInUseCase({required AuthService authService}) : _authService = authService;

  Future<void> call() async {
    await _authService.autoSignIn();
  }
}
