import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/category_nutrient_model.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource categoryLocalDataSource;
  CategoryRepositoryImpl({required this.categoryLocalDataSource});

@override
  Future<List<CategoryNutrientModel>> getAllCategories() async {
    return await categoryLocalDataSource.getCategories();
  }
}
