import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/survey_foods_by_category/mod/nutrient_by_group.dart';

class SurveyFoodsByCategory {
  final String category;
  final List<NutrientByCategory> nutrients;

  SurveyFoodsByCategory({required this.category, required this.nutrients});
}
