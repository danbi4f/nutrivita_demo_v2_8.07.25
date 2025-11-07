import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';

class SearchFoodsUseCase implements UseCase<List<Food>, String> {
  final FoodRepository repository;

  SearchFoodsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Food>>> call(String query) async {
    return await repository.searchFoods(query);
  }
}
