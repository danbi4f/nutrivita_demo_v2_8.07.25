import 'package:nutrivita_demo_v2/features/categories/data/models/nutrient_number_model.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';

class CategoryNutrientModel extends CategoryNutrient {
  const CategoryNutrientModel({
    required super.category,
    required super.nutrients,
  });

  factory CategoryNutrientModel.fromJson(Map<String, dynamic> json) {
    var nutrients =
        (json['nutrients'] as List<dynamic>)
            .map((e) => NutrientNumberModel.fromJson(e))
            .toList();

    return CategoryNutrientModel(
      category: json['category'] ?? '',
      nutrients: nutrients,
    );
  }
}