import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kasir_app/core/config/http/auth_interceptors.dart';
import 'package:kasir_app/core/config/http/dio.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProvidersDi {
  static late SharedPreferences _sharedPreferences;
  static late Dio _dio;

  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
    _sharedPreferences = await SharedPreferences.getInstance();
    _dio = Dio(DioConfig.options);

    _dio.interceptors.add(AuthInterceptor(_sharedPreferences));
  }

  static List<SingleChildWidget> get providers {
    return [];
  }
}
