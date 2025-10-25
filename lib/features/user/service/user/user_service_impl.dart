import 'package:dio/dio.dart';
import 'package:kasir_app/features/user/model/user.dart';
import 'package:kasir_app/features/user/service/user/user_service.dart';

class UserServiceImpl extends UserService {
  final Dio _dio;

  UserServiceImpl(this._dio);

  @override
  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.post('/api/v1/profile');
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
