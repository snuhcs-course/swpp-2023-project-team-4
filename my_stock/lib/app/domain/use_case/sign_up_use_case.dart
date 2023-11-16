import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class SignUpUseCase {
  final AuthService _authService;
  final UserRepository _userRepository;

  const SignUpUseCase({
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;

  Future<void> call({
    required String nickname,
    required void Function() onSuccess,
  }) async {
    final result = await _authService.signUpByGoogle(nickname: nickname);

    if (result is Fail) {
      return;
    }

    final result2 = await _userRepository.fetchUser();

    if (result2 is Fail) {
      return;
    }

    User user = (result2 as Success).data;
    GetIt.instance.registerSingleton<User>(user);
    onSuccess();
  }
}
