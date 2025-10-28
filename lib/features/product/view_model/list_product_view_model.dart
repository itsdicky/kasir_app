import 'package:flutter/foundation.dart' hide Category;
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/model/product.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';

enum Status { success, failed, loading, undefined }

class ListProductViewModel extends ChangeNotifier {
  final ProductService _productService;
  final CategoryService _categoryService;
  ListProductViewModel(
    ProductService productService,
    CategoryService categoryService,
  ) : _productService = productService,
      _categoryService = categoryService {
    fetchCategories();
    fetchProducts();
  }

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  final List<Product> _products = [];
  List<Product> get products => _products;

  Status _status = Status.undefined;
  Status get status => _status;

  List<Product> get filteredProduct {
    if (_selectedCategory != null) {
      return _products
          .where((product) => product.categoryId == _selectedCategory!.id)
          .toList();
    } else {
      return _products;
    }
  }

  Category? _selectedCategory;
  Category? get selectedCategory => _selectedCategory;

  Future<void> fetchCategories() async {
    try {
      _categories = await _categoryService.fetchCategoryList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchProducts() async {
    _status = Status.loading;
    notifyListeners();
    try {
      final fetchedProducts = await _productService.fetchProductList();
      _products.clear();
      _products.addAll(fetchedProducts);
      _status = Status.success;
    } catch (e) {
      _status = Status.failed;
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await _productService.deleteProduct(product.id!);
      await fetchProducts();
    } catch (e) {
      print(e);
    }
  }

  void setCategory(Category? newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }
}
