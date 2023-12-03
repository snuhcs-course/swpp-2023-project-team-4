import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class MockUserRepositoryImpl implements UserRepository {
  @override
  Future<Result<User, DefaultIssue>> fetchUser() async {
    return Success(
      User(
        googleId: "123456789",
        id: 1,
        nickname: "김철수",
      ),
    );
  }
}

class MockUserRepositoryImplFactory implements UserRepositoryFactory {
  @override
  UserRepository createUserRepository() {
    return MockUserRepositoryImpl();
  }
}
