import 'package:nutrivita_demo_v2/features/categories/domain/entities/top_food.dart';

class TopFoodModel extends TopFood {
  const TopFoodModel({
    required super.indexRanking,
    required super.rankingName,
    required super.description,
    required super.descriptionPL,
    required super.foodClass,
    required super.fdcId,
    required super.id,
    required super.nutrientValue,
    required super.matchedKey,
  });

  factory TopFoodModel.fromJson(Map<String, dynamic> json) {
    return TopFoodModel(
      indexRanking: json['indexRanking'] ?? 0,
      rankingName: json['rankingName'] ?? '',
      description: json['description'] ?? '',
      descriptionPL: json['descriptionPL'] ?? '',
      foodClass: json['foodClass'] ?? '',
      fdcId: json['fdcId'] ?? 0,
      id: json['id'] ?? '',
      nutrientValue: (json['nutrientValue'] ?? 0).toDouble(),
      matchedKey: json['matchedKey'] ?? '',
    );
  }
}
