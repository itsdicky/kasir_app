import 'package:dio/dio.dart';
import './product_service.dart';

class ProductServiceImpl extends ProductService {
  final Dio _dio;

  ProductServiceImpl(this._dio);

  @override
  Future<List<Map>> fetchProductList() async {
    try {
      final response = await _dio.get('/api/v1/product');
      return List<Map>.from(response.data['data']);
    } on DioException catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
