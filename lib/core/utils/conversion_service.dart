import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/foods/data/models/food_model.dart';
import 'package:nutrivita_demo_v2/features/foods/data/models/nutrient_info_model.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';

/// Conversion service SurveyFoodsByCategory -> FoodWithNutrients
class ConversionService {
  ConversionService._internal();
  static final ConversionService _instance = ConversionService._internal();
  factory ConversionService() => _instance;

  // 🔹 Memory cache
  final Map<int, Food> _cache = {};

  List<FoodModel> fromCategory(List<CategoryNutrient> categories) {
    final Map<int, FoodModel> foodsMap = {};

    for (var category in categories) {
      for (var nutrient in category.nutrients) {
        for (var food in nutrient.topFoods) {
          foodsMap.putIfAbsent(
            food.fdcId,
            () => FoodModel(
              fdcId: food.fdcId,
              description: food.description,
              descriptionPL: food.descriptionPL,
              foodClass: food.foodClass,
              nutrients: {},
            ),
          );

          foodsMap[food.fdcId]!.nutrients[nutrient.nutrientNumber] = NutrientInfoModel(
            nutrientNumber: nutrient.nutrientNumber,
            nutrientName: nutrient.nutrientName,
            unit: nutrient.unit,
            value: food.nutrientValue,
            indexRanking: food.indexRanking,
          );
        }
      }
    }

    // 🔹 Save everything to cache
    for (final f in foodsMap.values) {
      _cache[f.fdcId] = f;
    }

    return foodsMap.values.toList();
  }

  // 🔹 Download from cache
  List<Food> getCachedFoodsByIds(List<int> fdcIds) {
    return fdcIds
        .map((id) => _cache[id])
        .where((f) => f != null)
        .cast<Food>()
        .toList();
  }

  // 🔹 Save a single product to the cache
  void addToCache(Food food) {
    _cache[food.fdcId] = food;
  }
}
