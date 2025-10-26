import 'dart:io';

import 'package:flutter/foundation.dart' hide Category;
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/model/product.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';

class AddProductViewModel extends ChangeNotifier {
  ProductService _productService;
  CategoryService _categoryService;

  AddProductViewModel(
    ProductService productService,
    CategoryService categoryService,
  ) : _productService = productService,
      _categoryService = categoryService {
    _categoryService.fetchCategoryList().then((categories) {
      _categories = categories;
      notifyListeners();
    });
  }

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Future<void> addProduct(
    String name,
    int price,
    Category category,
    File picture,
  ) async {
    // Implementation for adding a product
    _productService.createProduct(
      Product(
        name: name,
        price: price,
        categoryId: category.id!,
        picture: picture,
      ),
    );
  }
}
