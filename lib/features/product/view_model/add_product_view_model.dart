import 'dart:io';

import 'package:flutter/foundation.dart' hide Category;
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/model/product.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';
import 'package:kasir_app/features/product/view_model/list_product_view_model.dart';

enum Status { success, failed, loading, undefined }

class AddProductViewModel extends ChangeNotifier {
  ProductService _productService;
  CategoryService _categoryService;
  ListProductViewModel listProductViewModel;

  AddProductViewModel(
    ProductService productService,
    CategoryService categoryService,
    this.listProductViewModel,
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
    _status = Status.loading;
    notifyListeners();
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
      listProductViewModel.fetchProducts();
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
