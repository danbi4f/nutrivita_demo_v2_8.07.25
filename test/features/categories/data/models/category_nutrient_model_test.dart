import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/category_nutrient_model.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tCategoryNutrientModel = CategoryNutrientModel(
    category: 'test',
    nutrients: [],
  );

  test('should be a subclass of CategoryNutrient entity', ()  {
    //! assert
    expect(tCategoryNutrientModel, isA<CategoryNutrient>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', ()  {
      //! arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('category_nutrient.json'),
      );
      //! act
      final result = CategoryNutrientModel.fromJson(jsonMap);
      //! assert
      expect(result, tCategoryNutrientModel);
    });
  });
}
