import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kasir_app/features/product/model/product.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'product_service.dart';

class ProductServiceImpl extends ProductService {
  final Dio _dio;

  ProductServiceImpl(this._dio);

  @override
  Future<List<Product>> fetchProductList() async {
    try {
      final response = await _dio.get('/api/v1/product');
      final result = (response.data['data'] as List)
          .map((item) => Product.fromJson(item))
          .toList();
      return result;
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  @override
  Future<Product> getProduct(String productId) async {
    try {
      final response = await _dio.get('/api/v1/product/$productId');
      return Product.fromJson(response.data['data']);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    try {
      final formData = FormData.fromMap({
        'name': product.name,
        'category_id': product.categoryId,
        'price': product.price,
      });

      File? picture = product.picture;

      //TODO: test upload picture

      if (picture != null && await picture.exists()) {
        final mimeType =
            lookupMimeType(picture.path) ?? 'application/octet-stream';
        final parts = mimeType.split('/');
        MultipartFile multipart = await MultipartFile.fromFile(
          picture.path,
          filename: path.basename(picture.path),
          contentType: MediaType(parts[0], parts[1]),
        );
        formData.files.add(MapEntry('picture', multipart));
      }

      final response = await _dio.post('/api/v1/product', data: formData);
      print(response.data);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    try {
      final formData = FormData.fromMap({
        'name': product.name,
        'category_id': product.categoryId,
        'price': product.price,
      });
      final response = await _dio.post(
        '/api/v1/product/update/${product.id!}',
        data: formData,
      );
      print(response.data);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    try {
      final response = await _dio.delete('/api/v1/product/$productId');
      print(response.data);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
