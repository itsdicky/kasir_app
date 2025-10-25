import 'package:dio/dio.dart';
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';

class CategoryServiceImpl extends CategoryService {
  final Dio _dio;

  CategoryServiceImpl(this._dio);

  @override
  Future<List<Category>> fetchCategoryList() async {
    try {
      final response = await _dio.get('/api/v1/category');
      final result = (response.data['data'] as List)
          .map((item) => Category.fromJson(item))
          .toList();
      return result;
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  @override
  Future<Category> getCategory(String categoryId) async {
    try {
      final response = await _dio.get('/api/v1/category/$categoryId');
      return Category.fromJson(response.data['data']);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  @override
  Future<void> createCategory(Category category) async {
    try {
      final response = await _dio.post(
        '/api/v1/category',
        data: {'name': category.name},
      );
      print(response.data);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  @override
  Future<void> updateCategory(Category category) async {
    try {
      final response = await _dio.put(
        '/api/v1/category/${category.id!}',
        data: {'name': category.name},
      );
      print(response.data);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    try {
      final response = await _dio.delete('/api/v1/category/$categoryId');
      print(response.data);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
