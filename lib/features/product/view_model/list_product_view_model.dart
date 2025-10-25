import 'package:flutter/material.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';

class ListProductViewModel extends ChangeNotifier {
  final ProductService _productService;
  ListProductViewModel(ProductService productService)
    : _productService = productService;

  List<String> _categories = [];
  List<String> get categories => _categories;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  Future<void> getCategories() async {}

  Future<void> setCategory(String newCategory) async {
    _selectedCategory = newCategory;
    notifyListeners();
  }
}
