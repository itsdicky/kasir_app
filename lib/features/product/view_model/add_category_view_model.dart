import 'package:flutter/foundation.dart' hide Category;
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';

class AddCategoryViewModel extends ChangeNotifier {
  CategoryService _categoryService;

  AddCategoryViewModel(CategoryService categoryService)
    : _categoryService = categoryService {
    _categoryService.fetchCategoryList().then((categories) {
      _categories = categories;
      notifyListeners();
    });
  }

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Future<void> addCategory(String name) async {
    if (_categories.any((category) => category.name == name)) {
      throw Exception('Category with the same name already exists');
    }
    await _categoryService.createCategory(Category(name: name));
  }
}
