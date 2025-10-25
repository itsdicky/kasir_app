import 'package:kasir_app/features/product/model/category.dart';

abstract class CategoryService {
  Future<List<Category>> fetchCategoryList();
  Future<Category> getCategory(String categoryId);
  Future<void> createCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String categoryId);
}
