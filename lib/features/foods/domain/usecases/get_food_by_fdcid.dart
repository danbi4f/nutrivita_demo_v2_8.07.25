import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';

class GetFoodByFdcId implements UseCase<Food, int> {
  final FoodRepository repository;

  GetFoodByFdcId(this.repository);

  @override
  Future<Either<Failure, Food>> call(int fdcId) async {
    final food = await repository.getFoodById(fdcId);

    if (food == null) {
      return Left(FoodNotFoundFailure());
    }
    return Right(food);
  }
}
