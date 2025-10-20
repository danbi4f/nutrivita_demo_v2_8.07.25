import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/complete_foods_service.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/service/survey_foods_by_category_service.dart';

class CompleteFoodRepository {
  CompleteFoodRepository({
    required this.surveyFoodsByCategoryService,
    required this.completFoodService,
  });

  final SurveyFoodsByCategoryService surveyFoodsByCategoryService;
  final CompleteFoodService completFoodService;

  /// Pobierz listę FoodWithNutrients na podstawie listy fdcIds
  Future<List<CompleteFood>> getCompleteFoodsByFdcIds(List<int> fdcIds) async {
    final categories = await surveyFoodsByCategoryService.getCategories();
    print(  '🍏 Fetched categories: ${categories.length}');
    final foods = completFoodService.fromSurveyFoods(categories);
    print(  '🍎 Total CompleteFoods available: ${foods.length}');

    final fdcSet = fdcIds.toSet();
    final result = foods.where((f) => fdcSet.contains(f.fdcId)).toList();

    return result;
  }

  /// 🔹 NOWE: Pobierz pojedynczy produkt na podstawie jednego fdcId
  Future<CompleteFood> getCompleteFoodByFdcId(int fdcId) async {
    final foods = await getCompleteFoodsByFdcIds([fdcId]);

      return foods.first;
 // brak produktu o podanym fdcId
  }

  /// Pobierz wszystkie produkty (np. do cache albo do filtracji)
  Future<List<CompleteFood>> getAllCompleteFoods() async {
    final categories = await surveyFoodsByCategoryService.getCategories();
    return completFoodService.fromSurveyFoods(categories);
  }
}
