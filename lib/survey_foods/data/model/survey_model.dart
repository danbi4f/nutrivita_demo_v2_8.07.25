import 'package:nutrivita_demo_v2/survey_foods/data/model/survey_food_nutrient_model.dart';

class SurveyModel {
  SurveyModel({
    required this.description,
    required this.foodNutrients,
    required this.fdcId,
  });

  final String description;
  final List<SurveyFoodNutrientModel> foodNutrients;
  final int fdcId;

  factory SurveyModel.formJson(Map<String, dynamic> json) {
    return SurveyModel(
      description: json['description'],
      foodNutrients:
          (json['foodNutrients'] as List)
              .map((map) => SurveyFoodNutrientModel.fromJson(map))
              .toList(),
      fdcId: json['fdcId'],
    );
  }
}
