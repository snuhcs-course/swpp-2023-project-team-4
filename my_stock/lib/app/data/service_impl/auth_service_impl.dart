import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_stock/app/data/dto/token_dto.dart';
import 'package:my_stock/app/data/util/http_util.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final HttpUtil _httpUtil = HttpUtil.I;
  GoogleSignInAccount? _googleUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<Result<void, SignInIssue>> signInByGoogle() async {
    String googleId;
    try {
      _googleUser = await _googleSignIn.signIn();
      googleId = _googleUser!.id;
    } catch (e) {
      return Fail(SignInIssue.badRequest);
    }
    try {
      final result = await _httpUtil.post("/api/user/signin/", data: {"google_id": googleId});
      final TokenDTO tokenDto = TokenDTO.fromJson(result.data);
      await _httpUtil.saveAccessToken(tokenDto.accessToken);
      _googleSignIn.signOut();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Fail(SignInIssue.notRegistered);
      }
      _googleSignIn.signOut();
      return Fail(SignInIssue.badRequest);
    }
    return Success(null);
  }

  @override
  Future<Result<void, Enum>> autoSignIn() async {
    if (HttpUtil.I.isAuthorized) {
      return Success(null);
    } else {
      return Fail(DefaultIssue.unAuthorized);
    }
  }

  @override
  Future<Result<void, Enum>> signOut() async {
    await HttpUtil.I.deleteAccessToken();
    return Success(null);
  }

  @override
  Future<Result<void, Enum>> signUpByGoogle({required String nickname}) async {
    String googleId = _googleUser!.id;
    try {
      final result = await _httpUtil.post(
        "/api/user/signup/",
        data: {
          "google_id": googleId,
          "nickname": nickname,
        },
      );
      final TokenDTO tokenDto = TokenDTO.fromJson(result.data);
      await _httpUtil.saveAccessToken(tokenDto.accessToken);
      _googleSignIn.signOut();
    } on DioException catch (e) {
      print(e);
      return Fail(DefaultIssue.badRequest);
    }
    return Success(null);
  }
}

class AuthServiceFactoryImpl implements AuthServiceFactory {
  @override
  AuthService createAuthService() {
    return AuthServiceImpl();
  }
}
