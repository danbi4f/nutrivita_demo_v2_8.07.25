import 'package:nutrivita_demo_v2/features/foods/data/models/nutrient_info_model.dart';
import 'dart:convert';

import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';

class FoodModel extends Food {
  const FoodModel({
    required super.fdcId,
    required super.description,
    required super.descriptionPL,
    required super.foodClass,
    required super.nutrients,
  });

  Map<String, dynamic> toMap() {
    return {
      'fdcId': fdcId,
      'description': description,
      'descriptionPL': descriptionPL,
      'foodClass': foodClass,
      'nutrients': jsonEncode(
        nutrients.map((key, value) => MapEntry(key, value)),
      ),
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    final raw = map['nutrients'];

    final nutrientsJson =
        raw is String
            ? jsonDecode(raw) as Map<String, dynamic>
            : raw as Map<String, dynamic>;

    return FoodModel(
      fdcId: map['fdcId'],
      description: map['description'] ?? '',
      descriptionPL: map['descriptionPL'] ?? '',
      foodClass: map['foodClass'] ?? '',
      nutrients: nutrientsJson.map(
        (key, value) => MapEntry(key, NutrientInfoModel.fromMap(value)),
      ),
    );
  }
}
