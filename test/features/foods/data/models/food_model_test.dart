import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutrivita_demo_v2/features/foods/data/models/food_model.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tFoodModel = FoodModel(
    fdcId: 1,
    description: "test",
    descriptionPL: "test",
    foodClass: "test",
    nutrients: {},
  );

  test('should be a subclass of Food entity', () {
    //! assert
    expect(tFoodModel, isA<Food>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      //! arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('food.json'));
      //! act
      final result = FoodModel.fromMap(jsonMap);
      //! assert
      expect(result, tFoodModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      //! act
      final result = tFoodModel.toMap();
      //! assert
      final expectedMap = {
        "fdcId": 1,
        "description": "test",
        "descriptionPL": "test",
        "foodClass": "test",
        "nutrients": "{}",
      };
      expect(result, expectedMap);
    });
  });
}
