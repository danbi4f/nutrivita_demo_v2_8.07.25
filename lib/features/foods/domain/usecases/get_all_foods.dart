import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/repositories/food_repository.dart';

class GetAllFoods implements UseCase<List<Food>, NoParams> {
  final FoodRepository repository;

  GetAllFoods(this.repository);

  @override
  Future<Either<Failure, List<Food>>> call(NoParams params) async {
    return await repository.getAllFoods();
  }
}
