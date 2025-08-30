import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/mod/nutrient_by_group.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/mod/top_food.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/survey_foods_by_category.dart';

class SurveyFoodsByCategoryService {
  SurveyFoodsByCategoryService._internal();

  static final SurveyFoodsByCategoryService _instance =
      SurveyFoodsByCategoryService._internal();

  factory SurveyFoodsByCategoryService() => _instance;

  List<SurveyFoodsByCategory>? _categories;
  Map<int, Map<String, int>>? _fdcRankingMap;

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
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      final categoryName = jsonData['category'] ?? '';
      final nutrientsJson = jsonData['nutrients'] as List<dynamic>? ?? [];

      final nutrients =
          nutrientsJson.map((n) => NutrientByCategory.fromJson(n)).toList();

      _categories!.add(
        SurveyFoodsByCategory(category: categoryName, nutrients: nutrients),
      );
    }

    // Opcjonalnie wczytaj fdc_ranking_map.json do szybkiego dostępu
    final rankingJsonString = await rootBundle.loadString(
      'assets/v2/sorted_SF_by_category_desc_nolimit/fdc_ranking_map.json',
    );
    final rankingData = jsonDecode(rankingJsonString) as Map<String, dynamic>;

    _fdcRankingMap = {};
    rankingData.forEach((key, value) {
      final fdcId = int.tryParse(key);
      if (fdcId != null && value is Map<String, dynamic>) {
        _fdcRankingMap![fdcId] = {};
        value.forEach((nutrientNumber, indexRanking) {
          // zapisujemy tylko int jako ranking
          if (indexRanking is int) {
            _fdcRankingMap![fdcId]![nutrientNumber] = indexRanking;
          }
        });
      }
    });
  }

  /// Pobierz wszystkie kategorie z ich nutrientami i topFoods
  Future<List<SurveyFoodsByCategory>> getCategories() async {
    await _loadData();
    return _categories!;
  }

  /// Pobierz wszystkie TopFood dla konkretnego fdcId przeszukując wszystkie pliki
  Future<List<TopFood>> getTopFoodsForFdcId(int fdcId) async {
    await _loadData();
    final List<TopFood> results = [];
    for (var category in _categories!) {
      for (var nutrient in category.nutrients) {
        results.addAll(nutrient.topFoods.where((tf) => tf.fdcId == fdcId));
      }
    }
    return results;
  }

  /// Pobierz indexRanking dla fdcId i konkretnego nutrientNumber
  int? getIndexRanking(int fdcId, String nutrientNumber) {
    return _fdcRankingMap?[fdcId]?[nutrientNumber];
  }
}
