import '../../domain/entities/food_entity.dart';
import '../../domain/entities/food_nutrient_entity.dart';
import 'food_nutrient_model.dart';

class FinalFood extends FoodEntity {
  FinalFood({required super.description, required super.foodNutrients});

  factory FinalFood.fromJson(Map<String, dynamic> json) {
    return FinalFood(
      description: json['description'],
      foodNutrients:
          (json['foodNutrients'] as List)
              .map(
                (json) =>
                    FoodNutrientModel.fromJson(json) as FoodNutrientEntity,
              )
              .toList(),
    );
  }
}
