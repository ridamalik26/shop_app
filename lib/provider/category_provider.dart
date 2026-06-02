import 'package:flutter_riverpod/legacy.dart';
import 'package:shop_app/models/category.dart';

class CategoryProvider extends StateNotifier<List<Category>> {
  CategoryProvider() : super([]);

  void setCategories(List<Category> category) {
    state = category;
  }
}

final categoryProvider = StateNotifierProvider<CategoryProvider,List<Category>>(
    (ref){
      return CategoryProvider();
    }
);
