import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/survey_foods_by_category_repository.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/survey_foods_by_category/survey_foods_by_category.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';

class AppFoodRepository {
  final SurveyFoodsByCategoryRepository surveyFoodsByCategoryRepository;
  final CompleteFoodRepository completeFoodRepository;

  AppFoodRepository({
    required this.surveyFoodsByCategoryRepository,
    required this.completeFoodRepository,
  });

  Future<DelayedResult<List<SurveyFoodsByCategory>>> getAllCategories() async {
    return await surveyFoodsByCategoryRepository.getAllCategories();
  }



  Future<List<CompleteFood>> getCompleteFoodsByFdcIds(List<int> fdcIds) async {
    final completeFoods = await completeFoodRepository
        .getCompleteFoodsByFdcIds(fdcIds);
    return completeFoods;
  }

  Future<CompleteFood> getCompleteFoodByFdcId(int fdcId) async {
    return await completeFoodRepository.getCompleteFoodByFdcId(fdcId);
  }

  Future<List<CompleteFood>> getAllCompleteFoods() async {
    return await completeFoodRepository.getAllCompleteFoods();
  }
  Future<List<CompleteFood>> searchFoods(String query) async {
    return await completeFoodRepository.searchFoods(query);
  }
}
