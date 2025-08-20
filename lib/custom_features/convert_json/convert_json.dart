// oto gotowy skrypt CLI w Dart, który:

// odczytuje plik surveyFoods.json (np. z folderu assets/ lub dowolnego),

// przetwarza go do uproszczonej postaci,

// zapisuje wynik jako cut_survey_foods.json (np. do assets/, aby można go potem włączyć do aplikacji Flutter).

import 'dart:convert';
import 'dart:io';

void main(List<String> arguments) async {
  const inputPath = 'assets/surveyFoods.json';
  const outputPath = 'assets/cut_survey_foods.json';

  final inputFile = File(inputPath);
  if (!await inputFile.exists()) {
    print('❌ Plik wejściowy nie istnieje: $inputPath');
    exit(1);
  }

  try {
    final jsonString = await inputFile.readAsString();
    final Map<String, dynamic> data = jsonDecode(jsonString);
    final List<dynamic> surveyFoods = data['SurveyFoods'] ?? [];

    final List<Map<String, dynamic>> cutSurveyFoods = [];

    for (final food in surveyFoods) {
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
            print('⚠️ Błąd składnika: $number, $amount → $e');
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

    final outputFile = File(outputPath);
    final outputJson = const JsonEncoder.withIndent(
      '  ',
    ).convert(cutSurveyFoods);
    await outputFile.writeAsString(outputJson, encoding: utf8);

    print('✅ Plik został zapisany: $outputPath');
  } catch (e) {
    print('❌ Wystąpił błąd: $e');
    exit(2);
  }
}
