import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/nutrient_info.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/survey_foods_by_category/survey_foods_by_category.dart';

/// Serwis do konwersji SurveyFoodsByCategory -> FoodWithNutrients
class CompleteFoodService {
  CompleteFoodService._internal();
  static final CompleteFoodService _instance = CompleteFoodService._internal();
  factory CompleteFoodService() => _instance;

  // 🔹 Cache w pamięci
  final Map<int, CompleteFood> _cache = {};

  List<CompleteFood> fromSurveyFoods(List<SurveyFoodsByCategory> categories) {
    final Map<int, CompleteFood> foodsMap = {};

    for (var category in categories) {
      for (var nutrient in category.nutrients) {
        for (var food in nutrient.topFoods) {
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

          foodsMap[food.fdcId]!.nutrients[nutrient.nutrientNumber] = NutrientInfo(
            nutrientNumber: nutrient.nutrientNumber,
            nutrientName: nutrient.nutrientName,
            unit: nutrient.unit,
            value: food.nutrientValue,
            indexRanking: food.indexRanking,
          );
        }
      }
    }

    // 🔹 Zapisz wszystko w cache
    for (final f in foodsMap.values) {
      _cache[f.fdcId] = f;
    }

    return foodsMap.values.toList();
  }

  // 🔹 Pobierz z cache
  List<CompleteFood> getCachedFoodsByIds(List<int> fdcIds) {
    return fdcIds
        .map((id) => _cache[id])
        .where((f) => f != null)
        .cast<CompleteFood>()
        .toList();
  }

  // 🔹 Zapisz pojedynczy produkt do cache
  void addToCache(CompleteFood food) {
    _cache[food.fdcId] = food;
  }
}
