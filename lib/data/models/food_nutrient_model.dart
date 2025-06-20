import '../../domain/entities/food_nutrient_entity.dart';
import 'nutrient_model.dart';
class FoodNutrientModel extends FoodNutrientEntity {
  FoodNutrientModel({required super.amount, required super.nutrient});
  factory FoodNutrientModel.fromJson(Map<String, dynamic> json) {
    return FoodNutrientModel(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      nutrient: NutrientModel.fromJson(json['nutrient']),
    );
  }
}