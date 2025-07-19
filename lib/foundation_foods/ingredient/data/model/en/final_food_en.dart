import 'food_nutrient_model_en.dart';

class FinalFoodEN {
  FinalFoodEN({
    required this.description,
    required this.foodNutrients,
    required this.fdcId,
  });

  final String description;
  final List<FoodNutrientModelEN> foodNutrients;
  final int fdcId;

  factory FinalFoodEN.fromJson(Map<String, dynamic> json) {
    return FinalFoodEN(
      fdcId: json['fdcId'] as int,
      description: json['description'],
      foodNutrients:
          (json['foodNutrients'] as List)
              .map((json) => FoodNutrientModelEN.fromJson(json))
              .toList(),
    );
  }
}
