import 'package:dio/dio.dart';
import 'package:kasir_app/features/user/service/auth/auth_service.dart';

class AuthServiceImpl extends AuthService {
  final Dio _dio;

  AuthServiceImpl(this._dio);

  @override
  Future<String> authenticate(String username, String password) async {
    try {
      final response = await _dio.post(
        '/api/v1/login',
        data: {"email": username, "password": password},
      );
      return response.data['data']['token'];
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
