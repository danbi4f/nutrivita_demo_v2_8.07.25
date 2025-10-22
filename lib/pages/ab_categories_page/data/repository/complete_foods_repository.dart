import 'package:flutter/foundation.dart';
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


  // ============================================================
  // 🔹 GŁÓWNA METODA WYSZUKIWANIA
  // ============================================================
  Future<List<CompleteFood>> searchFoods(String query) async {
    final allFoods = await getAllCompleteFoods();

    if (query.isEmpty) {
      return allFoods;
    }

    // compute = uruchamia w osobnym isolate (nie blokuje UI)
    return compute(_search, {'query': query, 'foods': allFoods});
  }

  // ============================================================
  // 🔹 FUNKCJA URUCHAMIANA W ISOLATE
  // ============================================================
  static List<CompleteFood> _search(Map<String, dynamic> data) {
    final String query = data['query'] as String;
    final List<CompleteFood> foods = List<CompleteFood>.from(data['foods']);
    final q = query.toLowerCase();

    final filtered = foods.where((food) {
      final name = food.description.toLowerCase();
      final namePL = (food.descriptionPL ?? '').toLowerCase();

      if (name.contains(q) || namePL.contains(q)) {
        return true;
      }

      final nameDistance = _levenshteinDistance(name, q);
      final namePLDistance = _levenshteinDistance(namePL, q);

      return nameDistance <= 2 || namePLDistance <= 2;
    }).toList();

    return filtered;
  }

  // ============================================================
  // 🔹 ALGORYTM LEVENSHTEINA
  // ============================================================
  static int _levenshteinDistance(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final matrix = List.generate(
      b.length + 1,
      (i) => List<int>.generate(a.length + 1, (j) => j),
    );

    for (int i = 1; i <= b.length; i++) {
      matrix[i][0] = i;
    }

    for (int i = 1; i <= b.length; i++) {
      for (int j = 1; j <= a.length; j++) {
        final substitutionCost = a[j - 1] == b[i - 1] ? 0 : 1;
        matrix[i][j] = _min3(
          matrix[i - 1][j] + 1, // usunięcie
          matrix[i][j - 1] + 1, // wstawienie
          matrix[i - 1][j - 1] + substitutionCost, // zamiana
        );
      }
    }

    return matrix[b.length][a.length];
  }

  static int _min3(int a, int b, int c) =>
      (a < b) ? (a < c ? a : c) : (b < c ? b : c);

}
