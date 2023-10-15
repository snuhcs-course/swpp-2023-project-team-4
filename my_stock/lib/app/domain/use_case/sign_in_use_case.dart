import '../service_interface/auth_service.dart';

class SignInUseCase {
  AuthService _authService;

  SignInUseCase({
    required AuthService authService,
  }) : _authService = authService;

  Future<void> call() async {
    await _authService.signInByGoogle();
  }
}
