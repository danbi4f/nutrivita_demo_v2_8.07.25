import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/repositories/category_repository.dart';

class GetAllCategories implements UseCase<List<CategoryNutrient>, NoParams> {
  final CategoryRepository repository;

  GetAllCategories(this.repository);

  @override
  Future<Either<Failure, List<CategoryNutrient>>> call(NoParams params) async {
    return await repository.getAllCategories();
  }
}
