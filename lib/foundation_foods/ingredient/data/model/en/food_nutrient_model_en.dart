import 'nutrient_model_en.dart';

class FoodNutrientModelEN {
  FoodNutrientModelEN({required this.amount, required this.nutrient});

  final double amount;
  final NutrientModelEN nutrient;

  factory FoodNutrientModelEN.fromJson(Map<String, dynamic> json) {
    return FoodNutrientModelEN(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      nutrient: NutrientModelEN.fromJson(json['nutrient']),
    );
  }
}
