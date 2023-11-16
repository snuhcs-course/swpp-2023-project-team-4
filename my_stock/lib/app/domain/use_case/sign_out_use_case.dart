import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class SignOutUseCase {
  final AuthService _authService;

  const SignOutUseCase({
    required AuthService authService,
  }) : _authService = authService;

  Future<void> call() async {
    await _authService.signOut();
    GetIt.instance.unregister<User>(instance: User);
  }
}
