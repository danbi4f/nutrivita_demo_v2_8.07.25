import 'package:nutrivita_demo_v2/shared/models/survey_foods_2.dart';
import 'package:nutrivita_demo_v2/shared/survey_foods_2/services/survey_foods_service_2/survey_foods_service_2.dart';

class SurveyRepository2 {
  const SurveyRepository2(this.surveyFoodsService2);

  final SurveyFoodsService2 surveyFoodsService2;

  Future<List<SurveyFoods2>> getSurveyFoods2Model() async {
    var data = await surveyFoodsService2.getRawData();

    return data
        .map((map) => SurveyFoods2.fromJson(map as Map<String, dynamic>))
        .toList();
  }

  Future<List<SurveyFoods2>> getSortedSurveyFoods2ByNutrient(
    String nutrientNumberSearch,
  ) async {
    final List<SurveyFoods2> cutSurveyFoods = await getSurveyFoods2Model();

    cutSurveyFoods.sort((a, b) {
      final double aAmount = a.nutrients[nutrientNumberSearch] ?? 0.0;
      final double bAmount = b.nutrients[nutrientNumberSearch] ?? 0.0;
      return bAmount.compareTo(aAmount); // malejąco
    });

    return cutSurveyFoods;
  }
}
