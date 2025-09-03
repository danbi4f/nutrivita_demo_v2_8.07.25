import 'package:nutrivita_demo_v2/shared/models/complet_foods/complet_foods.dart';
import 'package:nutrivita_demo_v2/shared/services/complete_foods_service.dart';
import 'package:nutrivita_demo_v2/shared/services/survey_foods_by_category_service.dart';

class CompleteFoodRepository {
  CompleteFoodRepository({
    required this.surveyFoodsByCategoryService,
    required this.completFoodService,
  });

  final SurveyFoodsByCategoryService surveyFoodsByCategoryService;

  final CompleteFoodService completFoodService;

  /// Pobierz listę FoodWithNutrients na podstawie listy fdcIds
  Future<List<CompleteFood>> getCompleteFoodsByFdcIds(List<int> fdcIds) async {
    print("Repository !!!! fetched IDS!!!!!: $fdcIds");
    final categories = await surveyFoodsByCategoryService.getCategories();
    print('Repository Fetched categories: ${categories.length}');
    final foods = completFoodService.fromSurveyFoods(categories);
    print(foods.length);
    print(foods);
    print(
      "Repository !!!All foods fdcIds: ${foods.map((f) => f.fdcId).take(50).toList()}",
    ); // podgląd pierwszych 50

    final fdcSet = fdcIds.toSet();
    print("Repository @@Looking for ids: $fdcSet");
    final result = foods.where((f) => fdcSet.contains(f.fdcId)).toList();
    print("Repository Matched: ${result.map((f) => f.fdcId).toList()}");
    return result;
  }

  /// Pobierz wszystkie produkty (np. do cache albo do filtracji)
  Future<List<CompleteFood>> getAllCompleteFoods() async {
    final categories = await surveyFoodsByCategoryService.getCategories();
    return completFoodService.fromSurveyFoods(categories);
  }
}
