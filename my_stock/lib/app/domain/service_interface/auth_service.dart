import 'package:my_stock/app/domain/result.dart';

abstract class AuthService {
  Future<Result<void, Enum>> signInByGoogle();
}
