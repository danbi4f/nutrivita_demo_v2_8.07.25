import 'dart:convert';
import 'package:flutter/foundation.dart'; // 👈 potrzebne dla compute()
import 'package:flutter/services.dart' show rootBundle;
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/survey_foods_by_category/mod/nutrient_by_group.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/survey_foods_by_category/mod/top_food.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/survey_foods_by_category/survey_foods_by_category.dart';

class SurveyFoodsByCategoryServiceV2 {
  SurveyFoodsByCategoryServiceV2._internal();

  static final SurveyFoodsByCategoryServiceV2 _instance =
      SurveyFoodsByCategoryServiceV2._internal();

  factory SurveyFoodsByCategoryServiceV2() => _instance;

  List<SurveyFoodsByCategory>? _categories;
  Map<int, Map<String, int>>? _fdcRankingMap;

  /// Fabryka async do inicjalizacji
  static Future<SurveyFoodsByCategoryServiceV2> init() async {
    final service = SurveyFoodsByCategoryServiceV2._instance;
    await service._loadData(); // od razu wczytaj JSONy
    return service;
  }

  /// Ładuje wszystkie pliki JSON z assets
  Future<void> _loadData() async {
    if (_categories != null) return;


    final List<String> files = [
      'assets/v2/sorted_SF_by_category_desc_nolimit/vitamins.json',
      'assets/v2/sorted_SF_by_category_desc_nolimit/minerals.json',
      'assets/v2/sorted_SF_by_category_desc_nolimit/fatty_acids.json',
      'assets/v2/sorted_SF_by_category_desc_nolimit/carbohydrates.json',
      'assets/v2/sorted_SF_by_category_desc_nolimit/energy.json',
      'assets/v2/sorted_SF_by_category_desc_nolimit/other.json',
      'assets/v2/sorted_SF_by_category_desc_nolimit/proteins.json',
      'assets/v2/sorted_SF_by_category_desc_nolimit/sugars.json',
    ];

    _categories = [];

    for (var file in files) {
      final jsonString = await rootBundle.loadString(file);
      final category = await compute(_decodeCategoryFile, jsonString);
      _categories!.add(category);
      debugPrint('🚕 ${_categories!.length} --SurveyFoodsByCategoryService');
    }

    // Wczytaj fdc_ranking_map.json
    final rankingJsonString = await rootBundle.loadString(
      'assets/v2/sorted_SF_by_category_desc_nolimit/fdc_ranking_map.json',
    );
    _fdcRankingMap = await compute(_decodeRankingMap, rankingJsonString);
  }

  /// Pobierz wszystkie kategorie z ich nutrientami i topFoods
  Future<List<SurveyFoodsByCategory>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1)); // 🧱 testowe opóźnienie

    await _loadData();
    return _categories!;
  }

  /// Obsługuje listę fdcId – zwraca topFoods należące do tych ID
  Future<List<TopFood>> getTopFoodsForFdcIds(List<int> fdcIds) async {
    await _loadData();
    final List<TopFood> results = [];
    final Set<int> fdcSet = fdcIds.toSet(); // szybsze wyszukiwanie

    for (var category in _categories!) {
      for (var nutrient in category.nutrients) {
        results.addAll(
          nutrient.topFoods.where((tf) => fdcSet.contains(tf.fdcId)),
        );
      }
    }

    return results;
  }

  /// Pobierz indexRanking dla fdcId i konkretnego nutrientNumber
  int? getIndexRanking(int fdcId, String nutrientNumber) {
    return _fdcRankingMap?[fdcId]?[nutrientNumber];
  }
}

// -----------------------------------------------------------------------------
// 🧠 Funkcje używane przez compute()
// -----------------------------------------------------------------------------

SurveyFoodsByCategory _decodeCategoryFile(String jsonString) {
  final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
  final categoryName = jsonData['category'] ?? '';
  final nutrientsJson = jsonData['nutrients'] as List<dynamic>? ?? [];

  final nutrients =
      nutrientsJson.map((n) => NutrientByCategory.fromJson(n)).toList();

  return SurveyFoodsByCategory(category: categoryName, nutrients: nutrients);
}

Map<int, Map<String, int>> _decodeRankingMap(String jsonString) {
  final rankingData = jsonDecode(jsonString) as Map<String, dynamic>;
  final Map<int, Map<String, int>> fdcRankingMap = {};

  rankingData.forEach((key, value) {
    final fdcId = int.tryParse(key);
    if (fdcId != null && value is Map<String, dynamic>) {
      fdcRankingMap[fdcId] = {};
      value.forEach((nutrientNumber, indexRanking) {
        if (indexRanking is int) {
          fdcRankingMap[fdcId]![nutrientNumber] = indexRanking;
        }
      });
    }
  });

  return fdcRankingMap;
}
