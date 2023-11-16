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
      print("start");
      final result = await _httpUtil.post("/api/user/verify/");
      print(result.data);
      final verifyDto = VerifyDTO.fromJson(result.data);
      return Success(
        User(
          id: verifyDto.userId,
          nickname: "",
          googleId: verifyDto.googleId,
        ),
      );
    } on DioException catch (e) {
      print(e);
      return Fail(DefaultIssue.badRequest);
    }
  }
}
