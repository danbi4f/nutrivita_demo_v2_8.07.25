import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutrivita_demo_v2/features/categories/data/models/top_food_model.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/top_food.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tTopFoodModel = TopFoodModel(
    indexRanking: 1,
    rankingName: "test",
    description: "test",
    descriptionPL: "test",
    foodClass: "test",
    fdcId: 1,
    id: "test",
    nutrientValue: 1.0,
    matchedKey: "test",
  );

  test('should be a subclass of TopFood entity', () {
    //! assert
    expect(tTopFoodModel, isA<TopFood>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      //! arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('top_food.json'),
      );
      //! act
      final result = TopFoodModel.fromJson(jsonMap);
      //! assert
      expect(result, tTopFoodModel);
    });
  });
}
