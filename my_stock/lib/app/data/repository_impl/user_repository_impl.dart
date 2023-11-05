import 'package:dio/dio.dart';
import 'package:my_stock/app/data/dto/verify_dto.dart';
import 'package:my_stock/app/data/util/http_util.dart';
import 'package:my_stock/app/domain/model/user.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class UserRepositoryImpl implements UserRepository {
  final HttpUtil _httpUtil = HttpUtil.I;

  @override
  Future<Result<User, DefaultIssue>> fetchUser() async {
    try {
      final result = await _httpUtil.get("/api/user/verify/");
      final verifyDto = VerifyDTO.fromJson(result.data);
      return Success(
        User(
          id: verifyDto.userId,
          nickname: "",
          googleId: verifyDto.googleId,
        ),
      );
    } on DioException {
      return Fail(DefaultIssue.badRequest);
    }
  }
}
