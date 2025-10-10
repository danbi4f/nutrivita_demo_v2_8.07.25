import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/nutrient_info.dart';
import 'dart:convert';

/// Model docelowy
class CompleteFood {
  final int fdcId;
  final String description;
  final String descriptionPL;
  final String foodClass;

  /// Mapowanie: nutrientNumber -> info
  final Map<String, NutrientInfo> nutrients;

  CompleteFood({
    required this.fdcId,
    required this.description,
    required this.descriptionPL,
    required this.foodClass,
    required this.nutrients,
  });

  Map<String, dynamic> toMap() {
    return {
      'fdcId': fdcId,
      'description': description,
      'descriptionPL': descriptionPL,
      'foodClass': foodClass,
      'nutrients': jsonEncode(
        nutrients.map((key, value) => MapEntry(key, value.toMap())),
      ),
    };
  }

  factory CompleteFood.fromMap(Map<String, dynamic> map) {
    final nutrientsJson = jsonDecode(map['nutrients']) as Map<String, dynamic>;

    return CompleteFood(
      fdcId: map['fdcId'],
      description: map['description'] ?? '',
      descriptionPL: map['descriptionPL'] ?? '',
      foodClass: map['foodClass'] ?? '',
      nutrients: nutrientsJson.map(
        (key, value) => MapEntry(key, NutrientInfo.fromMap(value)),
      ),
    );
  }
}
