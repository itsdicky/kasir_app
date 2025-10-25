import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kasir_app/core/config/http/auth_interceptors.dart';
import 'package:kasir_app/core/config/http/dio.dart';
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/model/product.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/category/category_service_impl.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';
import 'package:kasir_app/features/product/service/product/product_service_impl.dart';
import 'package:kasir_app/features/user/service/auth/auth_service.dart';
import 'package:kasir_app/features/user/service/auth/auth_service_impl.dart';
import 'package:kasir_app/features/user/service/user/user_service.dart';
import 'package:kasir_app/features/user/service/user/user_service_impl.dart';

void main() {
  late AuthService authService;
  late UserService userService;
  late ProductService productService;
  late CategoryService categoryService;

  late String username;
  late String password;

  setUp(() async {
    await dotenv.load(fileName: ".env");
    username = dotenv.env['USERNAME'] ?? '';
    password = dotenv.env['PASSWORD'] ?? '';

    final dio = Dio(DioConfig.options);
    dio.interceptors.add(DebugAuthInterceptor());

    authService = AuthServiceImpl(dio);
    userService = UserServiceImpl(dio);
    productService = ProductServiceImpl(dio);
    categoryService = CategoryServiceImpl(dio);
  });

  group("user", () {
    test("authentication", () async {
      final String result = await authService.authenticate(username, password);
      print(result);
    });
    test("get current user", () async {
      await authService.authenticate(username, password);
      final result = await userService.getCurrentUser();
      print(result);
    });
  });

  group("products", () {
    test("fetch products", () async {
      await authService.authenticate(username, password);
      final List<Product> result = await productService.fetchProductList();
      print(result);
    });

    test("get product", () async {
      await authService.authenticate(username, password);
      final Product result = await productService.getProduct(
        "8da4fad3-5e95-4e9f-8a63-fcbca7d9a90e",
      );
      print(result);
    });

    test("create product", () async {
      await authService.authenticate(username, password);
      final newProduct = Product(
        categoryId: "acfaf4a9-16b1-44ea-9e7f-238ffbe14d7e",
        name: "Speaker",
        price: 120000,
      );
      await productService.createProduct(newProduct);
    });

    test("update product", () async {
      await authService.authenticate(username, password);
      final newProduct = Product(
        id: "512cacfd-7e5d-4a99-9d01-779e8b34501b",
        categoryId: "ebb5542a-36c3-4e1e-b077-c4b595b4e2a4",
        name: "Gudeg Mercon",
        price: 30000,
      );
      await productService.updateProduct(newProduct);
    });

    test("delete product", () async {
      await authService.authenticate(username, password);
      await productService.deleteProduct("id");
    });
  });

  group("categories", () {
    test("fetch categories", () async {
      await authService.authenticate(username, password);
      final List<Category> result = await categoryService.fetchCategoryList();
      print(result);
    });

    test("get category", () async {
      await authService.authenticate(username, password);
      final Category result = await categoryService.getCategory(
        "f71278ea-b6fe-4bc4-9e3b-3fce6b2ac226",
      );
      print(result);
    });

    test("create category", () async {
      await authService.authenticate(username, password);
      final newCategory = Category(name: "Kerajinan");
      await categoryService.createCategory(newCategory);
    });

    test("update category", () async {
      await authService.authenticate(username, password);
      final updatedCategory = Category(
        id: "f71278ea-b6fe-4bc4-9e3b-3fce6b2ac226",
        name: "Fashion",
      );
      await categoryService.updateCategory(updatedCategory);
    });

    test("delete category", () async {
      await authService.authenticate(username, password);
      await categoryService.deleteCategory(
        "f71278ea-b6fe-4bc4-9e3b-3fce6b2ac226",
      );
    });
  });
}
