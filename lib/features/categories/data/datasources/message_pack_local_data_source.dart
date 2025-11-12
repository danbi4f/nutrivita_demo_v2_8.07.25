import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:nutrivita_demo_v2/features/categories/data/datasources/category_local_data_source.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/nutrient_number_model.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/category_nutrient_model.dart';

class MessagePackCategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  MessagePackCategoryLocalDataSourceImpl._internal();

  static final MessagePackCategoryLocalDataSourceImpl _instance =
      MessagePackCategoryLocalDataSourceImpl._internal();

  factory MessagePackCategoryLocalDataSourceImpl() => _instance;

  List<CategoryNutrientModel>? _categories;

  static Future<MessagePackCategoryLocalDataSourceImpl> init() async {
    final service = MessagePackCategoryLocalDataSourceImpl._instance;
    await service._loadData();
    return service;
  }

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

    final stopwatch = Stopwatch()..start(); // ⏱ Start mierzenia czasu

    final dir = await getApplicationDocumentsDirectory();
    _categories = [];

    for (final assetPath in _assetFiles) {
      final fileName = assetPath.split('/').last.replaceAll('.json', '.bin');
      final localFile = File('${dir.path}/$fileName');

      List<int> bytes;

      if (await localFile.exists()) {
        // 🔹 Wczytaj skompresowane dane binarne
        bytes = await localFile.readAsBytes();
        debugPrint('📦 Wczytano binarny cache: $fileName');
      } else {
        // 🔹 Pierwsze uruchomienie — wczytaj JSON z assets
        final jsonString = await rootBundle.loadString(assetPath);
        final jsonData = jsonDecode(jsonString);

        // 🔸 Zamień JSON → MessagePack (binary)
        bytes = serialize(jsonData);
        await localFile.writeAsBytes(bytes);
        debugPrint('💾 Zapisano binarny cache: $fileName');
      }

      // 🔸 Dekodowanie binarne (zamiast JSON)
      final raw = deserialize(Uint8List.fromList(bytes));
      final decoded = Map<String, dynamic>.from(raw as Map);

      final category = _decodeCategoryData(decoded);
      _categories!.add(category);
    }

    stopwatch.stop(); // ⏱ Zatrzymanie licznika
    debugPrint('✅ Załadowano ${_categories!.length} kategorii (binary).');
    debugPrint('⏱ Czas wczytania: ${stopwatch.elapsedMilliseconds} ms');
  }

  @override
  Future<List<CategoryNutrientModel>> getCategories() async {
    await _loadData();
    return _categories!;
  }
}

// -----------------------------------------------------------------------------
// 🧠 Pomocnicza funkcja dekodująca dane kategorii
// -----------------------------------------------------------------------------
CategoryNutrientModel _decodeCategoryData(Map<String, dynamic> jsonData) {
  final categoryName = jsonData['category'] ?? '';
  final nutrientsJson = jsonData['nutrients'] as List<dynamic>? ?? [];

  final nutrients = nutrientsJson.map((n) {
    final map = convertDynamicToStringKey(n) as Map<String, dynamic>;
    return NutrientNumberModel.fromJson(map);
  }).toList();

  return CategoryNutrientModel(category: categoryName, nutrients: nutrients);
}



dynamic convertDynamicToStringKey(dynamic value) {
  if (value is Map) {
    return Map<String, dynamic>.fromEntries(
      value.entries.map((e) => MapEntry(e.key.toString(), convertDynamicToStringKey(e.value))),
    );
  } else if (value is List) {
    return value.map(convertDynamicToStringKey).toList();
  } else {
    return value;
  }
}