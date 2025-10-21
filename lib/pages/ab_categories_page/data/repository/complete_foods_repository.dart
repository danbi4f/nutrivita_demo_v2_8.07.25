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
  List<CompleteFood>? _cachedFoods;

    /// Pobierz wszystkie produkty (np. do cache albo do filtracji)
  Future<List<CompleteFood>> getAllCompleteFoods() async {
    if (_cachedFoods != null) return _cachedFoods!;
    final categories = await surveyFoodsByCategoryService.getCategories();
    _cachedFoods = completFoodService.fromSurveyFoods(categories);
    return _cachedFoods!;
  }

  /// Pobierz listę FoodWithNutrients na podstawie listy fdcIds
  Future<List<CompleteFood>> getCompleteFoodsByFdcIds(List<int> fdcIds) async {
    final foods = await getAllCompleteFoods();
    final fdcSet = fdcIds.toSet();
    return foods.where((f) => fdcSet.contains(f.fdcId)).toList();
  }

  /// 🔹 NOWE: Pobierz pojedynczy produkt na podstawie jednego fdcId
  Future<CompleteFood> getCompleteFoodByFdcId(int fdcId) async {
    final foods = await getAllCompleteFoods();
    return foods.firstWhere((f) => f.fdcId == fdcId);
  }


}
