import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';

abstract class CategoryRepository {
  Future<List<CategoryNutrient>> getAllCategories();
}