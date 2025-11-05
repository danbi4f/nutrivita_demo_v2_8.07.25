import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';

abstract class FoodRepository {
  Future<List<Food>> getAllCompleteFoods();
  Future<List<Food>> getCompleteFoodsByFdcIds(List<int> fdcIds);
  Future<List<Food>> searchFoods(String query);
  Future<Food?> getFoodById(int fdcId);
}
