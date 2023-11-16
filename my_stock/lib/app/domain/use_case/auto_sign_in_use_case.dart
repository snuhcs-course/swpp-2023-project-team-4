import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class AutoSignInUseCase {
  final AuthService _authService;
  final UserRepository _userRepository;

  const AutoSignInUseCase({
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;

  Future<void> call({
    required void Function() onSuccess,
    required void Function() onFail,
  }) async {
    final result = await _authService.autoSignIn();
    if (result is Fail) {
      onFail();
      return;
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
