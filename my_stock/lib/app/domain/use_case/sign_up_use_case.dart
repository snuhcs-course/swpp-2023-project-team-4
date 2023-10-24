import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class SignUpUseCase {
  final AuthService _authService;

  const SignUpUseCase({
    required AuthService authService,
  }) : _authService = authService;

  Future<void> call({required String nickname}) async {
    final result = await _authService.signUpByGoogle(nickname: nickname);
  }
}
