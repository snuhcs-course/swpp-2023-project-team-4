import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_stock/app/data/util/http_util.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/app/domain/service_interface/auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<Result<void, Enum>> signInByGoogle() async {
    final GoogleSignInAccount? googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (e) {
      return Fail(DefaultIssue.badRequest);
    }
    String googleId = googleUser!.id;
    print("googleId: $googleId");
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
  Future<Result<void, Enum>> signUpByGoogle({required String nickname}) {
    // TODO: implement signUpByGoogle
    throw UnimplementedError();
  }
}
