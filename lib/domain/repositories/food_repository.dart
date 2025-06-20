import '../entities/food_entity.dart';
abstract class FoodRepository {
  Future<List<FoodEntity>> getSortedFoodsByNutrient(String nutrientNumber);
}