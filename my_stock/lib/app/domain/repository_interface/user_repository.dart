import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/domain/result.dart';

abstract class UserRepository {
  Future<Result<User, DefaultIssue>> fetchUser();
}
