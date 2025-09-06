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
    final categories = await surveyFoodsByCategoryService.getCategories();
    final foods = completFoodService.fromSurveyFoods(categories);

    final fdcSet = fdcIds.toSet();
    final result = foods.where((f) => fdcSet.contains(f.fdcId)).toList();

    return result;
  }

  /// 🔹 NOWE: Pobierz pojedynczy produkt na podstawie jednego fdcId
  Future<CompleteFood?> getCompleteFoodByFdcId(int fdcId) async {
    final foods = await getCompleteFoodsByFdcIds([fdcId]);
    if (foods.isNotEmpty) {
      return foods.first;
    }
    return null; // brak produktu o podanym fdcId
  }

  /// Pobierz wszystkie produkty (np. do cache albo do filtracji)
  Future<List<CompleteFood>> getAllCompleteFoods() async {
    final categories = await surveyFoodsByCategoryService.getCategories();
    return completFoodService.fromSurveyFoods(categories);
  }
}
