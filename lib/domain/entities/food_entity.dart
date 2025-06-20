import 'package:nutrivita_demo_v2/domain/entities/food_nutrient_entity.dart';

class FoodEntity {
  final String description;
  final List<FoodNutrientEntity> foodNutrients;
  FoodEntity({required this.description, required this.foodNutrients});
}
