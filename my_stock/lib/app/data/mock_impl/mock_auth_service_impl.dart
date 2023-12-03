import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class MockAuthServiceImpl implements AuthService {
  @override
  Future<Result<void, Enum>> autoSignIn() async {
    return Success(null);
  }

  @override
  Future<Result<void, SignInIssue>> signInByGoogle() async {
    return Success(null);
  }

  @override
  Future<Result<void, Enum>> signOut() async {
    return Success(null);
  }

  @override
  Future<Result<void, Enum>> signUpByGoogle({required String nickname}) async {
    return Success(null);
  }

  @override
  Future<Result<void, Enum>> testSignIn() async {
    return Success(null);
  }
}

class MockAuthServiceImplFactory implements AuthServiceFactory {
  @override
  AuthService createAuthService() {
    return MockAuthServiceImpl();
  }
}
