import 'package:nutrivita_demo_v2/category_group/data/model/category_group_nutrient_number.dart';

class CategoryGroup {
  CategoryGroup({required this.categoryName, required this.nutrientsGroup});

  final String categoryName;
  final List<CategoryGroupNutrientNumber> nutrientsGroup;

  factory CategoryGroup.fromJson(Map<String, dynamic> json) {
    return CategoryGroup(
      categoryName: json['categoryName'] as String,
      nutrientsGroup:
          (json['nutrients'] as List)
              .map((json) => CategoryGroupNutrientNumber.fromJson(json))
              .toList(),
    );
  }
}
