import '../entities/food_entity.dart';
import '../repositories/food_repository.dart';

class GetSortedFoodsByNutrient {
  final FoodRepository repository;
  GetSortedFoodsByNutrient(this.repository);
  Future<List<FoodEntity>> call(String nutrientNumber) {
    return repository.getSortedFoodsByNutrient(nutrientNumber);
  }
}
