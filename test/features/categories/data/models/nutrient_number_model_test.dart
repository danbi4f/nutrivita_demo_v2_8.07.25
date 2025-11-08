import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/nutrient_number_model.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/nutrient_number.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNutrientNumberModel = NutrientNumberModel(
    nutrientId: 1,
    nutrientNumber: 'test',
    nutrientName: 'test',
    unit: 'test',
    topFoods: [],
  );

  test('should be a subclass of NutrientNumber entity', () {
    //! assert
    expect(tNutrientNumberModel, isA<NutrientNumber>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      //! arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('nutrient_number.json'),
      );
      //! act
      final result = NutrientNumberModel.fromJson(jsonMap);
      //! assert
      expect(result, tNutrientNumberModel);
    });
  });
}
