import '../../domain/entities/food_entity.dart';
import '../../domain/entities/food_nutrient_entity.dart';
import 'food_nutrient_model.dart';
class FoodModel extends FoodEntity {
  FoodModel({required super.description, required super.foodNutrients});
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      description: json['description'],
      foodNutrients: (json['foodNutrients'] as List)
          .map((e) => FoodNutrientModel.fromJson(e) as FoodNutrientEntity)
          .toList(),
    );
  }
}