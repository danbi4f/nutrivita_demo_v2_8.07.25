import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';

abstract class FoodRepository {
  Future<Either<Failure, List<Food>>> getAllFoods();
  Future<Either<Failure, List<Food>>> getFoodsByFdcIds(List<int> fdcIds);
  Future<Either<Failure, List<Food>>> searchFoods(String query);
  Future<Either<Failure, Food>> getFoodById(int fdcId);
}
