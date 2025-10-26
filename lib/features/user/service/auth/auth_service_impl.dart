import 'package:dio/dio.dart';
import 'package:kasir_app/features/user/service/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceImpl extends AuthService {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  AuthServiceImpl(this._dio, this._sharedPreferences);

  @override
  Future<void> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/api/v1/login',
        data: {"email": username, "password": password},
      );
      if (response.statusCode == 200) {
        final String? token = response.data['data']['token'];
        if (token != null && token.isNotEmpty) {
          await _sharedPreferences.setString('jwt_token', token);
        }
      }
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _sharedPreferences.remove('jwt_token');
  }

  @override
  Future<bool> isLoggedIn() async {
    final String? token = _sharedPreferences.getString('jwt_token');
    return token != null && token.isNotEmpty;
  }
}
