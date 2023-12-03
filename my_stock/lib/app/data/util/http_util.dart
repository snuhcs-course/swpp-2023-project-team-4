import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpUtil {
  Dio _dio = Dio();
  SharedPreferences _pref = GetIt.I.get<SharedPreferences>();

  HttpUtil._() {
    _dio.options.baseUrl = 'http://ec2-54-180-107-205.ap-northeast-2.compute.amazonaws.com:3000';
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        if (this.isAuthorized) {
          options.headers['Authorization'] = 'Bearer ${_pref.getString('access_token')}';
        }
        return handler.next(options);
      }),
    );
  }

  static final HttpUtil _httpUtil = HttpUtil._();

  static HttpUtil get I => _httpUtil;

  bool get isAuthorized => _pref.get('access_token') != null;

  Future<void> saveAccessToken(String accessToken) async {
    await _pref.setString('access_token', accessToken);
  }

  Future<void> deleteAccessToken() async {
    await _pref.remove('access_token');
  }

  Future<Response<T>> get<T>(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get<T>(endpoint, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(String endpoint, {Object? data}) async {
    return await _dio.post<T>(endpoint, data: data);
  }

  Future<Response<T>> put<T>(String endpoint, {Object? data}) async {
    return await _dio.put<T>(endpoint, data: data);
  }

  Future<Response<T>> patch<T>(String endpoint, {Object? data}) async {
    return await _dio.patch<T>(endpoint, data: data);
  }

  Future<Response<T>> delete<T>(String endpoint) async {
    return await _dio.delete<T>(endpoint);
  }
}
