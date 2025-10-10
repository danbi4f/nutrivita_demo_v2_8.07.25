import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/survey_foods_by_category/mod/top_food.dart';

class NutrientByCategory {
  final int nutrientId;
  final String nutrientNumber;
  final String nutrientName;
  final String unit;
  final List<TopFood> topFoods;

  NutrientByCategory({
    required this.nutrientId,
    required this.nutrientNumber,
    required this.nutrientName,
    required this.unit,
    required this.topFoods,
  });

  factory NutrientByCategory.fromJson(Map<String, dynamic> json) {
    var foods =
        (json['topFoods'] as List<dynamic>)
            .map((e) => TopFood.fromJson(e))
            .toList();

    return NutrientByCategory(
      nutrientId: json['nutrientId'] ?? 0,
      nutrientNumber: json['nutrientNumber'] ?? '',
      nutrientName: json['nutrientName'] ?? '',
      unit: json['unit'] ?? '',
      topFoods: foods,
    );
  }
}
