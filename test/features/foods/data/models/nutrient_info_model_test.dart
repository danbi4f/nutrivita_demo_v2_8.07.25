import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutrivita_demo_v2/features/foods/data/models/nutrient_info_model.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/nutrient_info.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNutrientInfoModel = NutrientInfoModel(
    nutrientNumber: 'test',
    nutrientName: 'test',
    unit: 'test',
    value: 1.0,
    indexRanking: 1,
  );

  test('should be a subclass of NutrientInfo entity', () {
    //! assert
    expect(tNutrientInfoModel, isA<NutrientInfo>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      //! arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('nutrient_info.json'),
      );
      //! act
      final result = NutrientInfoModel.fromMap(jsonMap);
      //! assert
      expect(result, tNutrientInfoModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      //! act
      final result = tNutrientInfoModel.toMap();
      //! assert
      final expectedMap = {
        "nutrientNumber": "test",
        "nutrientName": "test",
        "unit": "test",
        "value": 1.0,
        "indexRanking": 1,
      };
      expect(result, expectedMap);
    });
  });
}
