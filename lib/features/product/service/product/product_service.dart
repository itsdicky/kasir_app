import 'package:kasir_app/features/product/model/product.dart';

abstract class ProductService {
  Future<List<Product>> fetchProductList();
  Future<Product> getProduct(String productId);
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String productId);
}
