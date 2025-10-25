import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  final SharedPreferences _sharedPreferences;

  AuthInterceptor(this._sharedPreferences);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = _sharedPreferences.getString(
      'jwt_token',
    ); // Retrieve the stored token

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      // Token expired or invalid. You might want to:
      // 1. Clear the token from SharedPreferences.
      // 2. Redirect the user to the login screen.
      print(
        'Authentication error: ${err.response?.statusCode}. Token likely expired or invalid.',
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt_token');
      // Navigate to login or show an error
      // Navigator.of(err.requestOptions.path.contains('/login') ? globalContext : YOUR_GLOBAL_NAVIGATOR_KEY.currentContext!)?.pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => LoginPage()),
      //   (Route<dynamic> route) => false,
      // );
    }
    super.onError(err, handler);
  }
}

class DebugAuthInterceptor extends Interceptor {
  String? debugToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (debugToken != null) {
      options.headers['Authorization'] = 'Bearer $debugToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map &&
        response.data['data'] is Map &&
        response.data['data']['token'] != null) {
      debugToken = response.data['data']['token'];
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      'Error[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}
