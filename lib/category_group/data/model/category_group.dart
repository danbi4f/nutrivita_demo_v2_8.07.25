import 'package:nutrivita_demo_v2/category_group/data/model/nutrient_group_number.dart';

class CategoryGroup {
  CategoryGroup({required this.categoryName, required this.nutrientsGroup});

  final String categoryName;
  final List<NutrientGroupNumber> nutrientsGroup;

  factory CategoryGroup.fromJson(Map<String, dynamic> json) {
    return CategoryGroup(
      categoryName: json['categoryName'] as String,
      nutrientsGroup:
          (json['nutrients'] as List)
              .map((json) => NutrientGroupNumber.fromJson(json))
              .toList(),
    );
  }
}
