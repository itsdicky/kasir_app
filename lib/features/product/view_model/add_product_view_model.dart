import 'dart:io';

import 'package:flutter/foundation.dart' hide Category;
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/model/product.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';

enum Status { success, failed, undefined }

class AddProductViewModel extends ChangeNotifier {
  ProductService _productService;
  CategoryService _categoryService;

  AddProductViewModel(
    ProductService productService,
    CategoryService categoryService,
  ) : _productService = productService,
      _categoryService = categoryService {
    fetchCategories();
  }

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Status _status = Status.undefined;
  Status get status => _status;

  Future<void> addProduct(
    String name,
    int price,
    Category category,
    File picture,
  ) async {
    // Implementation for adding a product
    try {
      await _productService.createProduct(
        Product(
          name: name,
          price: price,
          categoryId: category.id!,
          picture: picture,
        ),
      );
      _status = Status.success;
    } catch (e) {
      _status = Status.failed;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    try {
      _categories = await _categoryService.fetchCategoryList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
