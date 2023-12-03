import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class TestSignInUseCase {
  final AuthService _authService;
  final UserRepository _userRepository;

  const TestSignInUseCase({
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;

  Future<void> call({
    required void Function() onSuccess,
  }) async {
    final result = await _authService.testSignIn();

    switch (result) {
      case Success(:final data):
        final result2 = await _userRepository.fetchUser();
        switch (result2) {
          case Success(:final data):
            GetIt.I.registerSingleton<User>(data);
            onSuccess();
            return;
          case Fail(:final issue):
            return;
        }
      case Fail(:final issue):
        return;
    }
  }
}
