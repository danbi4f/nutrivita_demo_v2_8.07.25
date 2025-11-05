import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';

class GetFoodsByFdcids implements UseCase<List<Food>, FdcIdsParams> {
  final FoodRepository repository;

  GetFoodsByFdcids(this.repository);

  @override
  Future<Either<Failure, List<Food>>> call(FdcIdsParams params) async {
    try {
      final data = await repository.getFoodsByFdcIds(params.fdcIds);
      return Right(data);
    } catch (_) {
      return Left((FoodNotFoundFailure()));
    }
  }
}
