import 'package:nutrivita_demo_v2/foundation_foods/ingredient/domain/entities/food_nutrient_entity.dart';

class FoodEntity {
  FoodEntity({
    required this.description,
    required this.foodNutrients,
    required this.fdcId,
  });

  final String description;
  final List<FoodNutrientEntity> foodNutrients;
  final int fdcId;
}
