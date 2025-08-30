import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/services/survey_foods_by_category_service.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/survey_foods_by_category.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/mod/top_food.dart';

class SurveyFoodsByCategoryRepository {
  const SurveyFoodsByCategoryRepository(this.surveyFoodsByCategoryService);

  final SurveyFoodsByCategoryService surveyFoodsByCategoryService;

  Future<DelayedResult<List<SurveyFoodsByCategory>>> getAllCategories() async {
    try {
      final categories = await surveyFoodsByCategoryService.getCategories();
      return DelayedResult.fromValue(categories);
    } catch (e) {
      return DelayedResult.fromError(Exception(e.toString()));
    }
  }

  Future<DelayedResult<List<TopFood>>> getTopFoodsForFdcId(int fdcId) async {
    try {
      final topFoods = await surveyFoodsByCategoryService.getTopFoodsForFdcId(
        fdcId,
      );
      return DelayedResult.fromValue(topFoods);
    } catch (e) {
      return DelayedResult.fromError(Exception(e.toString()));
    }
  }
}
