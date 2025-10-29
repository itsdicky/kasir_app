import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kasir_app/core/config/http/auth_interceptors.dart';
import 'package:kasir_app/core/config/http/dio.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/category/category_service_impl.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';
import 'package:kasir_app/features/product/service/product/product_service_impl.dart';
import 'package:kasir_app/features/product/view_model/cart_view_model.dart';
import 'package:kasir_app/features/product/view_model/list_product_view_model.dart';
import 'package:kasir_app/features/user/service/auth/auth_service_impl.dart';
import 'package:kasir_app/features/user/service/user/user_service_impl.dart';
import 'package:kasir_app/features/user/view_model/auth_view_model.dart';
import 'package:kasir_app/features/user/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
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
    return <SingleChildWidget>[
      Provider<AuthServiceImpl>(
        create: (_) => AuthServiceImpl(_dio, _sharedPreferences),
      ),
      Provider<UserServiceImpl>(create: (_) => UserServiceImpl(_dio)),
      Provider<ProductService>(create: (_) => ProductServiceImpl(_dio)),
      Provider<CategoryService>(create: (_) => CategoryServiceImpl(_dio)),
      ChangeNotifierProvider<AuthViewModel>(
        lazy: false,
        create: (context) =>
            AuthViewModel(Provider.of<AuthServiceImpl>(context, listen: false))
              ..checkAuth(),
      ),
      ChangeNotifierProxyProvider<AuthViewModel, UserViewModel>(
        lazy: false,
        create: (context) =>
            UserViewModel(Provider.of<UserServiceImpl>(context, listen: false)),
        update: (context, authViewModel, userViewModel) {
          if (authViewModel.isLoggedIn == null || userViewModel == null) {
            return UserViewModel(
              Provider.of<UserServiceImpl>(context, listen: false),
            );
          } else {
            return userViewModel..fetchUserDetails();
          }
        },
      ),
      ChangeNotifierProvider<ListProductViewModel>(
        create: (context) => ListProductViewModel(
          Provider.of<ProductService>(context, listen: false),
          Provider.of<CategoryService>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<CartViewModel>(create: (_) => CartViewModel()),
    ];
  }
}
