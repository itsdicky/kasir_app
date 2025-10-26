import 'package:flutter/foundation.dart' hide Category;
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/model/product.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';

class ListProductViewModel extends ChangeNotifier {
  final ProductService _productService;
  ListProductViewModel(ProductService productService)
    : _productService = productService;

  final List<Category> _categories = [];
  List<Category> get categories => _categories;

  final List<Product> _products = [];
  List<Product> get products => _products;

  Category _selectedCategory = Category(name: "");
  Category get selectedCategory => _selectedCategory;

  Future<void> getCategories() async {}

  Future<void> setCategory(Category newCategory) async {
    _selectedCategory = newCategory;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    final fetchedProducts = await _productService.fetchProductList();
    _products.clear();
    _products.addAll(fetchedProducts);
    notifyListeners();
  }

  //TODO: make category filter
}
