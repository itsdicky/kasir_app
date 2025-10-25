import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioConfig {
  static BaseOptions options = BaseOptions(
    baseUrl: dotenv.env['API_BASE_URL']!,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    headers: {"Content-Type": "application/json"},
  );
}
