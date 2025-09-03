import 'package:nutrivita_demo_v2/arc/survey_foods.dart';
import 'package:nutrivita_demo_v2/arc/survey_foods_service.dart';

class SurveyRepository {
  const SurveyRepository(this.surveyFoodsService);

  final SurveyFoodsService surveyFoodsService;

  Future<List<SurveyFoods>> getSurveyFoods() async {
    var data = await surveyFoodsService.getRawData();

    return data
        .map((map) => SurveyFoods.fromJson(map as Map<String, dynamic>))
        .toList();
  }

  Future<List<SurveyFoods>> getSortedSurveyFoodsByNutrient(
    String nutrientNumberSearch,
  ) async {
    final List<SurveyFoods> cutSurveyFoods = await getSurveyFoods();

    cutSurveyFoods.sort((a, b) {
      final double aAmount = a.nutrients[nutrientNumberSearch] ?? 0.0;
      final double bAmount = b.nutrients[nutrientNumberSearch] ?? 0.0;
      return bAmount.compareTo(aAmount); // malejąco
    });

    return cutSurveyFoods;
  }
}
