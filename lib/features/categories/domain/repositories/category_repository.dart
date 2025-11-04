import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryNutrient>>>  getAllCategories();
}