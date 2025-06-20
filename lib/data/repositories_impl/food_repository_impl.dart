import '../../domain/entities/food_entity.dart';
import '../../domain/repositories/food_repository.dart';
import '../datasources/food_local_datasource.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodLocalDataSource localDataSource;
  FoodRepositoryImpl(this.localDataSource);

  @override
  Future<List<FoodEntity>> getSortedFoodsByNutrient(String nutrientNumber) async {
    final foods = await localDataSource.loadFoods();
    foods.sort((a, b) {
      double aAmount = a.foodNutrients
          .firstWhere(
            (n) => n.nutrient.number == nutrientNumber,
            orElse: () => a.foodNutrients.first,
          ).amount;
      double bAmount = b.foodNutrients
          .firstWhere(
            (n) => n.nutrient.number == nutrientNumber,
            orElse: () => b.foodNutrients.first,
          ).amount;
      return bAmount.compareTo(aAmount);
    });
    return foods;
  }
}