import 'package:flutter/foundation.dart' hide Category;
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';

enum Status { success, failed, loading, undefined }

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

  void setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  Future<void> addCategory(String name) async {
    _status = Status.loading;
    notifyListeners();
    try {
      if (_categories.any((category) => category.name == name)) {
        throw Exception('Nama Kategori sudah ada');
      }
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
