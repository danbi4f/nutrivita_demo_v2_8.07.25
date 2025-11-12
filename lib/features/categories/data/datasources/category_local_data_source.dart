import 'dart:convert';
import 'package:flutter/foundation.dart'; // 👈 needed for compute()
import 'package:flutter/services.dart' show rootBundle;
import 'package:nutrivita_demo_v2/features/categories/data/models/nutrient_number_model.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/category_nutrient_model.dart';

/// data they come form JSON files stored in assets and all 8 files come from one file from USDA - FDC Survey Foods (FNDDS)
abstract class CategoryLocalDataSource {
  Future<List<CategoryNutrientModel>> getCategories();
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  CategoryLocalDataSourceImpl._internal();

  static final CategoryLocalDataSourceImpl _instance =
      CategoryLocalDataSourceImpl._internal();

  factory CategoryLocalDataSourceImpl() => _instance;

  List<CategoryNutrientModel>? _categories;

  /// Async factory for initialization
  static Future<CategoryLocalDataSourceImpl> init() async {
    final service = CategoryLocalDataSourceImpl._instance;
    await service._loadData(); // load JSONs immediately
    return service;
  }

  ///Loads all JSON files from assets
  Future<void> _loadData() async {
    if (_categories != null) return;

    final stopwatch = Stopwatch()..start(); // ⏱ Start mierzenia czasu

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
        stopwatch.stop(); // ⏱ Zatrzymanie licznika
    debugPrint('✅ Załadowano ${_categories!.length} kategorii (assets).');
    debugPrint('⏱ Czas wczytania: ${stopwatch.elapsedMilliseconds} ms');
  }

  /// Download all categories with their nutrients and topFoods
  @override
  Future<List<CategoryNutrientModel>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1)); // 🧱 test delay

    await _loadData();
    return _categories!;
  }
}

// -----------------------------------------------------------------------------
// 🧠 Functions used by compute()
// -----------------------------------------------------------------------------

CategoryNutrientModel _decodeCategoryFile(String jsonString) {
  final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
  final categoryName = jsonData['category'] ?? '';
  final nutrientsJson = jsonData['nutrients'] as List<dynamic>? ?? [];

  final nutrients =
      nutrientsJson.map((n) => NutrientNumberModel.fromJson(n)).toList();

  return CategoryNutrientModel(category: categoryName, nutrients: nutrients);
}
