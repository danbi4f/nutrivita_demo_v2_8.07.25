import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/exceptions.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource categoryLocalDataSource;
  CategoryRepositoryImpl({required this.categoryLocalDataSource});

@override
  Future<Either<Failure, List<CategoryNutrient>>>  getAllCategories() async {
    try {
      final categories = await categoryLocalDataSource.getCategories();
      return Right(categories);
    } on CacheException {
      return Left(CacheFailure());
    }
  } 
}
