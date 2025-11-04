import 'package:nutrivita_demo_v2/features/categories/data/models/top_food_model.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/nutrient_number.dart';

class NutrientNumberModel extends NutrientNumber {


  const NutrientNumberModel({
    required super.nutrientId,
    required super.nutrientNumber,
    required super.nutrientName,
    required super.unit,
    required super.topFoods,
  });

  factory NutrientNumberModel.fromJson(Map<String, dynamic> json) {
    var foods =
        (json['topFoods'] as List<dynamic>)
            .map((e) => TopFoodModel.fromJson(e))
            .toList();

    return NutrientNumberModel(
      nutrientId: json['nutrientId'] ?? 0,
      nutrientNumber: json['nutrientNumber'] ?? '',
      nutrientName: json['nutrientName'] ?? '',
      unit: json['unit'] ?? '',
      topFoods: foods,
    );
  }
}
