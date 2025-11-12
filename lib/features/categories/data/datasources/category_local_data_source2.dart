import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/nutrient_number_model.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/category_nutrient_model.dart';



class CategoryLocalDataSourceImpl2 implements CategoryLocalDataSource {
  CategoryLocalDataSourceImpl2._internal();

  static final CategoryLocalDataSourceImpl2 _instance =
      CategoryLocalDataSourceImpl2._internal();

  factory CategoryLocalDataSourceImpl2() => _instance;

  List<CategoryNutrientModel>? _categories;

  static Future<CategoryLocalDataSourceImpl2> init() async {
    final service = CategoryLocalDataSourceImpl2._instance;
    await service._loadData();
    return service;
  }

  /// 🔹 Nazwy plików JSON (assets i cache)
  final List<String> _assetFiles = const [
    'assets/v2/sorted_SF_by_category_desc_nolimit/vitamins.json',
    'assets/v2/sorted_SF_by_category_desc_nolimit/minerals.json',
    'assets/v2/sorted_SF_by_category_desc_nolimit/fatty_acids.json',
    'assets/v2/sorted_SF_by_category_desc_nolimit/carbohydrates.json',
    'assets/v2/sorted_SF_by_category_desc_nolimit/energy.json',
    'assets/v2/sorted_SF_by_category_desc_nolimit/other.json',
    'assets/v2/sorted_SF_by_category_desc_nolimit/proteins.json',
    'assets/v2/sorted_SF_by_category_desc_nolimit/sugars.json',
  ];

  Future<void> _loadData() async {
    if (_categories != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _categories = [];

    for (final assetPath in _assetFiles) {
      final fileName = assetPath.split('/').last;
      final localFile = File('${dir.path}/$fileName');

      String jsonString;

      if (await localFile.exists()) {
        // 🔸 Wczytaj z lokalnego cache
        jsonString = await localFile.readAsString();
        debugPrint('📦 Wczytano z cache: $fileName');
      } else {
        // 🔸 Pierwsze uruchomienie — z assets
        jsonString = await rootBundle.loadString(assetPath);

        // zapisz kopię do lokalnego cache
        await localFile.writeAsString(jsonString);
        debugPrint('💾 Zapisano cache: $fileName');
      }

      final category = await compute(_decodeCategoryFile, jsonString);
      _categories!.add(category);
    }

    debugPrint('✅ Załadowano ${_categories!.length} kategorii.');
  }

  @override
  Future<List<CategoryNutrientModel>> getCategories() async {
    await _loadData();
    return _categories!;
  }
}

// -----------------------------------------------------------------------------
// 🧠 Funkcja dla compute()
// -----------------------------------------------------------------------------
CategoryNutrientModel _decodeCategoryFile(String jsonString) {
  final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
  final categoryName = jsonData['category'] ?? '';
  final nutrientsJson = jsonData['nutrients'] as List<dynamic>? ?? [];

  final nutrients =
      nutrientsJson.map((n) => NutrientNumberModel.fromJson(n)).toList();

  return CategoryNutrientModel(category: categoryName, nutrients: nutrients);
}

