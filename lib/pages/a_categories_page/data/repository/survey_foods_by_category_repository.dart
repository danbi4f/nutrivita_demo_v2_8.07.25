import 'package:nutrivita_demo_v2/pages/a_categories_page/data/service/survey_foods_by_category_service_v2.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/data/service/survey_foods_by_category_service.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/survey_foods_by_category/survey_foods_by_category.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/survey_foods_by_category/mod/top_food.dart';

class SurveyFoodsByCategoryRepository {
  const SurveyFoodsByCategoryRepository(this.surveyFoodsByCategoryService);

  final SurveyFoodsByCategoryServiceV2 surveyFoodsByCategoryService;

  Future<DelayedResult<List<SurveyFoodsByCategory>>> getAllCategories() async {
    try {

      final categories = await surveyFoodsByCategoryService.getCategories();
      return DelayedResult.fromValue(categories);
    } catch (e) {
      return DelayedResult.fromError(Exception(e.toString()));
    }
  }

  /// NOWA metoda – obsługuje listę fdcId
  Future<DelayedResult<List<TopFood>>> getTopFoodsForFdcIds(
    List<int> fdcIds,
  ) async {
    try {
      final topFoods = await surveyFoodsByCategoryService.getTopFoodsForFdcIds(
        fdcIds,
      );
      return DelayedResult.fromValue(topFoods);
    } catch (e) {
      return DelayedResult.fromError(Exception(e.toString()));
    }
  }
}
