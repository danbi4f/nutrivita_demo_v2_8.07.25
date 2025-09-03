import 'package:nutrivita_demo_v2/shared/models/complet_foods/complet_foods.dart';
import 'package:nutrivita_demo_v2/shared/models/complet_foods/nutrient_info.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/survey_foods_by_category.dart';

/// Serwis do konwersji SurveyFoodsByCategory -> FoodWithNutrients
class CompleteFoodService {
  CompleteFoodService._internal();

  static final CompleteFoodService _instance = CompleteFoodService._internal();

  factory CompleteFoodService() => _instance;

  List<CompleteFood> fromSurveyFoods(List<SurveyFoodsByCategory> categories) {
    final Map<int, CompleteFood> foodsMap = {};

    for (var category in categories) {
      for (var nutrient in category.nutrients) {
        for (var food in nutrient.topFoods) {
          // jeśli produkt jeszcze nie istnieje -> dodaj
          foodsMap.putIfAbsent(
            food.fdcId,
            () => CompleteFood(
              fdcId: food.fdcId,
              description: food.description,
              descriptionPL: food.descriptionPL,
              foodClass: food.foodClass,
              nutrients: {},
            ),
          );

          // dodaj/uzupełnij info o składniku
          foodsMap[food.fdcId]!.nutrients[nutrient
              .nutrientNumber] = NutrientInfo(
            nutrientName: nutrient.nutrientName,
            unit: nutrient.unit,
            value: food.nutrientValue,
            indexRanking: food.indexRanking,
          );
        }
      }
    }

    return foodsMap.values.toList();
  }
}
