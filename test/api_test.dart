import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kasir_app/core/config/http/auth_interceptors.dart';
import 'package:kasir_app/core/config/http/dio.dart';
import 'package:kasir_app/features/product/service/product_service.dart';
import 'package:kasir_app/features/product/service/product_service_impl.dart';
import 'package:kasir_app/features/user/service/auth/auth_service.dart';
import 'package:kasir_app/features/user/service/auth/auth_service_impl.dart';

void main() {
  late AuthService authService;
  late ProductService productService;

  late String username;
  late String password;

  setUp(() async {
    await dotenv.load(fileName: ".env");
    username = dotenv.env['USERNAME'] ?? '';
    password = dotenv.env['PASSWORD'] ?? '';

    final dio = Dio(DioConfig.options);
    dio.interceptors.add(DebugAuthInterceptor());

    authService = AuthServiceImpl(dio);
    productService = ProductServiceImpl(dio);
  });

  test("authentication", () async {
    final String result = await authService.authenticate(username, password);
    print(result);
  });

  group("products", () {
    test("fetch products", () async {
      await authService.authenticate(username, password);
      final List<Map> result = await productService.fetchProductList();
      print(result);
    });
  });
}
