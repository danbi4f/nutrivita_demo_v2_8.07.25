import 'package:nutrivita_demo_v2/survey_foods/data/model/survey_nutrient_model.dart';

class SurveyFoodNutrientModel {
  const SurveyFoodNutrientModel({required this.amount, required this.nutrient});

  final double amount;
  final SurveyNutrientModel nutrient;

  factory SurveyFoodNutrientModel.fromJson(Map<String, dynamic> json) {
    return SurveyFoodNutrientModel(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      nutrient: SurveyNutrientModel.fromJson(json['nutrient']),
    );
  }
}
