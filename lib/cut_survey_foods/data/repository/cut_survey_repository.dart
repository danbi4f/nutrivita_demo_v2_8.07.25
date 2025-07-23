import 'package:nutrivita_demo_v2/cut_survey_foods/data/model/cut_survey_model.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/data/service/cut_survey_asset_service.dart';

class CutSurveyRepository {
  const CutSurveyRepository(this.cutSurveyAssetService);

  final CutSurveyAssetService cutSurveyAssetService;

  Future<List<CutSurveyModel>> fetchCutSurveyFoods() {
    return cutSurveyAssetService.fetchCutSurveyFoods();
  }

  Future<List<CutSurveyModel>> getSortedCutSurveyFoodsByNutrient(
    String nutrientNumberSearch,
  ) async {
    final List<CutSurveyModel> cutSurveyFoods = await fetchCutSurveyFoods();

    cutSurveyFoods.sort((a, b) {
      final double aAmount = a.nutrients[nutrientNumberSearch] ?? 0.0;
      final double bAmount = b.nutrients[nutrientNumberSearch] ?? 0.0;
      return bAmount.compareTo(aAmount); // malejąco
    });

    return cutSurveyFoods;
  }
}
