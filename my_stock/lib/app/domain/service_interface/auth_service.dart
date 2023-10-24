import 'package:my_stock/app/domain/result.dart';

abstract class AuthService {
  Future<Result<void, Enum>> autoSignIn();

  Future<Result<void, Enum>> signInByGoogle();

  Future<Result<void, Enum>> signUpByGoogle({required String nickname});

  Future<Result<void, Enum>> signOut();
}
