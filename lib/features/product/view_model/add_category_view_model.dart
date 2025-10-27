import 'package:flutter/foundation.dart' hide Category;
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';

enum Status { success, failed, undefined }

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

  Status _status = Status.undefined;
  Status get status => _status;

  Future<void> addCategory(String name) async {
    if (_categories.any((category) => category.name == name)) {
      throw Exception('Category with the same name already exists');
    }
    try {
      await _categoryService.createCategory(Category(name: name));
      _status = Status.success;
    } catch (e) {
      _status = Status.failed;
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
