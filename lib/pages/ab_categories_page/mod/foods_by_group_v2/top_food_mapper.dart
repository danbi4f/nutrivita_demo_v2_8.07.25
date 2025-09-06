// lib/shared/mappers/top_food_mapper.dart
import 'package:nutrivita_demo_v2/shared/models/complet_foods/complet_foods.dart';
import 'package:nutrivita_demo_v2/shared/models/complet_foods/nutrient_info.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/mod/top_food.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/mod/nutrient_by_group.dart';

class TopFoodMapper {
  /// Gdy masz `nutrientNumber` i `unit` (np. z NutrientByCategory)
  static CompleteFood toCompleteFood(
    TopFood topFood, {
    required String nutrientNumber,
    required String unit,
  }) {
    return CompleteFood(
      fdcId: topFood.fdcId,
      description: topFood.description,
      descriptionPL: topFood.descriptionPL,
      foodClass: topFood.foodClass,
      nutrients: {
        nutrientNumber: NutrientInfo(
          nutrientNumber: nutrientNumber,
          nutrientName: topFood.rankingName,
          unit: unit,
          value: topFood.nutrientValue,
          indexRanking: topFood.indexRanking,
        ),
      },
    );
  }

  /// Wygodna wersja: gdy masz parę (TopFood, NutrientByCategory)
  static CompleteFood fromPair(TopFood topFood, NutrientByCategory nutrient) {
    return toCompleteFood(
      topFood,
      nutrientNumber: nutrient.nutrientNumber,
      unit: nutrient.unit,
    );
  }
}
