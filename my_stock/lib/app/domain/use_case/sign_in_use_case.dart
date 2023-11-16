import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:my_stock/app/domain/result.dart';

import '../service_interface/auth_service.dart';

class SignInUseCase {
  final AuthService _authService;
  final UserRepository _userRepository;

  SignInUseCase({
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;

  Future<void> call({
    required void Function() onSuccess,
    required void Function() needRegister,
    required void Function() onFail,
  }) async {
    final result = await _authService.signInByGoogle();

    if (result is Fail) {
      final issue = (result as Fail).issue;
      switch (issue) {
        case SignInIssue.badRequest:
          onFail();
          break;
        case SignInIssue.notRegistered:
          needRegister();
          break;
      }
    }

    final result2 = await _userRepository.fetchUser();

    if (result2 is Fail) {
      onFail();
      return;
    }
    User user = (result2 as Success).data;
    GetIt.instance.registerSingleton<User>(user);
    onSuccess();
  }
}
