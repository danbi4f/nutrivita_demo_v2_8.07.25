import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

void main(List<String> arguments) async {
  String inputPath = 'assets/surveyFoods.json';
  String outputFileName = 'cut_survey_foods.json';

  // 1. Wczytaj dane z assets
  final String jsonString;
  try {
    jsonString = await rootBundle.loadString(inputPath);
  } catch (e) {
    print('❌ Nie znaleziono pliku: $inputPath');
    return;
  }

  // 2. Parsowanie danych wejściowych
  final Map<String, dynamic> data = jsonDecode(jsonString);
  final List<dynamic> surveyfoods = data['SurveyFoods'] ?? [];

  final List<Map<String, dynamic>> cutSurveyFoods = [];

  for (final food in surveyfoods) {
    final Map<String, double> nutrientsMap = {};
    final Map<String, double> nameNutrientsMap = {};
    final Map<String, double> unitNameNutrientsMap = {};

    final List<dynamic> nutrients = food['foodNutrients'] ?? [];
    for (final nutrientEntry in nutrients) {
      final nutrient = nutrientEntry['nutrient'] ?? {};
      final number = nutrient['number'];
      final nameNutrient = nutrient['name'];
      final unitNameNutrient = nutrient['unitName'];
      final amount = nutrientEntry['amount'];

      if (number != null && amount != null) {
        try {
          final nutrientId = number.toString().trim();
          nutrientsMap[nutrientId] = (amount as num).toDouble();
          nameNutrientsMap[nutrientId] = (nameNutrient);
          unitNameNutrientsMap[nutrientId] = (unitNameNutrient);
        } catch (e) {
          print('⚠️ Błąd parsowania składnika: $number, $amount: $e');
        }
      }
    }

    cutSurveyFoods.add({
      'description': food['description'],
      'foodClass': food['foodClass'],
      'fdcId': food['fdcId'],
      'nutrients': nutrientsMap,
      'nameNutrient': nameNutrientsMap,
      'unitNameNutrient': unitNameNutrientsMap,
    });
  }

  // 3. Uzyskaj katalog do zapisu
  final dir = await getApplicationDocumentsDirectory();
  final outputPath = '${dir.path}/$outputFileName';
  final outputFile = File(outputPath);

  // 4. Zapis danych
  final outputJson = const JsonEncoder.withIndent('  ').convert(cutSurveyFoods);
  await outputFile.writeAsString(outputJson, encoding: utf8);

  print('✅ Plik $outputPath został zapisany.');
}
